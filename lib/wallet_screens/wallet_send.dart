import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:momerlin/data/localstorage/userdata_source.dart';
import 'package:momerlin/theme/theme.dart';
import 'package:momerlin/wallet_screens/wallet_final.dart';

class WalletSend extends StatefulWidget {
  const WalletSend({Key key}) : super(key: key);

  @override
  _WalletSendState createState() => _WalletSendState();
}

class _WalletSendState extends State<WalletSend> {
  var userLanguage, lang = [];
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
    if (lang.length != null && lang.length != 0) {
      userLanguage = lang[0];
    }
  }

  // ignore: todo
  //TODO: LanguageEnd

  // void _showModelSheet() {
  //   showBottomSheet(
  //       backgroundColor: backgroundcolor,
  //       context: context,
  //       builder: (context) {
  //         return Container(
  //           height: 390,
  //           width: MediaQuery.of(context).size.width,
  //           decoration: BoxDecoration(
  //               color: button,
  //               borderRadius: BorderRadius.only(
  //                 topLeft: Radius.circular(20),
  //                 topRight: Radius.circular(20),
  //               )),
  //           child: Column(children: [
  //             Padding(
  //               padding: const EdgeInsets.only(top: 5),
  //               child: Container(
  //                 height: 40,
  //                 width: 200,
  //                 // ignore: deprecated_member_use
  //                 child: RaisedButton(
  //                   shape: RoundedRectangleBorder(
  //                       borderRadius: BorderRadius.circular(25)),
  //                   onPressed: () {},
  //                   color: Colors.black.withOpacity(0.5),
  //                   child: Row(
  //                     mainAxisAlignment: MainAxisAlignment.spaceAround,
  //                     children: <Widget>[
  //                       Icon(
  //                         Icons.copy,
  //                         color: blue1,
  //                         size: 15,
  //                       ),
  //                       Text(
  //                         'PASTE FROM CLIPBOARD',
  //                         style: TextStyle(
  //                           fontSize: 11,
  //                           fontWeight: FontWeight.w700,
  //                           color: Colors.white,
  //                         ),
  //                       ),
  //                     ],
  //                   ),
  //                 ),
  //               ),
  //             ),
  //             Row(children: [
  //               buildButton("1"),
  //               buildButton("2"),
  //               buildButton("3"),
  //             ]),
  //             Row(children: [
  //               buildButton("4"),
  //               buildButton("5"),
  //               buildButton("6"),
  //             ]),
  //             Row(children: [
  //               buildButton("7"),
  //               buildButton("8"),
  //               buildButton("9"),
  //             ]),
  //             Row(children: [
  //               buildButton("*"),
  //               buildButton("0"),
  //               buildButton1(""),
  //             ]),
  //           ]),
  //         );
  //       });
  // }

  Widget buildButton(String buttonText) {
    return new Expanded(
      child: new MaterialButton(
        padding: new EdgeInsets.all(15),
        child: new Text(
          buttonText,
          style: GoogleFonts.poppins(
            fontSize: 28,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        onPressed: () {
          setState(() {
            output = output + buttonText;
          });
        },
      ),
    );
  }

  Widget buildButton1(String iconButton) {
    return new Expanded(
      child: new MaterialButton(
        onPressed: () {
          setState(() {
            output = "0";
          });
        },
        padding: new EdgeInsets.all(24.0),
        child: IconButton(
          onPressed: () {
            setState(() {
              output = "0";
            });
          },
          icon: Icon(
            Icons.backspace_sharp,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: backgroundcolor,
        body: Column(
          children: [
            Container(
              //color: Colors.amber,
              height: MediaQuery.of(context).size.height * 0.52,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      height: 70,
                      width: MediaQuery.of(context).size.width,
                      //color: Colors.amber,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(30),
                              child: Container(
                                height: 50,
                                width: 50,
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
                            Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: Text(
                                (lang.length != null &&
                                        lang.length != 0 &&
                                        userLanguage['sendfunds'] != null)
                                    ? "${userLanguage['sendfunds']}"
                                    : "SEND FUNDS",
                                style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontSize: 17,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      height: 70,
                      width: MediaQuery.of(context).size.width,
                      //color: Colors.blueAccent,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 25, top: 20),
                        child: Text(
                          (lang.length != null &&
                                  lang.length != 0 &&
                                  userLanguage['iwanttosend'] != null)
                              ? "${userLanguage['iwanttosend']}"
                              : "I want to send",
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 21,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.15,
                      width: MediaQuery.of(context).size.width,
                      //color: Colors.amber,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 25),
                            child: RichText(
                              text: TextSpan(
                                children: <TextSpan>[
                                  TextSpan(
                                    text: (lang.length != null &&
                                            lang.length != 0 &&
                                            userLanguage['0'] != null)
                                        ? "${userLanguage['0']}"
                                        : output,
                                    style: GoogleFonts.montserrat(
                                      fontSize: 101,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.white,
                                    ),
                                  ),
                                  TextSpan(
                                    text: (lang.length != null &&
                                            lang.length != 0 &&
                                            userLanguage['.00'] != null)
                                        ? "${userLanguage['.00']}"
                                        : '.00',
                                    style: GoogleFonts.montserrat(
                                      fontSize: 25,
                                      fontFeatures: [FontFeature.subscripts()],
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 15),
                            child: Text(
                              (lang.length != null &&
                                      lang.length != 0 &&
                                      userLanguage['sats'] != null)
                                  ? "${userLanguage['sats']}"
                                  : "SATs",
                              style: GoogleFonts.montserrat(
                                fontSize: 21,
                                color: Colors.orangeAccent,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 150,
                      width: MediaQuery.of(context).size.width,
                      //color: Colors.blueAccent,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Text(
                              (lang.length != null &&
                                      lang.length != 0 &&
                                      userLanguage['to'] != null)
                                  ? "${userLanguage['to']}"
                                  : 
                              "to:",
                              style: GoogleFonts.poppins(
                                fontSize: 25,
                                color: Colors.white,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Container(
                                height: 130,
                                width: 110,
                                //color: button,
                                decoration: BoxDecoration(
                                  color: button,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 25),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(30),
                                        child: Container(
                                          height: 50,
                                          width: 50,
                                          color: blue1,
                                          child: IconButton(
                                              onPressed: () {},
                                              icon: Icon(
                                                Icons.qr_code_scanner,
                                                color: Colors.white,
                                              )),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 15),
                                      child: Text(
                                        (lang.length != null &&
                                                lang.length != 0 &&
                                                userLanguage['scanqrcode'] != null)
                                            ? "${userLanguage['scanqrcode']}"
                                            : "Scan QR code",
                                        style: GoogleFonts.poppins(
                                            fontSize: 12, color: Colors.grey),
                                      ),
                                    )
                                  ],
                                )),
                          ),
                          GestureDetector(
                            onTap: () {
                              // _showModelSheet();
                              setState(() {
                                widthbtc = 200;
                              });
                            },
                            onDoubleTap: () {
                              setState(() {
                                widthbtc = 110;
                              });
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: AnimatedContainer(
                                  duration: Duration(milliseconds: 500),
                                  height: 130,
                                  width: widthbtc,
                                  //color: button,
                                  decoration: BoxDecoration(
                                    color: button,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(top: 25),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          child: Container(
                                            height: 50,
                                            width: 50,
                                            color: Colors.greenAccent,
                                            child: IconButton(
                                                onPressed: () {
                                                  // _showModelSheet();
                                                  setState(() {
                                                    widthbtc = 200;
                                                  });
                                                },
                                                icon: Icon(
                                                  Icons.stacked_line_chart,
                                                  color: Colors.white,
                                                )),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 15),
                                        child: Text(
                                          (lang.length != null &&
                                                  lang.length != 0 &&
                                                  userLanguage['btcaddress'] !=
                                                      null)
                                              ? "${userLanguage['btcaddress']}"
                                              : "BTC Address",
                                          style: GoogleFonts.poppins(
                                              fontSize: 12, color: Colors.grey),
                                        ),
                                      )
                                    ],
                                  )),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 160,
                      width: MediaQuery.of(context).size.width,
                      //color: Colors.amber,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 30),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 50),
                                  child: Container(
                                    height: 30,
                                    width: 30,
                                    child: Icon(
                                      Icons.fmd_bad_rounded,
                                      color: blue1,
                                    ),
                                  ),
                                ),
                                Text(
                                  (lang.length != null &&
                                          lang.length != 0 &&
                                          userLanguage['pleasedoublecheckyourrecipientsinfo'] != null)
                                      ? "${userLanguage['pleasedoublecheckyourrecipientsinfo']}"
                                      : 
                                  "PLEASE DOUBLE CHECK YOUR RECIPIENTS INFO",
                                  style: GoogleFonts.poppins(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.grey,
                                  ),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: Container(
                              height: 50,
                              width: MediaQuery.of(context).size.width * 0.9,
                              // ignore: deprecated_member_use
                              child: RaisedButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15)),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => WalletFinal()));
                                },
                                color: blue1,
                                child: Text(
                                  (lang.length != null &&
                                          lang.length != 0 &&
                                          userLanguage['sendnow'] != null)
                                      ? "${userLanguage['sendnow']}"
                                      : 
                                  'SEND NOW',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.43,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: button,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  )),
              child: Column(children: [
                Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Container(
                    height: 40,
                    width: 200,
                    // ignore: deprecated_member_use
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25)),
                      onPressed: () {},
                      color: Colors.black.withOpacity(0.5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Icon(
                            Icons.copy,
                            color: blue1,
                            size: 15,
                          ),
                          Text(
                            (lang.length != null &&
                                    lang.length != 0 &&
                                    userLanguage['pastefromclipboard'] != null)
                                ? "${userLanguage['pastefromclipboard']}"
                                : 
                            'PASTE FROM CLIPBOARD',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Row(children: [
                  buildButton("1"),
                  buildButton("2"),
                  buildButton("3"),
                ]),
                Row(children: [
                  buildButton("4"),
                  buildButton("5"),
                  buildButton("6"),
                ]),
                Row(children: [
                  buildButton("7"),
                  buildButton("8"),
                  buildButton("9"),
                ]),
                Row(children: [
                  buildButton("*"),
                  buildButton("0"),
                  buildButton1(""),
                ]),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
