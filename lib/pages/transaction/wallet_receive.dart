import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:momerlin/data/localstorage/userdata_source.dart';
import 'package:momerlin/theme/theme.dart';
import 'package:qr_flutter/qr_flutter.dart';
// import 'package:share/share.dart';
import 'package:clipboard/clipboard.dart';
import 'package:share/share.dart';

class WalletReceive extends StatefulWidget {
  @override
  _WalletReceiveState createState() => _WalletReceiveState();
}

class _WalletReceiveState extends State<WalletReceive> {
  final GlobalKey<ScaffoldState> scaffoldKeyWallet =
      new GlobalKey<ScaffoldState>();
  var userLanguage, user, lang = [];
  double widthbtc = 110;
  String output = "0";

  @override
  void initState() {
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

  // ignore: todo
  //TODO: LanguageEnd
  // ignore: unused_element
  _onShareData(BuildContext context) async {
    final RenderBox box = context.findRenderObject();
    {
      await Share.share(user[0]["walletaddress"],
          subject: user[0]["walletaddress"],
          sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
    }
  }

  String text = '';
  // String _scanBarcode = "";
  // ignore: deprecated_member_use
  bool loading = true, buttonpressed = false;

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
            backgroundColor: backgroundcolor,
            appBar: AppBar(
              backgroundColor: backgroundcolor,
              elevation: 0,
              leading: Padding(
                padding: const EdgeInsets.all(5.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Container(
                    // height: 50,
                    // width: 50,
                    color: button,
                    child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                        )),
                  ),
                ),
              ),
              title: Text(
                "RECEIVE FUNDS",
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            body: SingleChildScrollView(
              // padding: EdgeInsets.only(left: 40, right: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 50,
                  ),
                  Center(
                    child: Container(
                      // width: MediaQuery.of(context).size.width / 1.2,
                      height: MediaQuery.of(context).size.height / 1.9,
                      // height: 356,
                      width: 300,
                      decoration: BoxDecoration(
                        color: gridcolor,
                        borderRadius: BorderRadius.circular(36),
                      ),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 40,
                          ),
                          QrImage(
                            eyeStyle: QrEyeStyle(eyeShape: QrEyeShape.circle),
                            data: user[0]["walletaddress"],
                            size: MediaQuery.of(context).size.width / 1.7,
                            gapless: false,
                            dataModuleStyle: const QrDataModuleStyle(
                              dataModuleShape: QrDataModuleShape.circle,
                            ),
                            foregroundColor: white,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width / 1.5,
                            //color: Colors.amber,
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 3),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 26),
                                    child: Text(
                                      "Address",
                                      textAlign: TextAlign.left,
                                      style: GoogleFonts.poppins(
                                        color: white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 30),
                                    child: Row(
                                      children: [
                                        Container(
                                            padding: EdgeInsets.only(left: 10),
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                2.4,
                                            height: 34,
                                            decoration: BoxDecoration(
                                              color: backgroundcolor,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: Row(
                                              children: <Widget>[
                                                Expanded(
                                                  child: Text(
                                                    user[0]["walletaddress"]
                                                                .length >
                                                            8
                                                        ? user[0][
                                                                "walletaddress"]
                                                            .substring(
                                                                0,
                                                                user[0]["walletaddress"]
                                                                        .length -
                                                                    8)
                                                        : user[0]
                                                            ["walletaddress"],
                                                    maxLines: 1,
                                                    textAlign: TextAlign.end,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: GoogleFonts.poppins(
                                                      color: white,
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Text(
                                                    user[0]["walletaddress"]
                                                                .length >
                                                            8
                                                        ? user[0][
                                                                "walletaddress"]
                                                            .substring(user[0][
                                                                        "walletaddress"]
                                                                    .length -
                                                                8)
                                                        : '',
                                                    maxLines: 1,
                                                    textAlign: TextAlign.start,
                                                    style: GoogleFonts.poppins(
                                                      color: white,
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w400,
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
                                        // ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Container(
                                          width: 29,
                                          height: 29,
                                          decoration: BoxDecoration(
                                            color: blue1,
                                            borderRadius:
                                                BorderRadius.circular(50),
                                          ),
                                          child: GestureDetector(
                                            child: Icon(
                                              Icons.copy,
                                              size: 10,
                                              color: white,
                                            ),
                                            onTap: () {
                                              FlutterClipboard.copy(
                                                user[0]["walletaddress"],
                                              ).then(
                                                (result) {
                                                  _showScaffold(
                                                      'Wallet address copied to clipboard.');
                                                },
                                              );
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  GestureDetector(
                    onTap: () {
                      // setState(() {
                      //   buttonpressed = true;
                      // });
                      Share.share(
                        user[0]["walletaddress"],
                        subject: "Wallet Address",
                      );

                      // _onShareData(context);
                      // Navigator.pop(context);
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.6,
                      height: MediaQuery.of(context).size.height * 0.09,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(35),
                          color: blue1),
                      // height: 50,
                      // width: MediaQuery.of(context).size.width * 0.9,
                      // ignore: deprecated_member_use
                      child: Center(
                        child: buttonpressed == true
                            ? SpinKitThreeBounce(
                                color: white,
                                size: 20,
                              )
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.file_upload_outlined,
                                    color: white,
                                    size: 20,
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Text(
                                    (lang.length != null &&
                                            lang.length != 0 &&
                                            userLanguage['shareaddress'] !=
                                                null)
                                        ? "${userLanguage['shareaddress']}"
                                        : 'SHARE ADDRESS',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
  }

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
