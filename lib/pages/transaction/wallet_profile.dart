import 'dart:io';

import 'package:clipboard/clipboard.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:momerlin/data/localstorage/userdata_source.dart';
import 'package:momerlin/data/userrepository.dart';
import 'package:momerlin/pages/transaction/wallet_screen.dart';
import 'package:momerlin/tabscreen/tabscreen.dart';
import 'package:momerlin/theme/theme.dart';
//import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

class MenuItem {
  final String menuTextName;
  final IconData menuIconName;
  const MenuItem({
    this.menuTextName,
    this.menuIconName,
  });
}

class MenuItems {
  static const List<MenuItem> menuItems = [
    itemWallet,
    itemShare,
  ];
  static const itemWallet = MenuItem(
    menuTextName: 'Wallet',
    menuIconName: FontAwesomeIcons.wallet,
  );
  static const itemShare = MenuItem(
    menuTextName: 'Share',
    menuIconName: FontAwesomeIcons.share,
  );
}

class WalletProfile extends StatefulWidget {
  final selectindex;

  const WalletProfile({
    Key key,
    this.selectindex,
  }) : super(key: key);

  @override
  _WalletProfileState createState() => _WalletProfileState();
}

class _WalletProfileState extends State<WalletProfile> {
  var userLanguage, user, lang = [];
  bool loading = true;
  var imageFile = "";
  // ignore: unused_field
  ImagePicker _picker = ImagePicker();

  TextEditingController _controller = TextEditingController();
  String imageURL;

  getImage(ImageSource source) async {
    final image = await _picker.pickImage(
      source: source,
    );
    if (image != null) {
      File cropped = await ImageCropper.cropImage(
          sourcePath: image.path,
          aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
          compressQuality: 100,
          maxWidth: 700,
          maxHeight: 700,
          compressFormat: ImageCompressFormat.jpg,
          androidUiSettings: AndroidUiSettings(
            toolbarColor: blue2,
            toolbarTitle: "Set an image",
            toolbarWidgetColor: Colors.white,
            //statusBarColor: smartchatgold.withOpacity(0.3),
            backgroundColor: Colors.black,
          ));
      var extendion = cropped.path.split('/').last;
      var n = extendion.split('.').last;
      print('s: $extendion');
      print(extendion.split('.').last);
      firebase_storage.Reference firebaseStorageRef = firebase_storage
          .FirebaseStorage.instance
          .ref()
          .child('profile/${DateTime.now()}.$n');
      firebase_storage.UploadTask uploadTask =
          firebaseStorageRef.putFile(cropped);
      imageURL = await (await uploadTask).ref.getDownloadURL();
      var res = await UserRepository()
          .updateuser(user[0]["uid"], _controller.text, imageURL);

      if (res["success"] == true) {
        var res = await UserRepository().getUser(user[0]["walletaddress"]);

        setState(() {
          var name = res["user"]["fullName"];
          imageFile = res["user"]["imageUrl"];
          _controller.text = name;
        });
        // ignore: deprecated_member_use
        Scaffold.of(context).showSnackBar(SnackBar(
          content: Text('Profile Picture has been updated successfully.'),
          backgroundColor: Colors.green,
        ));
      } else {
        // ignore: deprecated_member_use
        Scaffold.of(context).showSnackBar(SnackBar(
          content: Text('Image cannot be updated.'),
          backgroundColor: Colors.red,
        ));
      }

      // return imageURL;//

    }
  }

