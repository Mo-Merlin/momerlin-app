import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:momerlin/data/localstorage/userdata_source.dart';
import 'package:momerlin/data/userrepository.dart';

import 'package:momerlin/tabscreen/tabscreen.dart';
import 'package:momerlin/theme/theme.dart';

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
  var startAt;
  var endAt;
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
  LeaderboardAllCompetitor({
    this.id,
    this.fullName,
  });

  String id;
  String fullName;

  factory LeaderboardAllCompetitor.fromJson(Map<String, dynamic> json) =>
      LeaderboardAllCompetitor(
        id: json["_id"],
        fullName: json["fullName"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "fullName": fullName,
      };
}

class ViewmoreRecentWinners extends StatefulWidget {
  const ViewmoreRecentWinners({Key key}) : super(key: key);

  @override
  _ViewmoreRecentWinnersState createState() => _ViewmoreRecentWinnersState();
}

class _ViewmoreRecentWinnersState extends State<ViewmoreRecentWinners> {
  bool loading = true;
  List<LeaderboardAll> leaderboardAll = [];
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

  Future<void> getAllLeaderboard() async {
    setState(() {
      loading = false;
    });
    var res = await UserRepository().getAllLeaderboard();
    print("PAVIANI $res");
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

  // ignore: todo
  //TODO: LanguageEnd
  List elements = [
    {
      "count": "1",
      "leadername": "zuno",
      "name": "@momozuno \nhas earned",
      "url":
          "https://www.pngitem.com/pimgs/m/78-786293_1240-x-1240-0-avatar-profile-icon-png.png",
      "amt": "400",
      "type": "Gwei",
    },
    {
      "count": "2",
      "leadername": "timodit",
      "name": "@jade.sim \nhas earned",
      "url":
          "https://cdn.imgbin.com/1/8/12/imgbin-computer-icons-user-profile-avatar-woman-business-woman-2x9qVDw4EgxX299EhCLm9fN89.jpg",
      "amt": "230",
      "type": "Gwei",
    },
    {
      "count": "3",
      "leadername": "sadiam",
      "name": "@cam.c \nhas earned",
      "url":
          "https://www.clipartmax.com/png/middle/171-1717870_stockvader-predicted-cron-for-may-user-profile-icon-png.png",
      "amt": "40",
      "type": "Gwei",
    },
    {
      "count": "4",
      "leadername": "sadiam",
      "name": "@momozuno \nhas earned",
      "url":
          "https://www.pngitem.com/pimgs/m/78-786293_1240-x-1240-0-avatar-profile-icon-png.png",
      "amt": "400",
      "type": "Gwei",
    },
    {
      "count": "5",
      "leadername": "sadiam",
      "name": "@jade.sim \nhas earned",
      "url":
          "https://cdn.imgbin.com/1/8/12/imgbin-computer-icons-user-profile-avatar-woman-business-woman-2x9qVDw4EgxX299EhCLm9fN89.jpg",
      "amt": "230",
      "type": "Gwei",
    },
    {
      "count": "6",
      "leadername": "sadiam",
      "name": "@cam.c \nhas earned",
      "url":
          "https://www.clipartmax.com/png/middle/171-1717870_stockvader-predicted-cron-for-may-user-profile-icon-png.png",
      "amt": "40",
      "type": "Gwei",
    },
  ];

  List<Color> recentWinnersColorList = [
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
                  userLanguage['recentwinners'] != null)
              ? "${userLanguage['recentwinners']}"
              : "RECENT WINNERS",
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
          // loading == true
          //     ? Container(
          //         height: MediaQuery.of(context).size.height * 0.23,
          //         width: MediaQuery.of(context).size.width,
          //         color: backgroundcolor,
          //         child: Center(
          //           child: SpinKitSpinningLines(
          //             color: white,
          //             size: 60,
          //           ),
          //         ),
          //       )
          //     : mychallenge.length == 0
          //         ? Container(
          //             height: MediaQuery.of(context).size.height * 0.2,
          //             width: MediaQuery.of(context).size.width,
          //             child: Center(
          //               child: Padding(
          //                 padding: const EdgeInsets.all(8.0),
          //                 child: Text("NO CHALLENGES",
          //                     style: GoogleFonts.poppins(
          //                       color: Colors.white,
          //                       fontSize: 14,
          //                       fontWeight: FontWeight.w600,
          //                     )),
          //               ),
          //             ),
          //           )
          //         :
          Container(
            // height: MediaQuery.of(context).size.height * 0.28,
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.only(left: 5, right: 0),
            //color: Colors.indigo,
            padding: EdgeInsets.only(left: 4, top: 10, bottom: 0, right: 0),
            child: ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              itemCount: leaderboardAll.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {},
                  child: Column(
                    children: [
                      Row(
                        children: [
                          // Padding(
                          //   padding: const EdgeInsets.only(left: 10),
                          //   child: Container(
                          //     height: MediaQuery.of(context).size.height * 0.07,
                          //     width: MediaQuery.of(context).size.width * 0.1,
                          //     //height: 63, width: 42,
                          //     decoration: BoxDecoration(
                          //         color: recentWinnersColorList[
                          //             index % recentWinnersColorList.length],
                          //         borderRadius: BorderRadius.circular(16)),
                          //     child: Center(
                          //       child: Text(
                          //         elements[index]["count"],
                          //         style: GoogleFonts.poppins(
                          //           color: Colors.white,
                          //           fontSize: 25,
                          //           fontWeight: FontWeight.w600,
                          //         ),
                          //       ),
                          //     ),
                          //   ),
                          // ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.08,
                              width: MediaQuery.of(context).size.width * 0.9,
                              //height: 63, width: 300,
                              decoration: BoxDecoration(
                                  color: white.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(20)),
                              child: ListTile(
                                leading: ClipRRect(
                                  borderRadius: BorderRadius.circular(30),
                                  child: Container(
                                      height: 35,
                                      width: 35,
                                      color: button,
                                      child: Image.network(
                                        elements[index]['url'],
                                        fit: BoxFit.cover,
                                      )),
                                ),
                                title: FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Row(
                                    children: [
                                      Text(
                                        leaderboardAll[index]
                                            .competitor
                                            .fullName
                                            .toString()
                                            .toUpperCase(),
                                        style: GoogleFonts.poppins(
                                          color: Colors.white60,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Text(
                                        " has earned",
                                        style: GoogleFonts.poppins(
                                          color: Colors.white60,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                //subtitle: Text("rating"),
                                subtitle: Text("yesterday",
                                    style: GoogleFonts.poppins(
                                        color: Colors.white54,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600)),
                                trailing: Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.05,
                                  width:
                                      MediaQuery.of(context).size.width * 0.25,
                                  //height: 38, width: 98,
                                  decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(16)),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                          leaderboardAll[index]
                                              .challenge
                                              .prize
                                              .toString(),
                                          style: GoogleFonts.poppins(
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600)),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 5),
                                        child: Text("Gwei",
                                            style: GoogleFonts.poppins(
                                                color: Colors.orangeAccent,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400)),
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
                  ),
                );
              },
            ),
          )
        ],
      )),
    );
  }
}
