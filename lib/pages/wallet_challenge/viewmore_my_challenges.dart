import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:momerlin/data/localstorage/userdata_source.dart';
import 'package:momerlin/data/userrepository.dart';
// import 'package:momerlin/tabscreen/tabscreen.dart';
import 'package:momerlin/theme/theme.dart';

import 'challangedetails.dart';
// import 'mychallengedetails.dart';

class MyChallenges {
  String mode;
  String type;
  String totalCompetitors;
  var streakDays;
  var totalKm;
  var wage;
  var prize;
  var id;

  MyChallenges(
      {this.mode,
      this.type,
      this.totalCompetitors,
      this.streakDays,
      this.totalKm,
      this.wage,
      this.prize,
      this.id});

  factory MyChallenges.fromJson(Map<String, dynamic> json) => MyChallenges(
      mode: json["mode"] == null ? null : json["mode"],
      type: json["type"],
      totalCompetitors: json["totalCompetitors"],
      streakDays: json["streakDays"],
      totalKm: json["totalKm"],
      wage: json["wage"],
      prize: json["prize"],
      id: json["_id"]);
}

class ViewmoreMyChallenge extends StatefulWidget {
  final bool focus;
  const ViewmoreMyChallenge({Key key, this.focus}) : super(key: key);

  @override
  _ViewmoreMyChallengeState createState() => _ViewmoreMyChallengeState();
}

class _ViewmoreMyChallengeState extends State<ViewmoreMyChallenge> {
  List<MyChallenges> mychallenge = [];
  bool loading = true;
  var userLanguage, user, lang = [];

  @override
  void initState() {
    super.initState();

    getUserLanguage();
  }

  // ignore: todo
  //TODO :languagestart
  Future<void> getUserLanguage() async {
    lang = await UserDataSource().getLanguage();

    user = await UserDataSource().getUser();
    if (lang.length != null && lang.length != 0) {
      userLanguage = lang[0];
    }
    getmyChallenges();
  }

  // ignore: todo
  //TODO: LanguageEnd

  Future<void> getmyChallenges() async {
    var res = await UserRepository().getmyChallenges(user[0]["uid"]);

    setState(() {
      loading = false;
    });
    if (res == false) {
      Scaffold.of(context)
          // ignore: deprecated_member_use
          .showSnackBar(SnackBar(
        content: Text('No Internet Connection'),
        backgroundColor: Colors.red,
      ));
    } else {
      if (res["success"] == true) {
        mychallenge = [];
        for (var i = 0; i < res["challenges"]["docs"].length; i++) {
          mychallenge.add(MyChallenges.fromJson(res["challenges"]["docs"][i]));
        }
      } else {
        Scaffold.of(context)
            // ignore: deprecated_member_use
            .showSnackBar(SnackBar(
          content: Text('Please Try Again!'),
          backgroundColor: Colors.red,
        ));
      }
    }
  }

  List<Color> myChallengeColorList = [
    blue1,
    spendingPink,
    containerOrange,
    containerGreen,
  ];

  var trophy = [
    Image.asset("assets/images/trophy3.png"),
    Image.asset("assets/images/trophy2.png"),
    Image.asset("assets/images/trophy1.png"),
  ];

