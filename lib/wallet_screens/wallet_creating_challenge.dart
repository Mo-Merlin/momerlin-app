import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:momerlin/data/localstorage/userdata_source.dart';
import 'package:momerlin/theme/theme.dart';
import 'package:momerlin/wallet_screens/wallet_challenge_two.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class WalletCreatingChallenge extends StatefulWidget {
  const WalletCreatingChallenge({Key key}) : super(key: key);

  @override
  _WalletCreatingChallengeState createState() =>
      _WalletCreatingChallengeState();
}

class _WalletCreatingChallengeState extends State<WalletCreatingChallenge> {
  bool ischeckvisible = false;
  var checkColor = blue1;
  var userLanguage, lang = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.7),
      appBar: AppBar(
        backgroundColor: Colors.white.withOpacity(0),
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
          (lang.length != null &&
                  lang.length != 0 &&
                  userLanguage['createachellenge'] != null)
              ? "${userLanguage['createachellenge']}"
              : "CREATE A \nCHALLENGE",
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 17,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: LinearPercentIndicator(
              width: 100,
              lineHeight: 25.0,
              percent: 0.25,
              center: Padding(
                padding: const EdgeInsets.only(left: 54),
                child: Text(
                  "25%",
                  style: GoogleFonts.poppins(
                      color: white,
                      letterSpacing: 1,
                      fontSize: 12,
                      fontWeight: FontWeight.w400),
                ),
              ),
              // trailing: Icon(Icons.mood),
              linearStrokeCap: LinearStrokeCap.roundAll,
              backgroundColor: backgroundcolor,
              progressColor: blue,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.06,
                width: MediaQuery.of(context).size.width * 0.8,
                decoration: BoxDecoration(
                  //color: Colors.amber,
                  borderRadius: BorderRadius.circular(15),
                ),
                // ignore: deprecated_member_use
                child: RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    onPressed: showBottom,
                    color: backgroundcolor,
                    child: Text(
                      (lang.length != null &&
                              lang.length != 0 &&
                              userLanguage['selectactivity'] != null)
                          ? "${userLanguage['selectactivity']}"
                          : "SELECT ACTIVITY",
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    )),
              ),
            ),
          ),
        ],
      ),
      // body: Column(
      //   children: [
      //     SizedBox(
      //       height: MediaQuery.of(context).size.height * 0.33,
      //     ),
      //     Container(
      //         height: MediaQuery.of(context).size.height * 0.55,
      //         width: MediaQuery.of(context).size.width,
      //         decoration: BoxDecoration(
      //           //color: Colors.amber,
      //           borderRadius: BorderRadius.circular(15),
      //         ),
      //         child: MaterialApp(
      //             debugShowCheckedModeBanner: false,
      //             theme: ThemeData(
      //               primaryColor: Color.fromRGBO(86, 86, 86, 1.00),
      //             ),
      //             initialRoute: '/W1',
      //             routes: {
      //               '/W1': (context) => WidgetOne(),
      //               '/W2': (context) => WidgetTwo(),
      //               '/W3': (context) => WidgetThree(),
      //               '/W4': (context) => WidgetFour(),
      //             }))
      //   ],
      // ),
    );
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
  void initState() {
    super.initState();
    getUserLanguage();
  }

  void showBottom() {
    print("select activity button pressed");
    showModalBottomSheet(
        backgroundColor: backgroundcolor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.6,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: backgroundcolor,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Column(children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.15,
                    width: MediaQuery.of(context).size.width,
                    //color: Colors.red,
                    child: Center(
                      child: Text(
                        (lang.length != null &&
                                lang.length != 0 &&
                                userLanguage['selectanactivity'] != null)
                            ? "${userLanguage['selectanactivity']}"
                            : "Select an Activity",
                        style: GoogleFonts.poppins(
                            decoration: TextDecoration.none,
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        ischeckvisible = true;
                      });
                    },
                    onDoubleTap: () {
                      setState(() {
                        ischeckvisible = false;
                      });
                    },
                    child: Container(
                      height: 188,
                      width: 134,
                      decoration: BoxDecoration(
                          color: (ischeckvisible = true) ? blue1 : button,
                          borderRadius: BorderRadius.circular(15)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: InkWell(
                              onTap: () {
                                // setState(() {
                                //   ischeckvisible = true;
                                // });
                              },
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(30),
                                child: Container(
                                  height: 25,
                                  width: 25,
                                  color: backgroundcolor,
                                  child: Visibility(
                                    visible: ischeckvisible,
                                    child: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            ischeckvisible = false;
                                          });
                                        },
                                        icon: Icon(
                                          Icons.check,
                                          color: blue1,
                                          size: 10,
                                        )),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 12),
                            child: Container(
                                height: 60,
                                width: 48,
                                //color: Colors.red,
                                child: Image.asset(
                                  "assets/images/walking.png",
                                  fit: BoxFit.fill,
                                )),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 12),
                            child: Text(
                              (lang.length != null &&
                                      lang.length != 0 &&
                                      userLanguage['walking'] != null)
                                  ? "${userLanguage['walking']}"
                                  : "WALKING",
                              style: GoogleFonts.poppins(
                                  decoration: TextDecoration.none,
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: 188,
                    width: 134,
                    decoration: BoxDecoration(
                        color: (ischeckvisible == false) ? blue1 : button,
                        borderRadius: BorderRadius.circular(15)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(30),
                            child: Container(
                              height: 25,
                              width: 25,
                              color: backgroundcolor,
                              child: Visibility(
                                visible: false,
                                child: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        ischeckvisible = true;
                                      });
                                    },
                                    icon: Icon(
                                      Icons.check,
                                      color: blue1,
                                      size: 10,
                                    )),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 12),
                          child: Container(
                              height: 60,
                              width: 48,
                              //color: Colors.red,
                              child: Image.asset(
                                "assets/images/running.png",
                                fit: BoxFit.fill,
                              )),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 12),
                          child: Text(
                            (lang.length != null &&
                                    lang.length != 0 &&
                                    userLanguage['running'] != null)
                                ? "${userLanguage['running']}"
                                : "RUNNING",
                            style: GoogleFonts.poppins(
                                decoration: TextDecoration.none,
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 50,
              ),
              Container(
                height: 55,
                width: 321,
                // ignore: deprecated_member_use
                child: RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => WalletChallengeTwo()));
                    },
                    //color: blue.withOpacity(0.3),
                    color: blue1,
                    child: Text(
                      (lang.length != null &&
                              lang.length != 0 &&
                              userLanguage['next'] != null)
                          ? "${userLanguage['next']}"
                          : "NEXT",
                      style: GoogleFonts.poppins(
                        //color: blue1,
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    )),
              ),
            ]),
          );
        });
  }
}
