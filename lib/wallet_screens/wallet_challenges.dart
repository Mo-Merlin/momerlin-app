import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:momerlin/data/localstorage/userdata_source.dart';
import 'package:momerlin/theme/theme.dart';
import 'package:momerlin/wallet_screens/horizontallist.dart';
import 'package:momerlin/wallet_screens/my_activity.dart';
// import 'package:momerlin/wallet_screens/my_reports.dart';
import 'package:momerlin/wallet_screens/wallet_challenge_final.dart';
// import 'package:momerlin/wallet_screens/wallet_creating_challenge.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class WalletChallenges extends StatefulWidget {
  const WalletChallenges({Key key}) : super(key: key);

  @override
  _WalletChallengesState createState() => _WalletChallengesState();
}

class _WalletChallengesState extends State<WalletChallenges> {
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

  List elements = [
    {
      "name": "@momozuno \nhas earned",
      "url":
          "https://www.pngitem.com/pimgs/m/78-786293_1240-x-1240-0-avatar-profile-icon-png.png",
      "amt": "400",
      "type": "Gwei",
    },
    {
      "name": "@jade.sim \nhas earned",
      "url":
          "https://cdn.imgbin.com/1/8/12/imgbin-computer-icons-user-profile-avatar-woman-business-woman-2x9qVDw4EgxX299EhCLm9fN89.jpg",
      "amt": "230",
      "type": "Gwei",
    },
    {
      "name": "@cam.c \nhas earned",
      "url":
          "https://www.clipartmax.com/png/middle/171-1717870_stockvader-predicted-cron-for-may-user-profile-icon-png.png",
      "amt": "40",
      "type": "Gwei",
    },
    {
      "name": "@momozuno \nhas earned",
      "url":
          "https://www.pngitem.com/pimgs/m/78-786293_1240-x-1240-0-avatar-profile-icon-png.png",
      "amt": "400",
      "type": "Gwei",
    },
    {
      "name": "@jade.sim \nhas earned",
      "url":
          "https://cdn.imgbin.com/1/8/12/imgbin-computer-icons-user-profile-avatar-woman-business-woman-2x9qVDw4EgxX299EhCLm9fN89.jpg",
      "amt": "230",
      "type": "Gwei",
    },
    {
      "name": "@cam.c \nhas earned",
      "url":
          "https://www.clipartmax.com/png/middle/171-1717870_stockvader-predicted-cron-for-may-user-profile-icon-png.png",
      "amt": "40",
      "type": "Gwei",
    },
  ];

