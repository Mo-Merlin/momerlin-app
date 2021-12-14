import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:health/health.dart';
import 'package:momerlin/data/localstorage/userdata_source.dart';
import 'package:momerlin/data/userrepository.dart';
import 'package:momerlin/theme/theme.dart';
// import 'package:table_calendar/table_calendar.dart';

import 'challangedetails.dart';

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

class MyActivity extends StatefulWidget {
  const MyActivity({Key key}) : super(key: key);

  @override
  _MyActivityState createState() => _MyActivityState();
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

enum AppState {
  DATA_NOT_FETCHED,
  FETCHING_DATA,
  DATA_READY,
  NO_DATA,
  AUTH_NOT_GRANTED
}

class _MyActivityState extends State<MyActivity> {
  // ignore: unused_field
  // CalendarController _controller;

  List<JoingetChallenges> joingetchallenge = [];
  bool loading = true;
  var userLanguage, user, lang = [];
  @override
  void initState() {
    super.initState();
    getUserLanguage();
    // _controller = CalendarController();
  }

  // ignore: todo
  //TODO :languagestart
  Future<void> getUserLanguage() async {
    lang = await UserDataSource().getLanguage();
    user = await UserDataSource().getUser();
    if (lang.length != null && lang.length != 0) {
      userLanguage = lang[0];
    }

    if (user[0]["googlefitenable"] == 1) {
      // fetchData();

      gettoken();
    } else if (user[0]["healthfitenable"] == 1) {
      fetchData1();
    } else {
      getjoinChallenges();
    }
  }

  num steps1 = 0;
  num distance = 0;
  List<HealthDataPoint> _healthDataList = [];
  // ignore: unused_field
  AppState _state = AppState.DATA_NOT_FETCHED;
  DateTime now = DateTime.now();
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

  var token;
  Future<void> gettoken() async {
    try {
      final result = await _googleSignIn.signIn();
      final ggAuth = await result.authentication;
      token = ggAuth.accessToken;
      // getmyChallenges();
      getjoinChallenges();
    } catch (error) {
      print(error);
    }
  }

  // ignore: todo
  //TODO: LanguageEnd

