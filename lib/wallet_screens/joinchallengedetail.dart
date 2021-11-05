import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:momerlin/data/localstorage/userdata_source.dart';
import 'package:momerlin/data/userrepository.dart';
import 'package:momerlin/tabscreen/tabscreen.dart';
import 'package:momerlin/theme/theme.dart';

class JoinChallengesdetail extends StatefulWidget {
  final challange;
  const JoinChallengesdetail({Key key, this.challange}) : super(key: key);

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
  Getwinnerchallenge winnerchallenge;
  WinnerDetails({
    this.totalkm,
    this.streakNo,
    this.winnerchallenge,
  });

  factory WinnerDetails.fromJson(Map<String, dynamic> json) => WinnerDetails(
        totalkm: json["totalkm"] == null ? null : json["totalkm"],
        streakNo: json["streakNo"],
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

class _JoinChallengesdetail extends State<JoinChallengesdetail> {
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
    print(widget.challange.id);
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
    print("Joinchallange $joinchallange");
    if (joinchallange == false) {
      Scaffold.of(context)
          // ignore: deprecated_member_use
          .showSnackBar(SnackBar(
        content: Text('No Internet Connection'),
        backgroundColor: Colors.red,
      ));
    } else {
      if (joinchallange["success"] == true) {
        challengeAccepted(context);
      } else {
        Scaffold.of(context)
            // ignore: deprecated_member_use
            .showSnackBar(
          SnackBar(
            content: Text(joinchallange["error"]),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
    print("user $joinchallange");
  }

  var joinchallenge = false;
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
      print("PAVITHRAMANOHARAN");
      print(res["challenge"]["competitors"]);
      for (var i = 0; i < res["challenge"]["competitors"].length; i++) {
        if (user[0]["uid"] == res["challenge"]["competitors"][i]["userId"]) {
          joinchallenge = true;
        } else {
          joinchallenge = false;
        }
      }
      for (var i = 0; i < res["leaders"].length; i++) {
        // print("pavimno");
        // print(res["leaders"][i]);
        mychallengesdetail.add(MyChallengesDetail.fromJson(res["leaders"][i]));
      }
      for (var i = 0; i < res["winners"].length; i++) {
        // print("pavimno");
        // print(res["leaders"][i]);
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
  List<Color> myActivityColorList = [
    containerGreen,
    spendingPink,
    containerOrange,
  ];

  @override
  Widget build(BuildContext context) {
    return loading == false
        ? Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: white,
            child: Center(
              child: SpinKitSpinningLines(
                color: backgroundcolor,
                size: 60,
              ),
            ),
          )
        : Scaffold(
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
                                      )));
                        },
                        icon: Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                        )),
                  ),
                ),
              ),
              title: Text(
                "Challenge Detail".toUpperCase(),
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
              child: SingleChildScrollView(
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
                                      challangedetail['mode'] == "Walking"
                                          ? "assets/images/walking.png"
                                          : "assets/images/running.png",
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Text(
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 15),
                                  child: Text(
                                    challangedetail["wage"],
                                    style: GoogleFonts.montserrat(
                                        decoration: TextDecoration.none,
                                        color: Colors.white,
                                        fontSize: 21,
                                        fontWeight: FontWeight.w600),
                                  ),
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
                                Padding(
                                  padding: const EdgeInsets.only(right: 10),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(30),
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
                                  child: Text(
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 15),
                                  child: Text(
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                          child: Text(
                                            challangedetail["type"] +
                                                "  " +
                                                challangedetail["totalKm"] +
                                                "KM",
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
                                  padding: const EdgeInsets.only(right: 25),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(30),
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
                                        ),
                                      ),
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 15),
                                  child: Text(
                                    challangedetail["totalCompetitors"],
                                    style: GoogleFonts.poppins(
                                        decoration: TextDecoration.none,
                                        color: Colors.white,
                                        fontSize: 21,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 25),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(30),
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
                                        ),
                                      ),
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
                        Text(
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
                      height: MediaQuery.of(context).size.height * 0.03,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.03,
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
                    mychallengesdetail.length == 0
                        ? Container(
                            child: Text(
                              "No Available Data",
                              style: GoogleFonts.montserrat(
                                  decoration: TextDecoration.none,
                                  color: white,
                                  fontSize: 17,
                                  fontWeight: FontWeight.w600),
                            ),
                          )
                        : ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            itemCount: mychallengesdetail.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {},
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
                                                  0.83,
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
                                                            0.6,
                                                    decoration: BoxDecoration(
                                                      color: Colors.white
                                                          .withOpacity(0.2),
                                                      borderRadius:
                                                          BorderRadius.only(
                                                              bottomLeft: Radius
                                                                  .circular(15),
                                                              bottomRight:
                                                                  Radius
                                                                      .circular(
                                                                          25),
                                                              topLeft: Radius
                                                                  .circular(15),
                                                              topRight: Radius
                                                                  .circular(
                                                                      25)),
                                                    ),
                                                    child: Padding(
                                                      padding: EdgeInsets.only(
                                                          left: 10, right: 10),
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
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                            ),
                                                          ),
                                                          Spacer(),
                                                          Text(
                                                            double.parse(mychallengesdetail[
                                                                            index]
                                                                        .totalkm)
                                                                    .toStringAsFixed(
                                                                        2) +
                                                                "KM",
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
                                                            right: 0),
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
                                                          Text(
                                                            "DAY",
                                                            style: GoogleFonts
                                                                .poppins(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 5),
                                                            child: Text(
                                                              mychallengesdetail[
                                                                      index]
                                                                  .streakNo
                                                                  .toString(),
                                                              style: GoogleFonts
                                                                  .poppins(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                              ),
                                                            ),
                                                          ),
                                                          Text(
                                                            " / " +
                                                                challangedetail[
                                                                    'streakDays'],
                                                            style: GoogleFonts
                                                                .poppins(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                            ),
                                                          ),
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
                                      right: 20,
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
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.03,
                    ),
                    winnerdetail.length == 0
                        ? SizedBox(
                            height: MediaQuery.of(context).size.height * 0.03,
                          )
                        : Padding(
                            padding: EdgeInsets.only(left: 35),
                            child: Column(
                              children: [
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    "Winner Details",
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
                        return GestureDetector(
                          onTap: () {},
                          child: Stack(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: 15,
                                      ),
                                      Container(
                                        height: 59,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.83,
                                        decoration: BoxDecoration(
                                            color: myActivityColorList[index %
                                                myActivityColorList.length],
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              height: 59,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.6,
                                              decoration: BoxDecoration(
                                                color: Colors.white
                                                    .withOpacity(0.2),
                                                borderRadius: BorderRadius.only(
                                                    bottomLeft:
                                                        Radius.circular(15),
                                                    bottomRight:
                                                        Radius.circular(25),
                                                    topLeft:
                                                        Radius.circular(15),
                                                    topRight:
                                                        Radius.circular(25)),
                                              ),
                                              child: Center(
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      challangedetail[
                                                              "totalKm"] +
                                                          "KM ",
                                                      style:
                                                          GoogleFonts.poppins(
                                                        color: Colors.black,
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                    ),
                                                    Text(
                                                      challangedetail['mode'] ==
                                                              "Walking"
                                                          ? "Walk"
                                                          : "Run",
                                                      style:
                                                          GoogleFonts.poppins(
                                                        color: Colors.black,
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                    ),
                                                    Text(
                                                      challangedetail['type'],
                                                      style:
                                                          GoogleFonts.poppins(
                                                        color: Colors.black,
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                    ),
                                                    Text(
                                                      " (" +
                                                          double.parse(
                                                                  winnerdetail[
                                                                          index]
                                                                      .totalkm)
                                                              .toStringAsFixed(
                                                                  2) +
                                                          "KM)",
                                                      style:
                                                          GoogleFonts.poppins(
                                                        color: Colors.black,
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 0),
                                              child: Container(
                                                height: 33,
                                                width: 85,
                                                decoration: BoxDecoration(
                                                    color: Colors.white
                                                        .withOpacity(0.25),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            16)),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text("DAY",
                                                        style:
                                                            GoogleFonts.poppins(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600)),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 5),
                                                      child: Text(
                                                          winnerdetail[index]
                                                              .streakNo
                                                              .toString(),
                                                          style: GoogleFonts
                                                              .poppins(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600)),
                                                    ),
                                                    Text(
                                                        " / " +
                                                            challangedetail[
                                                                'streakDays'],
                                                        style:
                                                            GoogleFonts.poppins(
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
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 15)
                                ],
                              ),
                              Positioned(
                                right: 20,
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
                  ],
                ),
              ),
            ),
            bottomNavigationBar: joinchallenge == false
                ? GestureDetector(
                    onTap: () {
                      joinChallenge(context, widget.challange);
                    },
                    child: Container(
                      margin: EdgeInsets.only(bottom: 15, right: 25, left: 25, top: 25),
                      width: MediaQuery.of(context).size.width * 0.2,
                      height: MediaQuery.of(context).size.height * 0.07,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: blue1),
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
                  ],
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
