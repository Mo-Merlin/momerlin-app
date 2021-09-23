import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:momerlin/data/localstorage/userdata_source.dart';
import 'package:momerlin/theme/theme.dart';
import 'package:momerlin/wallet_screens/wallet_challenge_four.dart';
import 'package:momerlin/wallet_screens/wallet_challenge_final.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class WalletChallengeThree extends StatefulWidget {
  const WalletChallengeThree({Key key}) : super(key: key);

  @override
  _WalletChallengeThreeState createState() => _WalletChallengeThreeState();
}

class _WalletChallengeThreeState extends State<WalletChallengeThree> {
  bool ischeckvisible = false;
  var checkColor = blue1;
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

  void showBottom() {
    print("bottom");
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
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.15,
                      width: MediaQuery.of(context).size.width,
                      //color: Colors.red,
                      child: Center(
                        child: Text(
                          (lang.length != null &&
                                  lang.length != 0 &&
                                  userLanguage['whattypeofchallenge'] != null)
                              ? "${userLanguage['whattypeofchallenge']}"
                              : "What type of \n  challenge?",
                          style: GoogleFonts.poppins(
                              decoration: TextDecoration.none,
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.w600),
                        ),
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
                          borderRadius: BorderRadius.circular(10)),
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
                                  "assets/images/streak.png",
                                  fit: BoxFit.fill,
                                )),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 12),
                            child: Text(
                              (lang.length != null &&
                                      lang.length != 0 &&
                                      userLanguage['streak'] != null)
                                  ? "${userLanguage['streak']}"
                                  : "STREAK",
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
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Container(
                            height: 28,
                            width: 86,
                            decoration: BoxDecoration(
                                color: blue1,
                                borderRadius: BorderRadius.circular(15)),
                            child: Visibility(
                                visible: ischeckvisible,
                                child: Center(
                                  child: Text(
                                      (lang.length != null &&
                                              lang.length != 0 &&
                                              userLanguage['commingsoon'] !=
                                                  null)
                                          ? "${userLanguage['commingsoon']}"
                                          : "COMMING SOON",
                                      style: GoogleFonts.poppins(
                                          decoration: TextDecoration.none,
                                          color: Colors.white,
                                          fontSize: 8,
                                          fontWeight: FontWeight.w600)),
                                )),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 12),
                          child: Container(
                              height: 60,
                              width: 40,
                              //color: Colors.red,
                              child: Opacity(
                                opacity: 0.25,
                                child: Image.asset(
                                  "assets/images/speed.png",
                                  fit: BoxFit.fill,
                                ),
                              )),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 12),
                          child: Text(
                            (lang.length != null &&
                                    lang.length != 0 &&
                                    userLanguage['speed'] != null)
                                ? "${userLanguage['speed']}"
                                : "SPEED",
                            style: GoogleFonts.poppins(
                                decoration: TextDecoration.none,
                                color: Colors.white.withOpacity(0.2),
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
                child: RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(17),
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => WalletChallengeFour()));
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
                  userLanguage['createachellenges'] != null)
              ? "${userLanguage['createachellenges']}"
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
              percent: 0.50,
              center: Padding(
                padding: const EdgeInsets.only(left: 54),
                child: Text(
                  "75%",
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
                child: RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    onPressed: showBottom,
                    color: backgroundcolor,
                    child: Text(
                      (lang.length != null &&
                              lang.length != 0 &&
                              userLanguage['selectchallengetype'] != null)
                          ? "${userLanguage['selectchallengetype']}"
                          : "SELECT CHELLENGE TYPE",
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
    );
  }
}
