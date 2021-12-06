import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:health/health.dart';
import 'package:intl/intl.dart';
import 'package:momerlin/data/localstorage/userdata_source.dart';
import 'package:momerlin/data/userrepository.dart';
import 'package:momerlin/tabscreen/tabscreen.dart';
import 'package:momerlin/theme/theme.dart';
// import 'wallet_challenges.dart';

class JoinChallengesdetail extends StatefulWidget {
  final challange;
  final bool focus;
  const JoinChallengesdetail({Key key, this.challange, this.focus})
      : super(key: key);

  @override
  _JoinChallengesdetail createState() => _JoinChallengesdetail();
}

class MyChallengesDetail {
  var totalkm;
  var streakNo;
  GetChallenge challenge;
  MyChallengesDetail({
    this.totalkm,
    this.streakNo,
    this.challenge,
  });

  factory MyChallengesDetail.fromJson(Map<String, dynamic> json) =>
      MyChallengesDetail(
        totalkm: json["totalkm"] == null ? null : json["totalkm"],
        streakNo: json["streakNo"],
        challenge: GetChallenge.fromJson(json["competitor"]),
      );
}

class GetChallenge {
  GetChallenge({
    this.id,
    this.fullName,
  });

  String id;
  String fullName;

  factory GetChallenge.fromJson(Map<String, dynamic> json) => GetChallenge(
        id: json["_id"],
        fullName: json["fullName"],
      );
  Map<String, dynamic> toJson() => {
        "_id": id,
        "fullName": fullName,
      };
}

class WinnerDetails {
  var totalkm;
  var streakNo;
  var prize;
  Getwinnerchallenge winnerchallenge;
  WinnerDetails({
    this.totalkm,
    this.streakNo,
    this.prize,
    this.winnerchallenge,
  });

  factory WinnerDetails.fromJson(Map<String, dynamic> json) => WinnerDetails(
        totalkm: json["totalkm"] == null ? null : json["totalkm"],
        streakNo: json["streakNo"],
        prize: json["prize"],
        winnerchallenge: Getwinnerchallenge.fromJson(json["competitor"]),
      );
}

class Getwinnerchallenge {
  Getwinnerchallenge({
    this.id,
    this.fullName,
  });

  String id;
  String fullName;

  factory Getwinnerchallenge.fromJson(Map<String, dynamic> json) =>
      Getwinnerchallenge(
        id: json["_id"],
        fullName: json["fullName"],
      );
  Map<String, dynamic> toJson() => {
        "_id": id,
        "fullName": fullName,
      };
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
  clientId:
      '377180466305-inemb4g0usu09f9l9j5p2nrccgcje6bu.apps.googleusercontent.com',
  scopes: <String>[
    'email',
    'https://www.googleapis.com/auth/fitness.activity.read',
    'https://www.googleapis.com/auth/fitness.activity.write',
    'https://www.googleapis.com/auth/fitness.location.read',
    'https://www.googleapis.com/auth/fitness.location.write',
  ],
);

class _JoinChallengesdetail extends State<JoinChallengesdetail> {
  var userLanguage, user, lang = [];
  List<HealthDataPoint> _healthDataList = [];
  // ignore: unused_field
  AppState _state = AppState.DATA_NOT_FETCHED;
  // final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool loading = false;
  var refreshKey = GlobalKey<RefreshIndicatorState>();
  Future<Null> refreshList() async {
    refreshKey.currentState?.show(atTop: false);
    await Future.delayed(Duration(seconds: 2));
    getUserLanguage();

    return null;
  }

  List<MyChallengesDetail> mychallengesdetail = [];

  List<WinnerDetails> winnerdetail = [];
  int value = 0;
  var startdate;
  var exprydate;

