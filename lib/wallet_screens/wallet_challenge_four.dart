import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:momerlin/data/localstorage/userdata_source.dart';
import 'package:momerlin/theme/theme.dart';
import 'package:momerlin/wallet_screens/wallet_challenge_five.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class WalletChallengeFour extends StatefulWidget {
  const WalletChallengeFour({Key key}) : super(key: key);

  @override
  _WalletChallengeFourState createState() => _WalletChallengeFourState();
}

class _WalletChallengeFourState extends State<WalletChallengeFour> {
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
          borderRadius: BorderRadius.circular(15),
        ),
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.6,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: backgroundcolor,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.1,
                      width: MediaQuery.of(context).size.width,
                      //color: Colors.red,
                      child: Center(
                        child: RichText(
                            text: TextSpan(children: [
                          TextSpan(
                              text: (lang.length != null &&
                                      lang.length != 0 &&
                                      userLanguage[
                                              'howmanycompetitorswouldyoulike'] !=
                                          null)
                                  ? "${userLanguage['howmanycompetitorswouldyoulike']}"
                                  : 'How many competitors \n         would you like?',
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 25,
                                fontWeight: FontWeight.w600,
                              )),
                        ])),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 50),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.13,
                  width: MediaQuery.of(context).size.width,
                  //color: Colors.amber,
                  child: Image.asset(
                    "assets/images/bar2.png",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 25),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.08,
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: RaisedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => WalletChallengeFive()));
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
              ),
            ]),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.white.withOpacity(0.8),
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
              percent: 0.6,
              center: Text(
                "60%",
                style: GoogleFonts.poppins(
                    color: white,
                    letterSpacing: 1,
                    fontSize: 12,
                    fontWeight: FontWeight.w400),
              ),
              // trailing: Icon(Icons.mood),
              linearStrokeCap: LinearStrokeCap.roundAll,
              backgroundColor: Colors.grey,
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
                              userLanguage['selectcompetitors'] != null)
                          ? "${userLanguage['selectcompotitors']}"
                          : "SELECT COMPETITORS",
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