  void updateuser(id, fullname, image) async {
    // ignore: unused_local_variable
    var res = await UserRepository()
        .updateuser(user[0]["uid"], _controller.text, image);

    if (res["success"] == true) {
      // ignore: deprecated_member_use
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text('Name has been updated successfully.'),
        backgroundColor: Colors.green,
      ));
    } else {
      // ignore: deprecated_member_use
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text('Name cannot be updated.'),
        backgroundColor: Colors.red,
      ));
    }
  }

  Future<void> getuser() async {
    var res = await UserRepository().getUser(user[0]["walletaddress"]);
    print("PAVITJRA $res");
    setState(() {
      var name = res["user"]["fullName"];
      imageFile = res["user"]["imageUrl"];
      _controller.text = name;
    });
  }

  Future<void> getUserLanguage() async {
    lang = await UserDataSource().getLanguage();
    user = await UserDataSource().getUser();
    getuser();
    setState(() {
      loading = false;
    });
    if (lang.length != null && lang.length != 0) {
      userLanguage = lang[0];
    }
  }

  // ignore: todo
  //TODO: LanguageEnd
  @override
  void initState() {
    loading = true;
    super.initState();
    print(widget.selectindex);
    getUserLanguage();
  }

  selectImage() {
    showModalBottomSheet(
        isScrollControlled: true,
        context: this.context,
        builder: (context) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.3,
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  "Upload Your Profile Picture",
                  style: TextStyle(fontSize: 20),
                ),
                //
                Container(
                  height: MediaQuery.of(context).size.height * 0.1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                          getImage(ImageSource.camera);
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Icon(
                              Icons.camera,
                              size: 35,
                            ),
                            Text(
                              "Camera",
                              style: TextStyle(fontSize: 16),
                            )
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                          getImage(ImageSource.gallery);
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Icon(
                              Icons.photo_sharp,
                              size: 35,
                            ),
                            Text(
                              "Gallery",
                              style: TextStyle(fontSize: 16),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                //
              ],
            ),
          );
        });
  }

  // ignore: unused_element
  void _showScaffold(String message) {
    // ignore: deprecated_member_use
    scaffoldKeyWallet.currentState.showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: GoogleFonts.poppins(
            color: white,
            fontSize: 17,
            fontWeight: FontWeight.w400,
          ),
        ),
        backgroundColor: blue1,
      ),
    );
  }

  // ignore: todo
  //TODO :languagestart
  bool iconchanged = false;

  // ignore: unused_field
  String _chosenValue;

  final GlobalKey<ScaffoldState> scaffoldKeyWallet =
      new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return loading == true
        ? Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: white,
            child: Center(
              child: SpinKitSpinningLines(
                color: backgroundcolor,
                size: 60,
              ),
            ),
          )
        : Scaffold(
            key: scaffoldKeyWallet,
            appBar: AppBar(
              backgroundColor: backgroundcolor,
              elevation: 0,
              leading: Padding(
                padding: const EdgeInsets.all(5.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Container(
                    // height: 30,
                    // width: 30,
                    color: button,
                    child: IconButton(
                        onPressed: () {
                          widget.selectindex != null && widget.selectindex < 4
                              ?
                              // Navigator.pop(context);
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => Tabscreen(
                                      index: widget.selectindex,
                                    ),
                                  ),
                                )
                              : Navigator.pop(context, false);
                        },
                        icon: Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                        )),
                  ),
                ),
              ),
              title: Text(
                (lang.length != null &&
                        lang.length != 0 &&
                        userLanguage['yourprofile'] != null)
                    ? "${userLanguage['yourprofile']}"
                    : "YOUR PROFILE",
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
              actions: [
                // IconButton(
                //     onPressed: () {
                //       Navigator.push(
                //           context,
                //           MaterialPageRoute(
                //               builder: (context) => WalletScreen()));
                //     },
                //     icon: Icon(
                //       FontAwesomeIcons.wallet,
                //       color: Colors.white,
                //       size: 20,
                //     )),

                // PopupMenuButton<MenuItem>(
                //   onSelected: (menuItems) {
                //     switch (menuItems) {
                //       case MenuItems.itemWallet:
                //         Navigator.push(
                //             context,
                //             MaterialPageRoute(
                //                 builder: (context) => WalletScreen()));
                //         break;
                //       // case MenuItems.itemShare:
                //       //   Navigator.push(
                //       //       context,
                //       //       MaterialPageRoute(
                //       //           builder: (context) => ));
                //       //   break;
                //       default:
                //     }
                //   },
                //   itemBuilder: (context) => [
                //     PopupMenuItem<MenuItem>(
                //         value: MenuItems.menuItems[0],
                //         child: Row(
                //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //           children: [
                //             Icon(
                //               FontAwesomeIcons.wallet,
                //               color: Colors.black,
                //               size: 18,
                //             ),
                //             Text(
                //               "Wallet",
                //               style: GoogleFonts.poppins(
                //                 color: Colors.black,
                //                 fontSize: 15,
                //               ),
                //             )
                //           ],
                //         )),
                //     // PopupMenuItem<MenuItem>(
                //     //     value: MenuItems.menuItems[1],
                //     //     child: Row(
                //     //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //     //       children: [
                //     //         Icon(
                //     //           FontAwesomeIcons.share,
                //     //           color: Colors.black,
                //     //           size: 20,
                //     //         ),
                //     //         Text(
                //     //           "Share",
                //     //           style: GoogleFonts.poppins(
                //     //             color: Colors.black,
                //     //             fontSize: 13,
                //     //           ),
                //     //         )
                //     //       ],
                //     //     ))
                //   ],
                // )
              ],
            ),
            backgroundColor: backgroundcolor,
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 25, left: 30),
                        child: GestureDetector(
                          onTap: () {
                            selectImage();
                          },
                          child: Container(
                            width: 76,
                            height: 76,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: imageFile != ""
                                  ? Image.network(
                                      imageFile,
                                      fit: BoxFit.cover,
                                    )
                                  : Image.asset(
                                      "assets/images/profile.png",
                                      fit: BoxFit.fill,
                                    ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        // height: 200,
                        width: MediaQuery.of(context).size.width * 0.6,
                        //color: Colors.blue,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                top: 25,
                              ),
                              child: Container(
                                alignment: Alignment.topLeft,
                                height: 40,
                                width: 210,
                                //color: Colors.orange,
                                child: Row(
                                  children: [
                                    Container(
                                      alignment: Alignment.topLeft,
                                      height: 40,
                                      width: 210,
                                      child: TextField(
                                        onChanged: (value) {
                                          setState(() {
                                            iconchanged = true;
                                          });
                                        },
                                        controller: _controller,
                                        decoration: new InputDecoration(
                                          suffix: IconButton(
                                            onPressed: () {
                                              iconchanged == true
                                                  ? updateuser(user[0]["uid"],
                                                      _controller, imageFile)
                                                  : print("");
                                            },
                                            icon: iconchanged == true
                                                ? Icon(
                                                    Icons.check_circle,
                                                    color: Colors.green,
                                                  )
                                                : Icon(
                                                    Icons.edit,
                                                    color: white,
                                                  ),
                                            // icon: Icon(Icons.ac_unit,
                                            //     color: Colors.white),
                                          ),
                                          //   suffix: Icon(Icons.ac_unit,color:Colors.white),
                                          filled: true,
                                          border: InputBorder.none,
                                          hintStyle:
                                              TextStyle(color: Colors.white),
                                          hintText: '  Nick Name',
                                        ),
                                        style: TextStyle(
                                            fontSize: 13, color: white),
                                      ),
                                    ),
                                    // IconButton(
                                    //   onPressed: () {
                                    //     iconchanged == true
                                    //         ? updateuser(user[0]["uid"],
                                    //             _controller, imageURL)
                                    //         : print("");
                                    //   },
                                    //   icon: iconchanged == true
                                    //       ? Icon(
                                    //           Icons.check_circle,
                                    //           color: Colors.green,
                                    //         )
                                    //       : Icon(
                                    //           Icons.edit,
                                    //           color: white,
                                    //         ),
                                    // )
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              height: 45,
                              width: 200,
                              decoration: new BoxDecoration(
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.circular(10),
                                color: button,
                              ),
                              child: Row(
                                children: [
                                  Center(
                                    child: Container(
                                        padding: EdgeInsets.only(left: 10),
                                        width: 150,
                                        height: 34,
                                        child: Row(
                                          children: <Widget>[
                                            Expanded(
                                              child: Text(
                                                user[0]["walletaddress"]
                                                            .length >
                                                        8
                                                    ? user[0]["walletaddress"]
                                                        .substring(
                                                            0,
                                                            user[0]["walletaddress"]
                                                                    .length -
                                                                8)
                                                    : user[0]["walletaddress"],
                                                maxLines: 1,
                                                textAlign: TextAlign.end,
                                                overflow: TextOverflow.ellipsis,
                                                style: GoogleFonts.poppins(
                                                  color: white,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Text(
                                                user[0]["walletaddress"]
                                                            .length >
                                                        8
                                                    ? user[0]["walletaddress"]
                                                        .substring(
                                                            user[0]["walletaddress"]
                                                                    .length -
                                                                8)
                                                    : '',
                                                maxLines: 1,
                                                textAlign: TextAlign.start,
                                                style: GoogleFonts.poppins(
                                                  color: white,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                            ),
                                          ],
                                        )
                                        // Center(
                                        // child: Text(
                                        //   user[0]["walletaddress"],
                                        //   textAlign: TextAlign.center,
                                        //   overflow: TextOverflow.ellipsis,
                                        //   style: GoogleFonts.poppins(
                                        //     color: white,
                                        //     fontSize: 12,
                                        //     fontWeight: FontWeight.w400,
                                        //   ),
                                        // ),
                                        ),
                                  ),
                                  // Spacer(),
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Container(
                                      height: 35,
                                      width: 35,
                                      color: blue1,
                                      child: IconButton(
                                        onPressed: () {
                                          FlutterClipboard.copy(
                                            // widget.xumCoinMainNetAddress,
                                            user[0]["walletaddress"],
                                          ).then(
                                            (result) {
                                              Scaffold.of(context)
                                                  // ignore: deprecated_member_use
                                                  .showSnackBar(SnackBar(
                                                content: Text(
                                                    'Wallet address copied to clipboard.'),
                                                backgroundColor: blue1,
                                              ));
                                              //  _showScaffold('Wallet address copied to clipboard.');
                                            },
                                          );
                                        },
                                        icon: Icon(
                                          Icons.copy,
                                          color: Colors.white,
                                          size: 15,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10, top: 5),
                              child: Text(
                                (lang.length != null &&
                                        lang.length != 0 &&
                                        userLanguage[
                                                'earnofreferredearnings'] !=
                                            null)
                                    ? "${userLanguage['earnofreferredearnings']}"
                                    : "Earn 1% of referred earnings",
                                style: GoogleFonts.poppins(
                                    color: blue1,
                                    fontSize: 9,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 50),
                  // Padding(
                  //   padding: const EdgeInsets.only(left: 20, right: 20),
                  //   child: Container(
                  //     height: 70,
                  //     decoration: BoxDecoration(
                  //       color: button,
                  //       borderRadius: BorderRadius.circular(15),
                  //     ),
                  //     child: Column(
                  //       children: [
                  //         Row(
                  //           mainAxisAlignment: MainAxisAlignment.spaceAround,
                  //           children: [
                  //             Padding(
                  //               padding:
                  //                   const EdgeInsets.only(left: 20, top: 5),
                  //               child: Text(
                  //                 (lang.length != null &&
                  //                         lang.length != 0 &&
                  //                         userLanguage['minwithdraw'] != null)
                  //                     ? "${userLanguage['minwithdraw']}"
                  //                     : "MIN WITHDRAW",
                  //                 style: GoogleFonts.poppins(
                  //                   fontSize: 12,
                  //                   fontWeight: FontWeight.w600,
                  //                   color: Colors.grey,
                  //                 ),
                  //               ),
                  //             ),
                  //             Spacer(),
                  //             Padding(
                  //               padding:
                  //                   const EdgeInsets.only(top: 5, right: 25),
                  //               child: Container(
                  //                 height: 35,
                  //                 width: 80,
                  //                 decoration: BoxDecoration(
                  //                     color: backgroundcolor,
                  //                     borderRadius: BorderRadius.circular(10)),
                  //                 child: Center(
                  //                   child: Text(
                  //                     "\$5",
                  //                     style: GoogleFonts.montserrat(
                  //                       color: Colors.white,
                  //                       fontSize: 12,
                  //                     ),
                  //                   ),
                  //                 ),
                  //               ),
                  //             )
                  //           ],
                  //         ),
                  //         Row(
                  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //           children: [
                  //             Padding(
                  //               padding:
                  //                   const EdgeInsets.only(left: 20, top: 5),
                  //               child: Text(
                  //                 (lang.length != null &&
                  //                         lang.length != 0 &&
                  //                         userLanguage[
                  //                                 'currentgasfeeestimated'] !=
                  //                             null)
                  //                     ? "${userLanguage['currentgasfeeestimated']}"
                  //                     : "Current gas fee estimated",
                  //                 style: GoogleFonts.poppins(
                  //                   fontSize: 9,
                  //                   fontWeight: FontWeight.w500,
                  //                   color: blue1,
                  //                 ),
                  //               ),
                  //             ),
                  //             // Spacer(),
                  //             Padding(
                  //               padding:
                  //                   const EdgeInsets.only(right: 50, top: 5),
                  //               child: Text(
                  //                 "\$2.50",
                  //                 style: GoogleFonts.montserrat(
                  //                   color: blue1,
                  //                   fontSize: 9,
                  //                 ),
                  //               ),
                  //             ),
                  //           ],
                  //         )
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  // Padding(
                  //   padding:
                  //       const EdgeInsets.only(left: 20, right: 20, top: 10),
                  //   child: Container(
                  //     height: 70,
                  //     decoration: BoxDecoration(
                  //       color: button,
                  //       borderRadius: BorderRadius.circular(15),
                  //     ),
                  //     child: Column(
                  //       children: [
                  //         Row(
                  //           mainAxisAlignment: MainAxisAlignment.spaceAround,
                  //           children: [
                  //             Padding(
                  //               padding:
                  //                   const EdgeInsets.only(left: 20, top: 10),
                  //               child: Text(
                  //                 (lang.length != null &&
                  //                         lang.length != 0 &&
                  //                         userLanguage['selectcurrency'] !=
                  //                             null)
                  //                     ? "${userLanguage['selectcurrency']}"
                  //                     : "SELECT CURRENCY",
                  //                 style: GoogleFonts.poppins(
                  //                   fontSize: 12,
                  //                   fontWeight: FontWeight.w600,
                  //                   color: Colors.white,
                  //                 ),
                  //               ),
                  //             ),
                  //             Spacer(),
                  //             Padding(
                  //               padding:
                  //                   const EdgeInsets.only(top: 20, right: 25),
                  //               child: Container(
                  //                 height: 35,
                  //                 width: 80,
                  //                 decoration: BoxDecoration(
                  //                     color: backgroundcolor,
                  //                     borderRadius: BorderRadius.circular(10)),
                  //                 child: Center(
                  //                   child: new Theme(
                  //                     data: Theme.of(context).copyWith(
                  //                       canvasColor: backgroundcolor,
                  //                     ),
                  //                     child: DropdownButton<String>(
                  //                       //focusColor: backgroundcolor,
                  //                       value: _chosenValue,
                  //                       underline: Container(),
                  //                       //elevation: 5,
                  //                       style: TextStyle(color: Colors.red),
                  //                       iconEnabledColor: blue1,
                  //                       items: <String>[
                  //                         '€ EUR',
                  //                         '£ GBP',
                  //                         '¥ JPY',
                  //                         '₴ UAH',
                  //                       ].map<DropdownMenuItem<String>>(
                  //                           (String value) {
                  //                         return DropdownMenuItem<String>(
                  //                           value: value,
                  //                           child: Text(
                  //                             value,
                  //                             style: GoogleFonts.montserrat(
                  //                               fontSize: 12,
                  //                               color: Colors.white,
                  //                               fontWeight: FontWeight.w600,
                  //                             ),
                  //                           ),
                  //                         );
                  //                       }).toList(),
                  //                       hint: Text("\$USD",
                  //                           style: GoogleFonts.montserrat(
                  //                             fontSize: 12,
                  //                             color: Colors.white,
                  //                             fontWeight: FontWeight.w600,
                  //                           )),
                  //                       onChanged: (String value) {
                  //                         setState(() {
                  //                           _chosenValue = value;
                  //                         });
                  //                       },
                  //                     ),
                  //                   ),
                  //                 ),
                  //               ),
                  //             ),
                  //           ],
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  // Padding(
                  //   padding:
                  //       const EdgeInsets.only(left: 20, right: 20, top: 10),
                  //   child: Container(
                  //     height: 70,
                  //     decoration: BoxDecoration(
                  //       color: button,
                  //       borderRadius: BorderRadius.circular(15),
                  //     ),
                  //     child: Column(
                  //       children: [
                  //         Row(
                  //           mainAxisAlignment: MainAxisAlignment.start,
                  //           children: [
                  //             Padding(
                  //               padding: const EdgeInsets.only(
                  //                   right: 50, left: 20, top: 15),
                  //               child: Text(
                  //                 (lang.length != null &&
                  //                         lang.length != 0 &&
                  //                         userLanguage['support'] != null)
                  //                     ? "${userLanguage['support']}"
                  //                     : "SUPPORT",
                  //                 style: GoogleFonts.poppins(
                  //                   fontSize: 12,
                  //                   fontWeight: FontWeight.w600,
                  //                   color: Colors.white,
                  //                 ),
                  //               ),
                  //             ),
                  //             Spacer(),
                  //             Padding(
                  //               padding: const EdgeInsets.only(
                  //                   left: 50, right: 25, top: 15),
                  //               child: ClipRRect(
                  //                 borderRadius: BorderRadius.circular(15),
                  //                 child: Container(
                  //                   height: 42,
                  //                   width: 42,
                  //                   color: backgroundcolor,
                  //                   child: IconButton(
                  //                       onPressed: () {},
                  //                       icon: Icon(
                  //                         Icons.search,
                  //                         size: 20,
                  //                         color: blue1,
                  //                       )),
                  //                 ),
                  //               ),
                  //             ),
                  //           ],
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 20, right: 20, top: 10),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => WalletScreen()));
                      },
                      child: Container(
                        height: 70,
                        decoration: BoxDecoration(
                          color: button,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Center(
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 20, top: 25),
                                    child: Text(
                                      (lang.length != null &&
                                              lang.length != 0 &&
                                              userLanguage['aboutus'] != null)
                                          ? "${userLanguage['aboutus']}"
                                          : "WALLET",
                                      style: GoogleFonts.poppins(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 20, right: 20, top: 10),
                    child: Container(
                      height: 70,
                      decoration: BoxDecoration(
                        color: button,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    right: 0, left: 20, top: 15),
                                child: Text(
                                  (lang.length != null &&
                                          lang.length != 0 &&
                                          userLanguage['followus'] != null)
                                      ? "${userLanguage['followus']}"
                                      : "FOLLOW US",
                                  style: GoogleFonts.poppins(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              Spacer(),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      launch(
                                          "https://twitter.com/Smartchainers1");
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 10),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(15),
                                        child: Container(
                                          height: 42,
                                          width: 42,
                                          color: backgroundcolor,
                                          child: Icon(
                                            FontAwesomeIcons.twitter,
                                            color: Colors.blue,
                                            size: 15,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      launch(
                                          "https://www.facebook.com/SmartChainers/");
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          right: 15, top: 10),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(15),
                                        child: Container(
                                          height: 42,
                                          width: 42,
                                          color: backgroundcolor,
                                          child: Icon(
                                            Icons.facebook,
                                            color: Colors.blue,
                                            size: 15,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 20, right: 20, top: 10),
                    child: GestureDetector(
                      onTap: () {
                        launch("https://www.momerlin.com");
                      },
                      child: Container(
                        height: 70,
                        decoration: BoxDecoration(
                          color: button,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Center(
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 20, top: 25),
                                    child: Text(
                                      (lang.length != null &&
                                              lang.length != 0 &&
                                              userLanguage['aboutus'] != null)
                                          ? "${userLanguage['aboutus']}"
                                          : "ABOUT US",
                                      style: GoogleFonts.poppins(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 20, right: 20, top: 10),
                    child: GestureDetector(
                      onTap: () {
                        launch("https://www.momerlin.com/privacyPolicy.html");
                      },
                      child: Container(
                        height: 70,
                        decoration: BoxDecoration(
                          color: button,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Center(
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 20, top: 25),
                                    child: Text(
                                      "PRIVACY POLICY",
                                      style: GoogleFonts.poppins(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  SizedBox(
                    height: 100,
                  ),
                ],
              ),
            ),
          );
  }
}