  Future<void> getjoinChallenges() async {
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

  List<Color> myActivityColorList = [
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
                  userLanguage['myactivity'] != null)
              ? "${userLanguage['myactivity']}"
              : "MY ACTIVITY",
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
//           Container(
//             decoration: BoxDecoration(
//               color: gridcolor,
//               borderRadius: BorderRadius.circular(30),
//             ),
//             child: Column(
//               children: [
//                 SizedBox(
//                   height: 10,
//                 ),
//                 Padding(
//                   padding: EdgeInsets.only(
//                     left: 10,
//                     top: 10,
//                     right: 110,
//                   ),
//                   child: Container(
//                     height: 33,
//                     decoration: BoxDecoration(
//                       color: button,
//                       borderRadius: BorderRadius.circular(15),
//                     ),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       children: [
//                         Expanded(
//                           child: Row(
//                             children: [
//                               Radio(
//                                 value: 1,
//                                 groupValue: val,
//                                 onChanged: (value) {
//                                   setState(() {
//                                     val = value;
//                                   });
//                                 },
//                                 activeColor: blue1,
//                               ),
//                               Expanded(
//                                 child: Text(
//                                   'Active Days',
//                                   style: GoogleFonts.poppins(
//                                     color: Colors.white,
//                                     fontSize: 12,
//                                     fontWeight: FontWeight.w400,
//                                   ),
//                                 ),
//                               )
//                             ],
//                           ),
//                         ),
//                         Expanded(
//                           child: Row(
//                             children: [
//                               Radio(
//                                 value: 2,
//                                 groupValue: val,
//                                 onChanged: (value) {
//                                   setState(() {
//                                     val = value;
//                                   });
//                                 },
//                                 activeColor: blue1,
//                               ),
//                               Expanded(
//                                   child: Text(
//                                 'Present Days',
//                                 style: GoogleFonts.poppins(
//                                   color: Colors.white,
//                                   fontSize: 12,
//                                   fontWeight: FontWeight.w400,
//                                 ),
//                               ))
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(left: 15, right: 15),
//                   child: TableCalendar(
//                     calendarController: _controller,
//                     initialCalendarFormat: CalendarFormat.month,
//                     calendarStyle: CalendarStyle(
//                       todayColor: blue1,
//                       selectedColor: blue,
//                       weekdayStyle:
//                           GoogleFonts.montserrat(fontSize: 12, color: text1),
//                       weekendStyle:
//                           GoogleFonts.montserrat(fontSize: 12, color: text1),
//                       holidayStyle:
//                           GoogleFonts.montserrat(fontSize: 12, color: text1),
//                       outsideHolidayStyle:
//                           GoogleFonts.montserrat(fontSize: 12, color: text1),
//                       unavailableStyle: const TextStyle(color: Colors.white),
//                       todayStyle: GoogleFonts.montserrat(
//                         fontSize: 12,
//                         color: Colors.white,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                     headerVisible: false,
//                     // headerStyle: HeaderStyle(
//                     //   centerHeaderTitle: true,
//                     //   formatButtonDecoration: BoxDecoration(
//                     //     color: Colors.brown,
//                     //     borderRadius: BorderRadius.circular(22.0),
//                     //   ),
//                     //   formatButtonTextStyle: TextStyle(color: Colors.white),
//                     //   formatButtonShowsNext: false,
//                     // ),
//                     startingDayOfWeek: StartingDayOfWeek.sunday,
//                     builders: CalendarBuilders(
//                       // dayBuilder: (context, date, events) => Container(
//                       //   height: 55,
//                       //   width: 55,
//                       //   margin: const EdgeInsets.all(8.0),
//                       //   alignment: Alignment.center,
//                       //   decoration: BoxDecoration(
//                       //       color: blue.withOpacity(0.3),
//                       //       borderRadius: BorderRadius.circular(10.0)),
//                       //   child: Text(
//                       //     date.day.toString(),
//                       //     style: TextStyle(color: Colors.black),
//                       //   )),
//                       unavailableDayBuilder: (context, date, events) =>
//                           Container(
//                         margin: const EdgeInsets.all(5.0),
//                         alignment: Alignment.center,
//                         child: Text(
//                           date.day.toString(),
//                           style: TextStyle(color: Colors.white),
//                         ),
//                       ),
// //                         unavailableDayBuilder: (context, date, events) => Container(
// //                        margin: const EdgeInsets.all(5.0),
// //                           alignment: Alignment.center,
// //                           decoration: BoxDecoration(
// //                               color: blue,
// //                               borderRadius: BorderRadius.circular(22)),
// //                           child: Text(
// //                             date.day.toString(),
// //                             style: TextStyle(color: Colors.white),
// //                           ),),
//                       selectedDayBuilder: (context, date, events) => Container(
//                           margin: const EdgeInsets.all(5.0),
//                           alignment: Alignment.center,
//                           decoration: BoxDecoration(
//                               color: blue,
//                               borderRadius: BorderRadius.circular(22)),
//                           child: Text(
//                             date.day.toString(),
//                             style: TextStyle(color: Colors.white),
//                           )),
//                       todayDayBuilder: (context, date, events) => Container(
//                         margin: const EdgeInsets.all(5.0),
//                         alignment: Alignment.center,
//                         decoration: BoxDecoration(
//                             color: blue1,
//                             borderRadius: BorderRadius.circular(22)),
//                         child: Text(
//                           date.day.toString(),
//                           style: TextStyle(color: Colors.white),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
          // SizedBox(
          //   height: 20,
          // ),
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
          SizedBox(
            height: 5,
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
              : joingetchallenge.length == 0
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
                              itemCount: joingetchallenge.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    // print(joingetchallenge[index]);
                                    // getwinnerChallenges(
                                    //     joingetchallenge[index].id);
                                    // challangedetails(context,3
                                    //     joingetchallenge[index]);
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                Challengesdetail(
                                                    challange:
                                                        joingetchallenge[index]
                                                            .challenge
                                                            .id)));
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
                                                    color: myActivityColorList[
                                                        index %
                                                            myActivityColorList
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
                                                              0.52,
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
                                                              joingetchallenge[
                                                                          index]
                                                                      .challenge
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
                                                              joingetchallenge[
                                                                              index]
                                                                          .challenge
                                                                          .totalKm ==
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
                                                              joingetchallenge[
                                                                      index]
                                                                  .challenge
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
                                                            Container(
                                                              child: FittedBox(
                                                                fit: BoxFit
                                                                    .scaleDown,
                                                                child: Text(
                                                                  " (" +
                                                                      double.parse(joingetchallenge[index]
                                                                              .totalkm)
                                                                          .toStringAsFixed(
                                                                              2) +
                                                                      "KM)",
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
                                                            Text("DAY",
                                                                style: GoogleFonts.poppins(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        12,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600)),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      left: 5),
                                                              child: Text(
                                                                  joingetchallenge[
                                                                          index]
                                                                      .streakNo
                                                                      .toString(),
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
                                                                " / " +
                                                                    joingetchallenge[
                                                                            index]
                                                                        .challenge
                                                                        .streakDays
                                                                        .toString(),
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
}
