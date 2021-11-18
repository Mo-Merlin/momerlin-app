import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:momerlin/data/localstorage/userdata_source.dart';
import 'package:momerlin/data/userrepository.dart';
import 'package:momerlin/tabscreen/tabscreen.dart';
import 'package:momerlin/theme/theme.dart';
import 'package:momerlin/wallet_screens/my_earnings.dart';
import 'package:momerlin/wallet_screens/spending_report.dart';
import 'package:momerlin/wallet_screens/wallet_profile.dart';

class MyReports extends StatefulWidget {
  const MyReports({Key key}) : super(key: key);

  @override
  _MyReportsState createState() => _MyReportsState();
}

class _MyReportsState extends State<MyReports> {
  var balance = 0.00;
  var userLanguage, lang, user = [];
  @override
  void initState() {
    super.initState();
    getUserLanguage();
    //_controller = CalendarController();
  }

  var gweibalance = "0";
  bool loading = true;
  // ignore: todo
  //TODO :languagestart
  Future<void> getUserLanguage() async {
    lang = await UserDataSource().getLanguage();

    user = await UserDataSource().getUser();
    var res = await UserRepository().getUser(user[0]["walletaddress"]);

    gweibalance = res["user"]["gwei"];
    // if (lang.length != null && lang.length != 0) {
    //   userLanguage = lang[0];
    // }
    setState(() {
      loading = false;
    });
  }

  // ignore: todo
  //TODO: LanguageEnd

  @override
  Widget build(BuildContext context) {
    return
        // loading == true
        //     ? Container(
        //         height: MediaQuery.of(context).size.height,
        //         width: MediaQuery.of(context).size.width,
        //         color: white,
        //         child: Center(
        //           child: SpinKitSpinningLines(
        //             color: backgroundcolor,
        //             size: 60,
        //           ),
        //         ),
        //       )
        //     :
        Scaffold(
      backgroundColor: backgroundcolor,
      appBar: AppBar(
        backgroundColor: blue2,
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
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (_) => Tabscreen(
                          index: 0,
                        ),
                      ),
                    );
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
                  userLanguage['myreports'] != null)
              ? "${userLanguage['myreports']}"
              : "MY REPORTS",
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(5),
            child: GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => WalletProfile()));
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Image.asset(
                  "assets/images/profile.png",
                  fit: BoxFit.cover,
                  width: 46,
                  height: 46,
                ),
              ),
            ),
          ),
        ],
      ),
      body: loading == true
          ? Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              color: backgroundcolor,
              child: Center(
                child: SpinKitRing(
                  color: white,
                  size: 60,
                ),
              ),
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  // APPBAR DESIGN WITH BALANCE
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Positioned(
                        child: Image.asset(
                          "assets/images/rr1.png",
                          width: MediaQuery.of(context).size.width,
                          fit: BoxFit.fill,
                          height: 130,
                        ),
                      ),
                      Positioned(
                        top: 20,
                        child: Text(
                          (lang.length != null &&
                                  lang.length != 0 &&
                                  userLanguage['yourBalanceIs'] != null)
                              ? "${userLanguage['yourBalanceIs']}"
                              : "Your balance is",
                          style: GoogleFonts.poppins(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Positioned(
                        top: 60,
                        child: Row(
                          children: [
                            Text(
                              gweibalance,
                              style: GoogleFonts.montserrat(
                                fontSize: 30,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(
                              width: 3,
                            ),
                            Text(
                              "Gwei",
                              style: GoogleFonts.montserrat(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: Colors.orange,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SpendingReport()));
                    },
                    child: Container(
                      height: 177,
                      width: 308,
                      decoration: BoxDecoration(
                        color: grey,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 30,
                          ),
                          Container(
                            height: 50,
                            width: 50,
                            //color: blue1,
                            child: Image.asset(
                              "assets/images/coin.png",
                              fit: BoxFit.cover,
                            ),
                          ),
                          Text(
                            (lang.length != null &&
                                    lang.length != 0 &&
                                    userLanguage['sendingReports'] != null)
                                ? "${userLanguage['sendingReports']}"
                                : "Spending Reports",
                            style: GoogleFonts.poppins(
                              fontSize: 25,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            (lang.length != null &&
                                    lang.length != 0 &&
                                    userLanguage['howmuchareyouspending'] !=
                                        null)
                                ? "${userLanguage['howmuchareyouspending']}"
                                : "How much are you spending?",
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              color: text1,
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
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MyEarnings()));
                    },
                    child: Container(
                      height: 177,
                      width: 308,
                      decoration: BoxDecoration(
                        color: grey,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 30,
                          ),
                          Container(
                            height: 50,
                            width: 50,
                            //color: blue1,
                            child: Image.asset(
                              "assets/images/pig_rr.png",
                              fit: BoxFit.cover,
                            ),
                          ),
                          Text(
                            (lang.length != null &&
                                    lang.length != 0 &&
                                    userLanguage['earningReports'] != null)
                                ? "${userLanguage['earningReports']}"
                                : "Earning Reports",
                            style: GoogleFonts.poppins(
                              fontSize: 25,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            (lang.length != null &&
                                    lang.length != 0 &&
                                    userLanguage['howmuchareyouearning'] !=
                                        null)
                                ? "${userLanguage['howmuchareyouearning']}"
                                : "How much are you earning?",
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              color: text1,
                            ),
                          ),
                        ],
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
