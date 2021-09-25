import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:momerlin/data/localstorage/userdata_source.dart';
import 'package:momerlin/theme/theme.dart';
import 'package:momerlin/wallet_screens/wallet_creating_challenge.dart';

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
      "type": "SATs",
    },
    {
      "name": "@jade.sim \nhas earned",
      "url":
          "https://cdn.imgbin.com/1/8/12/imgbin-computer-icons-user-profile-avatar-woman-business-woman-2x9qVDw4EgxX299EhCLm9fN89.jpg",
      "amt": "230",
      "type": "SATs",
    },
    {
      "name": "@cam.c \nhas earned",
      "url":
          "https://www.clipartmax.com/png/middle/171-1717870_stockvader-predicted-cron-for-may-user-profile-icon-png.png",
      "amt": "40",
      "type": "SATs",
    },
    {
      "name": "@momozuno \nhas earned",
      "url":
          "https://www.pngitem.com/pimgs/m/78-786293_1240-x-1240-0-avatar-profile-icon-png.png",
      "amt": "400",
      "type": "SATs",
    },
    {
      "name": "@jade.sim \nhas earned",
      "url":
          "https://cdn.imgbin.com/1/8/12/imgbin-computer-icons-user-profile-avatar-woman-business-woman-2x9qVDw4EgxX299EhCLm9fN89.jpg",
      "amt": "230",
      "type": "SATs",
    },
    {
      "name": "@cam.c \nhas earned",
      "url":
          "https://www.clipartmax.com/png/middle/171-1717870_stockvader-predicted-cron-for-may-user-profile-icon-png.png",
      "amt": "40",
      "type": "SATs",
    },
  ];

  List elementsOne = [
    {
      "name": "5KM RUN \nSTREAK",
      "url":
          "https://www.pngitem.com/pimgs/m/78-786293_1240-x-1240-0-avatar-profile-icon-png.png",
      "amt": "+750",
      "type": "SATs",
      "color": Colors.blue,
    },
    {
      "name": "3KM RUN \nSTREAK",
      "url":
          "https://cdn.imgbin.com/1/8/12/imgbin-computer-icons-user-profile-avatar-woman-business-woman-2x9qVDw4EgxX299EhCLm9fN89.jpg",
      "amt": "+750",
      "type": "SATs",
      "color": Colors.greenAccent,
    },
    {
      "name": "1KM WALK \nSTREAK",
      "url":
          "https://www.clipartmax.com/png/middle/171-1717870_stockvader-predicted-cron-for-may-user-profile-icon-png.png",
      "amt": "+300",
      "type": "SATs",
      "color": Colors.redAccent,
    },
    {
      "name": "5KM RUN \nSTREAK",
      "url":
          "https://www.pngitem.com/pimgs/m/78-786293_1240-x-1240-0-avatar-profile-icon-png.png",
      "amt": "+750",
      "type": "SATs",
      "color": Colors.blue,
    },
    {
      "name": "3KM RUN \nSTREAK",
      "url":
          "https://cdn.imgbin.com/1/8/12/imgbin-computer-icons-user-profile-avatar-woman-business-woman-2x9qVDw4EgxX299EhCLm9fN89.jpg",
      "amt": "+750",
      "type": "SATs",
      "color": Colors.greenAccent,
    },
    {
      "name": "1KM WALK \nSTREAK",
      "url":
          "https://www.clipartmax.com/png/middle/171-1717870_stockvader-predicted-cron-for-may-user-profile-icon-png.png",
      "amt": "+300",
      "type": "SATs",
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
                          : "SATs",
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
                      color: white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            height: MediaQuery.of(context).size.height * 0.05,
                            width: MediaQuery.of(context).size.width * 0.6,
                            //color: Colors.amber,
                            child: Center(
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
                          ),
                          Container(
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
                            return Stack(
                              children: [
                                Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.16,
                                  width:
                                      MediaQuery.of(context).size.width * 0.35,
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
                                                    style: GoogleFonts.poppins(
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
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 20,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold)),
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
                /******* 2st ListView   *******/
                Container(
                  height: MediaQuery.of(context).size.height * 0.28,
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
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            height: MediaQuery.of(context).size.height * 0.05,
                            width: MediaQuery.of(context).size.width * 0.6,
                            //color: Colors.amber,
                            child: Center(
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
                          ),
                          Container(
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
                          itemCount: elementsOne.length,
                          itemBuilder: (context, index) {
                            return Stack(
                              children: [
                                Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.2,
                                  width:
                                      MediaQuery.of(context).size.width * 0.4,
                                  //color: Colors.pink,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Container(
                                        // height:
                                        //     MediaQuery.of(context).size.height *
                                        //         0.18,
                                        // width:
                                        //     MediaQuery.of(context).size.width *
                                        //         0.35,
                                        height: 126,
                                        width: 130,
                                        decoration: BoxDecoration(
                                            // color: button.withOpacity(0.4),
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
                                                // height: MediaQuery.of(context)
                                                //         .size
                                                //         .height *
                                                //     0.06,
                                                // width: MediaQuery.of(context)
                                                //     .size
                                                //     .width,
                                                height: 38, width: 86,
                                                //color: Colors.red,
                                                child: Center(
                                                  child: Text(
                                                      elementsOne[index]
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
                                              height: 38, width: 98,
                                              decoration: BoxDecoration(
                                                  color: Colors.orange,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20)),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                      elementsOne[index]['amt'],
                                                      style:
                                                          GoogleFonts.poppins(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600)),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 5),
                                                    child: Text(
                                                        elementsOne[index]
                                                            ['type'],
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
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Positioned(
                                    top: 10,
                                    left: 53,
                                    child: Image.asset(
                                      "assets/images/challenge.png",
                                      fit: BoxFit.cover,
                                    )),
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
                /******* 3rd ListView   *******/
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
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            height: MediaQuery.of(context).size.height * 0.05,
                            width: MediaQuery.of(context).size.width * 0.6,
                            //color: Colors.amber,
                            child: Center(
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
                          ),
                          Container(
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
                SizedBox(height: 100),
              ],
            ),
          ),
        ],
      ),
      // floatingActionButton: FloatingActionButton.extended(
      //   elevation: 5,
      //   icon: const Icon(Icons.add),
      //   label: const Text('Add a task'),
      //   onPressed: () {},
      // ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        height: 60,
        width: 240,
        decoration: BoxDecoration(
          color: blue1,
          borderRadius: BorderRadius.circular(15),
        ),
        child: RaisedButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => WalletCreatingChallenge()));
          },
          color: blue1,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => WalletCreatingChallenge()));
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
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        color: backgroundcolor,
        shape: const CircularNotchedRectangle(),
        child: Container(
          height: 30,
        ),
      ),
    );
  }
}
