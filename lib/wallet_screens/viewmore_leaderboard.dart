import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
//import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:momerlin/data/localstorage/userdata_source.dart';
import 'package:momerlin/data/userrepository.dart';

import 'package:momerlin/tabscreen/tabscreen.dart';
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

class ViewmoreLeaderboard extends StatefulWidget {
  const ViewmoreLeaderboard({Key key}) : super(key: key);

  @override
  _ViewmoreLeaderboardState createState() => _ViewmoreLeaderboardState();
}

class _ViewmoreLeaderboardState extends State<ViewmoreLeaderboard> {
  List<Challenges> challengesOne = [];
  List<LeaderboardAll> leaderboardAll = [];
  bool loading = true;
  var userLanguage, user, lang = [];

  @override
  void initState() {
    super.initState();
    getChallenges();
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

  Future<void> getChallenges() async {
    var res = await UserRepository().getChallenges();
    if (res == false) {
      // Scaffold
      //   .of(context)
      //   .showSnackBar(SnackBar(content: Text('No Internet Connection'),backgroundColor: Colors.red,));
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
        Scaffold.of(context)
            // ignore: deprecated_member_use
            .showSnackBar(SnackBar(
          content: Text('Please Try Again!'),
          backgroundColor: Colors.red,
        ));
      }
    }
  }

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
  List<Color> joinChallengeColorList = [
    blue1,
    spendingPink,
    containerOrange,
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
              : leaderboardAll.length == 0
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
                                          challange: leaderboardAll[index]
                                              .challenge
                                              .id)));
                              // leaderboardProfile(context);
                            },
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Container(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.075,
                                        width:
                                            MediaQuery.of(context).size.width *
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
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Container(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.08,
                                        width:
                                            MediaQuery.of(context).size.width *
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
                                                child: Image.network(
                                                  url[index % url.length],
                                                  fit: BoxFit.cover,
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
                                                  width: MediaQuery.of(context)
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
                                                  onRatingUpdate: (rating) {
                                                  
                                                  },
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
                                                      BorderRadius.circular(
                                                          16)),
                                              child: FittedBox(
                                                fit: BoxFit.scaleDown,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
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
                                                                        .w600)),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 5),
                                                      child: Text("Gwei",
                                                          style: GoogleFonts.poppins(
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
                    )
        ],
      )),
    );
  }

  // ignore: non_constant_identifier_names
  void leaderboardProfile(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return StatefulBuilder(
          // You need this, notice the parameters below:
          builder: (BuildContext context, StateSetter setState) {
            return SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height,
                color: Colors.transparent.withOpacity(0.5),
                margin: EdgeInsets.only(top: 0, left: 0, bottom: 0),
                child: Column(
                  //  shrinkWrap: true,
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
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Tabscreen(
                                            index: 2,
                                          )));
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
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          (lang.length != null &&
                                  lang.length != 0 &&
                                  userLanguage['createachellenge'] != null)
                              ? "${userLanguage['createachellenge']}"
                              : "ZONO'S PROFILE",
                          style: GoogleFonts.poppins(
                            decoration: TextDecoration.none,
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 100),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Stack(
                        children: [
                          Container(
                            height: MediaQuery.of(context).size.height * 0.7,
                            //color: Colors.orange,
                            child: Stack(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 50),
                                  child: Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.65,
                                    width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(
                                      color: Color(0xff1C203A),
                                      borderRadius: BorderRadius.circular(22),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: 50,
                                        ),
                                        Center(
                                          child: Text(
                                            (lang.length != null &&
                                                    lang.length != 0 &&
                                                    userLanguage[''] != null)
                                                ? "${userLanguage['']}"
                                                : "ZONO",
                                            style: GoogleFonts.poppins(
                                              decoration: TextDecoration.none,
                                              color: Colors.white,
                                              fontSize: 25,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 50,
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 25),
                                          child: Text(
                                            (lang.length != null &&
                                                    lang.length != 0 &&
                                                    userLanguage[
                                                            'recentwins'] !=
                                                        null)
                                                ? "${userLanguage['recentwins']}"
                                                : "RECENT WINS",
                                            style: GoogleFonts.poppins(
                                              decoration: TextDecoration.none,
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.17,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          decoration: BoxDecoration(
                                              color: Color(0xff313248),
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: Column(
                                            children: [
                                              SizedBox(
                                                height: 10,
                                              ),
                                              challengesOne.length == 0
                                                  ? Container(
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.2,
                                                      width:
                                                          MediaQuery.of(context)
                                                              .size
                                                              .width,
                                                      child: Center(
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Text(
                                                              "NO CHALLENGES",
                                                              style: GoogleFonts
                                                                  .poppins(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                              )),
                                                        ),
                                                      ),
                                                    )
                                                  : loading == true
                                                      ? Container(
                                                          height: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .height *
                                                              0.23,
                                                          width: MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .width,
                                                          color:
                                                              backgroundcolor,
                                                          child: Center(
                                                            child:
                                                                SpinKitSpinningLines(
                                                              color: white,
                                                              size: 60,
                                                            ),
                                                          ),
                                                        )
                                                      : Container(
                                                          height: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .height *
                                                              0.14,
                                                          width: MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .width,
                                                          margin:
                                                              EdgeInsets.only(
                                                                  left: 5,
                                                                  right: 0),
                                                          //color: Colors.indigo,
                                                          padding:
                                                              EdgeInsets.only(
                                                                  left: 4,
                                                                  top: 10,
                                                                  bottom: 0,
                                                                  right: 0),
                                                          child:
                                                              ListView.builder(
                                                            scrollDirection:
                                                                Axis.horizontal,
                                                            itemCount:
                                                                challengesOne
                                                                    .length,
                                                            itemBuilder:
                                                                (context,
                                                                    index) {
                                                              print(
                                                                  "ChallengeOne Length :  ${challengesOne.length}");
                                                              return Material(
                                                                child: Stack(
                                                                  children: [
                                                                    Container(
                                                                      height: MediaQuery.of(context)
                                                                              .size
                                                                              .height *
                                                                          0.135,
                                                                      width: MediaQuery.of(context)
                                                                              .size
                                                                              .width *
                                                                          0.4,
                                                                      color: Color(
                                                                          0xff313248),
                                                                      child:
                                                                          Column(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.end,
                                                                        children: [
                                                                          Container(
                                                                            height:
                                                                                MediaQuery.of(context).size.height * 0.1,
                                                                            width:
                                                                                MediaQuery.of(context).size.width * 0.35,
                                                                            // height: 126,
                                                                            // width: 130,
                                                                            decoration:
                                                                                BoxDecoration(
                                                                              color: joinChallengeColorList[index % joinChallengeColorList.length],
                                                                              borderRadius: BorderRadius.circular(15),
                                                                            ),
                                                                            child:
                                                                                Column(
                                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                                              children: [
                                                                                SizedBox(height: 20),
                                                                                Row(
                                                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                                                  children: [
                                                                                    Text(
                                                                                      challengesOne[index].totalKm + "KM ",
                                                                                      style: GoogleFonts.poppins(
                                                                                        color: Colors.white,
                                                                                        fontSize: 14,
                                                                                        fontWeight: FontWeight.w600,
                                                                                      ),
                                                                                    ),
                                                                                    Text(
                                                                                      challengesOne[index].mode == "Walking" ? "WALK" : "RUN",
                                                                                      style: GoogleFonts.poppins(
                                                                                        color: Colors.white,
                                                                                        fontSize: 14,
                                                                                        fontWeight: FontWeight.w600,
                                                                                      ),
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                                Text(
                                                                                  challengesOne[index].type.toUpperCase(),
                                                                                  style: GoogleFonts.poppins(
                                                                                    color: Colors.white,
                                                                                    fontSize: 14,
                                                                                    fontWeight: FontWeight.w600,
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    Positioned(
                                                                      top: MediaQuery.of(context)
                                                                              .size
                                                                              .height *
                                                                          0,
                                                                      left: MediaQuery.of(context)
                                                                              .size
                                                                              .width *
                                                                          0.13,
                                                                      child:
                                                                          Container(
                                                                        height:
                                                                            43,
                                                                        width:
                                                                            43,
                                                                        //color: button,
                                                                        child: trophy[index %
                                                                            trophy.length],
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
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                            top: 3,
                            left: MediaQuery.of(context).size.width * 0.4,
                            child: Container(
                              height: 85,
                              width: 85,
                              decoration: BoxDecoration(
                                  //color: white,
                                  borderRadius: BorderRadius.circular(40)),
                              child: Image.asset(
                                "assets/images/profile.png",
                                fit: BoxFit.cover,
                              ),
                            ),
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
}