  @override
  void initState() {
    super.initState();
    getwinnerChallenges(widget.challange.id);
    getUserLanguage();
  }

// ignore: non_constant_identifier_names
  Future<void> JoinChallenges(uid, challangeid) async {
    var joinchallange = await UserRepository().joiningchallenge(
      uid,
      challangeid,
    );

    if (joinchallange == false) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('No Internet Connection'),
        backgroundColor: Colors.red,
      ));
    } else {
      if (joinchallange["success"] == true) {
        challengeAccepted(context);
      } else {
        getUserLanguage();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(joinchallange["error"]),
          backgroundColor: Colors.red,
        ));
        // Scaffold.of(context)
        //     // ignore: deprecated_member_use
        //     .showSnackBar(
        //   SnackBar(
        //     content: Text(joinchallange["error"]),
        //     backgroundColor: Colors.red,
        //   ),
        // );
      }
    }
  }

  var joinchallenge = false;
  Map<String, dynamic> challangedetail;
  var startDate;
  var endDate;

  var difference = 0;
  Future<void> getwinnerChallenges(challangeid) async {
    var res = await UserRepository().getwinnerChallenges(challangeid);

    if (res["success"] == true) {
      setState(() {
        loading = true;
      });
      for (var i = 0; i < res["challenge"]["competitors"].length; i++) {
        print(res["challenge"]["competitors"]);
        if (user[0]["uid"] == res["challenge"]["competitors"][i]["userId"]) {
          joinchallenge = true;
          print(joinchallenge);
        } else {
          joinchallenge = false;
          print(joinchallenge);
        }
      }
      challangedetail = res['challenge'];
      DateTime parseDate = new DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'")
          .parse(challangedetail['startAt']);
      var inputDate = DateTime.parse(parseDate.toString());
      startDate = (DateFormat.yMMMd().format(inputDate)).toString();
      DateTime parseendDate = new DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'")
          .parse(challangedetail['endAt']);
      var endinputDate = DateTime.parse(parseendDate.toString());
      endDate = (DateFormat.yMMMd().format(endinputDate)).toString();
      final endat = DateTime.parse(challangedetail['endAt']);
      print(endat);
      final date2 = DateTime.now();
      setState(() {
        difference = date2.difference(endat).inDays;
      });
      print(date2);
      print("PAIVTHRA $difference");

      for (var i = 0; i < res["leaders"].length; i++) {
        mychallengesdetail.add(MyChallengesDetail.fromJson(res["leaders"][i]));
      }
      for (var i = 0; i < res["winners"].length; i++) {
        winnerdetail.add(WinnerDetails.fromJson(res["winners"][i]));
      }
    } else {
      setState(() {
        loading = true;
      });
    }
  }

  // ignore: todo
  //TODO :languagestart
  Future<void> getUserLanguage() async {
    lang = await UserDataSource().getLanguage();
    user = await UserDataSource().getUser();
    if (user[0]["googlefitenable"] == 1) {
      fetchData();

      gettoken();
    }
    if (lang.length != null && lang.length != 0) {
      userLanguage = lang[0];
    }
  }

  // ignore: todo
  //TODO: LanguageEnd
  var trophy = [
    Image.asset("assets/images/trophy3.png"),
    Image.asset("assets/images/trophy2.png"),
    Image.asset("assets/images/trophy1.png"),
  ];
  var token;
  Future<void> gettoken() async {
    try {
      await UserRepository().updateUser(1);
      user = await UserDataSource().getUser();
      final result = await _googleSignIn.signIn();
      final ggAuth = await result.authentication;
      token = ggAuth.accessToken;
      // getmyChallenges();
      // getjoinChallenges();
    } catch (error) {
      print(error);
    }
  }

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
      HealthDataType.STEPS,
      HealthDataType.DISTANCE_WALKING_RUNNING,
    ];

    setState(() => _state = AppState.FETCHING_DATA);

    // you MUST request access to the data types before reading them
    bool accessWasGranted = await health.requestAuthorization(types);

    num steps1 = 0;

    if (accessWasGranted) {
      try {
        var res = await UserRepository().updatehealthfit(1);

        if (res == true) {
          joinChallenge(context, widget.challange);
        }
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
        steps1 += x.value.round();
      });
      distance = steps1 / 1000;
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

  var url = [
    "https://www.pngitem.com/pimgs/m/78-786293_1240-x-1240-0-avatar-profile-icon-png.png",
    "https://cdn.imgbin.com/1/8/12/imgbin-computer-icons-user-profile-avatar-woman-business-woman-2x9qVDw4EgxX299EhCLm9fN89.jpg",
    "https://www.clipartmax.com/png/middle/171-1717870_stockvader-predicted-cron-for-may-user-profile-icon-png.png",
  ];
  List<Color> myActivityColorList = [
    containerGreen,
    spendingPink,
    containerOrange,
  ];

  @override
  Widget build(BuildContext context) {
    return
        // loading == false
        //     ? Container(
        //         height: MediaQuery.of(context).size.height,
        //         width: MediaQuery.of(context).size.width,
        //         color: white,
        //         child: Center(
        //           child: SpinKitSpinningLines(
        //             color: backgroundcolor,
        //             size: 60,
        //           ),
        //         ),
        //       )
        //     :
        Scaffold(
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
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (_) => Tabscreen(
                    //               index: 2,
                    //             )));
                  },
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  )),
            ),
          ),
        ),
        title: Text(
          "Challenge Details".toUpperCase(),
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: RefreshIndicator(
        key: refreshKey,
        onRefresh: refreshList,
        child:
            // loading == false
            //     ? Container(
            //         height: MediaQuery.of(context).size.height,
            //         width: MediaQuery.of(context).size.width,
            //         color: backgroundcolor,
            //         child: Center(
            //           child: SpinKitRing(
            //             color: white,
            //             size: 60,
            //           ),
            //         ),
            //       )
            //     :
            SingleChildScrollView(
          child: Container(
            //color: Colors.pink,
            child: Stack(
              children: [
                Container(
                  //color: Colors.red,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 10, left: 25),
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
                            padding: const EdgeInsets.only(top: 10, right: 50),
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
                            padding: const EdgeInsets.only(top: 10, left: 25),
                            child: Container(
                              height: MediaQuery.of(context).size.width * 0.15,
                              width: MediaQuery.of(context).size.width * 0.41,
                              decoration: BoxDecoration(
                                  color: button,
                                  borderRadius: BorderRadius.circular(15)),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Container(
                                      height: 32,
                                      width: 25,
                                      //color: blue1,
                                      child: Image.asset(
                                        loading == false
                                            ? "assets/images/walking.png"
                                            : challangedetail['mode'] ==
                                                    "Walking"
                                                ? "assets/images/walking.png"
                                                : "assets/images/running.png",
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: loading == false
                                        ? Text(
                                            "ACTIVITY",
                                            style: GoogleFonts.poppins(
                                                decoration: TextDecoration.none,
                                                color: Colors.white,
                                                fontSize: 13,
                                                fontWeight: FontWeight.w600),
                                          )
                                        : Text(
                                            challangedetail['mode'] == "Walking"
                                                ? "Walk"
                                                : "Run",
                                            style: GoogleFonts.poppins(
                                                decoration: TextDecoration.none,
                                                color: Colors.white,
                                                fontSize: 13,
                                                fontWeight: FontWeight.w600),
                                          ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10, left: 25),
                            child: Container(
                              height: MediaQuery.of(context).size.width * 0.15,
                              width: MediaQuery.of(context).size.width * 0.41,
                              decoration: BoxDecoration(
                                  color: button,
                                  borderRadius: BorderRadius.circular(15)),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 15),
                                    child: loading == false
                                        ? Text(
                                            "GWEI",
                                            style: GoogleFonts.poppins(
                                                decoration: TextDecoration.none,
                                                color: Colors.white,
                                                fontSize: 13,
                                                fontWeight: FontWeight.w600),
                                          )
                                        : Text(
                                            challangedetail["wage"],
                                            style: GoogleFonts.montserrat(
                                                decoration: TextDecoration.none,
                                                color: Colors.white,
                                                fontSize: 21,
                                                fontWeight: FontWeight.w600),
                                          ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    (lang.length != null &&
                                            lang.length != 0 &&
                                            userLanguage['gwei'] != null)
                                        ? "${userLanguage['sats']}"
                                        : "Gwei",
                                    style: GoogleFonts.poppins(
                                        decoration: TextDecoration.none,
                                        color: Colors.orange,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  // Padding(
                                  //   padding: const EdgeInsets.only(right: 10),
                                  //   child: ClipRRect(
                                  //     borderRadius: BorderRadius.circular(30),
                                  //     child: Container(
                                  //       height: 25,
                                  //       width: 25,
                                  //       color: blue1,
                                  //       child: Center(
                                  //         child: Icon(
                                  //           Icons.note_add_outlined,
                                  //           color: Colors.white,
                                  //           size: 12,
                                  //         ),
                                  //       ),
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 10, left: 25),
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
                            padding: const EdgeInsets.only(top: 10, right: 90),
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
                            padding: const EdgeInsets.only(top: 10, left: 25),
                            child: Container(
                              height: MediaQuery.of(context).size.width * 0.15,
                              width: MediaQuery.of(context).size.width * 0.41,
                              decoration: BoxDecoration(
                                  color: button,
                                  borderRadius: BorderRadius.circular(15)),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: loading == false
                                        ? Text(
                                            "START DATE",
                                            style: GoogleFonts.poppins(
                                                decoration: TextDecoration.none,
                                                color: Colors.white,
                                                fontSize: 13,
                                                fontWeight: FontWeight.w600),
                                          )
                                        : Text(
                                            startDate.toString(),
                                            style: GoogleFonts.poppins(
                                                decoration: TextDecoration.none,
                                                color: Colors.white,
                                                fontSize: 13,
                                                fontWeight: FontWeight.w600),
                                          ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10, left: 25),
                            child: Container(
                              height: MediaQuery.of(context).size.width * 0.15,
                              width: MediaQuery.of(context).size.width * 0.41,
                              decoration: BoxDecoration(
                                  color: button,
                                  borderRadius: BorderRadius.circular(15)),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 15),
                                    child: loading == false
                                        ? Text(
                                            "END DATE",
                                            style: GoogleFonts.poppins(
                                                decoration: TextDecoration.none,
                                                color: Colors.white,
                                                fontSize: 13,
                                                fontWeight: FontWeight.w600),
                                          )
                                        : Text(
                                            endDate.toString(),
                                            style: GoogleFonts.poppins(
                                                decoration: TextDecoration.none,
                                                color: Colors.white,
                                                fontSize: 13,
                                                fontWeight: FontWeight.w600),
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
                            padding: const EdgeInsets.only(top: 10, left: 25),
                            child: Text(
                              (lang.length != null &&
                                      lang.length != 0 &&
                                      userLanguage['typesofchallenge'] != null)
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
                            padding: const EdgeInsets.only(top: 10, left: 25),
                            child: Container(
                              height: MediaQuery.of(context).size.width * 0.15,
                              width: MediaQuery.of(context).size.width * 0.9,
                              decoration: BoxDecoration(
                                  color: button,
                                  borderRadius: BorderRadius.circular(15)),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 15),
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
                                                const EdgeInsets.only(left: 10),
                                            child: loading == false
                                                ? Text(
                                                    "TYPE & KM",
                                                    style: GoogleFonts.poppins(
                                                        decoration:
                                                            TextDecoration.none,
                                                        color: Colors.white,
                                                        fontSize: 13,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  )
                                                : Text(
                                                    challangedetail["type"] +
                                                        "  " +
                                                        challangedetail[
                                                            "totalKm"] +
                                                        "KM",
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
                                  // Padding(
                                  //   padding: const EdgeInsets.only(right: 25),
                                  //   child: ClipRRect(
                                  //     borderRadius: BorderRadius.circular(30),
                                  //     child: Container(
                                  //       height: 25,
                                  //       width: 25,
                                  //       color: blue1,
                                  //       child: Center(
                                  //         child: Icon(
                                  //           Icons.check,
                                  //           color: Colors.white,
                                  //           size: 11,
                                  //         ),
                                  //       ),
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
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 10, left: 25),
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
                            padding: const EdgeInsets.only(top: 10, left: 25),
                            child: Container(
                              height: MediaQuery.of(context).size.width * 0.15,
                              width: MediaQuery.of(context).size.width * 0.9,
                              decoration: BoxDecoration(
                                  color: button,
                                  borderRadius: BorderRadius.circular(15)),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 15),
                                    child: loading == false
                                        ? Text(
                                            "NO OF COMPETITORS",
                                            style: GoogleFonts.poppins(
                                                decoration: TextDecoration.none,
                                                color: Colors.white,
                                                fontSize: 13,
                                                fontWeight: FontWeight.w600),
                                          )
                                        : Text(
                                            challangedetail["totalCompetitors"],
                                            style: GoogleFonts.poppins(
                                                decoration: TextDecoration.none,
                                                color: Colors.white,
                                                fontSize: 21,
                                                fontWeight: FontWeight.w600),
                                          ),
                                  ),
                                  // Padding(
                                  //   padding: const EdgeInsets.only(right: 25),
                                  //   child: ClipRRect(
                                  //     borderRadius: BorderRadius.circular(30),
                                  //     child: Container(
                                  //       height: 25,
                                  //       width: 25,
                                  //       color: blue1,
                                  //       child: Center(
                                  //         child: Icon(
                                  //           Icons.group,
                                  //           color: Colors.white,
                                  //           size: 12,
                                  //         ),
                                  //       ),
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
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 10, left: 25),
                            child: Text(
                              "Status",
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
                            padding: const EdgeInsets.only(top: 10, left: 25),
                            child: Container(
                              height: MediaQuery.of(context).size.width * 0.15,
                              width: MediaQuery.of(context).size.width * 0.9,
                              decoration: BoxDecoration(
                                  color: button,
                                  borderRadius: BorderRadius.circular(15)),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 15),
                                    child: loading == false
                                        ? Text(
                                            "CURRENT STATUS",
                                            style: GoogleFonts.poppins(
                                                decoration: TextDecoration.none,
                                                color: Colors.white,
                                                fontSize: 13,
                                                fontWeight: FontWeight.w600),
                                          )
                                        : Text(
                                            difference == 1
                                                ? "Challenge ended yesterday"
                                                : difference > 0
                                                    ? "Challenge ended on ${endDate.toString()}"
                                                    : "Challenge ongoing now",
                                            style: GoogleFonts.poppins(
                                                decoration: TextDecoration.none,
                                                color: Colors.white,
                                                fontSize: 15,
                                                fontWeight: FontWeight.w600),
                                          ),
                                  ),
                                  // Padding(
                                  //   padding: const EdgeInsets.only(right: 25),
                                  //   child: ClipRRect(
                                  //     borderRadius: BorderRadius.circular(30),
                                  //     child: difference >= 0
                                  //         ? SizedBox(
                                  //             height: 0,
                                  //           )
                                  //         : Container(
                                  //             height: 25,
                                  //             width: 25,
                                  //             color: loading == false
                                  //                 ? blue1
                                  //                 : Colors.green,
                                  //             child: Center(
                                  //               child: Icon(
                                  //                 Icons.add_task_outlined,
                                  //                 color: Colors.white,
                                  //                 size: 10,
                                  //               ),
                                  //             ),
                                  //           ),
                                  //   ),
                                  // ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
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
                          loading == false
                              ? Text(
                                  "0",
                                  style: GoogleFonts.poppins(
                                      decoration: TextDecoration.none,
                                      color: Colors.orange,
                                      fontSize: 17,
                                      fontWeight: FontWeight.w600),
                                )
                              : Text(
                                  challangedetail["prize"].toString(),
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
                            "Gwei",
                            style: GoogleFonts.montserrat(
                                decoration: TextDecoration.none,
                                color: Colors.orange,
                                fontSize: 17,
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.01,
                      ),
                      winnerdetail.length == 0
                          ? SizedBox(
                              height: 0,
                            )
                          : Padding(
                              padding: EdgeInsets.only(left: 35),
                              child: Column(
                                children: [
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      "WINNERS",
                                      textAlign: TextAlign.left,
                                      style: GoogleFonts.montserrat(
                                          decoration: TextDecoration.none,
                                          color: Colors.orange,
                                          fontSize: 17,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                      SizedBox(height: 15),
                      ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        itemCount: winnerdetail.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return Container(
                            padding: EdgeInsets.only(left: 25, right: 10),
                            child: GestureDetector(
                              onTap: () {},
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        height: 59,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.9,
                                        decoration: BoxDecoration(
                                            color: white.withOpacity(0.1),
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
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
                                            Container(
                                              alignment: Alignment.centerLeft,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.4,
                                              child: FittedBox(
                                                fit: BoxFit.scaleDown,
                                                child: Text(
                                                  winnerdetail[index]
                                                      .winnerchallenge
                                                      .fullName,
                                                  style: GoogleFonts.poppins(
                                                    color: white,
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                  textAlign: TextAlign.left,
                                                ),
                                              ),
                                            ),
                                            Spacer(),
                                            Container(
                                              height: 33,
                                              width: 85,
                                              decoration: BoxDecoration(
                                                  color: Colors.white
                                                      .withOpacity(0.25),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          16)),
                                              child: Center(
                                                child: FittedBox(
                                                  fit: BoxFit.scaleDown,
                                                  child: Row(
                                                    children: [
                                                      Text(
                                                        winnerdetail[index]
                                                            .prize
                                                            .toString(),
                                                        style:
                                                            GoogleFonts.poppins(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600),
                                                      ),
                                                      Text(
                                                        " Gwei",
                                                        style:
                                                            GoogleFonts.poppins(
                                                                color: Colors
                                                                    .orangeAccent,
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(width: 15)
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 15)
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.01,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 35),
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "LEADERBOARD",
                                textAlign: TextAlign.left,
                                style: GoogleFonts.montserrat(
                                    decoration: TextDecoration.none,
                                    color: Colors.orange,
                                    fontSize: 17,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 15),
                      loading == false
                          ? SizedBox()
                          : mychallengesdetail.length == 0
                              ? Container(
                                  child: Center(
                                    child: Text(
                                      "NO AVAILABLE DATA",
                                      style: GoogleFonts.montserrat(
                                          decoration: TextDecoration.none,
                                          color: white,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                )
                              : ListView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  scrollDirection: Axis.vertical,
                                  itemCount: mychallengesdetail.length,
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    return Container(
                                      padding:
                                          EdgeInsets.only(left: 25, right: 10),
                                      child: GestureDetector(
                                        onTap: () {},
                                        child: Stack(
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    Container(
                                                      height: 59,
                                                      decoration: BoxDecoration(
                                                        color: myActivityColorList[
                                                            index %
                                                                myActivityColorList
                                                                    .length],
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20),
                                                      ),
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
                                                                  bottomLeft: Radius
                                                                      .circular(
                                                                          20),
                                                                  bottomRight: Radius
                                                                      .circular(
                                                                          25),
                                                                  topLeft: Radius
                                                                      .circular(
                                                                          20),
                                                                  topRight: Radius
                                                                      .circular(
                                                                          25)),
                                                            ),
                                                            child: Padding(
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      left: 10,
                                                                      right:
                                                                          10),
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  Text(
                                                                    mychallengesdetail[
                                                                            index]
                                                                        .challenge
                                                                        .fullName,
                                                                    style: GoogleFonts
                                                                        .poppins(
                                                                      color: Colors
                                                                          .black,
                                                                      fontSize:
                                                                          14,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                    ),
                                                                  ),
                                                                  Spacer(),
                                                                  Text(
                                                                    double.parse(mychallengesdetail[index].totalkm)
                                                                            .toStringAsFixed(2) +
                                                                        "KM",
                                                                    style: GoogleFonts
                                                                        .poppins(
                                                                      color: Colors
                                                                          .black,
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
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    right: 20),
                                                            child: Container(
                                                              height: 33,
                                                              width: 85,
                                                              decoration: BoxDecoration(
                                                                  color: Colors
                                                                      .white
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
                                                                        mychallengesdetail[index]
                                                                            .streakNo
                                                                            .toString(),
                                                                        style: GoogleFonts.poppins(
                                                                            color: Colors
                                                                                .white,
                                                                            fontSize:
                                                                                12,
                                                                            fontWeight:
                                                                                FontWeight.w600)),
                                                                  ),
                                                                  Text(
                                                                      " / " +
                                                                          challangedetail[
                                                                              'streakDays'],
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
                                              right: 0,
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
                                      ),
                                    );
                                  },
                                ),
                    ],
                  ),
                ),
                loading == false
                    ? Positioned(
                        top: MediaQuery.of(context).size.height * 0.25,
                        left: MediaQuery.of(context).size.width * 0.2,
                        // right: MediaQuery.of(context).size.width * 0.03,
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.24,
                          width: MediaQuery.of(context).size.width * 0.55,
                          decoration: BoxDecoration(
                              color: white.withOpacity(0.9),
                              borderRadius: BorderRadius.circular(24)),
                          child: Center(child: SpinKitRing(color: blue2)),
                        ),
                      )
                    : SizedBox(),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: joinchallenge == false && difference < 1
          ? GestureDetector(
              onTap: () {
                getUserLanguage();
                user[0]["googlefitenable"] == 1 ||
                        user[0]["healthfitenable"] == 1
                    ? joinChallenge(context, widget.challange)
                    : startBetting(context, widget.challange);
              },
              child: Container(
                margin:
                    EdgeInsets.only(bottom: 15, right: 25, left: 25, top: 25),
                width: MediaQuery.of(context).size.width * 0.2,
                height: MediaQuery.of(context).size.height * 0.07,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50), color: blue1),
                child: Center(
                  child: Text(
                    "Join Challenge",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                        color: white,
                        fontSize: 15,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            )
          : SizedBox(
              height: 0,
            ),
    );
  }

  void startBetting(BuildContext context, challenge) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return StatefulBuilder(
          // You need this, notice the parameters below:
          builder: (BuildContext context, StateSetter setState) {
            return Container(
              color: backgroundcolor.withOpacity(0.7),
              child: Column(
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
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text(
                          "BET Gwei",
                          style: GoogleFonts.poppins(
                            decoration: TextDecoration.none,
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  // Spacer(),
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        Center(
                          child: Container(
                              height: 200,
                              width: 200,
                              child: Image.asset("assets/images/toyface.png",
                                  fit: BoxFit.cover)),
                        ),
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
                              height: MediaQuery.of(context).size.height * 0.55,
                              width: MediaQuery.of(context).size.width,
                              padding: EdgeInsets.all(0),
                              child: Column(
                                children: [
                                  SizedBox(height: 20),
                                  Container(
                                      height: 4,
                                      width: 50,
                                      decoration: BoxDecoration(
                                          color: text1,
                                          borderRadius:
                                              BorderRadius.circular(15))),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  RichText(
                                      text: TextSpan(children: [
                                    TextSpan(
                                        text: (lang.length != null &&
                                                lang.length != 0 &&
                                                userLanguage['startbetting'] !=
                                                    null)
                                            ? "${userLanguage['startbetting']}"
                                            : 'Start betting',
                                        style: GoogleFonts.poppins(
                                          color: Colors.white,
                                          fontSize: 25,
                                          fontWeight: FontWeight.w600,
                                        )),
                                    TextSpan(
                                        text: (lang.length != null &&
                                                lang.length != 0 &&
                                                userLanguage['gwei'] != null)
                                            ? "${userLanguage['gwei']}"
                                            : ' Gwei ',
                                        style: GoogleFonts.montserrat(
                                          color: Colors.orange,
                                          fontSize: 25,
                                          fontWeight: FontWeight.w600,
                                        )),
                                  ])),
                                  // SizedBox(
                                  //   height: 20,
                                  // ),
                                  Text(
                                    (lang.length != null &&
                                            lang.length != 0 &&
                                            userLanguage[
                                                    'bettingisaseasyasabracadabrajustconnectyourfitnesstrackertobegin'] !=
                                                null)
                                        ? "${userLanguage['bettingisaseasyasabracadabrajustconnectyourfitnesstrackertobegin']}"
                                        : "Betting is as easy as abracadabra, just\n  connect your fitness tracker to begin",
                                    style: GoogleFonts.poppins(
                                      decoration: TextDecoration.none,
                                      color: text1,
                                      fontSize: 12,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 50,
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(),

                                    height: 55,
                                    width:
                                        MediaQuery.of(context).size.width * 0.6,

                                    decoration: BoxDecoration(
                                        color: button,
                                        borderRadius:
                                            BorderRadius.circular(30)),
                                    // ignore: deprecated_member_use
                                    child: GestureDetector(
                                      // shape: RoundedRectangleBorder(
                                      //   borderRadius: BorderRadius.circular(30),
                                      // ),
                                      // color: button,
                                      onTap: () {
                                        if (Platform.isAndroid) {
                                          Navigator.pop(context);
                                          if (user[0]["googlefitenable"] == 1) {
                                            joinChallenge(context, challenge);
                                          } else {
                                            gettoken();
                                            fetchData();
                                          }

                                          // Android-specific code
                                        } else if (Platform.isIOS) {
                                          // iOS-specific code
                                        }
                                      },
                                      child: Row(
                                        children: [
                                          Container(
                                            height: 50,
                                            width: 50,
                                            decoration: BoxDecoration(
                                                color: white,
                                                borderRadius:
                                                    BorderRadius.circular(100)),
                                            child: Image.asset(
                                              "assets/images/gfit.png",
                                            ),
                                          ),
                                          SizedBox(width: 20),
                                          Text(
                                            (lang.length != null &&
                                                    lang.length != 0 &&
                                                    userLanguage['googlefit'] !=
                                                        null)
                                                ? "${userLanguage['googlefit']}"
                                                : "GOOGLE FIT",
                                            style: GoogleFonts.poppins(
                                              //color: blue1,
                                              color: Colors.white,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Container(
                                    height: 55,
                                    width:
                                        MediaQuery.of(context).size.width * 0.6,

                                    decoration: BoxDecoration(
                                        color: button,
                                        borderRadius:
                                            BorderRadius.circular(30)),
                                    // ignore: deprecated_member_use
                                    child: GestureDetector(
                                      onTap: () {
                                        if (Platform.isIOS) {
                                          Navigator.pop(context);
                                          if (user[0]["healthfitenable"] == 1) {
                                            joinChallenge(context, challenge);
                                          } else {
                                            fetchData1();
                                          }
                                          // Android-specific code
                                        } else if (Platform.isAndroid) {
                                          // iOS-specific code
                                        }

                                        //

                                        // fetchData();
                                      },
                                      child: Row(
                                        children: [
                                          Container(
                                              height: 50,
                                              width: 50,
                                              decoration: BoxDecoration(
                                                  color: healthkitPink
                                                      .withOpacity(0.4),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          100)),
                                              child: Image.asset(
                                                "assets/images/ahkit.png",
                                              )),
                                          SizedBox(width: 20),
                                          Text(
                                            (lang.length != null &&
                                                    lang.length != 0 &&
                                                    userLanguage[
                                                            'applehealthkit'] !=
                                                        null)
                                                ? "${userLanguage['applehealthkit']}"
                                                : "APPLE HEALTH KIT",
                                            style: GoogleFonts.poppins(
                                              //color: blue1,
                                              color: Colors.white,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 15),
                                  InkWell(
                                    onTap: () {
                                      Navigator.pop(context);
                                      bettingGuide(context);
                                    },
                                    child: Text(
                                      (lang.length != null &&
                                              lang.length != 0 &&
                                              userLanguage['howdoesthiswork'] !=
                                                  null)
                                          ? "${userLanguage['howdoesthiswork']}"
                                          : "How does this work?",
                                      style: GoogleFonts.poppins(
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
                        ),
                        // SizedBox(
                        //   height: 30,
                        // ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  void bettingGuide(BuildContext context) {
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
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text(
                          (lang.length != null &&
                                  lang.length != 0 &&
                                  userLanguage['betsats'] != null)
                              ? "${userLanguage['betsats']}"
                              : "BET SATS",
                          style: GoogleFonts.poppins(
                            decoration: TextDecoration.none,
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
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
                        height: MediaQuery.of(context).size.height * 0.7,
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.all(0),
                        child: Column(
                          children: [
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.02),
                            Container(
                                height: 4,
                                width: 50,
                                decoration: BoxDecoration(
                                    color: spr,
                                    borderRadius: BorderRadius.circular(15))),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.02,
                            ),
                            Container(
                              height: MediaQuery.of(context).size.height * 0.19,
                              width: MediaQuery.of(context).size.width * 0.8,
                              decoration: BoxDecoration(
                                color: grey,
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.02,
                                  ),
                                  Container(
                                    height: 50,
                                    width: 50,
                                    //color: blue1,
                                    child: Image.asset(
                                      "assets/images/betTrophy.png",
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Text(
                                    (lang.length != null &&
                                            lang.length != 0 &&
                                            userLanguage['step'] != null)
                                        ? "${userLanguage['step']}"
                                        : "Step 1",
                                    style: GoogleFonts.poppins(
                                      fontSize: 25,
                                      fontWeight: FontWeight.w600,
                                      color: white,
                                    ),
                                  ),
                                  Text(
                                    (lang.length != null &&
                                            lang.length != 0 &&
                                            userLanguage[
                                                    'joinormakeachallengewithgwei'] !=
                                                null)
                                        ? "${userLanguage['joinormakeachallengewithgwei']}"
                                        : "Join or make a challenge with GWEI",
                                    style: GoogleFonts.poppins(
                                      fontSize: 12,
                                      color: white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.02,
                            ),
                            Container(
                              height: MediaQuery.of(context).size.height * 0.19,
                              width: MediaQuery.of(context).size.width * 0.8,
                              decoration: BoxDecoration(
                                color: grey,
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.02,
                                  ),
                                  Container(
                                    height: 50,
                                    width: 50,
                                    //color: blue1,
                                    child: Stack(
                                      children: [
                                        Image.asset(
                                          "assets/images/betRunboy.png",
                                          fit: BoxFit.cover,
                                        ),
                                        Positioned(
                                          left: 10,
                                          child: Image.asset(
                                            "assets/images/betRungirl.png",
                                            fit: BoxFit.cover,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Text(
                                    (lang.length != null &&
                                            lang.length != 0 &&
                                            userLanguage['step'] != null)
                                        ? "${userLanguage['step']}"
                                        : "Step 2",
                                    style: GoogleFonts.poppins(
                                      fontSize: 25,
                                      fontWeight: FontWeight.w600,
                                      color: white,
                                    ),
                                  ),
                                  Text(
                                    (lang.length != null &&
                                            lang.length != 0 &&
                                            userLanguage[
                                                    'completeawalkorrunchallenge'] !=
                                                null)
                                        ? "${userLanguage['completeawalkorrunchallenge']}"
                                        : "Complete a walk or run challenge",
                                    style: GoogleFonts.poppins(
                                      fontSize: 12,
                                      color: white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.02,
                            ),
                            GestureDetector(
                              onTap: () {
                                // Navigator.pop(context);
                                // notEnoughBalance(context);
                              },
                              child: Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.19,
                                width: MediaQuery.of(context).size.width * 0.8,
                                decoration: BoxDecoration(
                                  color: grey,
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: Column(
                                  children: [
                                    // SizedBox(
                                    //   height:
                                    //       MediaQuery.of(context).size.height *
                                    //           0.02,
                                    // ),
                                    Container(
                                      height: 50,
                                      width: 50,
                                      //color: blue1,
                                      child: Image.asset(
                                        "assets/images/spendingcoin.png",
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Text(
                                      (lang.length != null &&
                                              lang.length != 0 &&
                                              userLanguage['step'] != null)
                                          ? "${userLanguage['step']}"
                                          : "Step 3",
                                      style: GoogleFonts.poppins(
                                        fontSize: 25,
                                        fontWeight: FontWeight.w600,
                                        color: white,
                                      ),
                                    ),
                                    Text(
                                      (lang.length != null &&
                                              lang.length != 0 &&
                                              userLanguage['winandgetpaid'] !=
                                                  null)
                                          ? "${userLanguage['winandgetpaid']}"
                                          : "Win and get paid!",
                                      style: GoogleFonts.poppins(
                                        fontSize: 12,
                                        color: white,
                                      ),
                                    ),
                                    Text(
                                      (lang.length != null &&
                                              lang.length != 0 &&
                                              userLanguage[
                                                      'orloseandtryagain)'] !=
                                                  null)
                                          ? "${userLanguage['orloseandtryagain']}"
                                          : "(Or lose and try again!)",
                                      style: GoogleFonts.poppins(
                                        fontSize: 12,
                                        color: white,
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

  void notEnoughBalance(BuildContext context) {
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
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => Tabscreen(
                                    index: 2,
                                  ),
                                ),
                              );
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
                      ],
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.8,
                      width: MediaQuery.of(context).size.width * 0.85,
                      //color: Colors.red,
                      child: Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 140),
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.5,
                              width: MediaQuery.of(context).size.width * 0.85,
                              decoration: BoxDecoration(
                                color: backgroundcolor,
                                borderRadius: BorderRadius.circular(25),
                              ),
                              child: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.14),
                                    RichText(
                                      text: TextSpan(
                                        children: [
                                          TextSpan(
                                              text: (lang.length != null &&
                                                      lang.length != 0 &&
                                                      userLanguage[
                                                              'sorryyoudonthaveenough'] !=
                                                          null)
                                                  ? "${userLanguage['sorryyoudonthaveenough']}"
                                                  : '   Sorry, you don’t \nhave enough',
                                              style: GoogleFonts.poppins(
                                                color: Colors.white,
                                                fontSize: 25,
                                                fontWeight: FontWeight.w600,
                                              )),
                                          TextSpan(
                                              text: (lang.length != null &&
                                                      lang.length != 0 &&
                                                      userLanguage['sats'] !=
                                                          null)
                                                  ? "${userLanguage['sats']}"
                                                  : ' Gwei ',
                                              style: GoogleFonts.montserrat(
                                                color: Colors.orange,
                                                fontSize: 25,
                                                fontWeight: FontWeight.w700,
                                              )),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.02,
                                    ),
                                    Text(
                                      (lang.length != null &&
                                              lang.length != 0 &&
                                              userLanguage[
                                                      'eitherkeepmakingpurchasesordepositfundsintoyourwallet'] !=
                                                  null)
                                          ? "${userLanguage['eitherkeepmakingpurchasesordepositfundsintoyourwallet']}"
                                          : "Either keep making purchases or   \ndeposit funds into your wallet!",
                                      style: GoogleFonts.poppins(
                                        color: text1,
                                        fontSize: 14,
                                      ),
                                    ),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.02,
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
                                          onPressed: () {},
                                          color: blue2,
                                          child: Text(
                                            (lang.length != null &&
                                                    lang.length != 0 &&
                                                    userLanguage['deposit'] !=
                                                        null)
                                                ? "${userLanguage['deposit']}"
                                                : "Deposit",
                                            style: GoogleFonts.poppins(
                                              color: white,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          )),
                                    ),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.025,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                            builder: (_) => Tabscreen(
                                              index: 2,
                                            ),
                                          ),
                                        );
                                      },
                                      child: Text(
                                        (lang.length != null &&
                                                lang.length != 0 &&
                                                userLanguage['goback'] != null)
                                            ? "${userLanguage['cancel']}"
                                            : "Go BACK",
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
                            left: MediaQuery.of(context).size.width * 0.04,
                            child: Image.asset("assets/images/notEnough1.png"),
                          ),
                          Positioned(
                            top: MediaQuery.of(context).size.height * 0,
                            left: MediaQuery.of(context).size.width * 0.04,
                            child: Image.asset("assets/images/notEnough.png"),
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

  void joinChallenge(BuildContext context, chall) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return StatefulBuilder(
          // You need this, notice the parameters below:
          builder: (BuildContext context, StateSetter setState) {
            return Scaffold(
              backgroundColor: backgroundcolor.withOpacity(0.4),
              appBar: AppBar(
                brightness: Brightness.light,
                backgroundColor: backgroundcolor.withOpacity(0.4),
                leading: Card(
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
              ),
              body: SingleChildScrollView(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  color: backgroundcolor.withOpacity(0.4),
                  margin: EdgeInsets.only(top: 0, left: 0, bottom: 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        // height: MediaQuery.of(context).size.height * 0.8,
                        width: MediaQuery.of(context).size.width * 0.85,

                        child: Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 140),
                              child: Container(
                                alignment: Alignment.center,
                                // height:
                                //     MediaQuery.of(context).size.height * 0.7,
                                width: MediaQuery.of(context).size.width * 0.85,
                                decoration: BoxDecoration(
                                  color: backgroundcolor,
                                  borderRadius: BorderRadius.circular(25),
                                ),
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
                                    FittedBox(
                                      fit: BoxFit.scaleDown,
                                      child: Text(
                                        "${chall.prize} Gwei",
                                        style: GoogleFonts.montserrat(
                                          decoration: TextDecoration.none,
                                          color: Colors.orange,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600,
                                        ),
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
                                            JoinChallenges(
                                              user[0]["uid"],
                                              chall.id,
                                            );
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
                            Positioned(
                              top: 0,
                              left: MediaQuery.of(context).size.width * 0.03,
                              child: Image.asset("assets/images/jc1.png"),
                            ),
                            Positioned(
                              top: MediaQuery.of(context).size.height * 0.055,
                              left: MediaQuery.of(context).size.width * 0.065,
                              child: Image.asset("assets/images/jc2.png"),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  void challengeAccepted(BuildContext context) {
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
                                              Navigator.pushReplacement(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (BuildContext
                                                              context) =>
                                                          this.widget));
                                            },
                                            color: blue2,
                                            child: Text(
                                              (lang.length != null &&
                                                      lang.length != 0 &&
                                                      userLanguage[
                                                              'viewchallenges'] !=
                                                          null)
                                                  ? "${userLanguage['viewchallenges']}"
                                                  : "View Challenge",
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
                                          Navigator.pop(context, false);
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
