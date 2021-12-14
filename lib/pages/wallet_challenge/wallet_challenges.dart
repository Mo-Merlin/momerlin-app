// import 'dart:io';

import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:health/health.dart';
import 'package:intl/intl.dart';
import 'package:momerlin/data/localstorage/userdata_source.dart';
import 'package:momerlin/data/userrepository.dart';
import 'package:momerlin/tabscreen/tabscreen.dart';
import 'package:momerlin/theme/theme.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:scroll_snap_list/scroll_snap_list.dart';

import 'challangedetails.dart';
import 'joinchallengedetail.dart';
import 'my_activity.dart';
import 'viewmore_join_challenge.dart';
import 'viewmore_leaderboard.dart';
import 'viewmore_my_challenges.dart';
import 'viewmore_recent_winners.dart';
import 'wallet_challenge_final.dart';

class Challenges {
  String id;
  String mode;
  String type;
  String totalCompetitors;
  String streakDays;
  String totalKm;
  CreatedBy createdBy;
  List<Competitor> competitors;
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
  Challenges({
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

  factory Challenges.fromJson(Map<String, dynamic> json) => Challenges(
        id: json["_id"],
        mode: json["mode"],
        type: json["type"],
        totalCompetitors: json["totalCompetitors"],
        streakDays: json["streakDays"],
        totalKm: json["totalKm"],
        createdBy: CreatedBy.fromJson(json["createdBy"]),
        competitors: List<Competitor>.from(
            json["competitors"].map((x) => Competitor.fromJson(x))),
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
        "createdBy": createdBy.toJson(),
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

class Competitor {
  Competitor({
    this.userId,
    this.joinedAt,
    this.id,
  });

  String userId;
  DateTime joinedAt;
  String id;

  factory Competitor.fromJson(Map<String, dynamic> json) => Competitor(
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

class CreatedBy {
  CreatedBy({
    this.id,
    this.fullName,
  });

  String id;
  String fullName;

  factory CreatedBy.fromJson(Map<String, dynamic> json) => CreatedBy(
        id: json["_id"],
        fullName: json["fullName"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "fullName": fullName,
      };
}

class MyChallenges {
  var mode;
  var type;
  var totalCompetitors;
  var streakDays;
  var totalKm;
  var wage;
  var id;
  var startDate;
  var endDate;
  var prize;

  MyChallenges({
    this.mode,
    this.type,
    this.totalCompetitors,
    this.streakDays,
    this.totalKm,
    this.wage,
    this.id,
    this.startDate,
    this.endDate,
    this.prize,
  });

  factory MyChallenges.fromJson(Map<String, dynamic> json) => MyChallenges(
      mode: json["mode"] == null ? null : json["mode"],
      type: json["type"],
      totalCompetitors: json["totalCompetitors"],
      streakDays: json["streakDays"],
      totalKm: json["totalKm"],
      wage: json["wage"],
      id: json["_id"],
      startDate: json["startAt"],
      endDate: json["endAt"],
      prize: json["prize"]);
}

class JoingetChallenges {
  var totalkm;
  var id;
  GetChallenge challenge;
  var streakNo;

  JoingetChallenges({
    this.totalkm,
    this.id,
    this.challenge,
    this.streakNo,
  });

  factory JoingetChallenges.fromJson(Map<String, dynamic> json) =>
      JoingetChallenges(
          totalkm: json["totalkm"],
          id: json["_id"],
          challenge: GetChallenge.fromJson(json["challenge"]),
          streakNo: json["streakNo"]);
}

class GetChallenge {
  GetChallenge({
    this.id,
    this.mode,
    this.type,
    this.totalCompetitors,
    this.streakDays,
    this.totalKm,
    this.createdBy,
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

  factory GetChallenge.fromJson(Map<String, dynamic> json) => GetChallenge(
        id: json["_id"],
        mode: json["mode"],
        type: json["type"],
        totalCompetitors: json["totalCompetitors"],
        streakDays: json["streakDays"],
        totalKm: json["totalKm"],
        createdBy: json["createdBy"],
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
    this.imageurl,
  });

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

// To parse this JSON data, do
//
//     final recentWinners = recentWinnersFromJson(jsonString);

// import 'dart:convert';

// RecentWinners recentWinnersFromJson(String str) => RecentWinners.fromJson(json.decode(str));

// String recentWinnersToJson(RecentWinners data) => json.encode(data.toJson());

class RecentWinners {
  RecentWinners({
    this.leaders,
  });

  List<Leader> leaders;

  factory RecentWinners.fromJson(Map<String, dynamic> json) => RecentWinners(
        leaders:
            List<Leader>.from(json["leaders"].map((x) => Leader.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "leaders": List<dynamic>.from(leaders.map((x) => x.toJson())),
      };
}

class Leader {
  Leader({
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
    this.prize,
  });

  String id;
  LeaderCompetitor competitor;
  Challenge challenge;
  DateTime startAt;
  DateTime endAt;
  String totalkm;
  int streakNo;
  String status;
  DateTime createdAt;
  DateTime updatedAt;
  int v;
  int prize;

  factory Leader.fromJson(Map<String, dynamic> json) => Leader(
        id: json["_id"],
        competitor: LeaderCompetitor.fromJson(json["competitor"]),
        challenge: Challenge.fromJson(json["challenge"]),
        startAt: DateTime.parse(json["startAt"]),
        endAt: DateTime.parse(json["endAt"]),
        totalkm: json["totalkm"],
        streakNo: json["streakNo"],
        status: json["status"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        prize: json["prize"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "competitor": competitor.toJson(),
        "challenge": challenge.toJson(),
        "startAt": startAt.toIso8601String(),
        "endAt": endAt.toIso8601String(),
        "totalkm": totalkm,
        "streakNo": streakNo,
        "status": status,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
        "prize": prize,
      };
}

class ChallengeRecent {
  ChallengeRecent({
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

  factory ChallengeRecent.fromJson(Map<String, dynamic> json) =>
      ChallengeRecent(
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

class CompetitorElementRecent {
  CompetitorElementRecent({
    this.userId,
    this.joinedAt,
    this.id,
  });

  String userId;
  DateTime joinedAt;
  String id;

  factory CompetitorElementRecent.fromJson(Map<String, dynamic> json) =>
      CompetitorElementRecent(
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

class LeaderCompetitor {
  LeaderCompetitor({
    this.id,
    this.fullName,
    this.imageurl,
  });

  String id;
  String fullName;
  var imageurl;

  factory LeaderCompetitor.fromJson(Map<String, dynamic> json) =>
      LeaderCompetitor(
        id: json["_id"],
        fullName: json["fullName"],
        imageurl: json["imageUrl"],
      );

  Map<String, dynamic> toJson() =>
      {"_id": id, "fullName": fullName, "imageUrl": imageurl};
}

class WalletChallenges extends StatefulWidget {
  final selectindex;
  const WalletChallenges({Key key, this.selectindex}) : super(key: key);

  @override
  _WalletChallengesState createState() => _WalletChallengesState();
}

enum AppState {
  DATA_NOT_FETCHED,
  FETCHING_DATA,
  DATA_READY,
  NO_DATA,
  AUTH_NOT_GRANTED
}
GoogleSignIn _googleSignIn = GoogleSignIn(
  // Optional clientId
  // clientId:
  //     '377180466305-inemb4g0usu09f9l9j5p2nrccgcje6bu.apps.googleusercontent.com',
  scopes: <String>[
    'email',
    'https://www.googleapis.com/auth/fitness.activity.read',
    'https://www.googleapis.com/auth/fitness.activity.write',
    'https://www.googleapis.com/auth/fitness.location.read',
    'https://www.googleapis.com/auth/fitness.location.write',
  ],
);

class _WalletChallengesState extends State<WalletChallenges> {
  List<HealthDataPoint> _healthDataList = [];
  // ignore: unused_field
  AppState _state = AppState.DATA_NOT_FETCHED;
  DateTime now = DateTime.now();

  var steps = 0.0;
  Future fetchData() async {
    // get everything from midnight until now

    DateTime startDate = DateTime(now.year, now.month, now.day, 0, 0, 0);
    DateTime endDate = DateTime.now();

    HealthFactory health = HealthFactory();

    // define the types to get
    List<HealthDataType> types = [
      HealthDataType.DISTANCE_DELTA,
    ];

    // you MUST request access to the data types before reading them
    bool accessWasGranted = await health.requestAuthorization(types);
    // if (accessWasGranted) {
    //   await UserRepository().updateUser(1);
    // }
    if (accessWasGranted) {
      try {
        // fetch new data
        List<HealthDataPoint> healthData =
            await health.getHealthDataFromTypes(startDate, endDate, types);

        // save all the new data points
        _healthDataList.addAll(healthData);
      } catch (e) {
        print("Caught exception in getHealthDataFromTypes: $e");
      }

      // filter out duplicates
      _healthDataList = HealthFactory.removeDuplicates(_healthDataList);

      // print the results

      _healthDataList.forEach((x) {
        // print("Data point: $x");
        steps += x.value / 1000;
      });

      print("Steps: $steps");

      // update the UI to display the results
      setState(() {
        _state =
            _healthDataList.isEmpty ? AppState.NO_DATA : AppState.DATA_READY;
      });
    } else {
      print("Authorization not granted");
      setState(() => _state = AppState.DATA_NOT_FETCHED);
    }
  }

  num steps1 = 0;
  num distance = 0;
  Future fetchData1() async {
    // get everything from midnight until now

    DateTime startDate = DateTime(now.year, now.month, now.day, 0, 0, 0);
    DateTime endDate = DateTime.now();

    HealthFactory health = HealthFactory();

    // define the types to get
    List<HealthDataType> types = [
      HealthDataType.DISTANCE_WALKING_RUNNING,
    ];

    setState(() => _state = AppState.FETCHING_DATA);

    // you MUST request access to the data types before reading them
    bool accessWasGranted = await health.requestAuthorization(types);

    num steps1 = 0;

    if (accessWasGranted) {
      try {
        // fetch new data
        List<HealthDataPoint> healthData =
            await health.getHealthDataFromTypes(startDate, endDate, types);

        // save all the new data points
        _healthDataList.addAll(healthData);
      } catch (e) {
        print("Caught exception in getHealthDataFromTypes: $e");
      }

      // filter out duplicates
      _healthDataList = HealthFactory.removeDuplicates(_healthDataList);

      // print the results
      _healthDataList.forEach((x) {
        steps1 += x.value.round();
      });
      distance = steps1 / 1000;
      getjoinChallenges();
      getmyChallenges();
      print("Steps: $steps1 $distance");

      // update the UI to display the results
      setState(() {
        _state =
            _healthDataList.isEmpty ? AppState.NO_DATA : AppState.DATA_READY;
      });
    } else {
      print("Authorization not granted");
      setState(() => _state = AppState.DATA_NOT_FETCHED);
    }
  }

  List<Challenges> challengesOne = [];
  List<MyChallenges> mychallenge = [];
  List<JoingetChallenges> joingetchallenge = [];
  List<LeaderboardAll> leaderboardAll = [];
  List<Leader> recentWinners = [];

  var userLanguage, user, lang = [];
  bool loading = true;
  // bool leaderViewMore = false;
  // bool recentWinnerViewMore = false;
  // bool viewProfile = false;
  List<int> data = [];
  List<int> km = [];

  List<int> day = [];
  List<int> wage = [];
  bool googlefitint = false;
  var refreshKey = GlobalKey<RefreshIndicatorState>();
  Future<Null> refreshList() async {
    refreshKey.currentState?.show(atTop: false);
    await Future.delayed(Duration(seconds: 2));
    getUserLanguage();
    getChallenges();
    getapp();
    // gettoken();
    return null;
  }

  int value = 0;
  int wagevalue = 0;
  int kmvalue = 0;

  int dayvalue = 0;
  var startdate;
  var exprydate;
  @override
  void initState() {
    super.initState();
    getUserLanguage();
    getChallenges();
    getapp();
    getAllLeaderboard();
    recentWinners1();
  }

  var gweibalance = "0";

  // ignore: todo
  //TODO :languagestart
  Future<void> getUserLanguage() async {
    lang = await UserDataSource().getLanguage();
    user = await UserDataSource().getUser();

    var res = await UserRepository().getUser(user[0]["walletaddress"]);

    gweibalance = res["user"]["gwei"];
    if (user[0]["googlefitenable"] == 1) {
      fetchData();

      gettoken();
    } else if (user[0]["healthfitenable"] == 1) {
      fetchData1();
    } else {
      getmyChallenges();
      getjoinChallenges();
    }

    if (lang.length != null && lang.length != 0) {
      userLanguage = lang[0];
    }
  }

  // ignore: todo
  //TODO: LanguageEnd

  Future<void> getChallenges() async {
    setState(() {
      loading = false;
    });
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

  var token;
  Future<void> gettoken() async {
    try {
      await UserRepository().updateUser(1);
      final result = await _googleSignIn.signIn();
      final ggAuth = await result.authentication;
      token = ggAuth.accessToken;
      getmyChallenges();
      getjoinChallenges();
    } catch (error) {
      print(error);
    }
  }

  Future<void> getapp() async {
    // ignore: unused_local_variable
    bool isInstalled =
        await DeviceApps.isAppInstalled('com.google.android.apps.fitness');
  }

  Future<void> getmyChallenges() async {
    setState(() {
      loading = false;
    });
    var res = await UserRepository().getmyChallenges(user[0]["uid"]);

    setState(() {
      loading = false;
    });
    if (res == false) {
      // Scaffold
      //   .of(context)
      //   .showSnackBar(SnackBar(content: Text('No Internet Connection'),backgroundColor: Colors.red,));
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

  Future<void> getjoinChallenges() async {
    setState(() {
      loading = false;
    });
    var res = await UserRepository()
        .joingetchallenge(user[0]["uid"], token, distance);

    setState(() {
      loading = false;
    });
    if (res == false) {
      // Scaffold
      //   .of(context)
      //   .showSnackBar(SnackBar(content: Text('No Internet Connection'),backgroundColor: Colors.red,));
    } else {
      if (res["success"] == true) {
        joingetchallenge = [];
        for (var i = 0; i < res["challenges"]["docs"].length; i++) {
          joingetchallenge
              .add(JoingetChallenges.fromJson(res["challenges"]["docs"][i]));
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

  Future<void> createChallenges() async {
    var todayDate = new DateTime.now();
    var todayDate1 = new DateTime.now();
    var days =
        new DateTime(todayDate1.year, todayDate1.month, todayDate1.day + 7);
    var expiryDate = (DateFormat.yMMMd().format(days)).toString();
    var today1 = (DateFormat.yMMMd().format(todayDate)).toString();

    setState(() {
      loading = false;
    });
    var createchallange = await UserRepository().createchallenge({
      "mode": selecttype,
      "type": challenge,
      "totalCompetitors": competitorsgets,
      "streakDays": daychallenge,
      "totalKm": kmchallenge,
      "createdBy": user[0]["uid"],
      "startAt": today1,
      "endAt": expiryDate,
      "wage": wagar,
    });
    if (createchallange == false) {
      Scaffold.of(context)
          // ignore: deprecated_member_use
          .showSnackBar(SnackBar(
        content: Text('No Internet Connection'),
        backgroundColor: Colors.red,
      ));
    } else {
      if (createchallange["success"] == true) {
        result = await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                ChallengeFinal(id: createchallange["challenge"]["_id"]),
          ),
        );
        if (result == false) {
          getChallenges();
          getUserLanguage();
          getmyChallenges();
          getjoinChallenges();

          getAllLeaderboard();
          recentWinners1();
        }
      } else {
        Scaffold.of(context)
            // ignore: deprecated_member_use
            .showSnackBar(SnackBar(
          content: Text(createchallange["error"]),
          backgroundColor: Colors.red,
        ));
      }
    }
  }

  // ignore: non_constant_identifier_names

  Future<void> getAllLeaderboard() async {
    setState(() {
      loading = false;
    });
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

  Future<void> recentWinners1() async {
    setState(() {
      loading = false;
    });
    var res = await UserRepository().recentWinners();
    // print("RECENT WINNERS $res");
    if (res == false) {
      // Scaffold
      //   .of(context)
      //   .showSnackBar(SnackBar(content: Text('No Internet Connection'),backgroundColor: Colors.red,));
    } else {
      if (res["success"] == true) {
        setState(() {
          loading = false;
        });
        recentWinners = [];
        for (var i = 0; i < res["leaders"].length; i++) {
          recentWinners.add(Leader.fromJson(res["leaders"][i]));
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

  List<Color> joinChallengeColorList = [
    blue1,
    spendingPink,
    containerOrange,
  ];
  List<Color> myActivityColorList = [
    containerGreen,
    spendingPink,
    containerOrange,
  ];
  List<Color> leaderboardColorList = [
    orange,
    blue1,
    spendingPink,
    text1,
  ];
  var result = true;
  var trophy = [
    Image.asset("assets/images/trophy3.png"),
    Image.asset("assets/images/trophy2.png"),
    Image.asset("assets/images/trophy1.png"),
  ];

  var url = [
    "https://www.pngitem.com/pimgs/m/78-786293_1240-x-1240-0-avatar-profile-icon-png.png",
    "https://cdn.imgbin.com/1/8/12/imgbin-computer-icons-user-profile-avatar-woman-business-woman-2x9qVDw4EgxX299EhCLm9fN89.jpg",
    "https://www.clipartmax.com/png/middle/171-1717870_stockvader-predicted-cron-for-may-user-profile-icon-png.png",
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
              color: button,
              child: IconButton(
                onPressed: () {
                  widget.selectindex != null && widget.selectindex < 4
                      ?
                      // Navigator.pop(context);
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (_) => Tabscreen(
                              index: widget.selectindex,
                            ),
                          ),
                        )
                      : Navigator.pop(context, false);
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
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Text(
                        gweibalance.toString(),
                        style: GoogleFonts.poppins(
                          fontSize: 17,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
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
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      body: RefreshIndicator(
        key: refreshKey,
        onRefresh: refreshList,
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 40,
                  ),

                  //******* RECENT WINNERS ListView   *******/

                  Container(
                    height: MediaQuery.of(context).size.height * 0.27,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.1),
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
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () async {
                                result = await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        ViewmoreRecentWinners(focus: true),
                                  ),
                                );
                                if (result == false) {
                                  getChallenges();
                                  getUserLanguage();
                                  getmyChallenges();
                                  getjoinChallenges();

                                  getAllLeaderboard();
                                  recentWinners1();
                                }
                              },
                              child:
                                  // recentWinnerViewMore == true
                                  //     ? InkWell(
                                  //         onTap: () {
                                  //           setState(() {
                                  //             recentWinnerViewMore = false;
                                  //             //print(recentWinnerViewMore);
                                  //           });
                                  //         },
                                  //         child: Padding(
                                  //           padding:
                                  //               const EdgeInsets.only(right: 25),
                                  //           child: Container(
                                  //             height: MediaQuery.of(context)
                                  //                     .size
                                  //                     .height *
                                  //                 0.05,
                                  //             width: MediaQuery.of(context)
                                  //                     .size
                                  //                     .width *
                                  //                 0.25,
                                  //             decoration: BoxDecoration(
                                  //                 color: blue2,
                                  //                 borderRadius:
                                  //                     BorderRadius.circular(10)),
                                  //             child: Center(
                                  //               child: Text(
                                  //                 (lang.length != null &&
                                  //                         lang.length != 0 &&
                                  //                         userLanguage[
                                  //                                 'viewless'] !=
                                  //                             null)
                                  //                     ? "${userLanguage['viewless']}"
                                  //                     : "VIEW LESS",
                                  //                 style: GoogleFonts.poppins(
                                  //                     fontSize: 8,
                                  //                     color: white,
                                  //                     fontWeight: FontWeight.w600),
                                  //               ),
                                  //             ),
                                  //           ),
                                  //         ),
                                  //       )
                                  //     :
                                  Padding(
                                padding: const EdgeInsets.only(right: 25),
                                child: Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.05,
                                  width:
                                      MediaQuery.of(context).size.width * 0.25,
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
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        Container(
                          decoration: BoxDecoration(
                            gradient: RadialGradient(
                              colors: [
                                gPink.withOpacity(0.3),
                                white.withOpacity(0.0)
                              ],
                              center: Alignment(-1.0, 0.0),
                              focal: Alignment(-1.0, -0.1),
                            ),
                          ),
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.2,
                            width: MediaQuery.of(context).size.width,
                            margin: EdgeInsets.only(left: 0, right: 0),
                            padding: EdgeInsets.only(
                                left: 4, top: 10, bottom: 0, right: 0),
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: recentWinners.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () async {
                                    result = await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => Challengesdetail(
                                          focus: true,
                                          challange:
                                              recentWinners[index].challenge.id,
                                        ),
                                      ),
                                    );
                                    if (result == false) {
                                      getChallenges();
                                      getUserLanguage();
                                      getmyChallenges();
                                      getjoinChallenges();

                                      getAllLeaderboard();
                                      recentWinners1();
                                    }
                                  },
                                  child: Stack(
                                    children: [
                                      Container(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.17,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.35,
                                        //color: Colors.pink,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Container(
                                              padding: EdgeInsets.only(
                                                  left: 10, right: 10),
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.15,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.30,
                                              decoration: BoxDecoration(
                                                color: white.withOpacity(0.2),
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                              ),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 15),
                                                    child: Container(
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.04,
                                                      width:
                                                          MediaQuery.of(context)
                                                              .size
                                                              .width,
                                                      child: Center(
                                                        child: Text(
                                                          recentWinners[index]
                                                              .competitor
                                                              .fullName
                                                              .toString()
                                                              .toUpperCase(),
                                                          style: GoogleFonts
                                                              .poppins(
                                                            color: Colors.grey,
                                                            fontSize: 12,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.06,
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.25,
                                                    decoration: BoxDecoration(
                                                        color: Colors.white
                                                            .withOpacity(0.25),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15)),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Container(
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              0.22,
                                                          child: FittedBox(
                                                            fit: BoxFit
                                                                .scaleDown,
                                                            child: Text(
                                                              recentWinners[
                                                                          index]
                                                                      .prize
                                                                      .toString() +
                                                                  " Gwei",
                                                              style: GoogleFonts
                                                                  .poppins(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                            ),
                                                          ),
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
                                        top:
                                            MediaQuery.of(context).size.height *
                                                0.001,
                                        left:
                                            MediaQuery.of(context).size.width *
                                                0.13,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          child: Container(
                                            height: 30,
                                            width: 30,
                                            color: button,
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(100),
                                              child: recentWinners[index]
                                                          .competitor
                                                          .imageurl !=
                                                      ""
                                                  ? Image.network(
                                                      recentWinners[index]
                                                          .competitor
                                                          .imageurl,
                                                      fit: BoxFit.cover,
                                                    )
                                                  : Center(
                                                      child: Text(
                                                        recentWinners[index]
                                                            .competitor
                                                            .fullName
                                                            .substring(0, 1),
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
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  //******* JOIN CHALLENGES  ListView   *******/

                  Container(
                    height: MediaQuery.of(context).size.height * 0.3,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      gradient: RadialGradient(
                        colors: [
                          gBlue.withOpacity(0.1),
                          white.withOpacity(0.0),
                        ],
                        // Add one stop for each color
                        // Values should increase from 0.0 to 1.0
                        stops: [0.6, 1],
                        center: Alignment(-.2, 0),
                        focal: Alignment(0.1, -0.1),
                        //focalRadius: 0.3,
                      ),
                    ),
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
                                        userLanguage['joinchallenges'] != null)
                                    ? "${userLanguage['joinchallenges']}"
                                    : "JOIN CHALLENGE",
                                style: GoogleFonts.poppins(
                                    fontSize: 16,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 25),
                              child: GestureDetector(
                                onTap: () async {
                                  var result = await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          ViewmoreJoinChallenge(focus: true),
                                    ),
                                  );

                                  if (result == false) {
                                    getChallenges();
                                    getUserLanguage();
                                    getmyChallenges();
                                    getjoinChallenges();

                                    getAllLeaderboard();
                                    recentWinners1();
                                  }
                                },
                                child: Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.05,
                                  width:
                                      MediaQuery.of(context).size.width * 0.25,
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
                        challengesOne.length == 0
                            ? Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.2,
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
                            : loading == true
                                ? Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.23,
                                    width: MediaQuery.of(context).size.width,
                                    color: backgroundcolor,
                                    child: Center(
                                      child: SpinKitSpinningLines(
                                        color: white,
                                        size: 60,
                                      ),
                                    ),
                                  )
                                : Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.23,
                                    width: MediaQuery.of(context).size.width,
                                    margin: EdgeInsets.only(left: 5, right: 0),
                                    padding: EdgeInsets.only(
                                        left: 4, top: 10, bottom: 0, right: 0),
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: challengesOne.length,
                                      itemBuilder: (context, index) {
                                        return InkWell(
                                          onTap: () async {
                                            result = await Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    JoinChallengesdetail(
                                                  focus: true,
                                                  challange:
                                                      challengesOne[index],
                                                ),
                                              ),
                                            );

                                            if (result == false) {
                                              getChallenges();
                                              getUserLanguage();
                                              getmyChallenges();
                                              getjoinChallenges();

                                              getAllLeaderboard();
                                              recentWinners1();
                                            }
                                          },
                                          child: Stack(
                                            children: [
                                              Container(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.2,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.38,
                                                //color: Colors.pink,
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    Container(
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.17,
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.35,
                                                      // height: 126,
                                                      // width: 130,
                                                      decoration: BoxDecoration(
                                                        color: joinChallengeColorList[
                                                            index %
                                                                joinChallengeColorList
                                                                    .length],
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20),
                                                      ),
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceAround,
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    top: 20),
                                                            child: Center(
                                                              child: Column(
                                                                children: [
                                                                  Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                      Text(
                                                                        challengesOne[index].totalKm +
                                                                            "KM ",
                                                                        style: GoogleFonts
                                                                            .poppins(
                                                                          color:
                                                                              Colors.white,
                                                                          fontSize:
                                                                              14,
                                                                          fontWeight:
                                                                              FontWeight.w600,
                                                                        ),
                                                                      ),
                                                                      Text(
                                                                        challengesOne[index].mode ==
                                                                                "Walking"
                                                                            ? "WALK"
                                                                            : "RUN",
                                                                        style: GoogleFonts
                                                                            .poppins(
                                                                          color:
                                                                              Colors.white,
                                                                          fontSize:
                                                                              14,
                                                                          fontWeight:
                                                                              FontWeight.w600,
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  Text(
                                                                    challengesOne[
                                                                            index]
                                                                        .type
                                                                        .toUpperCase(),
                                                                    style: GoogleFonts
                                                                        .poppins(
                                                                      color: Colors
                                                                          .white,
                                                                      fontSize:
                                                                          14,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                          Container(
                                                            height: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .height *
                                                                0.06,
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                0.28,
                                                            // height: 43,
                                                            // width: 93,
                                                            decoration: BoxDecoration(
                                                                color: Color(
                                                                    0xffFF8C00),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            20)),
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Container(
                                                                  width: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width *
                                                                      0.28,
                                                                  child:
                                                                      FittedBox(
                                                                    fit: BoxFit
                                                                        .scaleDown,
                                                                    child: Text(
                                                                      "+" +
                                                                          challengesOne[index]
                                                                              .prize
                                                                              .toString() +
                                                                          " Gwei",
                                                                      style: GoogleFonts.poppins(
                                                                          color: Colors
                                                                              .white,
                                                                          fontSize:
                                                                              16,
                                                                          fontWeight:
                                                                              FontWeight.w600),
                                                                    ),
                                                                  ),
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
                                                top: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.01,
                                                left: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.13,
                                                child: Container(
                                                  height: 43,
                                                  width: 43,
                                                  //color: button,
                                                  child: trophy[
                                                      index % trophy.length],
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
                  //******* MY CHALLENGES ListView   *******/

                  Container(
                    height: MediaQuery.of(context).size.height * 0.3,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        gradient: RadialGradient(
                          colors: [
                            gPink.withOpacity(0.1),
                            //gBlue.withOpacity(0.2),
                            white.withOpacity(0.0),
                          ],

                          stops: [0.6, 1],
                          center: Alignment(0.4, 0),
                          focal: Alignment(0.6, -0.1),
                          //focalRadius: 0.3,
                        ),
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
                                        userLanguage['mychallenges'] != null)
                                    ? "${userLanguage['mychallenges']}"
                                    : "MY CHALLENGES",
                                style: GoogleFonts.poppins(
                                    fontSize: 16,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 25),
                              child: GestureDetector(
                                onTap: () async {
                                  var result = await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ViewmoreMyChallenge(
                                                  focus: true)));
                                  if (result == false) {
                                    getChallenges();
                                    getUserLanguage();

                                    getmyChallenges();
                                    getjoinChallenges();

                                    getAllLeaderboard();
                                    recentWinners1();
                                  }
                                },
                                child: Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.05,
                                  width:
                                      MediaQuery.of(context).size.width * 0.25,
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
                            )
                          ],
                        ),

                        //**  add err condition for my challenge**/

                        mychallenge.length == 0
                            ? Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.2,
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
                            : loading == true
                                ? Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.23,
                                    width: MediaQuery.of(context).size.width,
                                    color: backgroundcolor,
                                    child: Center(
                                      child: SpinKitSpinningLines(
                                        color: white,
                                        size: 60,
                                      ),
                                    ),
                                  )
                                : Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.23,
                                    width: MediaQuery.of(context).size.width,
                                    margin: EdgeInsets.only(left: 5, right: 0),
                                    //color: Colors.indigo,
                                    padding: EdgeInsets.only(
                                        left: 4, top: 10, bottom: 0, right: 0),
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: mychallenge.length,
                                      itemBuilder: (context, index) {
                                        return GestureDetector(
                                          onTap: () async {
                                            print(
                                              mychallenge[index].id,
                                            );
                                            result = await Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    Challengesdetail(
                                                  focus: true,
                                                  challange:
                                                      mychallenge[index].id,
                                                ),
                                              ),
                                            );
                                            if (result == false) {
                                              getChallenges();
                                              getUserLanguage();
                                              getmyChallenges();
                                              getjoinChallenges();

                                              getAllLeaderboard();
                                              recentWinners1();
                                            }
                                          },
                                          child: Stack(
                                            children: [
                                              Container(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.2,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.38,
                                                //color: Colors.pink,
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    Container(
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.17,
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.35,
                                                      // height: 126,
                                                      // width: 130,
                                                      decoration: BoxDecoration(
                                                          color: joinChallengeColorList[
                                                              index %
                                                                  joinChallengeColorList
                                                                      .length],
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      20)),
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceAround,
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    top: 20),
                                                            child: Center(
                                                              child: Column(
                                                                children: [
                                                                  Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                      Text(
                                                                        challengesOne[index].totalKm +
                                                                            "KM ",
                                                                        style: GoogleFonts
                                                                            .poppins(
                                                                          color:
                                                                              Colors.white,
                                                                          fontSize:
                                                                              14,
                                                                          fontWeight:
                                                                              FontWeight.w600,
                                                                        ),
                                                                      ),
                                                                      Text(
                                                                        challengesOne[index].mode ==
                                                                                "Walking"
                                                                            ? "WALK"
                                                                            : "RUN",
                                                                        style: GoogleFonts
                                                                            .poppins(
                                                                          color:
                                                                              Colors.white,
                                                                          fontSize:
                                                                              14,
                                                                          fontWeight:
                                                                              FontWeight.w600,
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  Text(
                                                                    challengesOne[
                                                                            index]
                                                                        .type
                                                                        .toUpperCase(),
                                                                    style: GoogleFonts
                                                                        .poppins(
                                                                      color: Colors
                                                                          .white,
                                                                      fontSize:
                                                                          14,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                          Container(
                                                            height: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .height *
                                                                0.06,
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                0.28,
                                                            // height: 43,
                                                            // width: 93,
                                                            decoration: BoxDecoration(
                                                                color: Color(
                                                                    0xffFF8C00),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            20)),
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Container(
                                                                  width: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width *
                                                                      0.28,
                                                                  child:
                                                                      FittedBox(
                                                                    fit: BoxFit
                                                                        .scaleDown,
                                                                    child: Text(
                                                                      challengesOne[index]
                                                                              .prize
                                                                              .toString() +
                                                                          " Gwei",
                                                                      style: GoogleFonts.poppins(
                                                                          color: Colors
                                                                              .white,
                                                                          fontSize:
                                                                              16,
                                                                          fontWeight:
                                                                              FontWeight.w600),
                                                                    ),
                                                                  ),
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
                                                top: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.01,
                                                left: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.13,
                                                child: Container(
                                                  height: 43,
                                                  width: 43,
                                                  //color: button,
                                                  child: trophy[
                                                      index % trophy.length],
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

                  //******* MY ACTIVITY ListView   *******/

                  Container(
                    // height: MediaQuery.of(context).size.height * 0.28,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        //color: white.withOpacity(0.3),
                        gradient: RadialGradient(
                          colors: [
                            //gPink.withOpacity(0.1),
                            gBlue.withOpacity(0.15),
                            white.withOpacity(0.0),
                          ],
                          // Add one stop for each color
                          // Values should increase from 0.0 to 1.0
                          stops: [0.6, 1],
                          center: Alignment(-.3, 0),
                          focal: Alignment(-.3, -0.1),
                          //focalRadius: 0.3,
                        ),
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
                            GestureDetector(
                              onTap: () async {
                                //print("Gopinath");
                                result = await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => MyActivity()));
                                if (result == false) {
                                  getChallenges();
                                  getUserLanguage();

                                  getmyChallenges();
                                  getjoinChallenges();

                                  getAllLeaderboard();
                                  recentWinners1();
                                }
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(right: 25),
                                child: Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.05,
                                  width:
                                      MediaQuery.of(context).size.width * 0.25,
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
                        joingetchallenge.length == 0
                            ? Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.2,
                                width: MediaQuery.of(context).size.width,
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text("NO JOINED CHALLENGES",
                                        style: GoogleFonts.poppins(
                                          color: Colors.white,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                        )),
                                  ),
                                ),
                              )
                            : loading == true
                                ? Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.23,
                                    width: MediaQuery.of(context).size.width,
                                    color: backgroundcolor,
                                    child: Center(
                                      child: SpinKitSpinningLines(
                                        color: white,
                                        size: 60,
                                      ),
                                    ),
                                  )
                                : Container(
                                    // height: MediaQuery.of(context).size.height *
                                    //     0.26,
                                    // width: MediaQuery.of(context).size.width,
                                    margin: EdgeInsets.only(left: 5, right: 0),
                                    //color: Colors.indigo,
                                    padding: EdgeInsets.only(
                                        left: 4, top: 10, bottom: 0, right: 0),
                                    child: ListView.builder(
                                      physics: NeverScrollableScrollPhysics(),
                                      scrollDirection: Axis.vertical,
                                      itemCount: joingetchallenge.length <= 3
                                          ? joingetchallenge.length
                                          : 3,
                                      shrinkWrap: true,
                                      itemBuilder: (context, index) {
                                        return GestureDetector(
                                          onTap: () async {
                                            result = await Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    Challengesdetail(
                                                  focus: true,
                                                  challange:
                                                      joingetchallenge[index]
                                                          .challenge
                                                          .id,
                                                ),
                                              ),
                                            );
                                            if (result == false) {
                                              getChallenges();
                                              getUserLanguage();
                                              getmyChallenges();
                                              getjoinChallenges();

                                              getAllLeaderboard();
                                              recentWinners1();
                                            }
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
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.85,
                                                        decoration: BoxDecoration(
                                                            color: myActivityColorList[
                                                                index %
                                                                    myActivityColorList
                                                                        .length],
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20)),
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
                                                                  0.6,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: Colors
                                                                    .white
                                                                    .withOpacity(
                                                                        0.2),
                                                                borderRadius: BorderRadius.only(
                                                                    bottomLeft:
                                                                        Radius.circular(
                                                                            18),
                                                                    bottomRight:
                                                                        Radius.circular(
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
                                                                      joingetchallenge[index]
                                                                              .challenge
                                                                              .totalKm +
                                                                          "KM ",
                                                                      style: GoogleFonts
                                                                          .poppins(
                                                                        color: Colors
                                                                            .black,
                                                                        fontSize:
                                                                            14,
                                                                        fontWeight:
                                                                            FontWeight.w600,
                                                                      ),
                                                                    ),
                                                                    Text(
                                                                      joingetchallenge[index].challenge.mode ==
                                                                              "Walking"
                                                                          ? "WALK "
                                                                          : "RUN ",
                                                                      style: GoogleFonts
                                                                          .poppins(
                                                                        color: Colors
                                                                            .black,
                                                                        fontSize:
                                                                            14,
                                                                        fontWeight:
                                                                            FontWeight.w600,
                                                                      ),
                                                                    ),
                                                                    Text(
                                                                      joingetchallenge[
                                                                              index]
                                                                          .challenge
                                                                          .type
                                                                          .toUpperCase(),
                                                                      style: GoogleFonts
                                                                          .poppins(
                                                                        color: Colors
                                                                            .black,
                                                                        fontSize:
                                                                            14,
                                                                        fontWeight:
                                                                            FontWeight.w600,
                                                                      ),
                                                                    ),
                                                                    Container(
                                                                      child:
                                                                          FittedBox(
                                                                        fit: BoxFit
                                                                            .scaleDown,
                                                                        child:
                                                                            Text(
                                                                          " (" +
                                                                              double.parse(joingetchallenge[index].totalkm).toStringAsFixed(2) +
                                                                              "KM)",
                                                                          style:
                                                                              GoogleFonts.poppins(
                                                                            color:
                                                                                Colors.black,
                                                                            fontSize:
                                                                                14,
                                                                            fontWeight:
                                                                                FontWeight.w600,
                                                                          ),
                                                                        ),
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
                                                                      right: 5),
                                                              child: Container(
                                                                height: 33,
                                                                width: 85,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: Colors
                                                                      .white
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
                                                                    Text("DAY",
                                                                        style: GoogleFonts.poppins(
                                                                            color: Colors
                                                                                .white,
                                                                            fontSize:
                                                                                12,
                                                                            fontWeight:
                                                                                FontWeight.w600)),
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                              .only(
                                                                          left:
                                                                              5),
                                                                      child: Text(
                                                                          joingetchallenge[index]
                                                                              .streakNo
                                                                              .toString(),
                                                                          style: GoogleFonts.poppins(
                                                                              color: Colors.white,
                                                                              fontSize: 12,
                                                                              fontWeight: FontWeight.w600)),
                                                                    ),
                                                                    Text(
                                                                        " / " +
                                                                            joingetchallenge[index]
                                                                                .challenge
                                                                                .streakDays
                                                                                .toString(),
                                                                        style: GoogleFonts.poppins(
                                                                            color: Colors
                                                                                .white,
                                                                            fontSize:
                                                                                12,
                                                                            fontWeight:
                                                                                FontWeight.w400)),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(height: 15)
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

                  //******* Leaderboard ListView   *******/
                  Container(
                    // height: MediaQuery.of(context).size.height * 0.35,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        //color: white.withOpacity(0.3),
                        gradient: RadialGradient(
                          colors: [
                            //gPink.withOpacity(0.1),
                            gBlue.withOpacity(0.1),
                            white.withOpacity(0.0),
                          ],
                          // Add one stop for each color
                          // Values should increase from 0.0 to 1.0
                          stops: [0.6, 1],
                          center: Alignment(0.4, 0),
                          focal: Alignment(0.6, -0.1),
                          //focalRadius: 0.3,
                        ),
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
                            InkWell(
                              onTap: () async {
                                result = await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ViewmoreLeaderboard()));
                                if (result == false) {
                                  getChallenges();
                                  getUserLanguage();

                                  getmyChallenges();
                                  getjoinChallenges();

                                  getAllLeaderboard();
                                  recentWinners1();
                                }
                                // setState(() {
                                //   leaderViewMore = true;
                                //   //print(leaderViewMore);
                                // });
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(right: 25),
                                child: Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.05,
                                  width:
                                      MediaQuery.of(context).size.width * 0.25,
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
                            )
                          ],
                        ),
                        //**** leaderboard view less container *****/
                        leaderboardAll.length == 0
                            ? Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.2,
                                width: MediaQuery.of(context).size.width,
                                child: Center(
                                  child: Text(
                                    "NO AVAILABLE DATA",
                                    style: GoogleFonts.montserrat(
                                        decoration: TextDecoration.none,
                                        color: white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600),
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
                                  itemCount: leaderboardAll.length <= 3
                                      ? leaderboardAll.length
                                      : 3,
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                      onTap: () async {
                                        result = await Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                Challengesdetail(
                                              focus: true,
                                              challange: leaderboardAll[index]
                                                  .challenge
                                                  .id,
                                            ),
                                          ),
                                        );
                                        if (result == false) {
                                          getChallenges();
                                          getUserLanguage();
                                          getmyChallenges();
                                          getjoinChallenges();

                                          getAllLeaderboard();
                                          recentWinners1();
                                        }
                                        // leaderboardProfile(context);
                                      },
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10),
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
                                                      color: leaderboardColorList[
                                                          index %
                                                              leaderboardColorList
                                                                  .length],
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              16)),
                                                  child: Center(
                                                    child: Text(
                                                      "${index + 1}".toString(),
                                                      style:
                                                          GoogleFonts.poppins(
                                                        color: Colors.white,
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10),
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
                                                      color: white
                                                          .withOpacity(0.1),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20)),
                                                  child: Row(
                                                    children: [
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(30),
                                                        child: Container(
                                                          height: 35,
                                                          width: 35,
                                                          color: button,
                                                          child: ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        100),
                                                            child: leaderboardAll[
                                                                            index]
                                                                        .competitor
                                                                        .imageurl !=
                                                                    ""
                                                                ? Image.network(
                                                                    leaderboardAll[
                                                                            index]
                                                                        .competitor
                                                                        .imageurl,
                                                                    fit: BoxFit
                                                                        .cover,
                                                                  )
                                                                : Center(
                                                                    child: Text(
                                                                      leaderboardAll[
                                                                              index]
                                                                          .competitor
                                                                          .fullName
                                                                          .substring(
                                                                              0,
                                                                              1),
                                                                      style: TextStyle(
                                                                          color:
                                                                              white,
                                                                          fontSize:
                                                                              17,
                                                                          fontWeight:
                                                                              FontWeight.bold),
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
                                                            CrossAxisAlignment
                                                                .start,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Container(
                                                            alignment: Alignment
                                                                .centerLeft,
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                0.4,
                                                            child: FittedBox(
                                                              fit: BoxFit
                                                                  .scaleDown,
                                                              child: Text(
                                                                leaderboardAll[
                                                                        index]
                                                                    .competitor
                                                                    .fullName
                                                                    .toString()
                                                                    .toUpperCase(),
                                                                style:
                                                                    GoogleFonts
                                                                        .poppins(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 15,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          RatingBar.builder(
                                                            initialRating: 3,
                                                            minRating: 1,
                                                            direction:
                                                                Axis.horizontal,
                                                            allowHalfRating:
                                                                true,
                                                            itemCount: 3,
                                                            itemSize: 10,
                                                            itemPadding: EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        0.2),
                                                            itemBuilder:
                                                                (context, _) =>
                                                                    Icon(
                                                              Icons.star,
                                                              color:
                                                                  Colors.amber,
                                                            ),
                                                            onRatingUpdate:
                                                                (rating) {},
                                                          ),
                                                        ],
                                                      ),
                                                      Container(
                                                        height: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .height *
                                                            0.05,
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.23,
                                                        //height: 38, width: 98,
                                                        decoration: BoxDecoration(
                                                            color: Colors.white
                                                                .withOpacity(
                                                                    0.1),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        16)),
                                                        child: FittedBox(
                                                          fit: BoxFit.scaleDown,
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Text(
                                                                  leaderboardAll[
                                                                          index]
                                                                      .challenge
                                                                      .prize
                                                                      .toString(),
                                                                  style: GoogleFonts.poppins(
                                                                      color: Colors
                                                                          .white,
                                                                      fontSize:
                                                                          16,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600)),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        left:
                                                                            5),
                                                                child: Text(
                                                                    "Gwei",
                                                                    style: GoogleFonts.poppins(
                                                                        color: Colors
                                                                            .orangeAccent,
                                                                        fontSize:
                                                                            12,
                                                                        fontWeight:
                                                                            FontWeight.w400)),
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

                        //**** leaderboard view more container *****/

                        // : Padding(
                        //     padding: const EdgeInsets.only(top: 10),
                        //     child: Container(
                        //         height: MediaQuery.of(context).size.height *
                        //             0.4,
                        //         width: MediaQuery.of(context).size.width,
                        //         //color: Colors.red,
                        //         child: GridView.builder(
                        //             itemCount: elements.length,
                        //             gridDelegate:
                        //                 SliverGridDelegateWithFixedCrossAxisCount(
                        //               crossAxisCount: MediaQuery.of(context)
                        //                           .orientation ==
                        //                       Orientation.landscape
                        //                   ? 3
                        //                   : 2,
                        //               crossAxisSpacing: 0,
                        //               mainAxisSpacing: 0,
                        //               childAspectRatio: (1 / 0.8),
                        //             ),
                        //             itemBuilder: (
                        //               context,
                        //               index,
                        //             ) {
                        //               return GestureDetector(
                        //                 onTap: () {
                        //                   //leaderboardProfile(context);
                        //                   // Navigator.of(context)
                        //                   //     .pushNamed(RouteName.GridViewCustom);
                        //                 },
                        //                 child: Container(
                        //                   child: Row(
                        //                     mainAxisAlignment:
                        //                         MainAxisAlignment
                        //                             .spaceAround,
                        //                     children: [
                        //                       Container(
                        //                         height:
                        //                             MediaQuery.of(context)
                        //                                     .size
                        //                                     .height *
                        //                                 0.15,
                        //                         width:
                        //                             MediaQuery.of(context)
                        //                                     .size
                        //                                     .width *
                        //                                 0.09,
                        //                         decoration: BoxDecoration(
                        //                           color: leaderboardColorList[
                        //                               index %
                        //                                   leaderboardColorList
                        //                                       .length],
                        //                           borderRadius:
                        //                               BorderRadius.circular(
                        //                                   25),
                        //                         ),
                        //                         child: Center(
                        //                           child: Text(
                        //                             (lang.length != null &&
                        //                                     lang.length !=
                        //                                         0 &&
                        //                                     userLanguage[
                        //                                             ''] !=
                        //                                         null)
                        //                                 ? "${userLanguage['']}"
                        //                                 : elements[index]
                        //                                     ["count"],
                        //                             style: GoogleFonts
                        //                                 .montserrat(
                        //                                     fontSize: 14,
                        //                                     color: white,
                        //                                     fontWeight:
                        //                                         FontWeight
                        //                                             .w600),
                        //                           ),
                        //                         ),
                        //                       ),
                        //                       GestureDetector(
                        //                         onTap: () {
                        //                           // leaderboardProfile(context);
                        //                           // setState(() {
                        //                           //   viewProfile == true;
                        //                           // });
                        //                         },
                        //                         child: Container(
                        //                           height:
                        //                               MediaQuery.of(context)
                        //                                       .size
                        //                                       .height *
                        //                                   0.15,
                        //                           width:
                        //                               MediaQuery.of(context)
                        //                                       .size
                        //                                       .height *
                        //                                   0.17,
                        //                           decoration: BoxDecoration(
                        //                             color: white
                        //                                 .withOpacity(0.1),
                        //                             borderRadius:
                        //                                 BorderRadius
                        //                                     .circular(25),
                        //                           ),
                        //                           child: Column(
                        //                             children: [
                        //                               ListTile(
                        //                                 leading: ClipRRect(
                        //                                   borderRadius:
                        //                                       BorderRadius
                        //                                           .circular(
                        //                                               30),
                        //                                   child: Container(
                        //                                       height: 45,
                        //                                       width: 45,
                        //                                       color: button,
                        //                                       child: Image
                        //                                           .network(
                        //                                         elements[
                        //                                                 index]
                        //                                             ['url'],
                        //                                         fit: BoxFit
                        //                                             .cover,
                        //                                       )),
                        //                                 ),
                        //                                 title: FittedBox(
                        //                                   fit: BoxFit
                        //                                       .scaleDown,
                        //                                   child: Text(
                        //                                     elements[index][
                        //                                             "leadername"]
                        //                                         .toUpperCase(),
                        //                                     style:
                        //                                         GoogleFonts
                        //                                             .poppins(
                        //                                       color: Colors
                        //                                           .white,
                        //                                       fontSize: 16,
                        //                                       fontWeight:
                        //                                           FontWeight
                        //                                               .w600,
                        //                                     ),
                        //                                   ),
                        //                                 ),
                        //                                 subtitle: RatingBar
                        //                                     .builder(
                        //                                   initialRating: 3,
                        //                                   minRating: 1,
                        //                                   direction: Axis
                        //                                       .horizontal,
                        //                                   allowHalfRating:
                        //                                       true,
                        //                                   itemCount: 3,
                        //                                   itemSize: 10,
                        //                                   itemPadding: EdgeInsets
                        //                                       .symmetric(
                        //                                           horizontal:
                        //                                               0.2),
                        //                                   itemBuilder:
                        //                                       (context,
                        //                                               _) =>
                        //                                           Icon(
                        //                                     Icons.star,
                        //                                     color: Colors
                        //                                         .amber,
                        //                                   ),
                        //                                   onRatingUpdate:
                        //                                       (rating) {
                        //                                     print(rating);
                        //                                   },
                        //                                 ),
                        //                               ),
                        //                               viewProfile == false
                        //                                   ? InkWell(
                        //                                       onTap: () {
                        //                                         setState(
                        //                                             () {
                        //                                           viewProfile =
                        //                                               true;
                        //                                         });
                        //                                       },
                        //                                       child:
                        //                                           Container(
                        //                                         height: MediaQuery.of(context)
                        //                                                 .size
                        //                                                 .height *
                        //                                             0.05,
                        //                                         width: MediaQuery.of(context)
                        //                                                 .size
                        //                                                 .width *
                        //                                             0.3,
                        //                                         //height: 40, width: 105,
                        //                                         decoration: BoxDecoration(
                        //                                             color: Colors
                        //                                                 .white
                        //                                                 .withOpacity(
                        //                                                     0.25),
                        //                                             borderRadius:
                        //                                                 BorderRadius.circular(17)),
                        //                                         child: Row(
                        //                                           mainAxisAlignment:
                        //                                               MainAxisAlignment
                        //                                                   .center,
                        //                                           children: [
                        //                                             FittedBox(
                        //                                               fit: BoxFit
                        //                                                   .scaleDown,
                        //                                               child: Text(
                        //                                                   elements[index]['amt'],
                        //                                                   style: GoogleFonts.poppins(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600)),
                        //                                             ),
                        //                                             Padding(
                        //                                               padding:
                        //                                                   const EdgeInsets.only(left: 3),
                        //                                               child: Text(
                        //                                                   "Gwei",
                        //                                                   style: GoogleFonts.poppins(color: Colors.orangeAccent, fontSize: 12, fontWeight: FontWeight.w400)),
                        //                                             ),
                        //                                           ],
                        //                                         ),
                        //                                       ),
                        //                                     )
                        //                                   : InkWell(
                        //                                       onTap: () {
                        //                                         leaderboardProfile(
                        //                                             context);
                        //                                       },
                        //                                       child:
                        //                                           Container(
                        //                                         height: MediaQuery.of(context)
                        //                                                 .size
                        //                                                 .height *
                        //                                             0.05,
                        //                                         width: MediaQuery.of(context)
                        //                                                 .size
                        //                                                 .width *
                        //                                             0.3,
                        //                                         decoration:
                        //                                             BoxDecoration(
                        //                                           color:
                        //                                               blue2,
                        //                                           borderRadius:
                        //                                               BorderRadius.circular(
                        //                                                   17),
                        //                                         ),
                        //                                         child:
                        //                                             Center(
                        //                                           child:
                        //                                               Text(
                        //                                             (lang.length != null &&
                        //                                                     lang.length != 0 &&
                        //                                                     userLanguage['viewprofile'] != null)
                        //                                                 ? "${userLanguage['viewprofile']}"
                        //                                                 : "VIEW PROFILE",
                        //                                             style: GoogleFonts.montserrat(
                        //                                                 fontSize:
                        //                                                     9,
                        //                                                 color:
                        //                                                     white,
                        //                                                 fontWeight:
                        //                                                     FontWeight.w600),
                        //                                           ),
                        //                                         ),
                        //                                       ),
                        //                                     )
                        //                             ],
                        //                           ),
                        //                         ),
                        //                       )
                        //                     ],
                        //                   ),
                        //                 ),
                        //               );
                        //             })),
                        //   ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.03,
                  ),
                  Container(
                    height: 60,
                    width: MediaQuery.of(context).size.width * 0.65,
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
                      },
                      color: blue1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            onPressed: () {
                              //showdialog(context);
                              _enterNickname(context);
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
      ),
    );
  }

  //** NICKNAME BOTTOM SHEET */
  bool nickNameChecking = false;
  var nicknameAvailable = "default";
  String nickNameErrorMessage = "";
  final formKey = GlobalKey<FormState>();
  // ignore: unused_field
  final TextEditingController _nicknameController = TextEditingController();
  void _enterNickname(BuildContext context) async {
    showModalBottomSheet(
      backgroundColor: backgroundcolor.withOpacity(0.1),
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
          return Scaffold(
            // appBar: AppBar(
            //   backgroundColor: backgroundcolor.withOpacity(0),
            //   elevation: 0,
            //   leading: Padding(
            //     padding: const EdgeInsets.all(5.0),
            //     child: Container(
            //       width: 50,
            //       height: 50,
            //       decoration:
            //           BoxDecoration(shape: BoxShape.circle, color: gridcolor),
            //       child: Center(
            //         child:
            //             Icon(Icons.arrow_back, size: 20, color: Colors.white),
            //       ),
            //     ),
            //   ),
            //   title: Text(
            //     (lang.length != null &&
            //             lang.length != 0 &&
            //             userLanguage['createachellenge'] != null)
            //         ? "${userLanguage['createachellenge']}"
            //         : "CREATE A \nCHALLENGE",
            //     style: GoogleFonts.poppins(
            //       decoration: TextDecoration.none,
            //       height: 1,
            //       color: Colors.white,
            //       fontSize: 17,
            //       fontWeight: FontWeight.w600,
            //     ),
            //   ),
            //   actions: [
            //     Padding(
            //       padding: const EdgeInsets.only(right: 10),
            //       child: LinearPercentIndicator(
            //         width: 100,
            //         lineHeight: 25.0,
            //         percent: 0.25,
            //         center: Padding(
            //           padding: const EdgeInsets.only(left: 54),
            //           child: Text(
            //             "25%",
            //             style: GoogleFonts.poppins(
            //                 color: white,
            //                 letterSpacing: 1,
            //                 fontSize: 12,
            //                 fontWeight: FontWeight.w400),
            //           ),
            //         ),
            //         linearStrokeCap: LinearStrokeCap.roundAll,
            //         backgroundColor: backgroundcolor,
            //         progressColor: blue,
            //       ),
            //     ),
            //   ],
            // ),
            backgroundColor: backgroundcolor.withOpacity(0.1),
            // color: backgroundcolor.withOpacity(0.7),
            // margin: EdgeInsets.only(top: 0, left: 0, bottom: 0),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.04,
                ),
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
                                child: GestureDetector(
                                  onTap: () {
                                    selecttype = "";
                                    setState(() {
                                      selecttype = "Walking";
                                      iswalking = !iswalking;
                                      isrunning = false;
                                    });
                                  },
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(top: 25),
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
                                        padding: const EdgeInsets.only(top: 12),
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
                                        padding: const EdgeInsets.only(top: 10),
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
                                child: GestureDetector(
                                  onTap: () {
                                    selecttype = "";
                                    setState(() {
                                      selecttype = "Running";
                                      isrunning = !isrunning;
                                      iswalking = false;
                                    });
                                  },
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(top: 25),
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
                                        padding: const EdgeInsets.only(top: 12),
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
                                        padding: const EdgeInsets.only(top: 10),
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
          // Container(
          //   decoration: BoxDecoration(
          //       color: button.withOpacity(0.5),
          //       borderRadius: BorderRadius.only(
          //         topLeft: Radius.circular(25),
          //         topRight: Radius.circular(25),
          //       )),
          //   padding: EdgeInsets.only(
          //     bottom: MediaQuery.of(context).viewInsets.bottom,
          //   ),
          //   // You can wrap this Column with Padding of 8.0 for better design
          //   child: Padding(
          //     padding: const EdgeInsets.all(15.0),
          //     child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
          //       SizedBox(
          //         height: MediaQuery.of(context).size.height * 0.02,
          //       ),
          //       Text(
          //         (lang.length != null &&
          //                 lang.length != 0 &&
          //                 userLanguage['createyournicknamehere'] != null)
          //             ? "${userLanguage['createyournicknamehere']}"
          //             : "CREATE YOUR NICKNAME HERE",
          //         textAlign: TextAlign.center,
          //         style: GoogleFonts.poppins(
          //           color: white,
          //           fontSize: 20,
          //           fontWeight: FontWeight.w600,
          //         ),
          //       ),
          //       SizedBox(
          //         height: MediaQuery.of(context).size.height * 0.03,
          //       ),
          //       Form(
          //         key: formKey,
          //         child: TextFormField(
          //           onChanged: (value) {
          //             // setState(() {
          //             //   nickNameChecking = false;
          //             //   nickNameErrorMessage = "12345";
          //             // });
          //           },
          //           style: TextStyle(color: Colors.white),
          //           validator: (_nicknameController) {
          //             if (_nicknameController.isEmpty)
          //               return 'Please enter nickname';

          //             if (nicknameAvailable == "available") {
          //               return "Nickname is unavailable";
          //             }

          //             return null;
          //           },
          //           autofocus: true,
          //           controller: _nicknameController,
          //           decoration: InputDecoration(
          //             border: OutlineInputBorder(
          //               borderRadius: BorderRadius.all(Radius.circular(15)),
          //               borderSide: BorderSide(
          //                 color: Color(0xffedeff5),
          //               ),
          //             ),
          //             enabledBorder: OutlineInputBorder(
          //               borderRadius: BorderRadius.all(Radius.circular(15)),
          //               borderSide: BorderSide(
          //                 color: Color(0xffedeff5),
          //               ),
          //             ),
          //             focusedBorder: OutlineInputBorder(
          //               borderRadius: BorderRadius.all(Radius.circular(15)),
          //               borderSide: BorderSide(color: white),
          //             ),
          //             isDense: true,
          //             labelText: 'Nickname',
          //             labelStyle: TextStyle(
          //               // fontFamily: 'Dosis-Book',
          //               color: white,
          //               fontSize: 18,
          //             ),
          //             prefixIcon: Icon(
          //               Icons.star,
          //               color: Colors.red,
          //               size: 10,
          //             ),
          //           ),
          //           minLines: 1,
          //           maxLines: 1,
          //           //autovalidate: true,
          //           autocorrect: false,
          //         ),
          //       ),

          //       SizedBox(
          //         height: MediaQuery.of(context).size.height * 0.04,
          //       ),
          //       Center(
          //         child: Row(
          //           mainAxisAlignment: MainAxisAlignment.spaceAround,
          //           children: [
          //             Container(
          //               height: MediaQuery.of(context).size.height * 0.06,
          //               width: MediaQuery.of(context).size.width * 0.9,
          //               decoration: BoxDecoration(
          //                   borderRadius: BorderRadius.circular(15)),
          //               // ignore: deprecated_member_use
          //               child: RaisedButton(
          //                 shape: RoundedRectangleBorder(
          //                   borderRadius: BorderRadius.circular(15),
          //                 ),
          //                 onPressed: () {
          //                   //checkUserNickname();
          //                   if (formKey.currentState.validate()) {
          //                     formKey.currentState.save();
          //                   }
          //                 },
          //                 color: blue1.withOpacity(0.2),
          //                 child: Text(
          //                   (lang.length != null &&
          //                           lang.length != 0 &&
          //                           userLanguage['proceed'] != null)
          //                       ? "${userLanguage['proceed']}"
          //                       : "PROCEED",
          //                   style: GoogleFonts.poppins(
          //                     //color: blue1,
          //                     color: blue2,
          //                     fontSize: 15,
          //                     fontWeight: FontWeight.w600,
          //                   ),
          //                 ),
          //               ),
          //             ),
          //           ],
          //         ),
          //       )
          //     ]),
          //   ),
          // );
        });
      },
    );
  }

  bool ischeckvisible = false;
  bool iswalking = false;
  bool isrunning = false;
  var selecttype;
  var wagar;
  var challenge;
  var kmchallenge;
  var daychallenge;
  var competitorsgets;
  var winnergets;
  // Selecttype start//
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
                        child: GestureDetector(
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
                                  child: GestureDetector(
                                    onTap: () {
                                      selecttype = "";
                                      setState(() {
                                        selecttype = "Walking";
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
                                  child: GestureDetector(
                                    onTap: () {
                                      selecttype = "";
                                      setState(() {
                                        selecttype = "Running";
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

  // Selecttype end//
  int _focusedIndex = 0;
  int _wageIndex = 0;

  // selectsat start//
  void selectsat(BuildContext context) {
    for (int i = 0; i < 40; i++) {
      value = value + 5;
      data.add(value);
    }
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return StatefulBuilder(
          // You need this, notice the parameters below:
          builder: (BuildContext context, StateSetter setState) {
            void _onItemFocus(int index) {
              setState(() {
                _focusedIndex = index;
              });
            }

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
                        child: GestureDetector(
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
                                      MediaQuery.of(context).size.height * 0.15,
                                  // width: MediaQuery.of(context).size.width,
                                  //color: Colors.red,
                                  child: Center(
                                    child: RichText(
                                      text: TextSpan(
                                        children: [
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
                                              text: ' Gwei ',
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
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.001,
                            ),
                            // HorizontalList(),
                            Container(
                              height: MediaQuery.of(context).size.height * 0.2,
                              child: ScrollSnapList(
                                duration: 500,
                                scrollPhysics: BouncingScrollPhysics(),
                                onItemFocus: _onItemFocus,
                                itemSize: 50,
                                itemBuilder: _buildListItem,
                                itemCount: data.length,
                                reverse: false,
                                dynamicItemSize: false,
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.05,
                            ),
                            Container(
                              height: 55,
                              width: MediaQuery.of(context).size.width * 0.8,
                              // ignore: deprecated_member_use
                              child: RaisedButton(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                onPressed: () {
                                  wagar = data[_focusedIndex];
                                  Navigator.pop(context);
                                  selectKM(context);

                                  // print(_focusedIndex);
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

  // selectsat end//

  int _kmfocusedIndex = 0;

  // selectKM start//
  void selectKM(BuildContext context) {
    for (int i = 0; i < 40; i++) {
      kmvalue = kmvalue + 1;
      km.add(kmvalue);
    }
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return StatefulBuilder(
          // You need this, notice the parameters below:
          builder: (BuildContext context, StateSetter setState) {
            void _onItemFocus(int index) {
              setState(() {
                _kmfocusedIndex = index;
              });
            }

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
                        child: GestureDetector(
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
                                      MediaQuery.of(context).size.height * 0.15,
                                  // width: MediaQuery.of(context).size.width,
                                  //color: Colors.red,
                                  child: Center(
                                    child: RichText(
                                        text: TextSpan(children: [
                                      TextSpan(
                                          text: 'How many',
                                          style: GoogleFonts.poppins(
                                            color: Colors.white,
                                            fontSize: 25,
                                            fontWeight: FontWeight.w600,
                                          )),
                                      TextSpan(
                                          text: ' Km ',
                                          style: GoogleFonts.poppins(
                                            color: Colors.orange,
                                            fontSize: 25,
                                            fontWeight: FontWeight.w500,
                                          )),
                                      TextSpan(
                                          text:
                                              'would\nyou like for challenge? ',
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
                              height:
                                  MediaQuery.of(context).size.height * 0.001,
                            ),
                            // HorizontalList(),
                            Container(
                              height: MediaQuery.of(context).size.height * 0.2,
                              child: ScrollSnapList(
                                duration: 500,
                                scrollPhysics: BouncingScrollPhysics(),
                                onItemFocus: _onItemFocus,
                                itemSize: 50,
                                itemBuilder: _buildKMItem,
                                itemCount: km.length,
                                reverse: false,
                                dynamicItemSize: false,
                              ),
                            ),

                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.05,
                            ),
                            Container(
                              height: 55,
                              width: MediaQuery.of(context).size.width * 0.8,
                              // ignore: deprecated_member_use
                              child: RaisedButton(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                onPressed: () {
                                  kmchallenge = km[_kmfocusedIndex];
                                  Navigator.pop(context);
                                  selectDay(context);

                                  // print(_focusedIndex);
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

  // selectKM end//
  int _dayfocusedIndex = 0;

  // selectKM start//
  void selectDay(BuildContext context) {
    for (int i = 0; i < 40; i++) {
      dayvalue = dayvalue + 1;
      day.add(dayvalue);
    }
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return StatefulBuilder(
          // You need this, notice the parameters below:
          builder: (BuildContext context, StateSetter setState) {
            void _onItemFocus(int index) {
              setState(() {
                _dayfocusedIndex = index;
              });
            }

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
                        child: GestureDetector(
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
                                      MediaQuery.of(context).size.height * 0.15,
                                  // width: MediaQuery.of(context).size.width,
                                  //color: Colors.red,
                                  child: Center(
                                    child: RichText(
                                        text: TextSpan(children: [
                                      TextSpan(
                                          text: 'How many',
                                          style: GoogleFonts.poppins(
                                            color: Colors.white,
                                            fontSize: 25,
                                            fontWeight: FontWeight.w600,
                                          )),
                                      TextSpan(
                                          text: ' Days ',
                                          style: GoogleFonts.poppins(
                                            color: Colors.orange,
                                            fontSize: 25,
                                            fontWeight: FontWeight.w500,
                                          )),
                                      TextSpan(
                                          text:
                                              'would\nyou like for challenge? ',
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
                              height:
                                  MediaQuery.of(context).size.height * 0.001,
                            ),
                            // HorizontalList(),
                            Container(
                              height: MediaQuery.of(context).size.height * 0.2,
                              child: ScrollSnapList(
                                duration: 500,
                                scrollPhysics: BouncingScrollPhysics(),
                                onItemFocus: _onItemFocus,
                                itemSize: 50,
                                itemBuilder: _buildDAYItem,
                                itemCount: km.length,
                                reverse: false,
                                dynamicItemSize: false,
                              ),
                            ),

                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.05,
                            ),
                            Container(
                              height: 55,
                              width: MediaQuery.of(context).size.width * 0.8,
                              // ignore: deprecated_member_use
                              child: RaisedButton(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                onPressed: () {
                                  daychallenge = day[_dayfocusedIndex];
                                  Navigator.pop(context);
                                  selectchallengetype(context);

                                  // print(_focusedIndex);
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

  // selectKM end//

  // selectchallengetype start//
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
                        child: GestureDetector(
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
                                GestureDetector(
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
                                          child: GestureDetector(
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
                                      challenge = "Streak";
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

  // selectchallengetype end//

  // selectshowcompetitors start//
  void selectshowcompetitors(BuildContext context) {
    for (int i = 0; i < 40; i++) {
      wagevalue = wagevalue + 5;
      wage.add(wagevalue);
    }
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return StatefulBuilder(
          // You need this, notice the parameters below:
          builder: (BuildContext context, StateSetter setState) {
            void _onItemFocus(int index) {
              setState(() {
                _wageIndex = index;
              });
            }

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
                        child: GestureDetector(
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
                              height:
                                  MediaQuery.of(context).size.height * 0.001,
                            ),
                            Container(
                              height: MediaQuery.of(context).size.height * 0.16,
                              child: ScrollSnapList(
                                duration: 500,
                                scrollPhysics: BouncingScrollPhysics(),
                                onItemFocus: _onItemFocus,
                                itemSize: 50,
                                itemBuilder: _buildwageItem,
                                itemCount: wage.length,
                                reverse: false,
                                dynamicItemSize: false,
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.03,
                            ),
                            Text(
                              "WINNER GETS",
                              style: GoogleFonts.poppins(
                                  color: Color(0xFF808DA7),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500),
                            ),
                            Text(
                              "${wage[_wageIndex] * wagar}",
                              style: GoogleFonts.montserrat(
                                  color: Colors.orange,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.03,
                            ),
                            Container(
                              height: 55,
                              width: MediaQuery.of(context).size.width * 0.8,
                              // ignore: deprecated_member_use
                              child: RaisedButton(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  onPressed: () {
                                    competitorsgets = wage[_wageIndex];

                                    Navigator.pop(context);
                                    selectshowsummary(context);
                                  },
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

  // selectshowcompetitors end//

  // selectshowsummary start//
  void selectshowsummary(BuildContext context) {
    var todayDate = new DateTime.now();
    var todayDate1 = new DateTime.now();
    var days = new DateTime(
        todayDate1.year, todayDate1.month, todayDate1.day + daychallenge);
    var expiryDate = (DateFormat.yMMMd().format(days)).toString();
    var today1 = (DateFormat.yMMMd().format(todayDate)).toString();
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
                color: backgroundcolor.withOpacity(0.7),
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
                    // SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Card(
                        shadowColor: button.withOpacity(0.5),
                        color: Color(0xff1C203A),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(32),
                          // side: new BorderSide(color: Colors.black, width: 1.0),
                        ),
                        child: SingleChildScrollView(
                          child: Container(
                            child: Column(
                              // shrinkWrap: true,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 20, left: 25),
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
                                          top: 10, left: 25),
                                      child: Text(
                                        (lang.length != null &&
                                                lang.length != 0 &&
                                                userLanguage['activity'] !=
                                                    null)
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
                                          top: 10, right: 50),
                                      child: Text(
                                        "Gwei Wagered",
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
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.41,
                                        decoration: BoxDecoration(
                                            color: button,
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                        child: Row(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 10),
                                              child: Container(
                                                height: 32,
                                                width: 25,
                                                //color: blue1,
                                                child: Image.asset(
                                                  selecttype == "Walking"
                                                      ? "assets/images/walking.png"
                                                      : "assets/images/running.png",
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 10),
                                              child: Text(
                                                selecttype,
                                                style: GoogleFonts.poppins(
                                                    decoration:
                                                        TextDecoration.none,
                                                    color: Colors.white,
                                                    fontSize: 13,
                                                    fontWeight:
                                                        FontWeight.w600),
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
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.41,
                                        decoration: BoxDecoration(
                                            color: button,
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                        child: Row(
                                          // mainAxisAlignment:
                                          //     MainAxisAlignment.spaceBetween,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 15),
                                              child: Text(
                                                wagar.toString(),
                                                style: GoogleFonts.montserrat(
                                                    decoration:
                                                        TextDecoration.none,
                                                    color: Colors.white,
                                                    fontSize: 21,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(
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
                                            // Padding(
                                            //   padding: const EdgeInsets.only(
                                            //       right: 10),
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
                                            //             Icons.note_add_outlined,
                                            //             color: Colors.white,
                                            //             size: 12,
                                            //           )),
                                            //     ),
                                            //   ),
                                            // ),
                                          ],
                                        ),
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
                                          top: 10, left: 25),
                                      child: Text(
                                        "Start Date",
                                        style: GoogleFonts.poppins(
                                            decoration: TextDecoration.none,
                                            color: Colors.grey,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 10, right: 90),
                                      child: Text(
                                        "End Date",
                                        textAlign: TextAlign.start,
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
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.41,
                                        decoration: BoxDecoration(
                                            color: button,
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                        child: Row(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 10),
                                              child: Text(
                                                today1,
                                                style: GoogleFonts.poppins(
                                                    decoration:
                                                        TextDecoration.none,
                                                    color: Colors.white,
                                                    fontSize: 13,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            ),
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
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.41,
                                        decoration: BoxDecoration(
                                            color: button,
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 15),
                                              child: Text(
                                                expiryDate,
                                                style: GoogleFonts.poppins(
                                                    decoration:
                                                        TextDecoration.none,
                                                    color: Colors.white,
                                                    fontSize: 13,
                                                    fontWeight:
                                                        FontWeight.w600),
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
                                          top: 10, left: 25),
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
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 10, right: 90),
                                      child: Text(
                                        "Total KM",
                                        textAlign: TextAlign.start,
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
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.41,
                                        decoration: BoxDecoration(
                                            color: button,
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 15),
                                              child: Container(
                                                //color: blue1,
                                                child: Row(
                                                  children: [
                                                    Container(
                                                      height: 32,
                                                      width: 25,
                                                      //color: blue1,
                                                      child: Image.asset(
                                                        "assets/images/streak.png",
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 10),
                                                      child: Text(
                                                        challenge,
                                                        style:
                                                            GoogleFonts.poppins(
                                                                decoration:
                                                                    TextDecoration
                                                                        .none,
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 13,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600),
                                                      ),
                                                    ),
                                                    // Padding(
                                                    //   padding:
                                                    //       const EdgeInsets.only(
                                                    //           left: 10),
                                                    //   child: ClipRRect(
                                                    //     borderRadius:
                                                    //         BorderRadius
                                                    //             .circular(30),
                                                    //     child: Container(
                                                    //       height: 25,
                                                    //       width: 25,
                                                    //       color: blue1,
                                                    //       child: IconButton(
                                                    //           onPressed: () {},
                                                    //           icon: Icon(
                                                    //             Icons.check,
                                                    //             color: Colors
                                                    //                 .white,
                                                    //             size: 11,
                                                    //           )),
                                                    //     ),
                                                    //   ),
                                                    // ),
                                                  ],
                                                ),
                                              ),
                                            ),
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
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.41,
                                        decoration: BoxDecoration(
                                            color: button,
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 15),
                                              child: Text(
                                                kmchallenge.toString() + " KM",
                                                style: GoogleFonts.poppins(
                                                    decoration:
                                                        TextDecoration.none,
                                                    color: Colors.white,
                                                    fontSize: 13,
                                                    fontWeight:
                                                        FontWeight.w600),
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
                                          top: 10, left: 25),
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
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.9,
                                        decoration: BoxDecoration(
                                            color: button,
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 15),
                                              child: Text(
                                                competitorsgets.toString(),
                                                style: GoogleFonts.poppins(
                                                    decoration:
                                                        TextDecoration.none,
                                                    color: Colors.white,
                                                    fontSize: 21,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            ),
                                            // Padding(
                                            //   padding: const EdgeInsets.only(
                                            //       right: 25),
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
                                            //             Icons.note_add_outlined,
                                            //             color: Colors.white,
                                            //             size: 12,
                                            //           )),
                                            //     ),
                                            //   ),
                                            // ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.02,
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
                                      "${competitorsgets * wagar}".toString(),
                                      style: GoogleFonts.montserrat(
                                          decoration: TextDecoration.none,
                                          color: Colors.orange,
                                          fontSize: 17,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    SizedBox(
                                      width: 3,
                                    ),
                                    Text(
                                      "GWEI",
                                      style: GoogleFonts.montserrat(
                                          decoration: TextDecoration.none,
                                          color: Colors.orange,
                                          fontSize: 17,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.02,
                                ),
                                Container(
                                  height: 55,
                                  width:
                                      MediaQuery.of(context).size.width * 0.8,
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
                                      Navigator.pop(context);
                                      createChallenges();
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
                                    ),
                                  ),
                                ),
                                // SizedBox(
                                //   height:
                                //       MediaQuery.of(context).size.height * 0.02,
                                // ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),

                    // SizedBox(
                    //   height: MediaQuery.of(context).size.height * 0.02,
                    // ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  // selectshowsummary end//

  //** challangedetails screen start //

  void challangedetails(BuildContext context, detail) {
    DateTime parseDate =
        new DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").parse(detail.startDate);
    var inputDate = DateTime.parse(parseDate.toString());
    var startDate = (DateFormat.yMMMd().format(inputDate)).toString();
    DateTime parseendDate =
        new DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").parse(detail.endDate);
    var endinputDate = DateTime.parse(parseendDate.toString());
    var endDate = (DateFormat.yMMMd().format(endinputDate)).toString();

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
                color: backgroundcolor.withOpacity(0.7),
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
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(150),
                          ),
                          child: GestureDetector(
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
                          "MY ACTIVITY DETAILS",
                          style: GoogleFonts.poppins(
                            decoration: TextDecoration.none,
                            height: 1,
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Spacer(),
                      ],
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Card(
                        shadowColor: button.withOpacity(0.5),
                        color: Color(0xff1C203A),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(32),
                        ),
                        child: SingleChildScrollView(
                          child: Container(
                            child: Column(
                              // shrinkWrap: true,
                              children: [
                                // Row(
                                //   crossAxisAlignment: CrossAxisAlignment.center,
                                //   mainAxisAlignment: MainAxisAlignment.start,
                                //   children: [
                                //     Padding(
                                //       padding: const EdgeInsets.only(
                                //           top: 20, left: 25),
                                //       child: Text(
                                //         (lang.length != null &&
                                //                 lang.length != 0 &&
                                //                 userLanguage[
                                //                         'challengesummary'] !=
                                //                     null)
                                //             ? "${userLanguage['challengesummary']}"
                                //             : "Challenge Summary",
                                //         style: GoogleFonts.poppins(
                                //             decoration: TextDecoration.none,
                                //             color: Colors.white,
                                //             fontSize: 25,
                                //             fontWeight: FontWeight.w600),
                                //       ),
                                //     ),
                                //   ],
                                // ),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.03,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 10, left: 25),
                                      child: Text(
                                        (lang.length != null &&
                                                lang.length != 0 &&
                                                userLanguage['activity'] !=
                                                    null)
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
                                          top: 10, right: 50),
                                      child: Text(
                                        "Gwei Wagered",
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
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.41,
                                        decoration: BoxDecoration(
                                            color: button,
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                        child: Row(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 10),
                                              child: Container(
                                                height: 32,
                                                width: 25,
                                                //color: blue1,
                                                child: Image.asset(
                                                  detail.mode == "Walking"
                                                      ? "assets/images/walking.png"
                                                      : "assets/images/running.png",
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 10),
                                              child: Text(
                                                detail.mode,
                                                style: GoogleFonts.poppins(
                                                    decoration:
                                                        TextDecoration.none,
                                                    color: Colors.white,
                                                    fontSize: 13,
                                                    fontWeight:
                                                        FontWeight.w600),
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
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.41,
                                        decoration: BoxDecoration(
                                            color: button,
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 15),
                                              child: Text(
                                                detail.wage,
                                                style: GoogleFonts.montserrat(
                                                    decoration:
                                                        TextDecoration.none,
                                                    color: Colors.white,
                                                    fontSize: 21,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            ),
                                            Text(
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
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 10),
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
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 10, left: 25),
                                      child: Text(
                                        "Start Date",
                                        style: GoogleFonts.poppins(
                                            decoration: TextDecoration.none,
                                            color: Colors.grey,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 10, right: 90),
                                      child: Text(
                                        "End Date",
                                        textAlign: TextAlign.start,
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
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.41,
                                        decoration: BoxDecoration(
                                            color: button,
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                        child: Row(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 10),
                                              child: Text(
                                                startDate.toString(),
                                                style: GoogleFonts.poppins(
                                                    decoration:
                                                        TextDecoration.none,
                                                    color: Colors.white,
                                                    fontSize: 13,
                                                    fontWeight:
                                                        FontWeight.w600),
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
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.41,
                                        decoration: BoxDecoration(
                                            color: button,
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 15),
                                              child: Text(
                                                endDate.toString(),
                                                style: GoogleFonts.poppins(
                                                    decoration:
                                                        TextDecoration.none,
                                                    color: Colors.white,
                                                    fontSize: 13,
                                                    fontWeight:
                                                        FontWeight.w600),
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
                                          top: 10, left: 25),
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
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.9,
                                        decoration: BoxDecoration(
                                            color: button,
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 15),
                                              child: Container(
                                                //color: blue1,
                                                child: Row(
                                                  children: [
                                                    Container(
                                                      height: 32,
                                                      width: 25,
                                                      //color: blue1,
                                                      child: Image.asset(
                                                        "assets/images/streak.png",
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 10),
                                                      child: Text(
                                                        detail.mode,
                                                        style:
                                                            GoogleFonts.poppins(
                                                                decoration:
                                                                    TextDecoration
                                                                        .none,
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 13,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 25),
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
                                          top: 10, left: 25),
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
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.9,
                                        decoration: BoxDecoration(
                                            color: button,
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 15),
                                              child: Text(
                                                detail.totalCompetitors
                                                    .toString(),
                                                style: GoogleFonts.poppins(
                                                    decoration:
                                                        TextDecoration.none,
                                                    color: Colors.white,
                                                    fontSize: 21,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 25),
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
                                  height:
                                      MediaQuery.of(context).size.height * 0.02,
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
                                      detail.wage.toString(),
                                      style: GoogleFonts.montserrat(
                                          decoration: TextDecoration.none,
                                          color: Colors.orange,
                                          fontSize: 17,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    SizedBox(
                                      width: 3,
                                    ),
                                    Text(
                                      "GWEI",
                                      style: GoogleFonts.montserrat(
                                          decoration: TextDecoration.none,
                                          color: Colors.orange,
                                          fontSize: 17,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.03,
                                ),
                                // Container(
                                //   height: 55,
                                //   width:
                                //       MediaQuery.of(context).size.height * 0.6,
                                //   decoration: BoxDecoration(
                                //     //color: Colors.amber,
                                //     borderRadius: BorderRadius.circular(15),
                                //   ),
                                //   // ignore: deprecated_member_use
                                //   child: RaisedButton(
                                //       shape: RoundedRectangleBorder(
                                //         borderRadius: BorderRadius.circular(30),
                                //       ),
                                //       onPressed: () {
                                //         Navigator.pop(context);
                                //         createChallenges();
                                //         // Navigator.push(
                                //         //     context,
                                //         //     MaterialPageRoute(
                                //         //         builder: (context) =>
                                //         //             ChallengeFinal()));
                                //       },
                                //       color: blue1,
                                //       child: Text(
                                //         (lang.length != null &&
                                //                 lang.length != 0 &&
                                //                 userLanguage[
                                //                         'createchallenge'] !=
                                //                     null)
                                //             ? "${userLanguage['createchallenge']}"
                                //             : "CREATE CHALLENGE",
                                //         style: GoogleFonts.poppins(
                                //           color: Colors.white,
                                //           fontSize: 15,
                                //           fontWeight: FontWeight.w600,
                                //         ),
                                //       )),
                                // ),
                                // SizedBox(
                                //   height:
                                //       MediaQuery.of(context).size.height * 0.03,
                                // ),
                              ],
                            ),
                          ),
                        ),
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
//challange details screen end//

  // ignore: non_constant_identifier_names

  Widget _buildListItem(BuildContext context, int index) {
    var blue = Color(0xFF282C4A);
    var orange = Color(0xFFFF8C00);
    var nonlabel = Color(0xFF808DA7);
    //horizontal
    return Container(
      width: 50,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            alignment: Alignment.centerLeft,
            child: Text("${data[index]}",
                textScaleFactor: 1.0,
                style: GoogleFonts.poppins(
                    color: _focusedIndex == index ? orange : nonlabel,
                    fontWeight: _focusedIndex == index
                        ? FontWeight.bold
                        : FontWeight.normal,
                    fontSize: _focusedIndex == index ? 25 : 20)),
          ),
          Container(
            margin: EdgeInsets.only(left: 3, top: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  height: 60,
                  width: 2,
                  decoration: BoxDecoration(
                    color: blue,
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                  ),
                ),
                Container(
                  height: 40,
                  width: 1,
                  decoration: BoxDecoration(
                    color: blue,
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                  ),
                ),
                Container(
                  height: 40,
                  width: 1,
                  decoration: BoxDecoration(
                    color: blue,
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(right: 7),
                  height: 40,
                  width: 1,
                  decoration: BoxDecoration(
                    color: blue,
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildwageItem(BuildContext context, int index) {
    var blue = Color(0xFF282C4A);
    var orange = Color(0xFFFF8C00);
    var nonlabel = Color(0xFF808DA7);
    //horizontal
    return Container(
      width: 50,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            alignment: Alignment.centerLeft,
            child: Text("${wage[index]}",
                textScaleFactor: 1.0,
                style: GoogleFonts.poppins(
                    color: _wageIndex == index ? orange : nonlabel,
                    fontWeight: _wageIndex == index
                        ? FontWeight.bold
                        : FontWeight.normal,
                    fontSize: _wageIndex == index ? 25 : 20)),
          ),
          Container(
            margin: EdgeInsets.only(left: 3, top: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  height: 60,
                  width: 2,
                  decoration: BoxDecoration(
                    color: blue,
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                  ),
                ),
                Container(
                  height: 40,
                  width: 1,
                  decoration: BoxDecoration(
                    color: blue,
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                  ),
                ),
                Container(
                  height: 40,
                  width: 1,
                  decoration: BoxDecoration(
                    color: blue,
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(right: 7),
                  height: 40,
                  width: 1,
                  decoration: BoxDecoration(
                    color: blue,
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildKMItem(BuildContext context, int index) {
    var blue = Color(0xFF282C4A);
    var orange = Color(0xFFFF8C00);
    var nonlabel = Color(0xFF808DA7);
    //horizontal
    return Container(
      width: 50,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            alignment: Alignment.centerLeft,
            child: Text("${km[index]}",
                textScaleFactor: 1.0,
                style: GoogleFonts.poppins(
                    color: _kmfocusedIndex == index ? orange : nonlabel,
                    fontWeight: _kmfocusedIndex == index
                        ? FontWeight.bold
                        : FontWeight.normal,
                    fontSize: _kmfocusedIndex == index ? 25 : 20)),
          ),
          Container(
            margin: EdgeInsets.only(left: 3, top: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  height: 60,
                  width: 2,
                  decoration: BoxDecoration(
                    color: blue,
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                  ),
                ),
                Container(
                  height: 40,
                  width: 1,
                  decoration: BoxDecoration(
                    color: blue,
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                  ),
                ),
                Container(
                  height: 40,
                  width: 1,
                  decoration: BoxDecoration(
                    color: blue,
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(right: 7),
                  height: 40,
                  width: 1,
                  decoration: BoxDecoration(
                    color: blue,
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildDAYItem(BuildContext context, int index) {
    var blue = Color(0xFF282C4A);
    var orange = Color(0xFFFF8C00);
    var nonlabel = Color(0xFF808DA7);
    //horizontal
    return Container(
      width: 50,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            alignment: Alignment.centerLeft,
            child: Text("${day[index]}",
                textScaleFactor: 1.0,
                style: GoogleFonts.poppins(
                    color: _dayfocusedIndex == index ? orange : nonlabel,
                    fontWeight: _dayfocusedIndex == index
                        ? FontWeight.bold
                        : FontWeight.normal,
                    fontSize: _dayfocusedIndex == index ? 25 : 20)),
          ),
          Container(
            margin: EdgeInsets.only(left: 3, top: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  height: 60,
                  width: 2,
                  decoration: BoxDecoration(
                    color: blue,
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                  ),
                ),
                Container(
                  height: 40,
                  width: 1,
                  decoration: BoxDecoration(
                    color: blue,
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                  ),
                ),
                Container(
                  height: 40,
                  width: 1,
                  decoration: BoxDecoration(
                    color: blue,
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(right: 7),
                  height: 40,
                  width: 1,
                  decoration: BoxDecoration(
                    color: blue,
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class Day {}