  //bool _value = false;
  int val = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //key: scaffoldKeyWallet,
      backgroundColor: backgroundcolor,
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
                  Navigator.pop(context, false);
                  // Navigator.pushReplacement(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (_) => Tabscreen(
                  //       index: 2,
                  //     ),
                  //   ),
                  // );
                },
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        title: Text(
          (lang.length != null &&
                  lang.length != 0 &&
                  userLanguage['mychallenge'] != null)
              ? "${userLanguage['mychallenge']}"
              : "MY CHALLENGES",
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 10,
            ),
            // Center(
            //   child: Image.asset(
            //     "assets/images/promo_card_1.png",
            //     fit: BoxFit.cover,
            //   ),
            // ),
            // SizedBox(
            //   height: 25,
            // ),
            // Center(
            //   child: Container(
            //     height: 3,
            //     width: 64,
            //     decoration: BoxDecoration(
            //       color: text1,
            //       borderRadius: BorderRadius.circular(10),
            //     ),
            //   ),
            // ),
            SizedBox(
              height: 20,
            ),
            loading == true
                ? Center(
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.24,
                      width: MediaQuery.of(context).size.width * 0.55,
                      decoration: BoxDecoration(
                          color: white.withOpacity(0.9),
                          borderRadius: BorderRadius.circular(24)),
                      child: Center(child: SpinKitRing(color: blue2)),
                    ),
                  )
                : mychallenge.length == 0
                    ? Container(
                        height: MediaQuery.of(context).size.height * 0.2,
                        width: MediaQuery.of(context).size.width,
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("NO CHALLENGES",
                                style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                )),
                          ),
                        ),
                      )
                    : Container(
                        // height: MediaQuery.of(context).size.height * 0.35,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            //color: white.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(10)),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              // height: MediaQuery.of(context).size.height * 0.26,
                              width: MediaQuery.of(context).size.width,
                              margin: EdgeInsets.only(left: 5, right: 0),
                              //color: Colors.indigo,
                              padding: EdgeInsets.only(
                                  left: 4, top: 10, bottom: 0, right: 0),
                              child: ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                scrollDirection: Axis.vertical,
                                itemCount: mychallenge.length,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              Challengesdetail(
                                            challange: mychallenge[index].id,
                                          ),
                                        ),
                                      );
                                    },
                                    child: Column(
                                      children: [
                                        Stack(
                                          children: [
                                            Row(
                                              children: [
                                                SizedBox(
                                                  width: 15,
                                                ),
                                                Container(
                                                  height: 59,
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.85,
                                                  decoration: BoxDecoration(
                                                      color: myChallengeColorList[
                                                          index %
                                                              myChallengeColorList
                                                                  .length],
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15)),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Container(
                                                        height: 59,
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.5,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors.white
                                                              .withOpacity(0.2),
                                                          borderRadius:
                                                              BorderRadius.only(
                                                            bottomLeft:
                                                                Radius.circular(
                                                                    18),
                                                            bottomRight:
                                                                Radius.circular(
                                                                    25),
                                                            topLeft:
                                                                Radius.circular(
                                                                    18),
                                                            topRight:
                                                                Radius.circular(
                                                                    25),
                                                          ),
                                                        ),
                                                        child: Center(
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Text(
                                                                mychallenge[index]
                                                                        .totalKm +
                                                                    "KM ",
                                                                style:
                                                                    GoogleFonts
                                                                        .poppins(
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                ),
                                                              ),
                                                              Text(
                                                                mychallenge[index]
                                                                            .mode ==
                                                                        "Walking"
                                                                    ? "WALK "
                                                                    : "RUN ",
                                                                style:
                                                                    GoogleFonts
                                                                        .poppins(
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                ),
                                                              ),
                                                              Text(
                                                                mychallenge[
                                                                        index]
                                                                    .type
                                                                    .toUpperCase(),
                                                                style:
                                                                    GoogleFonts
                                                                        .poppins(
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                right: 20),
                                                        child: Container(
                                                          height: 33,
                                                          width: 85,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Colors.white
                                                                .withOpacity(
                                                                    0.25),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        16),
                                                          ),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        left:
                                                                            5),
                                                                child: Text(
                                                                  mychallenge[
                                                                          index]
                                                                      .prize
                                                                      .toString(),
                                                                  style: GoogleFonts.poppins(
                                                                      color: Colors
                                                                          .white,
                                                                      fontSize:
                                                                          12,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600),
                                                                ),
                                                              ),
                                                              Text(
                                                                " Gwei",
                                                                style: GoogleFonts.poppins(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        12,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Positioned(
                                              right: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.03,
                                              top: 10,
                                              child: Container(
                                                height: 40,
                                                width: 40,
                                                child: trophy[
                                                    index % trophy.length],
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 15),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
          ],
        ),
      ),
    );
  }
}
