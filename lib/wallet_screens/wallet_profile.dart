import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:momerlin/data/localstorage/userdata_source.dart';
import 'package:momerlin/tabscreen/tabscreen.dart';
import 'package:momerlin/theme/theme.dart';
import 'package:google_fonts/google_fonts.dart';

class WalletProfile extends StatefulWidget {
  const WalletProfile({Key key}) : super(key: key);

  @override
  _WalletProfileState createState() => _WalletProfileState();
}

class _WalletProfileState extends State<WalletProfile> {
  var userLanguage, user, lang = [];
  bool loading = true;
  @override
  void initState() {
    loading = true;
    super.initState();
    getUserLanguage();
  }

  // ignore: todo
  //TODO :languagestart
  Future<void> getUserLanguage() async {
    lang = await UserDataSource().getLanguage();
    user = await UserDataSource().getUser();
    setState(() {
      loading = false;
    });
    if (lang.length != null && lang.length != 0) {
      userLanguage = lang[0];
    }
  }

  TextEditingController _controller;
  // ignore: todo
  //TODO: LanguageEnd
  String _chosenValue;
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
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => Tabscreen(
                                        index: 0,
                                      ),),);
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
                        child: Container(
                          //color: Colors.redAccent,
                          child: Container(
                            child: Image.asset(
                              "assets/images/profile.png",
                              fit: BoxFit.fill,
                              width: 76,
                              height: 76,
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
                                child: TextField(
                                  // onChanged: (value) {
                                  //   _scanBarcode = value;
                                  // },
                                  controller: _controller,
                                  decoration: new InputDecoration(
                                      filled: true,
                                      border: InputBorder.none,
                                      hintStyle: TextStyle(color: Colors.white),
                                      hintText: '  Nick Name',
                                      suffixIcon:
                                          Icon(Icons.edit, color: white)),

                                  style: TextStyle(fontSize: 13, color: white),
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
                                      width: 160,
                                      child: Text(
                                        user[0]["walletaddress"],
                                        textAlign: TextAlign.center,
                                        overflow: TextOverflow.ellipsis,
                                        // overflow: Overflow.clip,
                                        style: TextStyle(
                                            fontSize: 14, color: Colors.white),
                                      ),
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
                                              _showScaffold('Address Copied');
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
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Container(
                      height: 70,
                      decoration: BoxDecoration(
                        color: button,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 20, top: 5),
                                child: Text(
                                  (lang.length != null &&
                                          lang.length != 0 &&
                                          userLanguage['minwithdraw'] != null)
                                      ? "${userLanguage['minwithdraw']}"
                                      : "MIN WITHDRAW",
                                  style: GoogleFonts.poppins(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                              Spacer(),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 5, right: 25),
                                child: Container(
                                  height: 35,
                                  width: 80,
                                  decoration: BoxDecoration(
                                      color: backgroundcolor,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Center(
                                    child: Text(
                                      "\$5",
                                      style: GoogleFonts.montserrat(
                                        color: Colors.white,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 20, top: 5),
                                child: Text(
                                  (lang.length != null &&
                                          lang.length != 0 &&
                                          userLanguage[
                                                  'currentgasfeeestimated'] !=
                                              null)
                                      ? "${userLanguage['currentgasfeeestimated']}"
                                      : "Current gas fee estimated",
                                  style: GoogleFonts.poppins(
                                    fontSize: 9,
                                    fontWeight: FontWeight.w500,
                                    color: blue1,
                                  ),
                                ),
                              ),
                              // Spacer(),
                              Padding(
                                padding:
                                    const EdgeInsets.only(right: 50, top: 5),
                                child: Text(
                                  "\$2.50",
                                  style: GoogleFonts.montserrat(
                                    color: blue1,
                                    fontSize: 9,
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
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
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 20, top: 10),
                                child: Text(
                                  (lang.length != null &&
                                          lang.length != 0 &&
                                          userLanguage['selectcurrency'] !=
                                              null)
                                      ? "${userLanguage['selectcurrency']}"
                                      : "SELECT CURRENCY",
                                  style: GoogleFonts.poppins(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              Spacer(),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 20, right: 25),
                                child: Container(
                                  height: 35,
                                  width: 80,
                                  decoration: BoxDecoration(
                                      color: backgroundcolor,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Center(
                                    child: new Theme(
                                      data: Theme.of(context).copyWith(
                                        canvasColor: backgroundcolor,
                                      ),
                                      child: DropdownButton<String>(
                                        //focusColor: backgroundcolor,
                                        value: _chosenValue,
                                        underline: Container(),
                                        //elevation: 5,
                                        style: TextStyle(color: Colors.red),
                                        iconEnabledColor: blue1,
                                        items: <String>[
                                          '€ EUR',
                                          '£ GBP',
                                          '¥ JPY',
                                          '₴ UAH',
                                        ].map<DropdownMenuItem<String>>(
                                            (String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(
                                              value,
                                              style: GoogleFonts.montserrat(
                                                fontSize: 12,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          );
                                        }).toList(),
                                        hint: Text("\$USD",
                                            style: GoogleFonts.montserrat(
                                              fontSize: 12,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w600,
                                            )),
                                        onChanged: (String value) {
                                          setState(() {
                                            _chosenValue = value;
                                          });
                                        },
                                      ),
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
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    right: 50, left: 20, top: 15),
                                child: Text(
                                  (lang.length != null &&
                                          lang.length != 0 &&
                                          userLanguage['support'] != null)
                                      ? "${userLanguage['support']}"
                                      : "SUPPORT",
                                  style: GoogleFonts.poppins(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              Spacer(),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 50, right: 25, top: 15),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: Container(
                                    height: 42,
                                    width: 42,
                                    color: backgroundcolor,
                                    child: IconButton(
                                        onPressed: () {},
                                        icon: Icon(
                                          Icons.search,
                                          size: 20,
                                          color: blue1,
                                        )),
                                  ),
                                ),
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
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(15),
                                      child: Container(
                                        height: 42,
                                        width: 42,
                                        color: backgroundcolor,
                                        child: IconButton(
                                            onPressed: () {},
                                            icon: Icon(
                                              FontAwesomeIcons.twitter,
                                              color: Colors.blue,
                                              size: 15,
                                            )),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        right: 15, top: 10),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(15),
                                      child: Container(
                                        height: 42,
                                        width: 42,
                                        color: backgroundcolor,
                                        child: IconButton(
                                          onPressed: () {},
                                          icon: Icon(
                                            FontAwesomeIcons.facebook,
                                            color: Color(0xff4267B2),
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
                                  padding:
                                      const EdgeInsets.only(left: 20, top: 25),
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
                  SizedBox(height: 100,),
                ],
              ),
            ),
          );
  }

  final GlobalKey<ScaffoldState> scaffoldKeyWallet =
      new GlobalKey<ScaffoldState>();
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
}
