import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
//import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:momerlin/data/localstorage/userdata_source.dart';
import 'package:momerlin/data/userrepository.dart';

// import 'package:momerlin/tabscreen/tabscreen.dart';
import 'package:momerlin/theme/theme.dart';

import 'challangedetails.dart';

class Challenges {
  var mode;
  var type;
  var totalCompetitors;
  var streakDays;
  var totalKm;
  var wage;
  var id;

  Challenges({
    this.mode,
    this.type,
    this.totalCompetitors,
    this.streakDays,
    this.totalKm,
    this.wage,
    this.id,
  });

  factory Challenges.fromJson(Map<String, dynamic> json) => Challenges(
        mode: json["mode"] == null ? null : json["mode"],
        type: json["type"],
        totalCompetitors: json["totalCompetitors"],
        streakDays: json["streakDays"],
        totalKm: json["totalKm"],
        wage: json["wage"],
        id: json["_id"],
      );
}

// To parse this JSON data, do

//     final leaderboardAll = leaderboardAllFromJson(jsonString);

class LeaderboardAll {
  LeaderboardAll({
    this.id,
    this.competitor,
    this.challenge,
    this.startAt,
    this.endAt,
    this.totalkm,
    this.streakNo,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  String id;
  LeaderboardAllCompetitor competitor;
  Challenge challenge;
  String startAt;
  String endAt;
  String totalkm;
  int streakNo;
  String status;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  factory LeaderboardAll.fromJson(Map<String, dynamic> json) => LeaderboardAll(
        id: json["_id"],
        competitor: LeaderboardAllCompetitor.fromJson(json["competitor"]),
        challenge: Challenge.fromJson(json["challenge"]),
        startAt: json["startAt"],
        endAt: json["endAt"],
        totalkm: json["totalkm"],
        streakNo: json["streakNo"],
        status: json["status"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "competitor": competitor.toJson(),
        "challenge": challenge.toJson(),
        "startAt": startAt,
        "endAt": endAt,
        "totalkm": totalkm,
        "streakNo": streakNo,
        "status": status,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
      };
}

class Challenge {
  Challenge({
    this.id,
    this.mode,
    this.type,
    this.totalCompetitors,
    this.streakDays,
    this.totalKm,
    this.createdBy,
    this.competitors,
    this.startAt,
    this.endAt,
    this.wage,
    this.prize,
    this.commissionEnabled,
    this.percentage,
    this.winners,
    this.active,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  String id;
  String mode;
  String type;
  String totalCompetitors;
  String streakDays;
  String totalKm;
  String createdBy;
  List<CompetitorElement> competitors;
  DateTime startAt;
  DateTime endAt;
  String wage;
  int prize;
  bool commissionEnabled;
  String percentage;
  List<dynamic> winners;
  bool active;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  factory Challenge.fromJson(Map<String, dynamic> json) => Challenge(
        id: json["_id"],
        mode: json["mode"],
        type: json["type"],
        totalCompetitors: json["totalCompetitors"],
        streakDays: json["streakDays"],
        totalKm: json["totalKm"],
        createdBy: json["createdBy"],
        competitors: List<CompetitorElement>.from(
            json["competitors"].map((x) => CompetitorElement.fromJson(x))),
        startAt: DateTime.parse(json["startAt"]),
        endAt: DateTime.parse(json["endAt"]),
        wage: json["wage"],
        prize: json["prize"],
        commissionEnabled: json["commissionEnabled"],
        percentage: json["percentage"],
        winners: List<dynamic>.from(json["winners"].map((x) => x)),
        active: json["active"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "mode": mode,
        "type": type,
        "totalCompetitors": totalCompetitors,
        "streakDays": streakDays,
        "totalKm": totalKm,
        "createdBy": createdBy,
        "competitors": List<dynamic>.from(competitors.map((x) => x.toJson())),
        "startAt": startAt.toIso8601String(),
        "endAt": endAt.toIso8601String(),
        "wage": wage,
        "prize": prize,
        "commissionEnabled": commissionEnabled,
        "percentage": percentage,
        "winners": List<dynamic>.from(winners.map((x) => x)),
        "active": active,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
      };
}

class CompetitorElement {
  CompetitorElement({
    this.userId,
    this.joinedAt,
    this.id,
  });

  String userId;
  DateTime joinedAt;
  String id;

  factory CompetitorElement.fromJson(Map<String, dynamic> json) =>
      CompetitorElement(
        userId: json["userId"],
        joinedAt: DateTime.parse(json["joinedAt"]),
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "joinedAt": joinedAt.toIso8601String(),
        "_id": id,
      };
}

class LeaderboardAllCompetitor {
  LeaderboardAllCompetitor({this.id, this.fullName, this.imageurl});

  String id;
  String fullName;
  var imageurl;
  factory LeaderboardAllCompetitor.fromJson(Map<String, dynamic> json) =>
      LeaderboardAllCompetitor(
        id: json["_id"],
        fullName: json["fullName"],
        imageurl: json["imageUrl"],
      );

  Map<String, dynamic> toJson() =>
      {"_id": id, "fullName": fullName, "imageUrl": imageurl};
}

class ViewmoreLeaderboard extends StatefulWidget {
  const ViewmoreLeaderboard({Key key}) : super(key: key);

  @override
  _ViewmoreLeaderboardState createState() => _ViewmoreLeaderboardState();
}

class _ViewmoreLeaderboardState extends State<ViewmoreLeaderboard> {
  List<LeaderboardAll> leaderboardAll = [];
  bool loading = true;
  var userLanguage, user, lang = [];

  @override
  void initState() {
    super.initState();
    getUserLanguage();
    getAllLeaderboard();
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

  Future<void> getAllLeaderboard() async {
    var res = await UserRepository().getAllLeaderboard();
    if (res == false) {
      // Scaffold
      //   .of(context)
      //   .showSnackBar(SnackBar(content: Text('No Internet Connection'),backgroundColor: Colors.red,));
    } else {
      if (res["success"] == true) {
        setState(() {
          loading = false;
        });
        leaderboardAll = [];
        for (var i = 0; i < res["leaders"].length; i++) {
          leaderboardAll.add(LeaderboardAll.fromJson(res["leaders"][i]));
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

  var url = [
    "https://www.pngitem.com/pimgs/m/78-786293_1240-x-1240-0-avatar-profile-icon-png.png",
    "https://cdn.imgbin.com/1/8/12/imgbin-computer-icons-user-profile-avatar-woman-business-woman-2x9qVDw4EgxX299EhCLm9fN89.jpg",
    "https://www.clipartmax.com/png/middle/171-1717870_stockvader-predicted-cron-for-may-user-profile-icon-png.png",
  ];

  List<Color> leaderboardNumberColorList = [
    orange,
    blue1,
    spendingPink,
    text1,
  ];
  List<Color> leaderboardColorList = [
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
                  userLanguage['recentwinners'] != null)
              ? "${userLanguage['recentwinners']}"
              : "LEADERBOARD",
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
                : leaderboardAll.length == 0
                    ? Container(
                        height: MediaQuery.of(context).size.height * 0.2,
                        width: MediaQuery.of(context).size.width,
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "NO CHALLENGES",
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      )
                    : Container(
                        // height: MediaQuery.of(context).size.height * 0.28,
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.only(left: 5, right: 0),
                        //color: Colors.indigo,
                        padding: EdgeInsets.only(
                            left: 4, top: 10, bottom: 0, right: 0),
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          itemCount: leaderboardAll.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Challengesdetail(
                                      challange:
                                          leaderboardAll[index].challenge.id,
                                    ),
                                  ),
                                );
                                // leaderboardProfile(context);
                              },
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10),
                                        child: Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.075,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.1,
                                          //height: 63, width: 42,
                                          decoration: BoxDecoration(
                                              color: leaderboardNumberColorList[
                                                  index %
                                                      leaderboardNumberColorList
                                                          .length],
                                              borderRadius:
                                                  BorderRadius.circular(16)),
                                          child: Center(
                                            child: Text(
                                              "${index + 1}",
                                              style: GoogleFonts.poppins(
                                                color: Colors.white,
                                                fontSize: 20,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10),
                                        child: Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.08,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.8,
                                          //height: 63, width: 300,
                                          decoration: BoxDecoration(
                                              color: white.withOpacity(0.1),
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                          child: Row(
                                            children: [
                                              SizedBox(
                                                width: 10,
                                              ),
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                                child: Container(
                                                  height: 35,
                                                  width: 35,
                                                  color: button,
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            100),
                                                    child: leaderboardAll[index]
                                                                .competitor
                                                                .imageurl !=
                                                            ""
                                                        ? Image.network(
                                                            leaderboardAll[
                                                                    index]
                                                                .competitor
                                                                .imageurl,
                                                            fit: BoxFit.cover,
                                                          )
                                                        : Center(
                                                            child: Text(
                                                              leaderboardAll[
                                                                      index]
                                                                  .competitor
                                                                  .fullName
                                                                  .substring(
                                                                      0, 1),
                                                              style: TextStyle(
                                                                  color: white,
                                                                  fontSize: 17,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                          ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.4,
                                                    child: FittedBox(
                                                      fit: BoxFit.scaleDown,
                                                      child: Text(
                                                        leaderboardAll[index]
                                                            .competitor
                                                            .fullName
                                                            .toString()
                                                            .toUpperCase(),
                                                        style:
                                                            GoogleFonts.poppins(
                                                          color: Colors.white,
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  RatingBar.builder(
                                                    initialRating: 3,
                                                    minRating: 1,
                                                    direction: Axis.horizontal,
                                                    allowHalfRating: true,
                                                    itemCount: 3,
                                                    itemSize: 10,
                                                    itemPadding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 0.2),
                                                    itemBuilder: (context, _) =>
                                                        Icon(
                                                      Icons.star,
                                                      color: Colors.amber,
                                                    ),
                                                    onRatingUpdate: (rating) {},
                                                  ),
                                                ],
                                              ),
                                              Container(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.05,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.23,
                                                //height: 38, width: 98,
                                                decoration: BoxDecoration(
                                                  color: Colors.white
                                                      .withOpacity(0.1),
                                                  borderRadius:
                                                      BorderRadius.circular(16),
                                                ),
                                                child: FittedBox(
                                                  fit: BoxFit.scaleDown,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        leaderboardAll[index]
                                                            .challenge
                                                            .prize
                                                            .toString(),
                                                        style:
                                                            GoogleFonts.poppins(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(left: 5),
                                                        child: Text(
                                                          "Gwei",
                                                          style: GoogleFonts.poppins(
                                                              color: Colors
                                                                  .orangeAccent,
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400),
                                                        ),
                                                      ),
                                                    ],
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
                                    height: 15,
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
    );
  }
}
