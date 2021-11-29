import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:momerlin/data/localstorage/userdata_source.dart';
import 'package:momerlin/data/userrepository.dart';
import 'package:momerlin/models/spendingreportsmodel.dart';
import 'package:momerlin/tabscreen/tabscreen.dart';
import 'package:momerlin/theme/theme.dart';

import 'package:timeago/timeago.dart' as timeago;
import 'package:momerlin/pages/transaction/wallet_profile.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
//import 'package:syncfusion_flutter_charts/sparkcharts.dart';
import 'package:percent_indicator/percent_indicator.dart';

class SpendingReport extends StatefulWidget {
  const SpendingReport({Key key}) : super(key: key);

  @override
  _SpendingReportState createState() => _SpendingReportState();
}

class _SpendingReportState extends State<SpendingReport> {
  bool isWeek = false;
  bool isMonth = false;
  bool isYear = false;
  bool isAll = true;
  var selectType;
  bool loading = true;
  bool isVisibleInfo = true;
  bool chartClick = true;
  List<GDPData> _chartData = [];
  // ignore: unused_field
  TooltipBehavior _tooltipBehavior;
  // Map<String, double> dataMap = {};
  var info;
  var balance = 0.00;
  var userLanguage, lang, user = [];
  @override
  void initState() {
    super.initState();
    getUserLanguage();
    // _chartData = getChartData();
    _tooltipBehavior = TooltipBehavior(
        enable: true,
        activationMode: ActivationMode.singleTap,
        tooltipPosition: TooltipPosition.pointer);
  }

  var gweibalance = "0";
  // ignore: todo
  //TODO :languagestart
  Future<void> getUserLanguage() async {
    lang = await UserDataSource().getLanguage();

    user = await UserDataSource().getUser();
    print("pavim ${user[0]}");
    var res = await UserRepository().getUser(user[0]["walletaddress"]);

    gweibalance = res["user"]["gwei"];
    // if (lang.length != null && lang.length != 0) {
    //   userLanguage = lang[0];
    // }
    getSpendingReports();
  }

  // ignore: todo
  //TODO: LanguageEnd
  var text;
  List<GDPData> chartData = [];
  List<SpendingReports> spendingreports = [];
  Future<void> getSpendingReports() async {
    // ignore: unused_local_variable
    var res =
        await UserRepository().getSpendingReports(user[0]["walletaddress"]);
    setState(() {
      loading = false;
    });
    if (res["success"] == true) {
      spendingreports = [];
      _chartData = [];
      for (var i = 0; i < res["spendings"].length; i++) {
        _chartData.add(
          GDPData(
            res["spendings"][i]["category"]["displayName"],
            res["spendings"][i]["percentage"],
            res["spendings"][i]["amount"],
            HexColor(
              res["spendings"][i]["category"]["color"],
            ),
          ),
        );
        // dataMap = {
        //   res["spendings"][i]["category"]["displayName"]:
        //       double.parse(res["spendings"][i]["amount"].toString())

        //};
        spendingreports.add(SpendingReports.fromJson(res["spendings"][i]));
      }
    } else {
      text = res["error"];
    }
  }

  Future<void> getMyspendingReportsfilter(startdate, enddate) async {
    // ignore: unused_local_variable
    var res = await UserRepository().getMyspendingReportsfilter(
        user[0]["walletaddress"], startdate, enddate);
    setState(() {
      loading = false;
    });
    if (res["success"] == true) {
      spendingreports = [];
      _chartData = [];
      for (var i = 0; i < res["spendings"].length; i++) {
        _chartData.add(
          GDPData(
            res["spendings"][i]["category"]["displayName"],
            res["spendings"][i]["percentage"],
            res["spendings"][i]["amount"],
            HexColor(
              res["spendings"][i]["category"]["color"],
            ),
          ),
        );
        // dataMap = {
        //   res["spendings"][i]["category"]["displayName"]:
        //       double.parse(res["spendings"][i]["amount"].toString())

        //};
        spendingreports.add(SpendingReports.fromJson(res["spendings"][i]));
      }
    } else {
      text = res["error"];
    }
  }

