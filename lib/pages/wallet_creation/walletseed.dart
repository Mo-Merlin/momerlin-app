import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:momerlin/data/localstorage/userdata_source.dart';
import 'package:momerlin/pages/wallet_creation/walletseed1.dart';
import 'package:momerlin/theme/theme.dart';

import 'package:bip39/bip39.dart' as bip39;
import 'package:percent_indicator/linear_percent_indicator.dart';

class WalletSeedPage extends StatefulWidget {
  @override
  _WalletSeedPage createState() => _WalletSeedPage();
}

class _WalletSeedPage extends State<WalletSeedPage> {
  var userLanguage, lang = [];

  var seed1, seed;
  bool loading = false;
  @override
  void initState() {
    super.initState();
    loading = false;
    createaddress();
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

// ignore: todo

// ignore: todo
//TODO: seed & address creation
  void createaddress() async {
    // loading = false;
    seed = bip39.generateMnemonic();

    // String _pk = Web3.privateKeyFromMnemonic(seed);

    // String _address = await Web3.getAddressFromPrivateKey(_pk);
    // print("addrwss $_address");

    var seed2 = seed.split(" ");

    seed1 = seed2;
    loading = true;
  }
// ignore: todo
//TODO: seed & address end

  @override
  Widget build(BuildContext context) {
    return loading == true
        ? Scaffold(
            backgroundColor: backgroundcolor,
            appBar: AppBar(
              elevation: 0,
              backgroundColor: backgroundcolor,
              leading: Container(
                padding: EdgeInsets.all(5),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50), color: button),
                    child: Icon(
                      Icons.arrow_back,
                      color: white,
                      size: 30,
                    ),
                  ),
                ),
              ),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Spacer(),
                  Image.asset(
                    "assets/images/MOMERLIN.png",
                    height: 40,
                  ),
                  Spacer(),
                  LinearPercentIndicator(
                    width: 102.0,
                    lineHeight: 25.0,
                    percent: 0.007,

                    center: Padding(
                      padding: EdgeInsets.only(left: 50),
                      child: Text(
                        "10%",
                        textAlign: TextAlign.end,
                        style: GoogleFonts.poppins(
                            color: white,
                            fontSize: 12,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                    // trailing: Icon(Icons.mood),
                    linearStrokeCap: LinearStrokeCap.roundAll,
                    backgroundColor: gridcolor,
                    progressColor: blue,
                  ),
                ],
              ),
            ),
            body: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: SingleChildScrollView(
                padding: EdgeInsets.only(left: 25, right: 25),
                child: Column(
                  children: [
                    SizedBox(
                      height: 60,
                    ),
                    Text(
                      (lang.length != null &&
                              lang.length != 0 &&
                              userLanguage['writedownthesewordsinorder'] !=
                                  null)
                          ? "${userLanguage['writedownthesewordsinorder']}"
                          : "Write down these 12 words in order",
                      // textAlign: TextAlign.left,
                      style: GoogleFonts.poppins(
                          height: 1.2,
                          color: white,
                          fontSize: 30,
                          fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      (lang.length != null &&
                              lang.length != 0 &&
                              userLanguage['recoverykey'] != null)
                          ? "${userLanguage['recoverykey']}"
                          : "This is your recovery key - you’ll need it if you ever need to recover your account",
                      style: GoogleFonts.poppins(
                          color: Color(0xff3B3D4D),
                          fontSize: 12,
                          fontWeight: FontWeight.w400),
                    ),
                    SizedBox(
                      height: 45,
                    ),
                    GridView.builder(
                      shrinkWrap: true,
                      itemCount: seed1.length,
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          childAspectRatio: 1.8,
                          crossAxisSpacing: 30,
                          mainAxisSpacing: 30),
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: blue1),
                          child: Center(
                            child: Text(
                              seed1[index],
                              textAlign: TextAlign.center,
                              style: GoogleFonts.poppins(
                                  color: white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        );
                      },
                    ),
                    SizedBox(
                      height: 70,
                    ),
                    GestureDetector(
                      onTap: () {
                        FlutterClipboard.copy(
                          seed,
                        ).then(
                          (result) {},
                        );
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) =>
                                    WalletSeedCheckPage(seed1, seed)));
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.07,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(28),
                            color: blue1),
                        child: Center(
                          child: Text(
                            (lang.length != null &&
                                    lang.length != 0 &&
                                    userLanguage['ihavewrittenthemdown'] !=
                                        null)
                                ? "${userLanguage['ihavewrittenthemdown']}"
                                : "I’VE WRITTEN THEM DOWN",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(
                                color: white,
                                fontSize: 15,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        : Center(
            child: SpinKitSpinningLines(
              color: backgroundcolor,
              size: 60,
            ),
          );
  }
}
