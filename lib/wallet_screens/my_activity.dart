import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:momerlin/data/localstorage/userdata_source.dart';
import 'package:momerlin/data/userrepository.dart';
import 'package:momerlin/theme/theme.dart';
import 'package:table_calendar/table_calendar.dart';

class JoingetChallenges {
  var mode;
  var type;
  var totalCompetitors;
  var streakDays;
  var totalKm;
  var wage;
  var id;

  JoingetChallenges({
    this.mode,
    this.type,
    this.totalCompetitors,
    this.streakDays,
    this.totalKm,
    this.wage,
    this.id,
  });

  factory JoingetChallenges.fromJson(Map<String, dynamic> json) =>
      JoingetChallenges(
        mode: json["mode"] == null ? null : json["mode"],
        type: json["type"],
        totalCompetitors: json["totalCompetitors"],
        streakDays: json["streakDays"],
        totalKm: json["totalKm"],
        wage: json["wage"],
        id: json["_id"],
      );
}

class MyActivity extends StatefulWidget {
  const MyActivity({Key key}) : super(key: key);

  @override
  _MyActivityState createState() => _MyActivityState();
}

class _MyActivityState extends State<MyActivity> {
  CalendarController _controller;

  List<JoingetChallenges> joingetchallenge = [];
  bool loading = true;
  var userLanguage, user, lang = [];
  @override
  void initState() {
    super.initState();
    getjoinChallenges();
    getUserLanguage();
    _controller = CalendarController();
  }

  // ignore: todo
  //TODO :languagestart
  Future<void> getUserLanguage() async {
    lang = await UserDataSource().getLanguage();
    user = await UserDataSource().getUser();
    if (lang.length != null && lang.length != 0) {
      userLanguage = lang[0];
    }
    getjoinChallenges();
  }

  // ignore: todo
  //TODO: LanguageEnd