  List<Categorytransaction> categorytransactions = [];
  Future<void> getcategorytransactions(category) async {
    // ignore: unused_local_variable
    var res = await UserRepository()
        .getSpendingReportsbycategory(category, user[0]["walletaddress"]);

    setState(() {
      loading = false;
    });
    if (res["success"] == true) {
      categorytransactions = [];
      for (var i = 0; i < res["transactions"].length; i++) {
        categorytransactions
            .add(Categorytransaction.fromJson(res["transactions"][i]));
      }
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return
        // loading == true
        //     ? Container(
        //         height: MediaQuery.of(context).size.height,
        //         width: MediaQuery.of(context).size.width,
        //         color: backgroundcolor,
        //         child: Center(
        //           child: Container(
        //             height: MediaQuery.of(context).size.height * 0.24,
        //             width: MediaQuery.of(context).size.width * 0.55,
        //             decoration: BoxDecoration(
        //                 color: white.withOpacity(0.9),
        //                 borderRadius: BorderRadius.circular(24)),
        //             child: Center(child: SpinKitRing(color: blue2)),
        //           ),
        //         ),
        //       )
        //     :
        Scaffold(
      backgroundColor: backgroundcolor,
      appBar: AppBar(
        backgroundColor: Color(0xff7D7BF2),
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
                  //   info == null
                  //?
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => Tabscreen(
                        index: 1,
                      ),
                    ),
                  );
                  // :   categorytransactions = [];
                  // setState(() {
                  //    info = null;
                  // });
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
          // (lang.length != null &&
          //         lang.length != 0 &&
          //         userLanguage['spendingReports'] != null)
          //     ? "${userLanguage['spendingReports']}"
          //     :
          "SPENDING REPORTS",
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(5),
            child: GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => WalletProfile()));
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Image.asset(
                  "assets/images/profile.png",
                  fit: BoxFit.cover,
                  width: 46,
                  height: 46,
                ),
              ),
            ),
          ),
        ],
      ),
      body: loading == true
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
          : Stack(
              children: [
                SingleChildScrollView(
                  child: Column(
                    children: [
                      // APPBAR DESIGN WITH BALANCE
                      Container(
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Positioned(
                              child: Image.asset(
                                "assets/images/rr1.png",
                                width: MediaQuery.of(context).size.width,
                                fit: BoxFit.fill,
                                height: 130,
                              ),
                            ),
                            Positioned(
                              top: 20,
                              child: Text(
                                (lang.length != null &&
                                        lang.length != 0 &&
                                        userLanguage['yourBalanceIs'] != null)
                                    ? "${userLanguage['yourBalanceIs']}"
                                    : "Your balance is",
                                style: GoogleFonts.poppins(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Positioned(
                              top: 60,
                              child: Row(
                                children: [
                                  Text(
                                    gweibalance,
                                    style: GoogleFonts.montserrat(
                                      fontSize: 30,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 3,
                                  ),
                                  Text(
                                    "Gwei",
                                    style: GoogleFonts.montserrat(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.orange,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      // PieChart(
                      //   dataMap: dataMap,
                      //   animationDuration: Duration(milliseconds: 800),
                      //   chartLegendSpacing: 32.0,
                      //   chartRadius: MediaQuery.of(context).size.width / 2.7,
                      //   chartType: ChartType.ring,
                      // ),

                      text != null
                          ? Container(
                              padding:
                                  EdgeInsets.only(left: 20, right: 20, top: 30),
                              alignment: Alignment.center,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    text,
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.poppins(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                ],
                              ),
                            )
                          : Column(
                              children: [
                                Container(
                                  height: 56,
                                  width: 280,
                                  decoration: BoxDecoration(
                                    color: Colors.black12,
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          var now = new DateTime.now();

                                          var todaydate =
                                              now.subtract(Duration(days: 1));
                                          var now_1w = todaydate
                                              .subtract(Duration(days: 7));
                                          var endDate = DateFormat('yyyy-MM-dd')
                                              .format(todaydate);
                                          var startDate =
                                              DateFormat('yyyy-MM-dd')
                                                  .format(now_1w);
                                          print(startDate);
                                          print(endDate);
                                          getMyspendingReportsfilter(
                                              startDate, endDate);
                                          selectType = "";
                                          setState(() {
                                            selectType = "Week";
                                            isWeek = true;
                                            isMonth = false;
                                            isYear = false;
                                            isAll = false;
                                          });
                                        },
                                        child: Container(
                                          height: 48,
                                          width: 70,
                                          decoration: isWeek == true
                                              ? BoxDecoration(
                                                  color: button,
                                                  borderRadius:
                                                      BorderRadius.circular(25),
                                                )
                                              : BoxDecoration(),
                                          child: Center(
                                            child: Text(
                                              "1W",
                                              style: GoogleFonts.poppins(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                                color: isWeek == true
                                                    ? white
                                                    : text1,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          var now = new DateTime.now();

                                          var now_1m = new DateTime(
                                              now.year, now.month - 1, now.day);
                                          print(now_1m);
                                          var now_1y = new DateTime(
                                              now.year - 1, now.month, now.day);
                                          print(now_1y);

                                          var endDate = DateFormat('yyyy-MM-dd')
                                              .format(now);
                                          var startDate =
                                              DateFormat('yyyy-MM-dd')
                                                  .format(now_1m);

                                          getMyspendingReportsfilter(
                                              startDate, endDate);
                                          selectType = "";
                                          setState(() {
                                            selectType = "Month";
                                            isMonth = true;
                                            isWeek = false;
                                            isYear = false;
                                            isAll = false;
                                          });
                                        },
                                        child: Container(
                                          height: 48,
                                          width: 70,
                                          decoration: isMonth == true
                                              ? BoxDecoration(
                                                  color: button,
                                                  borderRadius:
                                                      BorderRadius.circular(25),
                                                )
                                              : BoxDecoration(),
                                          child: Center(
                                            child: Text(
                                              "1M",
                                              style: GoogleFonts.poppins(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                                color: isMonth == true
                                                    ? white
                                                    : text1,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          var now = new DateTime.now();

                                          var now_1y = new DateTime(
                                              now.year - 1, now.month, now.day);

                                          var endDate = DateFormat('yyyy-MM-dd')
                                              .format(now);
                                          var startDate =
                                              DateFormat('yyyy-MM-dd')
                                                  .format(now_1y);
                                          print(startDate);
                                          print(endDate);
                                          getMyspendingReportsfilter(
                                              startDate, endDate);

                                          selectType = "";
                                          setState(() {
                                            selectType = "Year";
                                            isYear = true;
                                            isWeek = false;
                                            isMonth = false;
                                            isAll = false;
                                          });
                                        },
                                        child: Container(
                                          height: 48,
                                          width: 70,
                                          decoration: isYear == true
                                              ? BoxDecoration(
                                                  color: button,
                                                  borderRadius:
                                                      BorderRadius.circular(25),
                                                )
                                              : BoxDecoration(),
                                          child: Center(
                                            child: Text(
                                              "1Y",
                                              style: GoogleFonts.poppins(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                                color: isYear == true
                                                    ? white
                                                    : text1,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          getSpendingReports();
                                          selectType = "";
                                          setState(() {
                                            selectType = "All";
                                            isAll = true;
                                            isMonth = false;
                                            isWeek = false;
                                            isYear = false;
                                          });
                                        },
                                        child: Container(
                                          height: 48,
                                          width: 70,
                                          decoration: isAll == true
                                              ? BoxDecoration(
                                                  color: button,
                                                  borderRadius:
                                                      BorderRadius.circular(25),
                                                )
                                              : BoxDecoration(),
                                          child: Center(
                                            child: Text(
                                              (lang.length != null &&
                                                      lang.length != 0 &&
                                                      userLanguage['all'] !=
                                                          null)
                                                  ? "${userLanguage['all']}"
                                                  : "ALL",
                                              style: GoogleFonts.poppins(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                                color: isAll == true
                                                    ? white
                                                    : text1,
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 2,
                                ),

                                /******Pie chats package */

                                // Container(
                                //   height: 300,
                                //   child: PieChart(
                                //     dataMap: dataMap,
                                //     animationDuration: Duration(milliseconds: 1500),
                                //     chartLegendSpacing: 32,
                                //     chartRadius: MediaQuery.of(context).size.width / 2,
                                //     colorList: spendingColors,
                                //     initialAngleInDegree: 0,
                                //     chartType: ChartType.ring,
                                //     ringStrokeWidth: 45,
                                //     centerText: "HYBRID",
                                //     legendOptions: LegendOptions(
                                //       showLegends: false,
                                //     ),
                                //     chartValuesOptions: ChartValuesOptions(
                                //       showChartValueBackground: true,
                                //       showChartValues: true,
                                //       showChartValuesInPercentage: true,
                                //       showChartValuesOutside: false,
                                //       decimalPlaces: 1,
                                //     ),
                                //   ),
                                // ),

                                /******Syncfusion package */

                                Container(
                                  height: 300,
                                  //color: Colors.amberAccent,

                                  child: SfCircularChart(
                                    annotations: <CircularChartAnnotation>[
                                      CircularChartAnnotation(
                                        //   widget: Container(
                                        //     /**  TEXT DESIGN 1 **/
                                        //     child: info == null
                                        //         ? Text(
                                        //             'Select a portion\nof the chart to\nview details',
                                        //             style: GoogleFonts.poppins(
                                        //                 fontSize: 10,
                                        //                 color: text1))
                                        //         : Text(
                                        //             spendingreports[info]
                                        //                     .category
                                        //                     .displayName +
                                        //                 "\n" +
                                        //                 spendingreports[info]
                                        //                     .percentage
                                        //                     .toStringAsFixed(2) +
                                        //                 " %",
                                        //             textAlign: TextAlign.center,
                                        //             style: GoogleFonts.poppins(
                                        //                 fontWeight:
                                        //                     FontWeight.bold,
                                        //                 fontSize: 15,
                                        //                 color: white)),
                                        //   ),
                                        // )
                                        height:
                                            '110%', // Setting height and width for the circular chart annotation
                                        width: '110%',
                                        widget: Container(
                                          child: PhysicalModel(
                                            child: Container(),
                                            shape: BoxShape.circle,
                                            elevation: 10,
                                            shadowColor: Colors.black,
                                            color: backgroundcolor,
                                          ),
                                        ),
                                      ),
                                      CircularChartAnnotation(
                                        widget: Container(
                                          child: info == null
                                              ? Container(
                                                  width: 90,
                                                  child: Text(
                                                    'Select a portion of the chart to view details',
                                                    textAlign: TextAlign.center,
                                                    style: GoogleFonts.poppins(
                                                      fontSize: 11,
                                                      color: text1,
                                                    ),
                                                  ),
                                                )
                                              : RichText(
                                                  textAlign: TextAlign.center,
                                                  text: TextSpan(
                                                    children: [
                                                      TextSpan(
                                                        text: spendingreports[
                                                                info]
                                                            .category
                                                            .displayName,
                                                        style: GoogleFonts
                                                            .montserrat(
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontSize: 15,
                                                          color: white,
                                                        ),
                                                      ),
                                                      TextSpan(
                                                        text: "\n" +
                                                            spendingreports[
                                                                    info]
                                                                .percentage
                                                                .toInt()
                                                                .toString() +
                                                            "%",
                                                        style: GoogleFonts
                                                            .montserrat(
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontSize: 31,
                                                          color: white,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
// Text(
//                                                   spendingreports[info]
//                                                           .category
//                                                           .displayName +
//                                                       "\n" +
//                                                       spendingreports[info]
//                                                           .percentage
//                                                           .toInt()
//                                                           .toString() +
//                                                       " %",
//                                                   textAlign: TextAlign.center,
//                                                   style: GoogleFonts.poppins(
//                                                     fontWeight: FontWeight.bold,
//                                                     fontSize: 19,
//                                                     color: white,
//                                                   ),
//                                                 ),
                                        ),
                                      ),
                                    ],
                                    tooltipBehavior: _tooltipBehavior,
                                    series: <CircularSeries>[
                                      DoughnutSeries<GDPData, String>(
                                        dataSource: _chartData,
                                        pointColorMapper: (GDPData data, _) =>
                                            data.color,
                                        xValueMapper: (GDPData data, _) =>
                                            data.percentage,
                                        yValueMapper: (GDPData data, _) =>
                                            data.name,
                                        radius: '100%',
                                        // dataLabelSettings: DataLabelSettings(isVisible: true),

                                        enableTooltip: true,
                                        selectionBehavior: SelectionBehavior(
                                            enable: chartClick),
                                        explode: false,
                                        onPointTap:
                                            (ChartPointDetails details) {
                                          //setState(() {
                                          if (info == null) {
                                            //  categorytransactions = [];
                                            getcategorytransactions(
                                                spendingreports[details
                                                        .viewportPointIndex]
                                                    .category
                                                    .name);
                                            setState(() {
                                              info = details.viewportPointIndex;
                                            });
                                          } else if (info ==
                                              details.viewportPointIndex) {
                                            categorytransactions = [];
                                            setState(() {
                                              info = null;
                                            });
                                          } else {
                                            // categorytransactions = [];
                                            getcategorytransactions(
                                                spendingreports[details
                                                        .viewportPointIndex]
                                                    .category
                                                    .name);
                                            setState(() {
                                              info = details.viewportPointIndex;
                                            });
                                          }
                                          //  });
                                        },

                                        // explode: false,
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 2,
                                ),
                                // Visibility(
                                //   visible: isVisibleInfo,
                                //   child:
                                info == null
                                    ? SizedBox(
                                        height: 0,
                                      )
                                    : Padding(
                                        padding: const EdgeInsets.only(
                                            left: 30, right: 30),
                                        child: Container(
                                          padding: const EdgeInsets.only(
                                              left: 20, right: 20),
                                          height: 148,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          decoration: BoxDecoration(
                                            color: button,
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 20, left: 20),
                                                child: Text(
                                                  (lang.length != null &&
                                                          lang.length != 0 &&
                                                          userLanguage[
                                                                  'info'] !=
                                                              null)
                                                      ? "${userLanguage['info']}"
                                                      : "Info",
                                                  style: GoogleFonts.poppins(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                padding:
                                                    EdgeInsets.only(left: 20),
                                                child: RichText(
                                                  text: TextSpan(
                                                    children: [
                                                      TextSpan(
                                                        text: "You Spent ",
                                                        style:
                                                            GoogleFonts.poppins(
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontSize: 12,
                                                          color: text1,
                                                        ),
                                                      ),
                                                      TextSpan(
                                                        text: spendingreports[
                                                                info]
                                                            .amount
                                                            .toInt()
                                                            .toString(),
                                                        style: GoogleFonts
                                                            .montserrat(
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontSize: 14,
                                                          color: white,
                                                        ),
                                                      ),
                                                      TextSpan(
                                                        text: "  Gwei  ",
                                                        style: GoogleFonts
                                                            .montserrat(
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontSize: 10,
                                                          color: orange,
                                                        ),
                                                      ),
                                                      TextSpan(
                                                        text:
                                                            " on ${spendingreports[info].category.displayName} this month, that’s higher than normal.",
                                                        style:
                                                            GoogleFonts.poppins(
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontSize: 12,
                                                          color: text1,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              // Padding(
                                              //   padding: const EdgeInsets.only(
                                              //       top: 5, left: 20),
                                              //   child: Text(
                                              //     'You Spent ' +
                                              //         spendingreports[info]
                                              //             .amount
                                              //             .toInt()
                                              //             .toString() +
                                              //         " Gwei " +
                                              //         spendingreports[info]
                                              //             .category
                                              //             .displayName +
                                              //         " this month, that’s higher than normal.",
                                              //     style: GoogleFonts.poppins(
                                              //       fontSize: 12,
                                              //       color: text1,
                                              //     ),
                                              //   ),
                                              // ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 10, left: 20),
                                                child: Text(
                                                  (lang.length != null &&
                                                          lang.length != 0 &&
                                                          userLanguage[
                                                                  'whatcanwedotolowerthatnumber'] !=
                                                              null)
                                                      ? "${userLanguage['whatcanwedotolowerthatnumber']}"
                                                      : "What can we do to lower that number?",
                                                  style: GoogleFonts.poppins(
                                                    fontSize: 12,
                                                    color: text1,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                // ),
                                SizedBox(
                                  height: 30,
                                ),
                                categorytransactions.length != 0
                                    ? Container(
                                        decoration: BoxDecoration(
                                          color: button,
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(40),
                                            topRight: Radius.circular(40),
                                          ),
                                        ),
                                        //color: button,
                                        child: Container(
                                          padding: const EdgeInsets.only(
                                              left: 10, right: 10),
                                          child: Column(
                                            children: [
                                              SizedBox(
                                                height: 20,
                                              ),
                                              ListTile(
                                                leading: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(30),
                                                  child: Container(
                                                    width: 50,
                                                    height: 50,
                                                    color: HexColor(
                                                        spendingreports[info]
                                                            .category
                                                            .color),
                                                    child: Center(
                                                      child: spendingreports[
                                                                      info]
                                                                  .category
                                                                  .image
                                                                  .length >
                                                              1
                                                          ? CachedNetworkImage(
                                                              imageUrl:
                                                                  spendingreports[
                                                                          info]
                                                                      .category
                                                                      .image,
                                                              placeholder: (context,
                                                                      url) =>
                                                                  new CircularProgressIndicator(
                                                                color: white,
                                                              ),
                                                              errorWidget: (context,
                                                                      url,
                                                                      error) =>
                                                                  new Icon(Icons
                                                                      .error),
                                                            )
                                                          : Text(
                                                              // "Food",
                                                              spendingreports[
                                                                      info]
                                                                  .category
                                                                  .image,
                                                              style: GoogleFonts
                                                                  .poppins(
                                                                fontSize: 18,
                                                                color: Colors
                                                                    .white,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                              ),
                                                            ),
                                                    ),
                                                  ),
                                                ),
                                                title: Text(
                                                  // "Food",
                                                  spendingreports[info]
                                                      .category
                                                      .displayName,
                                                  style: GoogleFonts.poppins(
                                                    fontSize: 18,
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                                subtitle: Container(
                                                  child: Text(
                                                    spendingreports[info]
                                                            .transactionsCount
                                                            .toString() +
                                                        " Transactions",
                                                    maxLines: 2,
                                                    style: GoogleFonts.poppins(
                                                      fontSize: 12,
                                                      color: text1,
                                                      // fontWeight: FontWeight.w500,
                                                    ),
                                                  ),
                                                ),
                                                trailing: Wrap(
                                                  children: [
                                                    CircularPercentIndicator(
                                                      radius: 40,
                                                      lineWidth: 2,
                                                      animation: true,
                                                      percent: 0.7,
                                                      center: Text(
                                                        spendingreports[info]
                                                                .percentage
                                                                .toInt()
                                                                .toString() +
                                                            "%",
                                                        style: GoogleFonts
                                                            .montserrat(
                                                          fontSize: 10,
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        ),
                                                      ),
                                                      progressColor: HexColor(
                                                          spendingreports[info]
                                                              .category
                                                              .color),
                                                    ),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    Container(
                                                      height: 40,
                                                      width: 100,
                                                      decoration: BoxDecoration(
                                                        color: Color(0xff707070)
                                                            .withOpacity(0.4),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                      ),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Text(
                                                            spendingreports[
                                                                    info]
                                                                .amount
                                                                .toInt()
                                                                .toString(),
                                                            style: GoogleFonts
                                                                .poppins(
                                                              fontSize: 12,
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: 2,
                                                          ),
                                                          Text(
                                                            " Gwei",
                                                            style: GoogleFonts
                                                                .poppins(
                                                              fontSize: 9,
                                                              color:
                                                                  Colors.orange,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Container(
                                                height: 2,
                                                width: 200,
                                                color: Color(0xff707070)
                                                    .withOpacity(0.4),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              categorytransactions.length == 0
                                                  ? SpinKitRing(color: blue2)
                                                  : ListView.builder(
                                                      shrinkWrap: true,
                                                      physics:
                                                          NeverScrollableScrollPhysics(),
                                                      // controller: myscrollController,
                                                      itemCount:
                                                          categorytransactions
                                                              .length,
                                                      // padding: EdgeInsets.zero,
                                                      itemBuilder:
                                                          (BuildContext context,
                                                              int index) {
                                                        return ListTile(
                                                          leading: ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        30),
                                                            child: Container(
                                                              width: 50,
                                                              height: 50,
                                                              color: HexColor(
                                                                  categorytransactions[
                                                                          info]
                                                                      .category
                                                                      .color),
                                                              child: Center(
                                                                child: categorytransactions[info]
                                                                            .category
                                                                            .image
                                                                            .length >
                                                                        1
                                                                    ? CachedNetworkImage(
                                                                        imageUrl: categorytransactions[info]
                                                                            .category
                                                                            .image,
                                                                        placeholder:
                                                                            (context, url) =>
                                                                                new CircularProgressIndicator(
                                                                          color:
                                                                              white,
                                                                        ),
                                                                        errorWidget: (context,
                                                                                url,
                                                                                error) =>
                                                                            new Icon(Icons.error),
                                                                      )
//  Image.network(
//                                                   spendingreports[index].category.image,
//                                                   fit: BoxFit.none,
//                                                   width: 50,
//                                                   height: 50,
//                                                 )
                                                                    : Text(
                                                                        // "Food",
                                                                        categorytransactions[info]
                                                                            .category
                                                                            .image,
                                                                        style: GoogleFonts
                                                                            .poppins(
                                                                          fontSize:
                                                                              18,
                                                                          color:
                                                                              Colors.white,
                                                                          fontWeight:
                                                                              FontWeight.w500,
                                                                        ),
                                                                      ),
                                                              ),
                                                            ),
                                                          ),
                                                          title: Text(
                                                            // "Food",
                                                            categorytransactions[
                                                                    index]
                                                                .merchantName,
                                                            style: GoogleFonts
                                                                .poppins(
                                                              fontSize: 18,
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                            ),
                                                          ),
                                                          subtitle: Container(
                                                            child: Text(
                                                              timeago.format(
                                                                  categorytransactions[
                                                                          index]
                                                                      .createdAt),
                                                              maxLines: 2,
                                                              style: GoogleFonts
                                                                  .poppins(
                                                                fontSize: 12,
                                                                color: text1,
                                                                // fontWeight: FontWeight.w500,
                                                              ),
                                                            ),
                                                          ),
                                                          // trailing: Wrap(
                                                          //   children: [
                                                          //     CircularPercentIndicator(
                                                          //       radius: 40,
                                                          //       lineWidth: 2,
                                                          //       animation: true,
                                                          //       percent: 0.7,
                                                          //       center: Text(
                                                          //         spendingreports[
                                                          //                     index]
                                                          //                 .percentage
                                                          //                 .toInt()
                                                          //                 .toString() +
                                                          //             "%",
                                                          //         style: GoogleFonts
                                                          //             .montserrat(
                                                          //           fontSize: 10,
                                                          //           color:
                                                          //               Colors.white,
                                                          //           fontWeight:
                                                          //               FontWeight
                                                          //                   .w600,
                                                          //         ),
                                                          //       ),
                                                          //       progressColor: HexColor(
                                                          //           spendingreports[
                                                          //                   index]
                                                          //               .category
                                                          //               .color),
                                                          //     ),
                                                          //     SizedBox(
                                                          //       width: 10,
                                                          //     ),
                                                          trailing: Container(
                                                            height: 40,
                                                            width: 100,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: Color(
                                                                      0xff707070)
                                                                  .withOpacity(
                                                                      0.4),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10),
                                                            ),
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Text(
                                                                  categorytransactions[
                                                                          index]
                                                                      .sats
                                                                      .toInt()
                                                                      .toString(),
                                                                  style: GoogleFonts
                                                                      .poppins(
                                                                    fontSize:
                                                                        12,
                                                                    color: Colors
                                                                        .white,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  width: 2,
                                                                ),
                                                                Text(
                                                                  " Gwei",
                                                                  style: GoogleFonts
                                                                      .poppins(
                                                                    fontSize: 9,
                                                                    color: Colors
                                                                        .orange,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          // ],
                                                          // ),
                                                        );
                                                      },
                                                    ),
                                            ],
                                          ),
                                        ),
                                      )
                                    : Container(
                                        decoration: BoxDecoration(
                                          color: button,
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(40),
                                            topRight: Radius.circular(40),
                                          ),
                                        ),
                                        //color: button,
                                        child: Container(
                                          padding: const EdgeInsets.only(
                                              left: 10, right: 10),
                                          child: Column(
                                            children: [
                                              SizedBox(
                                                height: 20,
                                              ),
                                              ListTile(
                                                title: Text(
                                                  'Expenses',
                                                  style: GoogleFonts.poppins(
                                                    fontSize: 17,
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                ),
                                              ),
                                              ListView.builder(
                                                shrinkWrap: true,
                                                physics:
                                                    NeverScrollableScrollPhysics(),
                                                // controller: myscrollController,
                                                itemCount:
                                                    spendingreports.length,
                                                // padding: EdgeInsets.zero,
                                                itemBuilder:
                                                    (BuildContext context,
                                                        int index) {
                                                  return ListTile(
                                                    leading: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              30),
                                                      child: Container(
                                                        width: 50,
                                                        height: 50,
                                                        color: HexColor(
                                                            spendingreports[
                                                                    index]
                                                                .category
                                                                .color),
                                                        child: Center(
                                                          child: spendingreports[
                                                                          index]
                                                                      .category
                                                                      .image
                                                                      .length >
                                                                  1
                                                              ? CachedNetworkImage(
                                                                  imageUrl: spendingreports[
                                                                          index]
                                                                      .category
                                                                      .image,
                                                                  placeholder: (context,
                                                                          url) =>
                                                                      new CircularProgressIndicator(
                                                                    color:
                                                                        white,
                                                                  ),
                                                                  errorWidget: (context,
                                                                          url,
                                                                          error) =>
                                                                      new Icon(Icons
                                                                          .error),
                                                                )
//  Image.network(
//                                                   spendingreports[index].category.image,
//                                                   fit: BoxFit.none,
//                                                   width: 50,
//                                                   height: 50,
//                                                 )
                                                              : Text(
                                                                  // "Food",
                                                                  spendingreports[
                                                                          index]
                                                                      .category
                                                                      .image,
                                                                  style: GoogleFonts
                                                                      .poppins(
                                                                    fontSize:
                                                                        18,
                                                                    color: Colors
                                                                        .white,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                  ),
                                                                ),
                                                        ),
                                                      ),
                                                    ),
                                                    title: Text(
                                                      // "Food",
                                                      spendingreports[index]
                                                          .category
                                                          .displayName,
                                                      style:
                                                          GoogleFonts.poppins(
                                                        fontSize: 18,
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                    subtitle: Container(
                                                      child: Text(
                                                        spendingreports[index]
                                                                .transactionsCount
                                                                .toString() +
                                                            " Transactions",
                                                        maxLines: 2,
                                                        style:
                                                            GoogleFonts.poppins(
                                                          fontSize: 12,
                                                          color: text1,
                                                          // fontWeight: FontWeight.w500,
                                                        ),
                                                      ),
                                                    ),
                                                    trailing: Wrap(
                                                      children: [
                                                        CircularPercentIndicator(
                                                          radius: 40,
                                                          lineWidth: 2,
                                                          animation: true,
                                                          percent: 0.7,
                                                          center: Text(
                                                            spendingreports[
                                                                        index]
                                                                    .percentage
                                                                    .toInt()
                                                                    .toString() +
                                                                "%",
                                                            style: GoogleFonts
                                                                .montserrat(
                                                              fontSize: 10,
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                            ),
                                                          ),
                                                          progressColor: HexColor(
                                                              spendingreports[
                                                                      index]
                                                                  .category
                                                                  .color),
                                                        ),
                                                        SizedBox(
                                                          width: 10,
                                                        ),
                                                        Container(
                                                          height: 40,
                                                          width: 100,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Color(
                                                                    0xff707070)
                                                                .withOpacity(
                                                                    0.4),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                          ),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Text(
                                                                spendingreports[
                                                                        index]
                                                                    .amount
                                                                    .toInt()
                                                                    .toString(),
                                                                style:
                                                                    GoogleFonts
                                                                        .poppins(
                                                                  fontSize: 12,
                                                                  color: Colors
                                                                      .white,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                width: 2,
                                                              ),
                                                              Text(
                                                                " Gwei",
                                                                style:
                                                                    GoogleFonts
                                                                        .poppins(
                                                                  fontSize: 9,
                                                                  color: Colors
                                                                      .orange,
                                                                ),
                                                              ),
                                                            ],
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
                              ],
                            ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}

class GDPData {
  GDPData(this.percentage, this.name, this.amount, this.color);
  final percentage;
  final name;
  final amount;
  final Color color;
}
