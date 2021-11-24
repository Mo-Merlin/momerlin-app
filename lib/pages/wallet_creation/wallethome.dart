import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:momerlin/data/localstorage/userdata_source.dart';
import 'package:momerlin/pages/wallet_creation/walletseed.dart';
import 'package:momerlin/theme/theme.dart';

import 'importwallet.dart';

class WalletHomePage extends StatefulWidget {
  @override
  _WalletHomePage createState() => _WalletHomePage();
}

class _WalletHomePage extends State<WalletHomePage> {
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
      backgroundColor: Color(0xff6C6AEB),
      body: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Color(0xff6C6AEB),
          image: DecorationImage(
              image: AssetImage(
                "assets/images/Login3.png",
              ),
              fit: BoxFit.fill),
        ),
        child: SingleChildScrollView(
          padding: EdgeInsets.only(left: 20, right: 20, top: MediaQuery.of(context).size.height * 0.33),
          child: Container(
            // height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                // Image.asset(
                //   "assets/images/toyface.png",
                // ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.6,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      color: backgroundcolor),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 55,
                      ),
                      Text(
                        (lang.length != null &&
                                lang.length != 0 &&
                                userLanguage['heythereyounewhere'] != null)
                            ? "${userLanguage['heythereyounewhere']}"
                            : "Hey there,\nyou new here?",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                            height: 1,
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => WalletSeedPage()));
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.6,
                          height: MediaQuery.of(context).size.height * 0.09,
                          padding: EdgeInsets.only(left: 20),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(19),
                              color: blue),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Icon(
                                Icons.add,
                                color: white,
                              ),
                              Text(
                                (lang.length != null &&
                                        lang.length != 0 &&
                                        userLanguage['createWallet'] != null)
                                    ? "${userLanguage['createWallet']}"
                                    : "Create Wallet",
                                style: GoogleFonts.poppins(
                                    color: white,
                                    fontSize: 15,
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
                      SizedBox(
                        height: 15,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ImportWalletPage()));
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.6,
                          height: MediaQuery.of(context).size.height * 0.09,
                          padding: EdgeInsets.only(left: 20),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(19),
                              color: button),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Icon(
                                Icons.file_upload_outlined,
                                color: white,
                              ),
                              Text(
                                (lang.length != null &&
                                        lang.length != 0 &&
                                        userLanguage['importWallet'] != null)
                                    ? "${userLanguage['importWallet']}"
                                    : "Import Wallet",
                                style: GoogleFonts.poppins(
                                    color: white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w700),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 70),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.7,
                        child: Row(
                          children: [
                            Text(
                              (lang.length != null &&
                                      lang.length != 0 &&
                                      userLanguage['termsConditions'] != null)
                                  ? "${userLanguage['termsConditions']}"
                                  : "Terms & Conditions",
                              style: GoogleFonts.poppins(
                                  color: text1,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500),
                            ),
                            Spacer(),
                            Text(
                              (lang.length != null &&
                                      lang.length != 0 &&
                                      userLanguage['privacyPolicy'] != null)
                                  ? "${userLanguage['privacyPolicy']}"
                                  : "Privacy Policy",
                              style: GoogleFonts.poppins(
                                  color: text1,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
