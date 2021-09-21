import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:momerlin/data/localstorage/userdata_source.dart';
import 'package:momerlin/theme/theme.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class WalletCreatingChallenge extends StatefulWidget {
  const WalletCreatingChallenge({Key key}) : super(key: key);

  @override
  _WalletCreatingChallengeState createState() =>
      _WalletCreatingChallengeState();
}

class _WalletCreatingChallengeState extends State<WalletCreatingChallenge> {
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
                  userLanguage['chellenges'] != null)
              ? "${userLanguage['chellenges']}"
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
              percent: 0.1,
              center: Text(
                "10%",
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
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.33,
          ),
          Container(
              height: MediaQuery.of(context).size.height * 0.55,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                //color: Colors.amber,
                borderRadius: BorderRadius.circular(15),
              ),
              child: MaterialApp(
                  debugShowCheckedModeBanner: false,
                  theme: ThemeData(
                    primaryColor: Color.fromRGBO(86, 86, 86, 1.00),
                  ),
                  initialRoute: '/W1',
                  routes: {
                    '/W1': (context) => WidgetOne(),
                    '/W2': (context) => WidgetTwo(),
                  }))
        ],
      ),
    );
  }
}

class WidgetOne extends StatefulWidget {
  @override
  _WidgetOneState createState() => _WidgetOneState();
}

class _WidgetOneState extends State<WidgetOne> {
  bool ischeckvisible = false;
  var checkColor = blue1;
  @override
  Widget build(BuildContext context) {
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
            Container(
              height: MediaQuery.of(context).size.height * 0.1,
              width: MediaQuery.of(context).size.width,
              //color: Colors.red,
              child: Center(
                child: Text(
                  "Select an Activity",
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
                height: MediaQuery.of(context).size.height * 0.26,
                width: MediaQuery.of(context).size.width * 0.4,
                decoration: BoxDecoration(
                    color: (ischeckvisible = true) ? blue1 : button,
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
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
                            height: 35,
                            width: 35,
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
                                    size: 20,
                                  )),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 12),
                      child: Container(
                          height: 80,
                          width: 50,
                          //color: Colors.red,
                          child: Image.asset(
                            "assets/images/walking.png",
                            fit: BoxFit.fill,
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 12),
                      child: Text(
                        "WALKING",
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
              height: MediaQuery.of(context).size.height * 0.26,
              width: MediaQuery.of(context).size.width * 0.4,
              decoration: BoxDecoration(
                  color: (ischeckvisible == true) ? blue1 : button,
                  borderRadius: BorderRadius.circular(10)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: Container(
                        height: 35,
                        width: 35,
                        color: backgroundcolor,
                        child: Visibility(
                          visible: ischeckvisible,
                          child: IconButton(
                              onPressed: () {
                                setState(() {
                                  ischeckvisible = true;
                                });
                              },
                              icon: Icon(
                                Icons.check,
                                color: blue1,
                                size: 20,
                              )),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 12),
                    child: Container(
                        height: 80,
                        width: 50,
                        //color: Colors.red,
                        child: Image.asset(
                          "assets/images/running.png",
                          fit: BoxFit.fill,
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 12),
                    child: Text(
                      "RUNNING",
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
                  Navigator.pushNamed(context, '/W2');
                },
                color: blue.withOpacity(0.3),
                child: Text(
                  "NEXT",
                  style: GoogleFonts.poppins(
                    color: blue1,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                )),
          ),
        ),
      ]),
    );
  }
}

class WidgetTwo extends StatefulWidget {
  @override
  _WidgetTwoState createState() => _WidgetTwoState();
}

class _WidgetTwoState extends State<WidgetTwo> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, '/W1');
        },
        child: Container(color: Colors.pink));
  }
}