  List elementsOne = [
    {
      "name": "5KM RUN STREAK",
      "url":
          "https://www.pngitem.com/pimgs/m/78-786293_1240-x-1240-0-avatar-profile-icon-png.png",
      "amt": "+750",
      "type": "Gwei",
      "day": "DAY",
      "count": "5/7",
      "trophys": "trophy3",
      "color": Colors.blue,
    },
    {
      "name": "3KM RUN STREAK",
      "url":
          "https://cdn.imgbin.com/1/8/12/imgbin-computer-icons-user-profile-avatar-woman-business-woman-2x9qVDw4EgxX299EhCLm9fN89.jpg",
      "amt": "+750",
      "type": "Gwei",
      "day": "DAY",
      "count": "3/7",
      "trophys": "trophy2",
      "color": Colors.greenAccent,
    },
    {
      "name": "1KM WALK STREAK",
      "url":
          "https://www.clipartmax.com/png/middle/171-1717870_stockvader-predicted-cron-for-may-user-profile-icon-png.png",
      "amt": "+300",
      "type": "Gwei",
      "day": "DAY",
      "count": "1/7",
      "trophys": "trophy1",
      "color": Colors.redAccent,
    },
    {
      "name": "5KM RUN STREAK",
      "url":
          "https://www.pngitem.com/pimgs/m/78-786293_1240-x-1240-0-avatar-profile-icon-png.png",
      "amt": "+750",
      "type": "Gwei",
      "day": "DAY",
      "count": "5/7",
      "trophys": "trophy3",
      "color": Colors.blue,
    },
    {
      "name": "3KM RUN STREAK",
      "url":
          "https://cdn.imgbin.com/1/8/12/imgbin-computer-icons-user-profile-avatar-woman-business-woman-2x9qVDw4EgxX299EhCLm9fN89.jpg",
      "amt": "+750",
      "type": "Gwei",
      "day": "DAY",
      "count": "3/7",
      "trophys": "trophy2",
      "color": Colors.greenAccent,
    },
    {
      "name": "1KM WALK STREAK",
      "url":
          "https://www.clipartmax.com/png/middle/171-1717870_stockvader-predicted-cron-for-may-user-profile-icon-png.png",
      "amt": "+300",
      "type": "Gwei",
      "day": "DAY",
      "count": "1/7",
      "trophys": "trophy1",
      "color": Colors.redAccent,
    },
  ];
  List elementsTwo = [
    {
      "name": "5KM RUN \nSTREAK",
      "url":
          "https://www.pngitem.com/pimgs/m/78-786293_1240-x-1240-0-avatar-profile-icon-png.png",
      "amt": "+750",
      "type": "Gwei",
      "day": "DAY",
      "count": "5/7",
      "trophys": "trophy3",
      "color": Colors.blue,
    },
    {
      "name": "3KM RUN \nSTREAK",
      "url":
          "https://cdn.imgbin.com/1/8/12/imgbin-computer-icons-user-profile-avatar-woman-business-woman-2x9qVDw4EgxX299EhCLm9fN89.jpg",
      "amt": "+750",
      "type": "Gwei",
      "day": "DAY",
      "count": "3/7",
      "trophys": "trophy2",
      "color": Colors.greenAccent,
    },
    {
      "name": "1KM WALK \nSTREAK",
      "url":
          "https://www.clipartmax.com/png/middle/171-1717870_stockvader-predicted-cron-for-may-user-profile-icon-png.png",
      "amt": "+300",
      "type": "Gwei",
      "day": "DAY",
      "count": "1/7",
      "trophys": "trophy1",
      "color": Colors.redAccent,
    },
    {
      "name": "5KM RUN \nSTREAK",
      "url":
          "https://www.pngitem.com/pimgs/m/78-786293_1240-x-1240-0-avatar-profile-icon-png.png",
      "amt": "+750",
      "type": "Gwei",
      "day": "DAY",
      "count": "5/7",
      "trophys": "trophy3",
      "color": Colors.blue,
    },
    {
      "name": "3KM RUN \nSTREAK",
      "url":
          "https://cdn.imgbin.com/1/8/12/imgbin-computer-icons-user-profile-avatar-woman-business-woman-2x9qVDw4EgxX299EhCLm9fN89.jpg",
      "amt": "+750",
      "type": "Gwei",
      "day": "DAY",
      "count": "3/7",
      "trophys": "trophy2",
      "color": Colors.greenAccent,
    },
    {
      "name": "1KM WALK \nSTREAK",
      "url":
          "https://www.clipartmax.com/png/middle/171-1717870_stockvader-predicted-cron-for-may-user-profile-icon-png.png",
      "amt": "+300",
      "type": "Gwei",
      "day": "DAY",
      "count": "1/7",
      "trophys": "trophy1",
      "color": Colors.redAccent,
    },
  ];
  var colors = [
    blue1,
    Colors.greenAccent,
    Colors.orangeAccent,
    blue1,
    Colors.greenAccent,
    Colors.orangeAccent,
  ];
  var colors1 = [
    Colors.green[300],
    Colors.pinkAccent[100],
    Colors.orange[300],
    Colors.green[300],
    Colors.pinkAccent[100],
    Colors.orange[300],
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    // Navigator.pop(context);
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
              : "CHALLENGES",
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width * 0.35,
              decoration: BoxDecoration(
                  color: button, borderRadius: BorderRadius.circular(40)),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Text(
                      "300",
                      style: GoogleFonts.poppins(
                          fontSize: 17,
                          color: Colors.white,
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
                          : "Gwei",
                      style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: Colors.orangeAccent,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 12),
                    child: Stack(
                      children: [
                        CircularProgressIndicator(
                          strokeWidth: 3,
                          backgroundColor: blue,
                          valueColor: new AlwaysStoppedAnimation<Color>(blue1),
                        ),
                        Positioned(
                            child: Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 12, top: 5),
                              child: Text(
                                (lang.length != null &&
                                        lang.length != 0 &&
                                        userLanguage['level'] != null)
                                    ? "${userLanguage['level']}"
                                    : "LEVEL",
                                style: GoogleFonts.poppins(
                                  fontSize: 5,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10, top: 12),
                              child: Text(
                                "02",
                                style: GoogleFonts.poppins(
                                    fontSize: 13,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600),
                              ),
                            )
                          ],
                        ))
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 40,
                ),

