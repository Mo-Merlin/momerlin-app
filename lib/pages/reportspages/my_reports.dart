import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:momerlin/data/localstorage/userdata_source.dart';
import 'package:momerlin/data/userrepository.dart';
import 'package:momerlin/pages/transaction/wallet_profile.dart';
import 'package:momerlin/tabscreen/tabscreen.dart';
import 'package:momerlin/theme/theme.dart';

import 'my_earnings.dart';
import 'spending_report.dart';

class MyReports extends StatefulWidget {
  final selectindex;
  const MyReports({Key key, this.selectindex}) : super(key: key);

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
  var imageFile = "";
  bool loading = true;
  // ignore: todo
  //TODO :languagestart
  Future<void> getUserLanguage() async {
    lang = await UserDataSource().getLanguage();

    user = await UserDataSource().getUser();
    var res = await UserRepository().getUser(user[0]["walletaddress"]);
    imageFile = res["user"]["imageUrl"];
    gweibalance = res["user"]["gwei"];
    if (lang.length != null && lang.length != 0) {
      userLanguage = lang[0];
    }
    setState(() {
      loading = false;
    });
  }
Future<Null> refreshList() async {
    refreshKey.currentState?.show(atTop: false);
    await Future.delayed(Duration(seconds: 2));
    getUserLanguage();
  
    // gettoken();
    return null;
  }
  // ignore: todo
  //TODO: LanguageEnd

  var refreshKey = GlobalKey<RefreshIndicatorState>();
  @override
  Widget build(BuildContext context) {
    return
        // loading == true
        //     ? Container(
        //         height: MediaQuery.of(context).size.height,
        //         width: MediaQuery.of(context).size.width,
        //         color: backgroundcolor,
        //         child: Center(
        //           child: Container(
        //             height: MediaQuery.of(context).size.height * 0.24,
        //             width: MediaQuery.of(context).size.width * 0.55,
        //             decoration: BoxDecoration(
        //                 color: white.withOpacity(0.9),
        //                 borderRadius: BorderRadius.circular(24)),
        //             child: Center(child: SpinKitRing(color: blue2)),
        //           ),
        //         ),
        //       )
        //     :
        RefreshIndicator(
        key: refreshKey,
        onRefresh: refreshList,
          child: Scaffold(
            extendBody: true,
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
            // (lang.length != null &&
            //         lang.length != 0 &&
            //         userLanguage['myreports'] != null)
            //     ? "${userLanguage['myreports']}"
            //     :
            "MY REPORTS",
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
                  borderRadius: BorderRadius.circular(100),
                  child: imageFile == ""
                      ? Image.asset(
                          "assets/images/profile.png",
                          fit: BoxFit.fill,
                        )
                      : Image.network(
                          imageFile,
                          fit: BoxFit.cover,
                        ),
                ),
              ),
            ),
          ],
      ),
      body: loading == true
            ? Center(
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.24,
                  width: MediaQuery.of(context).size.width * 0.55,
                  decoration: BoxDecoration(
                      color: white.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(24)),
                  child: Center(child: SpinKitRing(color: blue1)),
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
    ),
        );
  }
}
