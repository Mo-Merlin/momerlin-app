import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:momerlin/data/localstorage/userdata_source.dart';
import 'package:momerlin/theme/theme.dart';
import 'package:momerlin/wallet_screens/wallet_challenge_final.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class WalletChallengeFive extends StatefulWidget {
  const WalletChallengeFive({Key key}) : super(key: key);

  @override
  _WalletChallengeFiveState createState() => _WalletChallengeFiveState();
}

class _WalletChallengeFiveState extends State<WalletChallengeFive> {
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
        backgroundColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        isScrollControlled: true,
        context: context,
        builder: (BuildContext context) {
          return DraggableScrollableSheet(
              initialChildSize: 0.85, //set this as you want
              maxChildSize: 1, //set this as you want
              minChildSize: 0.85,
              //expand: true,
              builder: (context, scrollController) {
                return Container(
                  // height: MediaQuery.of(context).size.height * 1,
                  // width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: backgroundcolor,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 40, left: 25),
                              child: Text(
                                (lang.length != null &&
                                        lang.length != 0 &&
                                        userLanguage['challengesummary'] !=
                                            null)
                                    ? "${userLanguage['challengesummary']}"
                                    : "Challenge Summary",
                                style: GoogleFonts.poppins(
                                    decoration: TextDecoration.none,
                                    color: Colors.white,
                                    fontSize: 25,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 30, left: 25),
                              child: Text(
                                (lang.length != null &&
                                        lang.length != 0 &&
                                        userLanguage['activity'] != null)
                                    ? "${userLanguage['activity']}"
                                    : "Activity",
                                style: GoogleFonts.poppins(
                                    decoration: TextDecoration.none,
                                    color: Colors.grey,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 20, left: 25),
                              child: Container(
                                height:
                                    MediaQuery.of(context).size.width * 0.15,
                                width: MediaQuery.of(context).size.width * 0.9,
                                decoration: BoxDecoration(
                                    color: button,
                                    borderRadius: BorderRadius.circular(15)),
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Container(
                                        height: 32,
                                        width: 25,
                                        //color: blue1,
                                        child: Image.asset(
                                          "assets/images/walking.png",
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Text(
                                        (lang.length != null &&
                                                lang.length != 0 &&
                                                userLanguage['walking'] != null)
                                            ? "${userLanguage['walking']}"
                                            : "WALKING",
                                        style: GoogleFonts.poppins(
                                            decoration: TextDecoration.none,
                                            color: Colors.white,
                                            fontSize: 13,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 185),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(30),
                                        child: Container(
                                          height: 25,
                                          width: 25,
                                          color: blue1,
                                          child: IconButton(
                                              onPressed: () {},
                                              icon: Icon(
                                                Icons.check,
                                                color: Colors.white,
                                                size: 11,
                                              )),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 20, left: 25),
                              child: Text(
                                (lang.length != null &&
                                        lang.length != 0 &&
                                        userLanguage['satswagered'] != null)
                                    ? "${userLanguage['satswagered']}"
                                    : "SATS Wagered",
                                style: GoogleFonts.poppins(
                                    decoration: TextDecoration.none,
                                    color: Colors.grey,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 20, left: 25),
                              child: Container(
                                height:
                                    MediaQuery.of(context).size.width * 0.15,
                                width: MediaQuery.of(context).size.width * 0.9,
                                decoration: BoxDecoration(
                                    color: button,
                                    borderRadius: BorderRadius.circular(15)),
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 20),
                                      child: Text(
                                        "125",
                                        style: GoogleFonts.poppins(
                                            decoration: TextDecoration.none,
                                            color: Colors.white,
                                            fontSize: 21,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 5),
                                      child: Text(
                                        (lang.length != null &&
                                                lang.length != 0 &&
                                                userLanguage['sats'] != null)
                                            ? "${userLanguage['sats']}"
                                            : "SATs",
                                        style: GoogleFonts.poppins(
                                            decoration: TextDecoration.none,
                                            color: Colors.orange,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 210),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(30),
                                        child: Container(
                                          height: 25,
                                          width: 25,
                                          color: blue1,
                                          child: IconButton(
                                              onPressed: () {},
                                              icon: Icon(
                                                Icons.note_add_outlined,
                                                color: Colors.white,
                                                size: 12,
                                              )),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 20, left: 25),
                              child: Text(
                                (lang.length != null &&
                                        lang.length != 0 &&
                                        userLanguage['typesofchallenge'] !=
                                            null)
                                    ? "${userLanguage['typesofchallenge']}"
                                    : "Type of Challenge",
                                style: GoogleFonts.poppins(
                                    decoration: TextDecoration.none,
                                    color: Colors.grey,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 20, left: 25),
                              child: Container(
                                height:
                                    MediaQuery.of(context).size.width * 0.15,
                                width: MediaQuery.of(context).size.width * 0.9,
                                decoration: BoxDecoration(
                                    color: button,
                                    borderRadius: BorderRadius.circular(15)),
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Container(
                                        height: 32,
                                        width: 25,
                                        //color: blue1,
                                        child: Image.asset(
                                          "assets/images/streak.png",
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Text(
                                        (lang.length != null &&
                                                lang.length != 0 &&
                                                userLanguage['walking'] != null)
                                            ? "${userLanguage['walking']}"
                                            : "WALKING",
                                        style: GoogleFonts.poppins(
                                            decoration: TextDecoration.none,
                                            color: Colors.white,
                                            fontSize: 13,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 185),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(30),
                                        child: Container(
                                          height: 25,
                                          width: 25,
                                          color: blue1,
                                          child: IconButton(
                                              onPressed: () {},
                                              icon: Icon(
                                                Icons.check,
                                                color: Colors.white,
                                                size: 11,
                                              )),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 20, left: 25),
                              child: Text(
                                "Number of Competitors ",
                                style: GoogleFonts.poppins(
                                    decoration: TextDecoration.none,
                                    color: Colors.grey,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 20, left: 25),
                              child: Container(
                                height:
                                    MediaQuery.of(context).size.width * 0.15,
                                width: MediaQuery.of(context).size.width * 0.9,
                                decoration: BoxDecoration(
                                    color: button,
                                    borderRadius: BorderRadius.circular(15)),
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 20),
                                      child: Text(
                                        "85",
                                        style: GoogleFonts.poppins(
                                            decoration: TextDecoration.none,
                                            color: Colors.white,
                                            fontSize: 21,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 250),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(30),
                                        child: Container(
                                          height: 25,
                                          width: 25,
                                          color: blue1,
                                          child: IconButton(
                                              onPressed: () {},
                                              icon: Icon(
                                                Icons.note_add_outlined,
                                                color: Colors.white,
                                                size: 12,
                                              )),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        Container(
                          height: 55,
                          width: 321,
                          decoration: BoxDecoration(
                            //color: Colors.amber,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          // ignore: deprecated_member_use
                          child: RaisedButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(17),
                              ),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ChallengeFinal()));
                              },
                              color: blue1,
                              child: Text(
                                (lang.length != null &&
                                        lang.length != 0 &&
                                        userLanguage['createchallenge'] != null)
                                    ? "${userLanguage['createchallenge']}"
                                    : "CREATE CHALLENGE",
                                style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                ),
                              )),
                        ),
                      ],
                    ),
                  ),
                );
              });
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
              percent: 0.70,
              center: Padding(
                padding: const EdgeInsets.only(left: 54),
                child: Text(
                  "95%",
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
          SizedBox(height: 50),
          Center(
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
                            userLanguage['showchallengesummary'] != null)
                        ? "${userLanguage['showchallengesummary']}"
                        : "SHOW CHALLENGE SUMMARY",
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
