import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:momerlin/data/localstorage/userdata_source.dart';
import 'package:momerlin/theme/theme.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:momerlin/wallet_screens/wallet_profile.dart';
import 'package:momerlin/wallet_screens/wallet_send.dart';

class WalletTwo extends StatefulWidget {
  const WalletTwo({Key key}) : super(key: key);

  @override
  _WalletTwoState createState() => _WalletTwoState();
}

class _WalletTwoState extends State<WalletTwo> {
  var userLanguage, lang = [];
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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: backgroundcolor,
        body: Stack(children: [
          Container(
            height: 460,
            width: MediaQuery.of(context).size.width,
            //color: Colors.amber,
            child: Column(
              children: [
                AnimatedContainer(
                  duration: Duration(milliseconds: 200),
                  //color: blue1,
                  height: 315,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: blue1,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.elliptical(200, 180),
                      bottomRight: Radius.elliptical(270, 90),
                    ),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 40),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => WalletProfile()));
                          },
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(30),
                              child: Container(
                                height: 60,
                                width: 60,
                                child: Image.network(
                                  'https://www.pngitem.com/pimgs/m/78-786293_1240-x-1240-0-avatar-profile-icon-png.png',
                                  fit: BoxFit.cover,
                                ),
                              )),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Text(
                          (lang.length != null &&
                                  lang.length != 0 &&
                                  userLanguage['yourBalanceIs'] != null)
                              ? "${userLanguage['yourBalanceIs']}"
                              : "Your balance is",
                          style: GoogleFonts.poppins(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Center(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            RichText(
                              text: TextSpan(
                                children: <TextSpan>[
                                  TextSpan(
                                    text: (lang.length != null &&
                                            lang.length != 0 &&
                                            userLanguage['355'] != null)
                                        ? "${userLanguage['355']}"
                                        : '355',
                                    style: GoogleFonts.montserrat(
                                      fontSize: 70,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  // TextSpan(
                                  //   text: 'SATs',
                                  //   style: GoogleFonts.poppins(
                                  //     fontSize: 15,
                                  //     fontFeatures: [
                                  //       FontFeature.superscripts()
                                  //     ],
                                  //     color: Colors.black,
                                  //   ),
                                  // ),
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
                            Padding(
                              padding: const EdgeInsets.only(top: 15),
                              child: Text(
                                (lang.length != null &&
                                        lang.length != 0 &&
                                        userLanguage['sats'] != null)
                                    ? "${userLanguage['sats']}"
                                    : "SATs",
                                style: GoogleFonts.montserrat(
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        // color: button,
                        height: 40,
                        width: 100,
                        decoration: BoxDecoration(
                          color: Color(0xff707070).withOpacity(0.4),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            (lang.length != null &&
                                    lang.length != 0 &&
                                    userLanguage['0.64USD'] != null)
                                ? "${userLanguage['0.64USD']}"
                                : "0.64USD",
                            style: GoogleFonts.montserrat(
                              fontSize: 13,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => WalletSend()));
                        },
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
                                      color: Colors.green[300],
                                      child: IconButton(
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        WalletSend()));
                                          },
                                          icon: Icon(
                                            Icons.arrow_upward,
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
                                            userLanguage['send'] != null)
                                        ? "${userLanguage['send']}"
                                        : "Send",
                                    style: GoogleFonts.poppins(
                                        fontSize: 15, color: Colors.grey),
                                  ),
                                )
                              ],
                            )),
                      ),
                      Container(
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
                                          Icons.arrow_downward,
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
                                          userLanguage['receive'] != null)
                                      ? "${userLanguage['receive']}"
                                      : "Receive",
                                  style: GoogleFonts.poppins(
                                      fontSize: 15, color: Colors.grey),
                                ),
                              )
                            ],
                          )),
                      Container(
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
                                    color: Colors.orange[300],
                                    child: IconButton(
                                        onPressed: () {},
                                        icon: Icon(
                                          FontAwesomeIcons.dollarSign,
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
                                          userLanguage['earn'] != null)
                                      ? "${userLanguage['earn']}"
                                      : "Earn",
                                  style: GoogleFonts.poppins(
                                      fontSize: 15, color: Colors.grey),
                                ),
                              )
                            ],
                          ))
                    ],
                  ),
                ),
              ],
            ),
          ),
          DraggableScrollableSheet(
            initialChildSize: 0.4,
            minChildSize: 0.4,
            maxChildSize: 0.7,
            builder: (BuildContext context, myscrollController) {
              return Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: button,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                    ),
                    //color: button,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 30),
                          child: Container(
                            height: 6,
                            width: 80,
                            decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(10)),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 30),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: Text(
                                  (lang.length != null &&
                                          lang.length != 0 &&
                                          userLanguage['transaction'] != null)
                                      ? "${userLanguage['transaction']}"
                                      : "Transaction",
                                  style: GoogleFonts.poppins(
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 20),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Container(
                                    height: 40,
                                    width: 40,
                                    color: Colors.black54,
                                    child: IconButton(
                                        onPressed: () {},
                                        icon: Icon(
                                          Icons.search,
                                          color: blue1,
                                        )),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 100),
                    child: ListView.builder(
                      controller: myscrollController,
                      itemCount: 25,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Container(
                            child: ListTile(
                              leading: ClipRRect(
                                borderRadius: BorderRadius.circular(30),
                                child: Container(
                                    height: 60,
                                    width: 60,
                                    color: Colors.black54,
                                    child: Image.network(
                                      "https://c.static-nike.com/a/images/w_1920,c_limit/mdbgldn6yg1gg88jomci/image.jpg",
                                      fit: BoxFit.cover,
                                    )),
                              ),
                              title: Text(
                                (lang.length != null &&
                                        lang.length != 0 &&
                                        userLanguage['nikecom'] != null)
                                    ? "${userLanguage['nikecom']}"
                                    : 'Nike.com',
                                style: GoogleFonts.poppins(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white),
                              ),
                              subtitle: Text(
                                (lang.length != null &&
                                        lang.length != 0 &&
                                        userLanguage['minago'] != null)
                                    ? "${userLanguage['minago']}"
                                    : '3 min ago',
                                style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  color: Colors.white,
                                ),
                              ),
                              trailing: Container(
                                height: 40,
                                width: 100,
                                decoration: BoxDecoration(
                                  color: Color(0xff707070).withOpacity(0.4),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Center(
                                  child: RichText(
                                    text: TextSpan(
                                      text: (lang.length != null &&
                                              lang.length != 0 &&
                                              userLanguage['-12.00'] != null)
                                          ? "${userLanguage['-12.00']}"
                                          : '-12.00 ',
                                      style: GoogleFonts.montserrat(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white,
                                      ),
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: (lang.length != null &&
                                                  lang.length != 0 &&
                                                  userLanguage['sats'] != null)
                                              ? "${userLanguage['sats']}"
                                              : ' sats',
                                          style: GoogleFonts.montserrat(
                                            fontSize: 12,
                                            color: Colors.orangeAccent,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
            },
          )
        ]),
      ),
    );
  }
}
