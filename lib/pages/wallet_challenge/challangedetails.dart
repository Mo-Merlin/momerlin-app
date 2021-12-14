import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:momerlin/data/localstorage/userdata_source.dart';
import 'package:momerlin/data/userrepository.dart';
// import 'package:momerlin/tabscreen/tabscreen.dart';
import 'package:momerlin/theme/theme.dart';

class Challengesdetail extends StatefulWidget {
  final bool focus;
  final challange;
  const Challengesdetail({Key key, this.challange, this.focus})
      : super(key: key);

  @override
  _ChallengesdetailState createState() => _ChallengesdetailState();
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

class _ChallengesdetailState extends State<Challengesdetail> {
  var userLanguage, user, lang = [];
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
    // print(widget.challange);
    super.initState();
    getwinnerChallenges(widget.challange);
    getUserLanguage();
  }

  var difference = 0;
  Map<String, dynamic> challangedetail;
  var startDate;
  var endDate;
  Future<void> getwinnerChallenges(challangeid) async {
    var res = await UserRepository().getwinnerChallenges(challangeid);
    // print("USER ID :" + user[0]["uid"]);
    // print(res["leaders"]);
    if (res["success"] == true) {
      setState(() {
        loading = true;
      });

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
      final date2 = DateTime.now();
      difference = date2.difference(endat).inDays;
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
    // print("PAVIMANO12 $res");
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
  List<Color> myActivityColorList = [
    containerGreen,
    spendingPink,
    containerOrange,
  ];
  bool refresh = false;
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
                    Navigator.pop(context, refresh);
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
                                // mainAxisAlignment:
                                //     MainAxisAlignment.spaceBetween,
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
                                  SizedBox(width: 10),
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
                                  //          child: Icon(
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
                                                : difference >= 0
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
                                  //     child: Container(
                                  //       height: 25,
                                  //       width: 25,
                                  //       color: loading == false
                                  //           ? blue1
                                  //           : difference >= 0
                                  //               ? Colors.redAccent
                                  //               : Colors.green,
                                  //       child: IconButton(
                                  //         onPressed: () {},
                                  //         icon: Icon(
                                  //           difference >= 0
                                  //               ? Icons.check
                                  //               : Icons.add_task_outlined,
                                  //           color: Colors.white,
                                  //           size: 10,
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
                        ))
                    : SizedBox(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
