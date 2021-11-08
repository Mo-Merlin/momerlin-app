import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:momerlin/data/localstorage/userdata_source.dart';
import 'package:momerlin/data/userrepository.dart';
import 'package:momerlin/tabscreen/tabscreen.dart';
import 'package:momerlin/theme/theme.dart';

class Challenges {
  var mode;
  var type;
  var totalCompetitors;
  var streakDays;
  var totalKm;
  var wage;
  var id;
  var prize;

  Challenges({
    this.mode,
    this.type,
    this.totalCompetitors,
    this.streakDays,
    this.totalKm,
    this.wage,
    this.id,
    this.prize,
  });

  factory Challenges.fromJson(Map<String, dynamic> json) => Challenges(
      mode: json["mode"] == null ? null : json["mode"],
      type: json["type"],
      totalCompetitors: json["totalCompetitors"],
      streakDays: json["streakDays"],
      totalKm: json["totalKm"],
      wage: json["wage"],
      id: json["_id"],
       prize: json["prize"],);
}

class ViewmoreJoinChallenge extends StatefulWidget {
  const ViewmoreJoinChallenge({Key key}) : super(key: key);

  @override
  _ViewmoreJoinChallengeState createState() => _ViewmoreJoinChallengeState();
}

class _ViewmoreJoinChallengeState extends State<ViewmoreJoinChallenge> {
  List<Challenges> challengesOne = [];
  bool loading = true;
  var userLanguage, user, lang = [];

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
    user = await UserDataSource().getUser();
    if (lang.length != null && lang.length != 0) {
      userLanguage = lang[0];
    }
  }

  // ignore: todo
  //TODO: LanguageEnd

  Future<void> getChallenges() async {
    var res = await UserRepository().getChallenges();
    if (res == false) {
      setState(() {
        loading = false;
      });
      // ignore: deprecated_member_use
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text('No Internet Connection'),
        backgroundColor: Colors.red,
      ));
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
        // ignore: deprecated_member_use
        Scaffold.of(context).showSnackBar(SnackBar(
          content: Text(res["error"]),
          backgroundColor: Colors.red,
        ));
      }
    }
  }

  Future<void> joiningchallenge(uid, challangeid) async {
    var joinchallange = await UserRepository().joiningchallenge(
      uid,
      challangeid,
    );
    print("Joinchallange $joinchallange");
    if (joinchallange == false) {
      // ignore: deprecated_member_use
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text('No Internet Connection'),
        backgroundColor: Colors.red,
      ));
    } else {
      if (joinchallange["success"] == true) {
        challengeAccepted(context);
      } else {
        _showScaffold(joinchallange["error"]);
      }
    }
    print("user $joinchallange");
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
            Container(
              width: 300,
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  message,
                  style: GoogleFonts.poppins(
                    color: white,
                  ),
                ),
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
  ];
  List<Color> joinChallengeColorList = [
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

  List<String> day = ["5", "6", "4", "2", "1", "3", "7"];
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
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => Tabscreen(
                        index: 2,
                      ),
                    ),
                  );
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
                                return InkWell(
                                  onTap: () {
                                    joinChallenge(
                                        context, challengesOne[index]);
                                  },
                                  child: Stack(
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
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.85,
                                                decoration: BoxDecoration(
                                                    color: joinChallengeColorList[
                                                        index %
                                                            joinChallengeColorList
                                                                .length],
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20)),
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
                                                                    .circular(
                                                                        18),
                                                                bottomRight:
                                                                    Radius
                                                                        .circular(
                                                                            25),
                                                                topLeft: Radius
                                                                    .circular(
                                                                        18),
                                                                topRight: Radius
                                                                    .circular(
                                                                        25)),
                                                      ),
                                                      child: Center(
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Text(
                                                              challengesOne[
                                                                          index]
                                                                      .totalKm +
                                                                  "KM ",
                                                              style: GoogleFonts
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
                                                              challengesOne[index]
                                                                          .mode ==
                                                                      "Walking"
                                                                  ? "WALK "
                                                                  : "RUN ",
                                                              style: GoogleFonts
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
                                                              challengesOne[
                                                                      index]
                                                                  .type
                                                                  .toUpperCase(),
                                                              style: GoogleFonts
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
                                                           
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      left: 5),
                                                              child: Text(
                                                                challengesOne[
                                                                      index]
                                                                  .prize.toString(),
                                                                  style: GoogleFonts.poppins(
                                                                      color: Colors
                                                                          .white,
                                                                      fontSize:
                                                                          12,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600)),
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
                                        right:
                                            MediaQuery.of(context).size.width *
                                                0.03,
                                        top: 10,
                                        child: Container(
                                          height: 40,
                                          width: 40,
                                          child: trophy[index % trophy.length],
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
        ],
      )),
    );
  }

  void joinChallenge(BuildContext context, chall) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return StatefulBuilder(
          // You need this, notice the parameters below:
          builder: (BuildContext context, StateSetter setState) {
            return SingleChildScrollView(
              child: Container(
                color: backgroundcolor.withOpacity(0.4),
                margin: EdgeInsets.only(top: 0, left: 0, bottom: 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
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
                        // Text(
                        //   (lang.length != null &&
                        //           lang.length != 0 &&
                        //           userLanguage['createachellenge'] != null)
                        //       ? "${userLanguage['createachellenge']}"
                        //       : "CREATE A \nCHALLENGE",
                        //   style: GoogleFonts.poppins(
                        //     decoration: TextDecoration.none,
                        //     height: 1,
                        //     color: Colors.white,
                        //     fontSize: 17,
                        //     fontWeight: FontWeight.w600,
                        //   ),
                        // ),
                      ],
                    ),
                    // SizedBox(
                    //   height: MediaQuery.of(context).size.height * 0.2,
                    // ),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.8,
                      width: MediaQuery.of(context).size.width * 0.85,
                      //color: Colors.red,
                      child: Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 140),
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.7,
                              width: MediaQuery.of(context).size.width * 0.85,
                              decoration: BoxDecoration(
                                color: backgroundcolor,
                                borderRadius: BorderRadius.circular(25),
                              ),
                              child: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(height: 100),
                                    Text(
                                      (lang.length != null &&
                                              lang.length != 0 &&
                                              userLanguage[
                                                      'areyousureyouwanttoenter'] !=
                                                  null)
                                          ? "${userLanguage['areyousureyouwanttoenter']}"
                                          : "Are you sure you \n  want to enter?",
                                      style: GoogleFonts.poppins(
                                        decoration: TextDecoration.none,
                                        color: Colors.white,
                                        fontSize: 25,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    SizedBox(height: 15),
                                    Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.05,
                                      width: MediaQuery.of(context).size.width *
                                          0.55,
                                      //height: 36, width: 210,
                                      decoration: BoxDecoration(
                                        color: spr.withOpacity(0.5),
                                        borderRadius: BorderRadius.circular(25),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Container(
                                            child: Row(
                                              children: [
                                                Text(
                                                  (lang.length != null &&
                                                          lang.length != 0 &&
                                                          userLanguage[
                                                                  'activity'] !=
                                                              null)
                                                      ? "${userLanguage['activity']}"
                                                      : "Activity: ",
                                                  style: GoogleFonts.poppins(
                                                    decoration:
                                                        TextDecoration.none,
                                                    color: text1,
                                                    fontSize: 12,
                                                  ),
                                                ),
                                                Text(
                                                  chall.mode,
                                                  style: GoogleFonts.poppins(
                                                    decoration:
                                                        TextDecoration.none,
                                                    color: white,
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            child: Row(
                                              children: [
                                                Text(
                                                  (lang.length != null &&
                                                          lang.length != 0 &&
                                                          userLanguage[
                                                                  'type'] !=
                                                              null)
                                                      ? "${userLanguage['type']}"
                                                      : "Type: ",
                                                  style: GoogleFonts.poppins(
                                                    decoration:
                                                        TextDecoration.none,
                                                    color: text1,
                                                    fontSize: 12,
                                                  ),
                                                ),
                                                Text(
                                                  chall.type,
                                                  style: GoogleFonts.poppins(
                                                    decoration:
                                                        TextDecoration.none,
                                                    color: white,
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Text(
                                      (lang.length != null &&
                                              lang.length != 0 &&
                                              userLanguage['wager'] != null)
                                          ? "${userLanguage['wager']}"
                                          : "WAGER",
                                      style: GoogleFonts.poppins(
                                        decoration: TextDecoration.none,
                                        color: text1,
                                        fontSize: 9,
                                        //fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Text(
                                      chall.totalCompetitors,
                                      style: GoogleFonts.montserrat(
                                        decoration: TextDecoration.none,
                                        color: white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Text(
                                      (lang.length != null &&
                                              lang.length != 0 &&
                                              userLanguage['winnergets'] !=
                                                  null)
                                          ? "${userLanguage['winnergets']}"
                                          : "WINNER GETS",
                                      style: GoogleFonts.poppins(
                                        decoration: TextDecoration.none,
                                        color: text1,
                                        fontSize: 12,
                                        //fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Text(
                                      "${chall.wage} Gwei",
                                      style: GoogleFonts.montserrat(
                                        decoration: TextDecoration.none,
                                        color: Colors.orange,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Container(
                                      height: 55,
                                      width: 144,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      // ignore: deprecated_member_use
                                      child: RaisedButton(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(30),
                                          ),
                                          onPressed: () {
                                            Navigator.pop(context);
                                            joiningchallenge(
                                              user[0]["uid"],
                                              chall.id,
                                            );
                                            //challengeAccepted(context);
                                          },
                                          color: blue2,
                                          child: Text(
                                            (lang.length != null &&
                                                    lang.length != 0 &&
                                                    userLanguage['confirm'] !=
                                                        null)
                                                ? "${userLanguage['confirm']}"
                                                : "Confirm",
                                            style: GoogleFonts.poppins(
                                              color: white,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          )),
                                    ),
                                    SizedBox(
                                      height: 25,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text(
                                        (lang.length != null &&
                                                lang.length != 0 &&
                                                userLanguage['cancel'] != null)
                                            ? "${userLanguage['cancel']}"
                                            : "CANCEL",
                                        style: GoogleFonts.montserrat(
                                          decoration: TextDecoration.none,
                                          color: blue2,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 50),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            top: 0,
                            left: MediaQuery.of(context).size.width * 0.01,
                            child: Image.asset("assets/images/jc1.png"),
                          ),
                          Positioned(
                            top: MediaQuery.of(context).size.height * 0.06,
                            left: MediaQuery.of(context).size.width * 0.05,
                            child: Image.asset("assets/images/jc2.png"),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  challengeAccepted(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return StatefulBuilder(
          // You need this, notice the parameters below:
          builder: (BuildContext context, StateSetter setState) {
            return Container(
              color: backgroundcolor.withOpacity(0.4),
              margin: EdgeInsets.only(top: 0, left: 0, bottom: 0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 150,
                    ),
                    Stack(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height * 0.6,
                          width: MediaQuery.of(context).size.width * 0.85,
                          //color: Colors.red,
                          child: Stack(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 65),
                                child: Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.5,
                                  width:
                                      MediaQuery.of(context).size.width * 0.85,
                                  decoration: BoxDecoration(
                                    color: backgroundcolor,
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: Column(
                                    children: [
                                      SizedBox(height: 75),
                                      Text(
                                        (lang.length != null &&
                                                lang.length != 0 &&
                                                userLanguage[
                                                        'challengeaccepted'] !=
                                                    null)
                                            ? "${userLanguage['challengeaccepted']}"
                                            : "Challenge \nAccepted!",
                                        style: GoogleFonts.poppins(
                                          height: 1,
                                          decoration: TextDecoration.none,
                                          color: white,
                                          fontSize: 30,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      SizedBox(height: 25),
                                      RichText(
                                        text: TextSpan(
                                          children: [
                                            TextSpan(
                                                text: (lang.length != null &&
                                                        lang.length != 0 &&
                                                        userLanguage[
                                                                'youcantrackyourprogressinthischallengeandothersin'] !=
                                                            null)
                                                    ? "${userLanguage['youcantrackyourprogressinthischallengeandothersin']}"
                                                    : 'You can track your progress in this \nchallenge and others in',
                                                style: GoogleFonts.poppins(
                                                  color: text1,
                                                  fontSize: 12,
                                                  // fontWeight: FontWeight.w600,
                                                )),
                                            TextSpan(
                                                text: (lang.length != null &&
                                                        lang.length != 0 &&
                                                        userLanguage[
                                                                'myactivity'] !=
                                                            null)
                                                    ? "${userLanguage['myactivity']}"
                                                    : ' My Activity',
                                                style: GoogleFonts.poppins(
                                                  color: blue,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w500,
                                                )),
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 25),
                                      Container(
                                        height: 55,
                                        width: 144,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        // ignore: deprecated_member_use
                                        child: RaisedButton(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                            ),
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            color: blue2,
                                            child: Text(
                                              (lang.length != null &&
                                                      lang.length != 0 &&
                                                      userLanguage[
                                                              'viewchallenges'] !=
                                                          null)
                                                  ? "${userLanguage['viewchallenges']}"
                                                  : "View Challenges",
                                              style: GoogleFonts.poppins(
                                                color: white,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            )),
                                      ),
                                      SizedBox(
                                        height: 25,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text(
                                          (lang.length != null &&
                                                  lang.length != 0 &&
                                                  userLanguage['gohome'] !=
                                                      null)
                                              ? "${userLanguage['gohome']}"
                                              : "GO HOME",
                                          style: GoogleFonts.montserrat(
                                            decoration: TextDecoration.none,
                                            color: blue2,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          top: 0,
                          left: MediaQuery.of(context).size.width * 0.2,
                          child: Image.asset("assets/images/jct.png"),
                        )
                      ],
                    )
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
