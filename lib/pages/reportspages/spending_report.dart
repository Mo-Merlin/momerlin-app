import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:momerlin/data/localstorage/userdata_source.dart';
import 'package:momerlin/data/userrepository.dart';
import 'package:momerlin/models/spendingreportsmodel.dart';
//import 'package:momerlin/tabscreen/tabscreen.dart';
import 'package:momerlin/theme/theme.dart';
import 'package:plaid_flutter/plaid_flutter.dart';
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
  PlaidLink _plaidLinkToken;
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
    getToken();
    super.initState();
    getUserLanguage();
    // _chartData = getChartData();
    _tooltipBehavior = TooltipBehavior(
        activationMode: ActivationMode.singleTap,
        enable: true,
        duration: 500000,
        tooltipPosition: TooltipPosition.pointer);
  }

  var gweibalance = "0";
  Future<void> getToken() async {
    final usertoken1 = await UserRepository().getToken();
    if (usertoken1 == false) {
      Scaffold.of(context)
          // ignore: deprecated_member_use
          .showSnackBar(SnackBar(
        content: Text('No Internet Connection'),
        backgroundColor: Colors.red,
      ));
    } else {
      if (usertoken1["success"] == true) {
        // print("token $linktoken");
        LinkTokenConfiguration linkTokenConfiguration = LinkTokenConfiguration(
          token: usertoken1["link_token"],
        );
        _plaidLinkToken = PlaidLink(
          configuration: linkTokenConfiguration,
          onSuccess: _onSuccessCallback,
          onEvent: _onEventCallback,
          onExit: _onExitCallback,
        );
      } else {
        Scaffold.of(context)
            // ignore: deprecated_member_use
            .showSnackBar(SnackBar(
          content: Text('Please Try Again!'),
          backgroundColor: Colors.red,
        ));
      }
    }

    // print("UserTokne $usertoken1");
  }

  void _onEventCallback(String event, LinkEventMetadata metadata) {
    print("onEvent: $event, metadata: ${metadata.description()}");
  }

  void _onExitCallback(LinkError error, LinkExitMetadata metadata) {
    print("onExit metadata: ${metadata.description()}");

    if (error != null) {
      print("onExit error: ${error.description()}");
    }
  }

  Future<void> _onSuccessCallback(
      String publicToken, LinkSuccessMetadata metadata) async {
    await UserRepository().updateToken({"public_token": publicToken});
    // getTransaction();
    // ignore: unused_local_variable
    var res1 = await UserRepository().updateplaidlogin(1);
    gweibalance = "0";
    var res = await UserRepository().getTransaction(user[0]["walletaddress"]);
    if (res["success"] == true) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Bank account connection successful'),
          backgroundColor: Colors.green,
        ),
      );
      var res = await UserRepository().getUser(user[0]["walletaddress"]);

      gweibalance = res["user"]["gwei"];
      var res1 =
          await UserRepository().getSpendingReports(user[0]["walletaddress"]);
      print(res);

      if (res["success"] == true) {
        spendingreports = [];
        _chartData = [];
        for (var i = 0; i < res1["spendings"].length; i++) {
          _chartData.add(
            GDPData(
              res1["spendings"][i]["category"]["displayName"],
              res1["spendings"][i]["percentage"],
              res1["spendings"][i]["amount"],
              HexColor(
                res1["spendings"][i]["category"]["color"],
              ),
            ),
          );
          // dataMap = {
          //   res["spendings"][i]["category"]["displayName"]:
          //       double.parse(res["spendings"][i]["amount"].toString())

          //};
          spendingreports.add(SpendingReports.fromJson(res1["spendings"][i]));
        }
      }

      //   getSpendingReports();
      // Navigator.of(context).pushAndRemoveUntil(
      //     MaterialPageRoute(builder: (context) => Tabscreen()),
      //     (Route<dynamic> route) => false);

      // getUserLanguage();
    }

    final usersave =
        await UserRepository().storeUser({"publictoken": publicToken});
    setState(() {
      loading = false;
    });
    if (usersave == true) {
    } else {
      // print("PAVITHRA");
    }
  }

  var imageFile = "";
  // ignore: todo
  //TODO :languagestart
  Future<void> getUserLanguage() async {
    lang = await UserDataSource().getLanguage();

    user = await UserDataSource().getUser();

    var res = await UserRepository().getUser(user[0]["walletaddress"]);
    imageFile = res["user"]["imageUrl"];
    gweibalance = res["user"]["gwei"];
    // if (lang.length != null && lang.length != 0) {
    //   userLanguage = lang[0];
    // }
    getSpendingReports();
  }

  // ignore: todo
  //TODO: LanguageEnd
  var text, text2;

  List<GDPData> chartData = [];
  List<SpendingReports> spendingreports = [];
  Future<void> getSpendingReports() async {
    // ignore: unused_local_variable
    var res =
        await UserRepository().getSpendingReports(user[0]["walletaddress"]);
    print(res);
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
      text2 = "1";
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
                  info == null
                      ? Navigator.pop(context, false)
                      // ? Navigator.pushReplacement(
                      //     context,
                      //     MaterialPageRoute(
                      //       builder: (_) => Tabscreen(
                      //         index: 1,
                      //       ),
                      //     ),
                      //   )
                      : categorytransactions = [];
                  chartClick = false;
                  setState(() {
                    text2 = null;
                    text = null;
                    info = null;
                  });
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
                borderRadius: BorderRadius.circular(100),
                child: imageFile == ""
                    ? Image.asset(
                        "assets/images/profile.png",
                        fit: BoxFit.fill,
                      )
                    : Image.network(
                        imageFile,
                        fit: BoxFit.cover,
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
                              padding: EdgeInsets.only(
                                  left: 20, right: 20, top: 150),
                              alignment: Alignment.center,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Center(
                                    child: Text(
                                      "No transactions for the selected period. Please sync latest transactions from your account",
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.poppins(
                                        fontSize: 12,
                                        //fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      plaidconnection(context);

                                      // setState(() {
                                      //   buttonpressed = true;
                                      // });

                                      // _onShareData(context);
                                      // Navigator.pop(context);
                                    },
                                    child: Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.6,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.06,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(35),
                                          color: blue1),
                                      // height: 50,
                                      // width: MediaQuery.of(context).size.width * 0.9,
                                      // ignore: deprecated_member_use
                                      child: Center(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              'Connect bank account',
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w700,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
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
                                          text2 = null;
                                          text = null;
                                          chartClick = false;
                                          info = null;
                                          categorytransactions = [];
                                          var now = new DateTime.now();

                                          var todaydate =
                                              now.subtract(Duration(days: 1));
                                          var now_1w = todaydate
                                              .subtract(Duration(days: 7));
                                          var endDate = DateFormat('yyyy-MM-dd')
                                              .format(now);
                                          var startDate =
                                              DateFormat('yyyy-MM-dd')
                                                  .format(now_1w);

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
                                          text2 = null;
                                          text = null;
                                          chartClick = false;
                                          info = null;
                                          categorytransactions = [];
                                          var now = new DateTime.now();

                                          var now_1m = new DateTime(
                                              now.year, now.month - 1, now.day);

                                          // var now_1y = new DateTime(
                                          //     now.year - 1, now.month, now.day);

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
                                          text2 = null;
                                          text = null;
                                          chartClick = false;
                                          info = null;
                                          categorytransactions = [];
                                          var now = new DateTime.now();

                                          var now_1y = new DateTime(
                                              now.year - 1, now.month, now.day);

                                          var endDate = DateFormat('yyyy-MM-dd')
                                              .format(now);
                                          var startDate =
                                              DateFormat('yyyy-MM-dd')
                                                  .format(now_1y);

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
                                          text2 = null;
                                          text = null;
                                          chartClick = false;
                                          info = null;
                                          categorytransactions = [];
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
                                text2 != null
                                    ? Container(
                                        padding: EdgeInsets.only(
                                            left: 20, right: 20, top: 30),
                                        alignment: Alignment.center,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Center(
                                              child: Text(
                                                "No transactions for the selected period. Please sync latest transactions from your account",
                                                textAlign: TextAlign.center,
                                                style: GoogleFonts.poppins(
                                                  fontSize: 19,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 80,
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                plaidconnection(context);

                                                // setState(() {
                                                //   buttonpressed = true;
                                                // });

                                                // _onShareData(context);
                                                // Navigator.pop(context);
                                              },
                                              child: Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.6,
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.06,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            35),
                                                    color: blue1),
                                                // height: 50,
                                                // width: MediaQuery.of(context).size.width * 0.9,
                                                // ignore: deprecated_member_use
                                                child: Center(
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        'Sync transactions',
                                                        style: TextStyle(
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w700,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    : Container(
                                        height: 300,
                                        //color: Colors.amberAccent,

                                        child: SfCircularChart(
                                          annotations: <
                                              CircularChartAnnotation>[
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
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: GoogleFonts
                                                              .poppins(
                                                            fontSize: 11,
                                                            color: text1,
                                                          ),
                                                        ),
                                                      )
                                                    : RichText(
                                                        textAlign:
                                                            TextAlign.center,
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
                                                                    FontWeight
                                                                        .w600,
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
                                                                    FontWeight
                                                                        .w600,
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
                                          tooltipBehavior: TooltipBehavior(
                                              enable: true, shared: true),
                                          series: <CircularSeries>[
                                            DoughnutSeries<GDPData, String>(
                                              dataSource: _chartData,
                                              pointColorMapper:
                                                  (GDPData data, _) =>
                                                      data.color,
                                              xValueMapper: (GDPData data, _) =>
                                                  data.percentage,
                                              yValueMapper: (GDPData data, _) =>
                                                  data.name,
                                              radius: '100%',

                                              // dataLabelSettings: DataLabelSettings(isVisible: true),
                                              // dataLabelSettings:
                                              //     DataLabelSettings(

                                              //         // labelPosition:
                                              //         //     ChartDataLabelPosition
                                              //         //         .outside,
                                              //         isVisible: true,
                                              //         // Templating the data label
                                              //         builder: (dynamic data,
                                              //             dynamic point,
                                              //             dynamic series,
                                              //             int pointIndex,
                                              //             int seriesIndex) {
                                              //           return Container(
                                              //               height: 30,
                                              //               width: 30,
                                              //               child: Text(
                                              //               pointIndex.toString(),
                                              //               ));
                                              //         }),

                                              enableTooltip: true,
                                              selectionBehavior:
                                                  SelectionBehavior(
                                                      enable: chartClick),
                                              explode: false,
                                              onPointTap:
                                                  (ChartPointDetails details) {
                                                //setState(() {
                                                if (info == null) {
                                                  categorytransactions = [];
                                                  getcategorytransactions(
                                                      spendingreports[details
                                                              .viewportPointIndex]
                                                          .category
                                                          .name);
                                                  setState(() {
                                                    info = details
                                                        .viewportPointIndex;
                                                  });
                                                } else if (info ==
                                                    details
                                                        .viewportPointIndex) {
                                                  categorytransactions = [];
                                                  setState(() {
                                                    info = null;
                                                  });
                                                } else {
                                                  categorytransactions = [];
                                                  getcategorytransactions(
                                                      spendingreports[details
                                                              .viewportPointIndex]
                                                          .category
                                                          .name);
                                                  setState(() {
                                                    info = details
                                                        .viewportPointIndex;
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
                                              GestureDetector(
                                                onTap: () {
                                                  categorytransactions = [];
                                                  setState(() {
                                                    info = null;
                                                  });
                                                },
                                                child: ListTile(
                                                  leading: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30),
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
                                                                style:
                                                                    GoogleFonts
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
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                  subtitle: Container(
                                                    child: Text(
                                                      spendingreports[info]
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
                                                            spendingreports[
                                                                    info]
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
                                                    ],
                                                  ),
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
                                              ListView.builder(
                                                shrinkWrap: true,
                                                physics:
                                                    NeverScrollableScrollPhysics(),
                                                // controller: myscrollController,
                                                itemCount:
                                                    categorytransactions.length,
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
                                                            categorytransactions[
                                                                    index]
                                                                .category
                                                                .color),
                                                        child: Center(
                                                          child: categorytransactions[
                                                                          index]
                                                                      .category
                                                                      .image
                                                                      .length >
                                                                  1
                                                              ? CachedNetworkImage(
                                                                  imageUrl: categorytransactions[
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
                                                                  categorytransactions[
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
                                                      categorytransactions[
                                                              index]
                                                          .merchantName,
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
                                                        timeago.format(
                                                            categorytransactions[
                                                                    index]
                                                                .createdAt),
                                                        maxLines: 2,
                                                        style:
                                                            GoogleFonts.poppins(
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
                                                            categorytransactions[
                                                                    index]
                                                                .sats
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
                                                    // ],
                                                    // ),
                                                  );
                                                },
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                    : text2 != null
                                        ? SizedBox(
                                            height: 0,
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
                                                      style:
                                                          GoogleFonts.poppins(
                                                        fontSize: 17,
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.w700,
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
                                                      return GestureDetector(
                                                        onTap: () {
                                                          if (info == null) {
                                                            categorytransactions =
                                                                [];
                                                            getcategorytransactions(
                                                                spendingreports[
                                                                        index]
                                                                    .category
                                                                    .name);
                                                            setState(() {
                                                              info = index;
                                                            });
                                                          } else if (info ==
                                                              index) {
                                                            categorytransactions =
                                                                [];
                                                            setState(() {
                                                              info = null;
                                                            });
                                                          } else {
                                                            categorytransactions =
                                                                [];
                                                            getcategorytransactions(
                                                                spendingreports[
                                                                        index]
                                                                    .category
                                                                    .name);
                                                            setState(() {
                                                              info = index;
                                                            });
                                                          }
                                                          // categorytransactions =
                                                          //     [];
                                                          // getcategorytransactions(
                                                          //     spendingreports[
                                                          //             index]
                                                          //         .category
                                                          //         .name);
                                                          // setState(
                                                          //   () {
                                                          //     info = index;
                                                          //   },
                                                          // );
                                                        },
                                                        child: ListTile(
                                                          leading: ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
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
                                                                child: spendingreports[index]
                                                                            .category
                                                                            .image
                                                                            .length >
                                                                        1
                                                                    ? CachedNetworkImage(
                                                                        imageUrl: spendingreports[index]
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
                                                                    : Text(
                                                                        // "Food",
                                                                        spendingreports[index]
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
                                                            spendingreports[
                                                                    index]
                                                                .category
                                                                .displayName,
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
                                                              spendingreports[
                                                                          index]
                                                                      .transactionsCount
                                                                      .toString() +
                                                                  " Transactions",
                                                              maxLines: 2,
                                                              style: GoogleFonts
                                                                  .poppins(
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
                                                                    fontSize:
                                                                        10,
                                                                    color: Colors
                                                                        .white,
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
                                                                      style: GoogleFonts
                                                                          .poppins(
                                                                        fontSize:
                                                                            12,
                                                                        color: Colors
                                                                            .white,
                                                                        fontWeight:
                                                                            FontWeight.w600,
                                                                      ),
                                                                    ),
                                                                    SizedBox(
                                                                      width: 2,
                                                                    ),
                                                                    Text(
                                                                      " Gwei",
                                                                      style: GoogleFonts
                                                                          .poppins(
                                                                        fontSize:
                                                                            9,
                                                                        color: Colors
                                                                            .orange,
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

  void plaidconnection(BuildContext context) {
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
                          "Plaid Connection",
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
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        Center(
                          child: Container(
                            height: 200,
                            width: 200,
                            child: Image.asset(
                              "assets/images/toyface.png",
                              fit: BoxFit.cover,
                            ),
                          ),
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
                              height: MediaQuery.of(context).size.height * 0.35,
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

                                  // SizedBox(
                                  //   height: 20,
                                  // ),
                                  Text(
                                    "We are going to launch plaid",
                                    style: GoogleFonts.poppins(
                                      fontSize: 19,
                                      fontWeight: FontWeight.w400,
                                      color: white,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 50,
                                  ),
                                  Container(
                                    height: 55,
                                    width:
                                        MediaQuery.of(context).size.width * 0.6,
                                    // ignore: deprecated_member_use
                                    child: RaisedButton(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      color: button,
                                      onPressed: () {
                                        _plaidLinkToken.open();
                                        Navigator.pop(context);
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "Get Started!",
                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.poppins(
                                                color: white,
                                                fontSize: 15,
                                                fontWeight: FontWeight.w700),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
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
}

class GDPData {
  GDPData(this.percentage, this.name, this.amount, this.color);
  final percentage;
  final name;
  final amount;
  final Color color;
}
