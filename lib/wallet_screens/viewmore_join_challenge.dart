import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:momerlin/data/localstorage/userdata_source.dart';
import 'package:momerlin/data/userrepository.dart';
import 'package:momerlin/theme/theme.dart';

class Challenges {
  String mode;
  String type;
  String totalCompetitors;
  var streakDays;
  var totalKm;
  var wage;

  Challenges({
    this.mode,
    this.type,
    this.totalCompetitors,
    this.streakDays,
    this.totalKm,
    this.wage,
  });

  factory Challenges.fromJson(Map<String, dynamic> json) => Challenges(
        mode: json["mode"] == null ? null : json["mode"],
        type: json["type"],
        totalCompetitors: json["totalCompetitors"],
        streakDays: json["streakDays"],
        totalKm: json["totalKm"],
        wage: json["wage"],
      );
}

class ViewmoreJoinChallenge extends StatefulWidget {
  const ViewmoreJoinChallenge({Key key}) : super(key: key);

  @override
  _ViewmoreJoinChallengeState createState() => _ViewmoreJoinChallengeState();
}

class _ViewmoreJoinChallengeState extends State<ViewmoreJoinChallenge> {
  List<Challenges> challengesOne = [];
  bool loading = true;
  var userLanguage, lang = [];

  @override
  void initState() {
    super.initState();
    getChallenges();
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

  Future<void> getChallenges() async {
    setState(() {
      loading = true;
    });
    var res = await UserRepository().getChallenges();
    if (res == false) {
      setState(() {
        loading = false;
      });
      _showScaffold('No Internet Connection');
    } else {
      if (res["success"] == true) {
        setState(() {
          loading = false;
        });
        challengesOne = [];
        for (var i = 0; i < res["challenges"]["docs"].length; i++) {
          challengesOne.add(Challenges.fromJson(res["challenges"]["docs"][i]));
        }
      } else {
        _showScaffold('Please Try Again!');
      }
    }
  }

  final GlobalKey<ScaffoldState> scaffoldKeyWallet =
      new GlobalKey<ScaffoldState>();
  void _showScaffold(String message) {
    // ignore: deprecated_member_use
    scaffoldKeyWallet.currentState.showSnackBar(
      SnackBar(
        content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              message,
              style: GoogleFonts.poppins(
                color: white,
                fontSize: 17,
                fontWeight: FontWeight.w400,
              ),
            ),
            Icon(
              Icons.info_outline,
              color: Colors.white,
            )
          ],
        ),
        backgroundColor: Colors.red,
      ),
    );
  }

  List elementsOne = [
    {
      "name": "5KM RUN STREAK",
      "url":
          "https://www.pngitem.com/pimgs/m/78-786293_1240-x-1240-0-avatar-profile-icon-png.png",
      "amt": "DAY",
      "type": "5",
      "trophys": "trophy3"
    },
    {
      "name": "5KM WALK STREAK",
      "url":
          "https://cdn.imgbin.com/1/8/12/imgbin-computer-icons-user-profile-avatar-woman-business-woman-2x9qVDw4EgxX299EhCLm9fN89.jpg",
      "amt": "DAY",
      "type": "5",
      "trophys": "trophy2"
    },
    {
      "name": "INSERT CHALLENGE THREE",
      "url":
          "https://www.clipartmax.com/png/middle/171-1717870_stockvader-predicted-cron-for-may-user-profile-icon-png.png",
      "amt": "DAY",
      "type": "1",
      "trophys": "trophy1"
    },
    {
      "name": "5KM RUN STREAK",
      "url":
          "https://www.pngitem.com/pimgs/m/78-786293_1240-x-1240-0-avatar-profile-icon-png.png",
      "amt": "DAY",
      "type": "6",
      "trophys": "trophy3"
    },
    {
      "name": "3KM RUN STREAK",
      "url":
          "https://cdn.imgbin.com/1/8/12/imgbin-computer-icons-user-profile-avatar-woman-business-woman-2x9qVDw4EgxX299EhCLm9fN89.jpg",
      "amt": "DAY",
      "type": "2",
      "trophys": "trophy2"
    },
    {
      "name": "1KM WALK STREAK",
      "url":
          "https://www.clipartmax.com/png/middle/171-1717870_stockvader-predicted-cron-for-may-user-profile-icon-png.png",
      "amt": "DAY",
      "type": "3",
      "trophys": "trophy1"
    },
  ];
  var colors = [
    blue1,
    Colors.pinkAccent[100],
    Colors.orange[300],
    blue1,
    Colors.greenAccent,
    Colors.orangeAccent,
  ];
  //bool _value = false;
  int val = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKeyWallet,
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
                  Navigator.pop(context);
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
                  userLanguage['joinchallenge'] != null)
              ? "${userLanguage['joinchallenge']}"
              : "JOIN CHALLENGE",
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
          Center(
            child: Image.asset(
              "assets/images/promo_card_1.png",
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(
            height: 25,
          ),
          Center(
            child: Container(
              height: 3,
              width: 64,
              decoration: BoxDecoration(
                color: text1,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          // Padding(
          //   padding: const EdgeInsets.only(left: 30),
          //   child: Text(
          //     (lang.length != null &&
          //             lang.length != 0 &&
          //             userLanguage['currentchallenges'] != null)
          //         ? "${userLanguage['currentchallenges']}"
          //         : "CURRENT CHALLENGES",
          //     style: GoogleFonts.poppins(
          //       color: Colors.white,
          //       fontSize: 16,
          //       fontWeight: FontWeight.w600,
          //     ),
          //   ),
          // ),
          // SizedBox(
          //   height: 5,
          // ),

          loading == true
              ? Container(
                  height: MediaQuery.of(context).size.height * 0.23,
                  width: MediaQuery.of(context).size.width,
                  color: backgroundcolor,
                  child: Center(
                    child: SpinKitSpinningLines(
                      color: white,
                      size: 60,
                    ),
                  ),
                )
              : challengesOne.length == 0
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
                              itemCount: challengesOne.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return Stack(
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            SizedBox(
                                              width: 15,
                                            ),
                                            Container(
                                              height: 59,
                                              width: 306,
                                              decoration: BoxDecoration(
                                                  color: colors[index],
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
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.5,
                                                    decoration: BoxDecoration(
                                                      color: Colors.white
                                                          .withOpacity(0.2),
                                                      borderRadius:
                                                          BorderRadius.only(
                                                              bottomLeft: Radius
                                                                  .circular(13),
                                                              bottomRight:
                                                                  Radius
                                                                      .circular(
                                                                          25),
                                                              topLeft: Radius
                                                                  .circular(13),
                                                              topRight: Radius
                                                                  .circular(
                                                                      25)),
                                                    ),
                                                    child: Center(
                                                      child: Text(
                                                        challengesOne[index]
                                                                .totalKm +
                                                            " KM " +
                                                            challengesOne[index]
                                                                .mode
                                                                .toUpperCase(),
                                                        style:
                                                            GoogleFonts.poppins(
                                                          color: Colors.black,
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 20),
                                                    child: Container(
                                                      height: 33,
                                                      width: 85,
                                                      decoration: BoxDecoration(
                                                          color: Colors.white
                                                              .withOpacity(
                                                                  0.25),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      16)),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Text("DAY",
                                                              style: GoogleFonts.poppins(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600)),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 5),
                                                            child: Text(
                                                                elementsOne[index]
                                                                        [
                                                                        "type"] +
                                                                    " / ",
                                                                style: GoogleFonts.poppins(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        12,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400)),
                                                          ),
                                                          Text(
                                                              challengesOne[
                                                                      index]
                                                                  .streakDays,
                                                              style: GoogleFonts.poppins(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400)),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              // child: ListTile(
                                              //   title: Text(
                                              //     elementsOne[index]['name'],
                                              //     style: GoogleFonts.poppins(
                                              //       color: Colors.white,
                                              //       fontSize: 14,
                                              //       fontWeight: FontWeight.w600,
                                              //     ),
                                              //   ),
                                              //   trailing: Container(
                                              //     height: 33,
                                              //     width: 85,
                                              //     decoration: BoxDecoration(
                                              //         color:
                                              //             Colors.white.withOpacity(0.25),
                                              //         borderRadius:
                                              //             BorderRadius.circular(16)),
                                              //     child: Row(
                                              //       mainAxisAlignment:
                                              //           MainAxisAlignment.center,
                                              //       children: [
                                              //         Text(elementsOne[index]['amt'],
                                              //             style: GoogleFonts.poppins(
                                              //                 color: Colors.white,
                                              //                 fontSize: 12,
                                              //                 fontWeight:
                                              //                     FontWeight.w600)),
                                              //         Padding(
                                              //           padding: const EdgeInsets.only(
                                              //               left: 5),
                                              //           child: Text(
                                              //               elementsOne[index]['type'],
                                              //               style: GoogleFonts.poppins(
                                              //                   color: Colors.white,
                                              //                   fontSize: 12,
                                              //                   fontWeight:
                                              //                       FontWeight.w400)),
                                              //         ),
                                              //       ],
                                              //     ),
                                              //   ),
                                              // ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 15)
                                      ],
                                    ),
                                    Positioned(
                                      right: 30,
                                      top: 10,
                                      child: Container(
                                        height: 40,
                                        width: 40,
                                        child: Image.asset(
                                          "assets/images/${elementsOne[index]['trophys']}.png",
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
        ],
      )),
    );
  }
}