  Future<void> getjoinChallenges() async {
    setState(() {
      loading = false;
    });
    var res = await UserRepository().joingetchallenge(user[0]["uid"]);

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

  List elementsOne = [
    {
      "name": "5KM RUN STREAK",
      "url":
          "https://www.pngitem.com/pimgs/m/78-786293_1240-x-1240-0-avatar-profile-icon-png.png",
      "amt": "DAY",
      "type": "5/7",
      "trophys": "trophy3"
    },
    {
      "name": "5KM WALK STREAK",
      "url":
          "https://cdn.imgbin.com/1/8/12/imgbin-computer-icons-user-profile-avatar-woman-business-woman-2x9qVDw4EgxX299EhCLm9fN89.jpg",
      "amt": "DAY",
      "type": "5/7",
      "trophys": "trophy2"
    },
    {
      "name": "INSERT CHALLENGE THREE",
      "url":
          "https://www.clipartmax.com/png/middle/171-1717870_stockvader-predicted-cron-for-may-user-profile-icon-png.png",
      "amt": "DAY",
      "type": "1/7",
      "trophys": "trophy1"
    },
    {
      "name": "5KM RUN STREAK",
      "url":
          "https://www.pngitem.com/pimgs/m/78-786293_1240-x-1240-0-avatar-profile-icon-png.png",
      "amt": "DAY",
      "type": "6/7",
      "trophys": "trophy3"
    },
    {
      "name": "3KM RUN STREAK",
      "url":
          "https://cdn.imgbin.com/1/8/12/imgbin-computer-icons-user-profile-avatar-woman-business-woman-2x9qVDw4EgxX299EhCLm9fN89.jpg",
      "amt": "DAY",
      "type": "2/7",
      "trophys": "trophy2"
    },
    {
      "name": "1KM WALK STREAK",
      "url":
          "https://www.clipartmax.com/png/middle/171-1717870_stockvader-predicted-cron-for-may-user-profile-icon-png.png",
      "amt": "DAY",
      "type": "3/7",
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

  List<Color> colorList = [
    blue1,
    Colors.greenAccent,
    Colors.orangeAccent,
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
          Container(
            decoration: BoxDecoration(
              color: gridcolor,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: 10,
                    top: 10,
                    right: 110,
                  ),
                  child: Container(
                    height: 33,
                    decoration: BoxDecoration(
                      color: button,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              Radio(
                                value: 1,
                                groupValue: val,
                                onChanged: (value) {
                                  setState(() {
                                    val = value;
                                  });
                                },
                                activeColor: blue1,
                              ),
                              Expanded(
                                child: Text(
                                  'Active Days',
                                  style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Expanded(
                          child: Row(
                            children: [
                              Radio(
                                value: 2,
                                groupValue: val,
                                onChanged: (value) {
                                  setState(() {
                                    val = value;
                                  });
                                },
                                activeColor: blue1,
                              ),
                              Expanded(
                                  child: Text(
                                'Present Days',
                                style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                ),
                              ))
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  child: TableCalendar(
                    calendarController: _controller,
                    initialCalendarFormat: CalendarFormat.month,
                    calendarStyle: CalendarStyle(
                      todayColor: blue1,
                      selectedColor: blue,
                      weekdayStyle:
                          GoogleFonts.montserrat(fontSize: 12, color: text1),
                      weekendStyle:
                          GoogleFonts.montserrat(fontSize: 12, color: text1),
                      holidayStyle:
                          GoogleFonts.montserrat(fontSize: 12, color: text1),
                      outsideHolidayStyle:
                          GoogleFonts.montserrat(fontSize: 12, color: text1),
                      unavailableStyle: const TextStyle(color: Colors.white),
                      todayStyle: GoogleFonts.montserrat(
                        fontSize: 12,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    headerVisible: false,
                    // headerStyle: HeaderStyle(
                    //   centerHeaderTitle: true,
                    //   formatButtonDecoration: BoxDecoration(
                    //     color: Colors.brown,
                    //     borderRadius: BorderRadius.circular(22.0),
                    //   ),
                    //   formatButtonTextStyle: TextStyle(color: Colors.white),
                    //   formatButtonShowsNext: false,
                    // ),
                    startingDayOfWeek: StartingDayOfWeek.sunday,
                    builders: CalendarBuilders(
                      // dayBuilder: (context, date, events) => Container(
                      //   height: 55,
                      //   width: 55,
                      //   margin: const EdgeInsets.all(8.0),
                      //   alignment: Alignment.center,
                      //   decoration: BoxDecoration(
                      //       color: blue.withOpacity(0.3),
                      //       borderRadius: BorderRadius.circular(10.0)),
                      //   child: Text(
                      //     date.day.toString(),
                      //     style: TextStyle(color: Colors.black),
                      //   )),
                      unavailableDayBuilder: (context, date, events) =>
                          Container(
                        margin: const EdgeInsets.all(5.0),
                        alignment: Alignment.center,
                        child: Text(
                          date.day.toString(),
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
//                         unavailableDayBuilder: (context, date, events) => Container(
//                        margin: const EdgeInsets.all(5.0),
//                           alignment: Alignment.center,
//                           decoration: BoxDecoration(
//                               color: blue,
//                               borderRadius: BorderRadius.circular(22)),
//                           child: Text(
//                             date.day.toString(),
//                             style: TextStyle(color: Colors.white),
//                           ),),
                      selectedDayBuilder: (context, date, events) => Container(
                          margin: const EdgeInsets.all(5.0),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: blue,
                              borderRadius: BorderRadius.circular(22)),
                          child: Text(
                            date.day.toString(),
                            style: TextStyle(color: Colors.white),
                          )),
                      todayDayBuilder: (context, date, events) => Container(
                        margin: const EdgeInsets.all(5.0),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: blue1,
                            borderRadius: BorderRadius.circular(22)),
                        child: Text(
                          date.day.toString(),
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30),
            child: Text(
              (lang.length != null &&
                      lang.length != 0 &&
                      userLanguage['currentchallenges'] != null)
                  ? "${userLanguage['currentchallenges']}"
                  : "CURRENT CHALLENGES",
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          SizedBox(
            height: 5,
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
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.8,
                                              decoration: BoxDecoration(
                                                  color: colorList[
                                                      index % colorList.length],
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
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Text(
                                                            joingetchallenge[
                                                                        index]
                                                                    .totalKm +
                                                                "KM ",
                                                            style: GoogleFonts
                                                                .poppins(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                            ),
                                                          ),
                                                          Text(
                                                            joingetchallenge[
                                                                            index]
                                                                        .mode ==
                                                                    "Walking"
                                                                ? "WALK "
                                                                : "RUN ",
                                                            style: GoogleFonts
                                                                .poppins(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                            ),
                                                          ),
                                                          Text(
                                                            joingetchallenge[
                                                                    index]
                                                                .type
                                                                .toUpperCase(),
                                                            style: GoogleFonts
                                                                .poppins(
                                                              color:
                                                                  Colors.black,
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
                                                                day[index %
                                                                    day.length],
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
                                        child: trophy[index % trophy.length],
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
