import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:momerlin/data/localstorage/userdata_source.dart';
import 'package:momerlin/pages/transaction/wallet_screen.dart';
//import 'package:momerlin/tabscreen/tabscreen.dart';
import 'package:momerlin/theme/theme.dart';
// import 'package:momerlin/walletcreation.dart/wallethome.dart';

class WalletFinal extends StatefulWidget {
  const WalletFinal({Key key}) : super(key: key);

  @override
  _WalletFinalState createState() => _WalletFinalState();
}

class _WalletFinalState extends State<WalletFinal> {
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
    return Scaffold(
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
      ),
      body: SingleChildScrollView(
        // padding: EdgeInsets.only(left: 20, right: 20, top: 270),
        child: Column(
          children: [
            Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 130),
                  child: Container(
                    padding: const EdgeInsets.only(
                      left: 40,
                      right: 40,
                    ),
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.52,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: button,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 120,
                        ),
                        Text(
                          (lang.length != null &&
                                  lang.length != 0 &&
                                  userLanguage['justlikemagicyourealldone'] !=
                                      null)
                              ? "${userLanguage['justlikemagicyourealldone']}"
                              : "Just like magic,\nyou’re all done!",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                              height: 1,
                              color: Colors.white,
                              fontSize: 30,
                              fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          (lang.length != null &&
                                  lang.length != 0 &&
                                  userLanguage[
                                          'thoughitmaytakeourmagicminstoreachyourdestination'] !=
                                      null)
                              ? "${userLanguage['thoughitmaytakeourmagicminstoreachyourdestination']}"
                              : "(Though it may take our magic 5-10 mins to reach your destination)",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                            color: text1,
                            letterSpacing: 1,
                            fontSize: 12,
                          ),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) => Tabscreen()));
                          },
                          child: Container(
                            width: 245,

                            // height: MediaQuery.of(context).size.height * 0.07,
                            height: 50,
                            padding: EdgeInsets.only(left: 20),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: blue1),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  (lang.length != null &&
                                          lang.length != 0 &&
                                          userLanguage['sendmore'] != null)
                                      ? "${userLanguage['sendmore']}"
                                      : "SEND MORE",
                                  style: GoogleFonts.poppins(
                                      color: white,
                                      letterSpacing: 1,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                              ],
                              // ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => WalletScreen()));
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.8,
                            height: MediaQuery.of(context).size.height * 0.05,
                            padding: EdgeInsets.only(left: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  (lang.length != null &&
                                          lang.length != 0 &&
                                          userLanguage['gohome'] != null)
                                      ? "${userLanguage['gohome']}"
                                      : "GO HOME",
                                  style: GoogleFonts.poppins(
                                      color: white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                              ],
                              // ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  left: 100,
                  top: 20,
                  child: Image.asset("assets/images/final.png"),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
