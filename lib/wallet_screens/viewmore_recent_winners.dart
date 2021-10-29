import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:momerlin/data/localstorage/userdata_source.dart';

import 'package:momerlin/tabscreen/tabscreen.dart';
import 'package:momerlin/theme/theme.dart';

class ViewmoreRecentWinners extends StatefulWidget {
  const ViewmoreRecentWinners({Key key}) : super(key: key);

  @override
  _ViewmoreRecentWinnersState createState() => _ViewmoreRecentWinnersState();
}

class _ViewmoreRecentWinnersState extends State<ViewmoreRecentWinners> {
  bool loading = true;
  var userLanguage, user, lang = [];

  @override
  void initState() {
    super.initState();

    getUserLanguage();
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
              itemCount: elements.length,
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
                                title: Row(
                                  children: [
                                    FittedBox(
                                      fit: BoxFit.scaleDown,
                                      child: Text(
                                        elements[index]["leadername"]
                                            .toString()
                                            .toUpperCase(),
                                        style: GoogleFonts.poppins(
                                          color: Colors.white60,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600,
                                        ),
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
                                      Text(elements[index]['amt'],
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
