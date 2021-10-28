import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:momerlin/data/localstorage/userdata_source.dart';
import 'package:momerlin/data/userrepository.dart';
import 'package:momerlin/tabscreen/tabscreen.dart';
import 'package:momerlin/theme/theme.dart';

class Challengesdetail extends StatefulWidget {
  final challange;
  const Challengesdetail({Key key, this.challange}) : super(key: key);

  @override
  _ChallengesdetailState createState() => _ChallengesdetailState();
}

class _ChallengesdetailState extends State<Challengesdetail> {
  var userLanguage, user, lang = [];
  bool loading = true;
  var refreshKey = GlobalKey<RefreshIndicatorState>();
  Future<Null> refreshList() async {
    refreshKey.currentState?.show(atTop: false);
    await Future.delayed(Duration(seconds: 2));
    getUserLanguage();

    return null;
  }

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

  Future<void> getwinnerChallenges(challangeid) async {
    setState(() {
      loading = false;
    });
    var res = await UserRepository().getwinnerChallenges(challangeid);
    print("USER ID :" + user[0]["uid"]);

    print("PAVIMANO12 $res");
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
    DateTime parseDate = new DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'")
        .parse(widget.challange.startDate);
    var inputDate = DateTime.parse(parseDate.toString());
    var startDate = (DateFormat.yMMMd().format(inputDate)).toString();
    DateTime parseendDate = new DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'")
        .parse(widget.challange.endDate);
    var endinputDate = DateTime.parse(parseendDate.toString());
    var endDate = (DateFormat.yMMMd().format(endinputDate)).toString();
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
          "Challange Detail",
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
                  padding: const EdgeInsets.only(top: 20, left: 25),
                  child: Container(
                    height: MediaQuery.of(context).size.width * 0.15,
                    width: MediaQuery.of(context).size.width * 0.41,
                    decoration: BoxDecoration(
                        color: button, borderRadius: BorderRadius.circular(15)),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Container(
                            height: 32,
                            width: 25,
                            //color: blue1,
                            child: Image.asset(
                              widget.challange.mode == "Walking"
                                  ? "assets/images/walking.png"
                                  : "assets/images/running.png",
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text(
                            widget.challange.mode == "Walking" ? "Walk" : "Run",
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
                  padding: const EdgeInsets.only(top: 20, left: 25),
                  child: Container(
                    height: MediaQuery.of(context).size.width * 0.15,
                    width: MediaQuery.of(context).size.width * 0.41,
                    decoration: BoxDecoration(
                        color: button, borderRadius: BorderRadius.circular(15)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 15),
                          child: Text(
                            widget.challange.wage,
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
                  padding: const EdgeInsets.only(top: 20, left: 25),
                  child: Container(
                    height: MediaQuery.of(context).size.width * 0.15,
                    width: MediaQuery.of(context).size.width * 0.41,
                    decoration: BoxDecoration(
                        color: button, borderRadius: BorderRadius.circular(15)),
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
                  padding: const EdgeInsets.only(top: 20, left: 25),
                  child: Container(
                    height: MediaQuery.of(context).size.width * 0.15,
                    width: MediaQuery.of(context).size.width * 0.41,
                    decoration: BoxDecoration(
                        color: button, borderRadius: BorderRadius.circular(15)),
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
                  padding: const EdgeInsets.only(top: 20, left: 25),
                  child: Container(
                    height: MediaQuery.of(context).size.width * 0.15,
                    width: MediaQuery.of(context).size.width * 0.9,
                    decoration: BoxDecoration(
                        color: button, borderRadius: BorderRadius.circular(15)),
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
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Text(
                                    widget.challange.mode,
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
                  padding: const EdgeInsets.only(top: 20, left: 25),
                  child: Container(
                    height: MediaQuery.of(context).size.width * 0.15,
                    width: MediaQuery.of(context).size.width * 0.9,
                    decoration: BoxDecoration(
                        color: button, borderRadius: BorderRadius.circular(15)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 15),
                          child: Text(
                            widget.challange.totalCompetitors.toString(),
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
                  widget.challange.wage.toString(),
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
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              itemCount: 2,
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
                                width: MediaQuery.of(context).size.width * 0.83,
                                decoration: BoxDecoration(
                                    color: myActivityColorList[
                                        index % myActivityColorList.length],
                                    borderRadius: BorderRadius.circular(20)),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      height: 59,
                                      width: MediaQuery.of(context).size.width *
                                          0.6,
                                      decoration: BoxDecoration(
                                        color: Colors.white.withOpacity(0.2),
                                        borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(15),
                                            bottomRight: Radius.circular(25),
                                            topLeft: Radius.circular(15),
                                            topRight: Radius.circular(25)),
                                      ),
                                      child: Center(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "1" + "KM ",
                                              style: GoogleFonts.poppins(
                                                color: Colors.black,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            Text(
                                              "WALK ",
                                              style: GoogleFonts.poppins(
                                                color: Colors.black,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            Text(
                                              "STREAK",
                                              style: GoogleFonts.poppins(
                                                color: Colors.black,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            Text(
                                              " (" + "1" + "KM)",
                                              style: GoogleFonts.poppins(
                                                color: Colors.black,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(right: 0),
                                      child: Container(
                                        height: 33,
                                        width: 85,
                                        decoration: BoxDecoration(
                                            color:
                                                Colors.white.withOpacity(0.25),
                                            borderRadius:
                                                BorderRadius.circular(16)),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text("DAY",
                                                style: GoogleFonts.poppins(
                                                    color: Colors.white,
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.w600)),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 5),
                                              child: Text("5",
                                                  style: GoogleFonts.poppins(
                                                      color: Colors.white,
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w600)),
                                            ),
                                            Text(
                                                " / " +
                                                    widget.challange.streakDays,
                                                style: GoogleFonts.poppins(
                                                    color: Colors.white,
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.w400)),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                // child: ListTile(
                                //   title: Padding(
                                //     padding:
                                //         const EdgeInsets.fromLTRB(
                                //             0, 0, 20, 2),
                                //     child: Container(
                                //       height: 60,
                                //       decoration: BoxDecoration(
                                //           color: Colors.black
                                //               .withOpacity(0.1),
                                //           borderRadius:
                                //               BorderRadius.circular(
                                //                   15)),
                                //       child: Center(
                                //         child: Text(
                                //           elementsOne[index]['name'],
                                //           style: GoogleFonts.poppins(
                                //             color: Colors.black,
                                //             fontSize: 14,
                                //             fontWeight:
                                //                 FontWeight.w600,
                                //           ),
                                //         ),
                                //       ),
                                //     ),
                                //   ),
                                //   trailing: Container(
                                //     height: 33,
                                //     width: 85,
                                //     decoration: BoxDecoration(
                                //         color: Colors.white
                                //             .withOpacity(0.25),
                                //         borderRadius:
                                //             BorderRadius.circular(
                                //                 16)),
                                //     child: Row(
                                //       mainAxisAlignment:
                                //           MainAxisAlignment.center,
                                //       children: [
                                //         Text(
                                //             elementsOne[index]['day'],
                                //             style:
                                //                 GoogleFonts.poppins(
                                //                     color:
                                //                         Colors.white,
                                //                     fontSize: 12,
                                //                     fontWeight:
                                //                         FontWeight
                                //                             .w600)),
                                //         Padding(
                                //           padding:
                                //               const EdgeInsets.only(
                                //                   left: 5),
                                //           child: Text(
                                //               elementsOne[index]
                                //                   ['count'],
                                //               style:
                                //                   GoogleFonts.poppins(
                                //                       color: Colors
                                //                           .white,
                                //                       fontSize: 12,
                                //                       fontWeight:
                                //                           FontWeight
                                //                               .w400)),
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
    );
  }
}
