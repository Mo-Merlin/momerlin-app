import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:momerlin/data/localstorage/userdata_source.dart';
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
  var userLanguage, lang = [];
  @override
  void initState() {
    super.initState();
    getUserLanguage();
    //_controller = CalendarController();
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
      // appBar: AppBar(
      //   backgroundColor: blue1,
      //   elevation: 0,
      //   leading: Padding(
      //     padding: const EdgeInsets.all(5.0),
      //     child: ClipRRect(
      //       borderRadius: BorderRadius.circular(30),
      //       child: Container(
      //         // height: 50,
      //         // width: 50,
      //         color: button,
      //         child: IconButton(
      //             onPressed: () {
      //               Navigator.pop(context);
      //             },
      //             icon: Icon(
      //               Icons.arrow_back,
      //               color: Colors.white,
      //             )),
      //       ),
      //     ),
      //   ),
      //   title: Text(
      //     (lang.length != null &&
      //             lang.length != 0 &&
      //             userLanguage['myreports'] != null)
      //         ? "${userLanguage['myreports']}"
      //         : "MY REPORTS",
      //     style: GoogleFonts.poppins(
      //       color: Colors.white,
      //       fontSize: 15,
      //       fontWeight: FontWeight.w600,
      //     ),
      //   ),
      //   actions: [
      //     Padding(
      //       padding: const EdgeInsets.all(5),
      //       child: GestureDetector(
      //         onTap: () {
      //           Navigator.push(context,
      //               MaterialPageRoute(builder: (context) => WalletProfile()));
      //         },
      //         child: ClipRRect(
      //           borderRadius: BorderRadius.circular(30),
      //           child: Image.asset(
      //             "assets/images/profile.png",
      //             fit: BoxFit.cover,
      //             width: 46,
      //             height: 46,
      //           ),
      //         ),
      //       ),
      //     ),
      //   ],
      // ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // APPBAR DESIGN WITH BALANCE
            Stack(
              alignment: Alignment.center,
              children: [
                Positioned(
                  child: Image.asset(
                    "assets/images/rr.png",
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 45,
                  child: Container(
                    //color: Colors.amber,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(30),
                            child: Container(
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
                        SizedBox(
                          width: 15,
                        ),
                        Text(
                          (lang.length != null &&
                                  lang.length != 0 &&
                                  userLanguage['myreports'] != null)
                              ? "${userLanguage['myreports']}"
                              : "MY REPORTS",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                              color: white,
                              fontSize: 15,
                              fontWeight: FontWeight.w700),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 2.6,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5.0),
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
                                color: button,
                                child: Image.asset(
                                  "assets/images/profile.png",
                                  fit: BoxFit.fill,
                                  width: 46,
                                  height: 46,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 105,
                  child: Row(
                    children: [
                      Text(
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
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        balance.toStringAsFixed(2),
                        style: GoogleFonts.montserrat(
                          fontSize: 60,
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
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SpendingReport()));
              },
              child: Container(
                height: 177,
                width: 308,
                decoration: BoxDecoration(
                  color: button,
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
                              userLanguage['howmuchareyouspending'] != null)
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
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MyEarnings()));
              },
              child: Container(
                height: 177,
                width: 308,
                decoration: BoxDecoration(
                  color: button,
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
                              userLanguage['howmuchareyouearning'] != null)
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
            )
          ],
        ),
      ),
    );
  }
}