                /******* 1st ListView   *******/
                Container(
                  height: MediaQuery.of(context).size.height * 0.26,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: Color(0xff313248),
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 25),
                            child: Text(
                              (lang.length != null &&
                                      lang.length != 0 &&
                                      userLanguage['recentwinners'] != null)
                                  ? "${userLanguage['recentwinners']}"
                                  : "RECENT WINNERS",
                              style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 25),
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.05,
                              width: MediaQuery.of(context).size.width * 0.25,
                              decoration: BoxDecoration(
                                  color: blue.withOpacity(0.3),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Center(
                                child: Text(
                                  (lang.length != null &&
                                          lang.length != 0 &&
                                          userLanguage['viewmore'] != null)
                                      ? "${userLanguage['viewmore']}"
                                      : "VIEW MORE",
                                  style: GoogleFonts.poppins(
                                      fontSize: 8,
                                      color: blue1,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.18,
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.only(left: 5, right: 0),
                        //color: Colors.indigo,
                        padding: EdgeInsets.only(
                            left: 4, top: 10, bottom: 0, right: 0),
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: elements.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              // onTap: () {
                              //   if (elements[index]['name'] ==
                              //       '@momozuno \nhas earned') {
                              //     Navigator.push(
                              //         context,
                              //         MaterialPageRoute(
                              //             builder: (context) => MyActivity()));
                              //   }
                              // },
                              child: Stack(
                                children: [
                                  Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.16,
                                    width: MediaQuery.of(context).size.width *
                                        0.35,
                                    //color: Colors.pink,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Container(
                                          // height:
                                          //     MediaQuery.of(context).size.height *
                                          //         0.15,
                                          // width:
                                          //     MediaQuery.of(context).size.width *
                                          //         0.30,
                                          height: 112,
                                          width: 113,
                                          decoration: BoxDecoration(
                                              color: button.withOpacity(0.4),
                                              borderRadius:
                                                  BorderRadius.circular(15)),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 15),
                                                child: Container(
                                                  // height: MediaQuery.of(context)
                                                  //         .size
                                                  //         .height *
                                                  //     0.06,
                                                  // width: MediaQuery.of(context)
                                                  //     .size
                                                  //     .width,
                                                  height: 29, width: 79,
                                                  //color: Colors.red,
                                                  child: Text(
                                                      elements[index]['name'],
                                                      style:
                                                          GoogleFonts.poppins(
                                                        color: Colors.grey,
                                                        fontSize: 11,
                                                      )),
                                                ),
                                              ),
                                              Container(
                                                // height: MediaQuery.of(context)
                                                //         .size
                                                //         .height *
                                                //     0.06,
                                                // width: MediaQuery.of(context)
                                                //         .size
                                                //         .width *
                                                //     0.30,
                                                height: 43, width: 93,
                                                decoration: BoxDecoration(
                                                    color: Colors.white
                                                        .withOpacity(0.25),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15)),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(elements[index]['amt'],
                                                        style:
                                                            GoogleFonts.poppins(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 20,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold)),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 5),
                                                      child: Text(
                                                          elements[index]
                                                              ['type'],
                                                          style: GoogleFonts.poppins(
                                                              color: Colors
                                                                  .orangeAccent,
                                                              fontSize: 7,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500)),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Positioned(
                                    top: 5,
                                    left: 53,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(30),
                                      child: Container(
                                          height: 30,
                                          width: 30,
                                          color: button,
                                          child: Image.network(
                                            elements[index]['url'],
                                            fit: BoxFit.cover,
                                          )),
                                    ),
                                  )
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                /******* 2nd ListView   *******/
                Container(
                  height: MediaQuery.of(context).size.height * 0.3,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      //color: Color(0xff313248),
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 25),
                            child: Text(
                              (lang.length != null &&
                                      lang.length != 0 &&
                                      userLanguage['joinachallenge'] != null)
                                  ? "${userLanguage['joinachallenge']}"
                                  : "JOIN A CHALLENGE",
                              style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 25),
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.05,
                              width: MediaQuery.of(context).size.width * 0.25,
                              decoration: BoxDecoration(
                                  color: blue.withOpacity(0.3),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Center(
                                child: Text(
                                  (lang.length != null &&
                                          lang.length != 0 &&
                                          userLanguage['viewmore'] != null)
                                      ? "${userLanguage['viewmore']}"
                                      : "VIEW MORE",
                                  style: GoogleFonts.poppins(
                                      fontSize: 8,
                                      color: blue1,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.2,
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.only(left: 5, right: 0),
                        //color: Colors.indigo,
                        padding: EdgeInsets.only(
                            left: 4, top: 10, bottom: 0, right: 0),
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: elements.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              // onTap: () {
                              //   if (elements[index]['name'] ==
                              //       '@momozuno \nhas earned') {
                              //     Navigator.push(
                              //         context,
                              //         MaterialPageRoute(
                              //             builder: (context) => MyActivity()));
                              //   }
                              //},
                              child: Stack(
                                children: [
                                  Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.2,
                                    width: MediaQuery.of(context).size.width *
                                        0.38,
                                    //color: Colors.pink,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Container(
                                          height: 126,
                                          width: 130,
                                          decoration: BoxDecoration(
                                              color: colors[index],
                                              borderRadius:
                                                  BorderRadius.circular(15)),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 15),
                                                child: Container(
                                                  height: 40, width: 79,
                                                  //color: Colors.red,
                                                  child: Text(
                                                      elementsTwo[index]
                                                          ['name'],
                                                      style:
                                                          GoogleFonts.poppins(
                                                        color: Colors.white,
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      )),
                                                ),
                                              ),
                                              Container(
                                                height: 43,
                                                width: 93,
                                                decoration: BoxDecoration(
                                                    color: Color(0xffFF8C00),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15)),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                        elementsTwo[index]
                                                            ['amt'],
                                                        style:
                                                            GoogleFonts.poppins(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600)),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 5),
                                                      child: Text(
                                                          elementsTwo[index]
                                                              ['type'],
                                                          style: GoogleFonts
                                                              .poppins(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500)),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Positioned(
                                    top: 10,
                                    left: 45,
                                    child: Container(
                                      height: 43,
                                      width: 43,
                                      //color: button,
                                      child: Image.asset(
                                        "assets/images/${elementsTwo[index]['trophys']}.png",
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                /******* 3rd ListView   *******/
                Container(
                  // height: MediaQuery.of(context).size.height * 0.28,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      //color: white.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 25),
                            child: Text(
                              (lang.length != null &&
                                      lang.length != 0 &&
                                      userLanguage['myactivity'] != null)
                                  ? "${userLanguage['myactivity']}"
                                  : "MY ACTIVITY",
                              style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              //print("Gopinath");
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MyActivity()));
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(right: 25),
                              child: Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.05,
                                width: MediaQuery.of(context).size.width * 0.25,
                                decoration: BoxDecoration(
                                    color: blue.withOpacity(0.3),
                                    borderRadius: BorderRadius.circular(10)),
                                child: Center(
                                  child: Text(
                                    (lang.length != null &&
                                            lang.length != 0 &&
                                            userLanguage['viewmore'] != null)
                                        ? "${userLanguage['viewmore']}"
                                        : "VIEW MORE",
                                    style: GoogleFonts.poppins(
                                        fontSize: 8,
                                        color: blue1,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
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
                          itemCount: 3,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return Stack(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                              color: colors1[index],
                                              borderRadius:
                                                  BorderRadius.circular(15)),
                                          child: ListTile(
                                            title: Text(
                                              elementsOne[index]['name'],
                                              style: GoogleFonts.poppins(
                                                color: Colors.black,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            trailing: Container(
                                              height: 33,
                                              width: 85,
                                              decoration: BoxDecoration(
                                                  color: Colors.white
                                                      .withOpacity(0.25),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          16)),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                      elementsOne[index]['day'],
                                                      style:
                                                          GoogleFonts.poppins(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600)),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 5),
                                                    child: Text(
                                                        elementsOne[index]
                                                            ['count'],
                                                        style:
                                                            GoogleFonts.poppins(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400)),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
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
                                        )))
                              ],
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),

                /******* 4th ListView   *******/
                Container(
                  height: MediaQuery.of(context).size.height * 0.35,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      //color: white.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 25),
                            child: Text(
                              (lang.length != null &&
                                      lang.length != 0 &&
                                      userLanguage['leaderboard'] != null)
                                  ? "${userLanguage['leaderboard']}"
                                  : "LEADERBOARD",
                              style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 25),
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.05,
                              width: MediaQuery.of(context).size.width * 0.25,
                              decoration: BoxDecoration(
                                  color: blue.withOpacity(0.3),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Center(
                                child: Text(
                                  (lang.length != null &&
                                          lang.length != 0 &&
                                          userLanguage['viewmore'] != null)
                                      ? "${userLanguage['viewmore']}"
                                      : "VIEW MORE",
                                  style: GoogleFonts.poppins(
                                      fontSize: 8,
                                      color: blue1,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.28,
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.only(left: 5, right: 0),
                        //color: Colors.indigo,
                        padding: EdgeInsets.only(
                            left: 4, top: 10, bottom: 0, right: 0),
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          itemCount: 6,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Container(
                                        // height:
                                        //     MediaQuery.of(context).size.height *
                                        //         0.1,
                                        // width: MediaQuery.of(context).size.width *
                                        //     0.15,
                                        height: 63, width: 42,
                                        decoration: BoxDecoration(
                                            color: colors[index],
                                            borderRadius:
                                                BorderRadius.circular(16)),
                                        child: Center(
                                          child: Text(
                                            "1",
                                            style: GoogleFonts.poppins(
                                              color: Colors.white,
                                              fontSize: 25,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Container(
                                        // height:
                                        //     MediaQuery.of(context).size.height *
                                        //         0.1,
                                        // width: MediaQuery.of(context).size.width *
                                        //     0.75,
                                        height: 63, width: 300,
                                        decoration: BoxDecoration(
                                            color:
                                                Colors.white.withOpacity(0.2),
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                        child: ListTile(
                                          leading: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(30),
                                            child: Container(
                                                height: 35,
                                                width: 35,
                                                color: button,
                                                child: Image.network(
                                                  elements[index]['url'],
                                                  fit: BoxFit.cover,
                                                )),
                                          ),
                                          title: Text(
                                            "ZUNO",
                                            style: GoogleFonts.poppins(
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          //subtitle: Text("rating"),
                                          subtitle: RatingBar.builder(
                                            initialRating: 3,
                                            minRating: 1,
                                            direction: Axis.horizontal,
                                            allowHalfRating: true,
                                            itemCount: 3,
                                            itemSize: 10,
                                            itemPadding: EdgeInsets.symmetric(
                                                horizontal: 0.2),
                                            itemBuilder: (context, _) => Icon(
                                              Icons.star,
                                              color: Colors.amber,
                                            ),
                                            onRatingUpdate: (rating) {
                                              print(rating);
                                            },
                                          ),
                                          trailing: Container(
                                            // height: MediaQuery.of(context)
                                            //         .size
                                            //         .height *
                                            //     0.05,
                                            // width: MediaQuery.of(context)
                                            //         .size
                                            //         .width *
                                            //     0.25,
                                            height: 38, width: 98,
                                            decoration: BoxDecoration(
                                                color: Colors.white
                                                    .withOpacity(0.25),
                                                borderRadius:
                                                    BorderRadius.circular(16)),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(elements[index]['amt'],
                                                    style: GoogleFonts.poppins(
                                                        color: Colors.white,
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w600)),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 5),
                                                  child: Text(
                                                      elements[index]['type'],
                                                      style:
                                                          GoogleFonts.poppins(
                                                              color: Colors
                                                                  .orangeAccent,
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400)),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 60,
                  width: 240,
                  decoration: BoxDecoration(
                    color: blue1,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  // ignore: deprecated_member_use
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    onPressed: () {
                      showdialog(context);
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => WalletCreatingChallenge()));
                    },
                    color: blue1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          onPressed: () {
                            showdialog(context);
                          },
                          icon: Icon(
                            Icons.add,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                        Text(
                          (lang.length != null &&
                                  lang.length != 0 &&
                                  userLanguage['createachallenge'] != null)
                              ? "${userLanguage['createachallenge']}"
                              : "CREATE A CHALLENGE",
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 150,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  bool ischeckvisible = false;
  bool iswalking = false;
  bool isrunning = false;
  void showdialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return StatefulBuilder(
          // You need this, notice the parameters below:
          builder: (BuildContext context, StateSetter setState) {
            return Container(
              color: backgroundcolor.withOpacity(0.7),
              margin: EdgeInsets.only(top: 0, left: 0, bottom: 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Card(
                        color: gridcolor,
                        elevation: 20,
                        // shadowColor: button.withOpacity(0.5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(150),
                          // side: new BorderSide(color: Colors.black, width: 1.0),
                        ),
                        child: InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle, color: gridcolor),
                            child: Center(
                              child: Icon(Icons.arrow_back,
                                  size: 20, color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      Text(
                        (lang.length != null &&
                                lang.length != 0 &&
                                userLanguage['createachellenge'] != null)
                            ? "${userLanguage['createachellenge']}"
                            : "CREATE A \nCHALLENGE",
                        style: GoogleFonts.poppins(
                          decoration: TextDecoration.none,
                          height: 1,
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Spacer(),
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
                          linearStrokeCap: LinearStrokeCap.roundAll,
                          backgroundColor: backgroundcolor,
                          progressColor: blue,
                        ),
                      ),
                    ],
                  ),
                  Spacer(),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Card(
                      shadowColor: button.withOpacity(0.5),
                      color: Color(0xff1C203A),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32),
                        // side: new BorderSide(color: Colors.black, width: 1.0),
                      ),
                      child: Container(
                        height: 467,
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.all(0),
                        child: Column(
                          children: [
                            SizedBox(height: 40),
                            Text(
                              "Select an Activity",
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 25,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: 70),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  height: 188,
                                  width: 134,
                                  decoration: BoxDecoration(
                                      color: iswalking == true ? blue1 : button,
                                      borderRadius: BorderRadius.circular(15)),
                                  child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        iswalking = !iswalking;
                                        isrunning = false;
                                      });
                                    },
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 25),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(30),
                                            child: Container(
                                                height: 25,
                                                width: 25,
                                                color: backgroundcolor,
                                                child: iswalking == true
                                                    ? IconButton(
                                                        onPressed: () {
                                                          setState(() {
                                                            iswalking = true;
                                                          });
                                                        },
                                                        icon: Icon(
                                                          Icons.check,
                                                          color: blue1,
                                                          size: 10,
                                                        ),
                                                      )
                                                    : SizedBox(
                                                        height: 0,
                                                      ) // : SizedBox(0),
                                                ),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 12),
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
                                          padding:
                                              const EdgeInsets.only(top: 10),
                                          child: Text(
                                            (lang.length != null &&
                                                    lang.length != 0 &&
                                                    userLanguage['walking'] !=
                                                        null)
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
                                SizedBox(width: 30),
                                Container(
                                  height: 188,
                                  width: 134,
                                  decoration: BoxDecoration(
                                      color: isrunning == true ? blue1 : button,
                                      borderRadius: BorderRadius.circular(15)),
                                  child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        isrunning = !isrunning;
                                        iswalking = false;
                                      });
                                    },
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 25),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(30),
                                            child: Container(
                                                height: 25,
                                                width: 25,
                                                color: backgroundcolor,
                                                child: isrunning == true
                                                    ? IconButton(
                                                        onPressed: () {
                                                          setState(() {
                                                            isrunning = true;
                                                          });
                                                        },
                                                        icon: Icon(
                                                          Icons.check,
                                                          color: blue1,
                                                          size: 10,
                                                        ),
                                                      )
                                                    : SizedBox(
                                                        height: 0,
                                                      ) // : SizedBox(0),
                                                ),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 12),
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
                                          padding:
                                              const EdgeInsets.only(top: 10),
                                          child: Text(
                                            (lang.length != null &&
                                                    lang.length != 0 &&
                                                    userLanguage['running'] !=
                                                        null)
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
                              // ignore: deprecated_member_use
                              child: RaisedButton(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                onPressed: () {
                                  if (iswalking == true || isrunning == true) {
                                    Navigator.pop(context);
                                    selectsat(context);
                                  }
                                  return;
                                },
                                //color: blue.withOpacity(0.3),
                                color: iswalking == true || isrunning == true
                                    ? blue1
                                    : button,
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
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  // SizedBox(
                  //   height: 30,
                  // ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  void selectsat(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return StatefulBuilder(
          // You need this, notice the parameters below:
          builder: (BuildContext context, StateSetter setState) {
            return Container(
              color: backgroundcolor.withOpacity(0.7),
              margin: EdgeInsets.only(top: 0, left: 0, bottom: 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Card(
                        color: gridcolor,
                        elevation: 20,
                        // shadowColor: button.withOpacity(0.5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(150),
                          // side: new BorderSide(color: Colors.black, width: 1.0),
                        ),
                        child: InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle, color: gridcolor),
                            child: Center(
                              child: Icon(Icons.arrow_back,
                                  size: 20, color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      Text(
                        (lang.length != null &&
                                lang.length != 0 &&
                                userLanguage['createachellenge'] != null)
                            ? "${userLanguage['createachellenge']}"
                            : "CREATE A \nCHALLENGE",
                        style: GoogleFonts.poppins(
                          decoration: TextDecoration.none,
                          height: 1,
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Spacer(),
                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: LinearPercentIndicator(
                          width: 100,
                          lineHeight: 25.0,
                          percent: 0.40,
                          center: Padding(
                            padding: const EdgeInsets.only(left: 54),
                            child: Text(
                              "50%",
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
                  Spacer(),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Card(
                      shadowColor: button.withOpacity(0.5),
                      color: Color(0xff1C203A),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32),
                        // side: new BorderSide(color: Colors.black, width: 1.0),
                      ),
                      child: Container(
                        height: 467,
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.all(0),
                        child: Column(
                          children: [
                            // SizedBox(height: 20),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.2,
                                  // width: MediaQuery.of(context).size.width,
                                  //color: Colors.red,
                                  child: Center(
                                    child: RichText(
                                        text: TextSpan(children: [
                                      TextSpan(
                                          text: (lang.length != null &&
                                                  lang.length != 0 &&
                                                  userLanguage['howmany'] !=
                                                      null)
                                              ? "${userLanguage['howmany']}"
                                              : 'How many',
                                          style: GoogleFonts.poppins(
                                            color: Colors.white,
                                            fontSize: 25,
                                            fontWeight: FontWeight.w600,
                                          )),
                                      TextSpan(
                                          text: (lang.length != null &&
                                                  lang.length != 0 &&
                                                  userLanguage['sats'] != null)
                                              ? "${userLanguage['sats']}"
                                              : ' Gwei ',
                                          style: GoogleFonts.poppins(
                                            color: Colors.orange,
                                            fontSize: 25,
                                            fontWeight: FontWeight.w500,
                                          )),
                                      TextSpan(
                                          text: (lang.length != null &&
                                                  lang.length != 0 &&
                                                  userLanguage[
                                                          'wouldyouliketowager'] !=
                                                      null)
                                              ? "${userLanguage['wouldyouliketowager']}"
                                              : 'would \n       you like to wager?',
                                          style: GoogleFonts.poppins(
                                            color: Colors.white,
                                            height: 1,
                                            fontSize: 25,
                                            fontWeight: FontWeight.w600,
                                          )),
                                    ])),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            // Container(
                            //   height: MediaQuery.of(context).size.height * 0.13,
                            //   width: MediaQuery.of(context).size.width,
                            //   //color: Colors.amber,
                            //   child: SfLinearGauge(
                            //       markerPointers: [
                            //         LinearShapePointer(
                            //           value: _pointerValue,
                            //           onValueChanged: (value) => {
                            //             setState(() => {_pointerValue = value})
                            //           },
                            //           shapeType: LinearShapePointerType
                            //               .invertedTriangle,
                            //           color: blue1,
                            //           elevation: 10,
                            //         )
                            //       ],
                            //       tickPosition: LinearElementPosition.outside,
                            //       labelPosition: LinearLabelPosition.outside,
                            //       majorTickStyle: LinearTickStyle(
                            //           length: 70, thickness: 2, color: button),
                            //       minorTickStyle: LinearTickStyle(
                            //           length: 40,
                            //           thickness: 1.75,
                            //           color: button),
                            //       axisLabelStyle: GoogleFonts.montserrat(
                            //         fontSize: 15,
                            //         color: Colors.grey,
                            //       )),
                            // ),
                            HorizontalList(),
                            SizedBox(
                              height: 90,
                            ),
                            Container(
                              height: 55,
                              width: 321,
                              // ignore: deprecated_member_use
                              child: RaisedButton(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                  selectchallengetype(context);
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
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  // SizedBox(
                  //   height: 30,
                  // ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  void selectchallengetype(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return StatefulBuilder(
          // You need this, notice the parameters below:
          builder: (BuildContext context, StateSetter setState) {
            return Container(
              color: backgroundcolor.withOpacity(0.7),
              margin: EdgeInsets.only(top: 0, left: 0, bottom: 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Card(
                        color: gridcolor,
                        elevation: 20,
                        // shadowColor: button.withOpacity(0.5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(150),
                          // side: new BorderSide(color: Colors.black, width: 1.0),
                        ),
                        child: InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle, color: gridcolor),
                            child: Center(
                              child: Icon(Icons.arrow_back,
                                  size: 20, color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      Text(
                        (lang.length != null &&
                                lang.length != 0 &&
                                userLanguage['createachellenge'] != null)
                            ? "${userLanguage['createachellenge']}"
                            : "CREATE A \nCHALLENGE",
                        style: GoogleFonts.poppins(
                          decoration: TextDecoration.none,
                          height: 1,
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Spacer(),
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
                  Spacer(),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Card(
                      shadowColor: button.withOpacity(0.5),
                      color: Color(0xff1C203A),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32),
                        // side: new BorderSide(color: Colors.black, width: 1.0),
                      ),
                      child: Container(
                        height: 467,
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.all(0),
                        child: Column(
                          children: [
                            // SizedBox(height: 20),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.15,
                                    // width: MediaQuery.of(context).size.width,
                                    //color: Colors.red,
                                    child: Center(
                                      child: Text(
                                        (lang.length != null &&
                                                lang.length != 0 &&
                                                userLanguage[
                                                        'whattypeofchallenge'] !=
                                                    null)
                                            ? "${userLanguage['whattypeofchallenge']}"
                                            : "What type of \n  challenge?",
                                        style: GoogleFonts.poppins(
                                            decoration: TextDecoration.none,
                                            color: Colors.white,
                                            height: 1,
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
                                      ischeckvisible = !ischeckvisible;
                                    });
                                  },
                                  child: Container(
                                    height: 188,
                                    width: 134,
                                    decoration: BoxDecoration(
                                        color: ischeckvisible == true
                                            ? blue1
                                            : button,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      // mainAxisAlignment:
                                      //     MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 20),
                                          child: InkWell(
                                            onTap: () {
                                              // setState(() {
                                              //   ischeckvisible = true;
                                              // });
                                            },
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                              child: Container(
                                                height: 25,
                                                width: 25,
                                                color: backgroundcolor,
                                                child: ischeckvisible == true
                                                    ? IconButton(
                                                        onPressed: () {
                                                          setState(() {
                                                            ischeckvisible =
                                                                false;
                                                          });
                                                        },
                                                        icon: Icon(
                                                          Icons.check,
                                                          color: blue1,
                                                          size: 10,
                                                        ))
                                                    : SizedBox(
                                                        height: 0,
                                                      ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 12),
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
                                          padding:
                                              const EdgeInsets.only(top: 12),
                                          child: Text(
                                            (lang.length != null &&
                                                    lang.length != 0 &&
                                                    userLanguage['streak'] !=
                                                        null)
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
                                      color: button,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    // mainAxisAlignment:
                                    //     MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(top: 20),
                                        child: Container(
                                          height: 28,
                                          width: 86,
                                          decoration: BoxDecoration(
                                              color: blue1,
                                              borderRadius:
                                                  BorderRadius.circular(15)),
                                          child: Center(
                                            child: Text(
                                                (lang.length != null &&
                                                        lang.length != 0 &&
                                                        userLanguage[
                                                                'commingsoon'] !=
                                                            null)
                                                    ? "${userLanguage['commingsoon']}"
                                                    : "COMING SOON",
                                                style: GoogleFonts.poppins(
                                                    decoration:
                                                        TextDecoration.none,
                                                    color: Colors.white,
                                                    fontSize: 8,
                                                    fontWeight:
                                                        FontWeight.w600)),
                                          ),
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
                                              color:
                                                  Colors.white.withOpacity(0.2),
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
                              height: 60,
                            ),
                            Container(
                              height: 55,
                              width: 321,
                              // ignore: deprecated_member_use
                              child: RaisedButton(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  onPressed: () {
                                    if (ischeckvisible == true) {
                                      Navigator.pop(context);
                                      selectshowcompetitors(context);
                                    }
                                    return;
                                  },
                                  //color: blue.withOpacity(0.3),
                                  color:
                                      ischeckvisible == true ? blue1 : button,
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
                          ],
                        ),
                      ),
                    ),
                  ),
                  // SizedBox(
                  //   height: 30,
                  // ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  void selectshowcompetitors(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return StatefulBuilder(
          // You need this, notice the parameters below:
          builder: (BuildContext context, StateSetter setState) {
            return Container(
              color: backgroundcolor.withOpacity(0.7),
              margin: EdgeInsets.only(top: 0, left: 0, bottom: 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Card(
                        color: gridcolor,
                        elevation: 20,
                        // shadowColor: button.withOpacity(0.5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(150),
                          // side: new BorderSide(color: Colors.black, width: 1.0),
                        ),
                        child: InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle, color: gridcolor),
                            child: Center(
                              child: Icon(Icons.arrow_back,
                                  size: 20, color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      Text(
                        (lang.length != null &&
                                lang.length != 0 &&
                                userLanguage['createachellenge'] != null)
                            ? "${userLanguage['createachellenge']}"
                            : "CREATE A \nCHALLENGE",
                        style: GoogleFonts.poppins(
                          decoration: TextDecoration.none,
                          height: 1,
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Spacer(),
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
                  Spacer(),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Card(
                      shadowColor: button.withOpacity(0.5),
                      color: Color(0xff1C203A),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32),
                        // side: new BorderSide(color: Colors.black, width: 1.0),
                      ),
                      child: Container(
                        height: 467,
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.all(0),
                        child: Column(
                          children: [
                            // SizedBox(height: 40),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.15,
                                    // width: MediaQuery.of(context).size.width,
                                    //color: Colors.red,
                                    child: Center(
                                      child: RichText(
                                        text: TextSpan(
                                          children: [
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
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            HorizontalList(),
                            // Container(
                            //   height: MediaQuery.of(context).size.height * 0.13,
                            //   width: MediaQuery.of(context).size.width,
                            //   // color: Colors.amber,
                            //   child: SfLinearGauge(
                            //       markerPointers: [
                            //         LinearShapePointer(
                            //           value: _pointerValue,
                            //           onValueChanged: (value) => {
                            //             setState(() => {_pointerValue = value})
                            //           },
                            //           shapeType: LinearShapePointerType
                            //               .invertedTriangle,
                            //           color: blue1,
                            //           elevation: 10,
                            //         )
                            //       ],
                            //       tickPosition: LinearElementPosition.outside,
                            //       labelPosition: LinearLabelPosition.outside,
                            //       majorTickStyle: LinearTickStyle(
                            //           length: 70, thickness: 2, color: button),
                            //       minorTickStyle: LinearTickStyle(
                            //           length: 40,
                            //           thickness: 1.75,
                            //           color: button),
                            //       axisLabelStyle: GoogleFonts.montserrat(
                            //         fontSize: 15,
                            //         color: Colors.grey,
                            //       )),
                            // ),
                            SizedBox(
                              height: 30,
                            ),
                            Text(
                              "WINNER GETS",
                              style: GoogleFonts.poppins(
                                  color: Color(0xFF808DA7),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500),
                            ),
                            Text(
                              "7500 Gwei",
                              style: GoogleFonts.montserrat(
                                  color: Colors.orange,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600),
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
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  onPressed: () {
                                    Navigator.pop(context);
                                    selectshowsummary(context);
                                    // Navigator.push(
                                    //     context,
                                    //     MaterialPageRoute(
                                    //         builder: (context) =>
                                    //             WalletChallengeFive()));
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
                          ],
                        ),
                      ),
                    ),
                  ),
                  // SizedBox(
                  //   height: 30,
                  // ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  void selectshowsummary(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return StatefulBuilder(
          // You need this, notice the parameters below:
          builder: (BuildContext context, StateSetter setState) {
            return Container(
              color: backgroundcolor.withOpacity(0.7),
              margin: EdgeInsets.only(top: 0, left: 0, bottom: 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Card(
                        color: gridcolor,
                        elevation: 20,
                        // shadowColor: button.withOpacity(0.5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(150),
                          // side: new BorderSide(color: Colors.black, width: 1.0),
                        ),
                        child: InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle, color: gridcolor),
                            child: Center(
                              child: Icon(Icons.arrow_back,
                                  size: 20, color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      Text(
                        (lang.length != null &&
                                lang.length != 0 &&
                                userLanguage['createachellenge'] != null)
                            ? "${userLanguage['createachellenge']}"
                            : "CREATE A \nCHALLENGE",
                        style: GoogleFonts.poppins(
                          decoration: TextDecoration.none,
                          height: 1,
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Spacer(),
                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: LinearPercentIndicator(
                          width: 100,
                          lineHeight: 25.0,
                          percent: 0.80,
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
                  Spacer(),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Card(
                      shadowColor: button.withOpacity(0.5),
                      color: Color(0xff1C203A),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32),
                        // side: new BorderSide(color: Colors.black, width: 1.0),
                      ),
                      child: Container(
                        // height: 703,
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.all(0),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 40, left: 25),
                                    child: Text(
                                      (lang.length != null &&
                                              lang.length != 0 &&
                                              userLanguage[
                                                      'challengesummary'] !=
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 30, left: 25),
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
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 30, right: 50),
                                    child: Text(
                                      (lang.length != null &&
                                              lang.length != 0 &&
                                              userLanguage['satswagered'] !=
                                                  null)
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
                                    padding: const EdgeInsets.only(
                                        top: 20, left: 25),
                                    child: Container(
                                      height:
                                          MediaQuery.of(context).size.width *
                                              0.15,
                                      width: MediaQuery.of(context).size.width *
                                          0.41,
                                      decoration: BoxDecoration(
                                          color: button,
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 10),
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
                                            padding:
                                                const EdgeInsets.only(left: 10),
                                            child: Text(
                                              (lang.length != null &&
                                                      lang.length != 0 &&
                                                      userLanguage['walking'] !=
                                                          null)
                                                  ? "${userLanguage['walking']}"
                                                  : "WALKING",
                                              style: GoogleFonts.poppins(
                                                  decoration:
                                                      TextDecoration.none,
                                                  color: Colors.white,
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ),
                                          // Padding(
                                          //   padding: const EdgeInsets.only(
                                          //       left: 185),
                                          //   child: ClipRRect(
                                          //     borderRadius:
                                          //         BorderRadius.circular(30),
                                          //     child: Container(
                                          //       height: 25,
                                          //       width: 25,
                                          //       color: blue1,
                                          //       child: IconButton(
                                          //           onPressed: () {},
                                          //           icon: Icon(
                                          //             Icons.check,
                                          //             color: Colors.white,
                                          //             size: 11,
                                          //           )),
                                          //     ),
                                          //   ),
                                          // ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 20, left: 25),
                                    child: Container(
                                      height:
                                          MediaQuery.of(context).size.width *
                                              0.15,
                                      width: MediaQuery.of(context).size.width *
                                          0.41,
                                      decoration: BoxDecoration(
                                          color: button,
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 20),
                                            child: Text(
                                              "125",
                                              style: GoogleFonts.montserrat(
                                                  decoration:
                                                      TextDecoration.none,
                                                  color: Colors.white,
                                                  fontSize: 21,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 5),
                                            child: Text(
                                              (lang.length != null &&
                                                      lang.length != 0 &&
                                                      userLanguage['gwei'] !=
                                                          null)
                                                  ? "${userLanguage['sats']}"
                                                  : "Gwei",
                                              style: GoogleFonts.poppins(
                                                  decoration:
                                                      TextDecoration.none,
                                                  color: Colors.orange,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 25),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(30),
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
                              // Row(
                              //   children: [
                              //     Padding(
                              //       padding: const EdgeInsets.only(
                              //           top: 20, left: 25),
                              //       child: Text(
                              //         (lang.length != null &&
                              //                 lang.length != 0 &&
                              //                 userLanguage['satswagered'] !=
                              //                     null)
                              //             ? "${userLanguage['satswagered']}"
                              //             : "Gwei Wagered",
                              //         style: GoogleFonts.poppins(
                              //             decoration: TextDecoration.none,
                              //             color: Colors.grey,
                              //             fontSize: 15,
                              //             fontWeight: FontWeight.w400),
                              //       ),
                              //     ),
                              //   ],
                              // ),
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 20, left: 25),
                                    child: Text(
                                      (lang.length != null &&
                                              lang.length != 0 &&
                                              userLanguage[
                                                      'typesofchallenge'] !=
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
                                    padding: const EdgeInsets.only(
                                        top: 20, left: 25),
                                    child: Container(
                                      height:
                                          MediaQuery.of(context).size.width *
                                              0.15,
                                      width: MediaQuery.of(context).size.width *
                                          0.9,
                                      decoration: BoxDecoration(
                                          color: button,
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 10),
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
                                            padding:
                                                const EdgeInsets.only(left: 10),
                                            child: Text(
                                              (lang.length != null &&
                                                      lang.length != 0 &&
                                                      userLanguage['walking'] !=
                                                          null)
                                                  ? "${userLanguage['walking']}"
                                                  : "WALKING",
                                              style: GoogleFonts.poppins(
                                                  decoration:
                                                      TextDecoration.none,
                                                  color: Colors.white,
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 190),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(30),
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
                                    padding: const EdgeInsets.only(
                                        top: 20, left: 25),
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
                                    padding: const EdgeInsets.only(
                                        top: 20, left: 25),
                                    child: Container(
                                      height:
                                          MediaQuery.of(context).size.width *
                                              0.15,
                                      width: MediaQuery.of(context).size.width *
                                          0.9,
                                      decoration: BoxDecoration(
                                          color: button,
                                          borderRadius:
                                              BorderRadius.circular(15)),
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 20),
                                            child: Text(
                                              "85",
                                              style: GoogleFonts.poppins(
                                                  decoration:
                                                      TextDecoration.none,
                                                  color: Colors.white,
                                                  fontSize: 21,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 250),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(30),
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
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "WINNER GETS",
                                    style: GoogleFonts.poppins(
                                        decoration: TextDecoration.none,
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "7500 Gwei",
                                    style: GoogleFonts.montserrat(
                                        decoration: TextDecoration.none,
                                        color: Colors.orange,
                                        fontSize: 17,
                                        fontWeight: FontWeight.w600),
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
                                      borderRadius: BorderRadius.circular(30),
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
                                              userLanguage['createchallenge'] !=
                                                  null)
                                          ? "${userLanguage['createchallenge']}"
                                          : "CREATE CHALLENGE",
                                      style: GoogleFonts.poppins(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    )),
                              ),
                              SizedBox(
                                height: 50,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  // SizedBox(
                  //   height: 30,
                  // ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
