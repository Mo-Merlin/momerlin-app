import 'dart:async';

import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
// import 'package:intl/intl.dart';
import 'package:momerlin/data/localstorage/userdata_source.dart';
import 'package:momerlin/data/userrepository.dart';
import 'package:momerlin/models/myearningactivitymodel.dart';
import 'package:momerlin/pages/transaction/wallet_profile.dart';
import 'package:momerlin/tabscreen/tabscreen.dart';
import 'package:momerlin/theme/theme.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:timeago/timeago.dart' as timeago;

class MyEarnings extends StatefulWidget {
  const MyEarnings({Key key}) : super(key: key);

  @override
  _MyEarningsState createState() => _MyEarningsState();
}

class _MyEarningsState extends State<MyEarnings> {
  // List<SalesData> _chartData;
  // TooltipBehavior _tooltipBehavior;
  bool isHourChart = false;
  bool isWeekChart = false;
  bool isYearChart = false;
  bool isAllChart = true;

  //var selectChartType;

  bool isHour = false;
  bool isWeek = false;
  bool isYear = false;
  bool isAll = true;
  var selectType;
  var balance = 0.00;

  var userLanguage, lang, user = [];
  @override
  void initState() {
    super.initState();
    // getCoinsTimeSeries();
    getUserLanguage();
    // _chartData = getChartData();
    // _tooltipBehavior = TooltipBehavior(enable: true);
  }

  var currentTime = new DateTime.now();
  bool tweleve = true;
  bool week = false;
  bool loading = true;
  var gweibalance = "0";

  var difference = 0;
  // ignore: todo
  //TODO :languagestart
  Future<void> getUserLanguage() async {
    lang = await UserDataSource().getLanguage();

    user = await UserDataSource().getUser();
    var res = await UserRepository().getUser(user[0]["walletaddress"]);
    getmyEarningActivity();
    gweibalance = res["user"]["gwei"];
    // if (lang.length != null && lang.length != 0) {
    //   userLanguage = lang[0];
    // }
  }

  List<MyEarningActivity> myEarningActivity = [];
  Future<void> getmyEarningActivity() async {
    // ignore: unused_local_variable
    var res = await UserRepository().getmyEarningActivity(user[0]["uid"]);
    setState(() {
      loading = false;
    });
    dataJSON = [];
    print("pavithramanoharan ${res["activities"]}");
    if (res["success"] == true) {
      myEarningActivity = [];
      dataJSON = res["activities"];
      for (var i = 0; i < res["activities"].length; i++) {
        myEarningActivity.add(MyEarningActivity.fromJson(res["activities"][i]));
      }
    }
  }

  // ignore: todo
  //TODO: LanguageEnd
  List<HourChartData> hourChartData = <HourChartData>[
    HourChartData(x: DateTime(2015, 1, 1, 5), yValue: 1.13),
    HourChartData(x: DateTime(2015, 1, 2, 2), yValue: 1.12),
    HourChartData(x: DateTime(2015, 1, 3, 3), yValue: 1.08),
    HourChartData(x: DateTime(2015, 1, 4, 4), yValue: 1.12),
    HourChartData(x: DateTime(2015, 1, 5, 5), yValue: 1.1),
    HourChartData(x: DateTime(2015, 1, 6, 6), yValue: 1.12),
    HourChartData(x: DateTime(2015, 1, 7, 7), yValue: 1.1),
    HourChartData(x: DateTime(2015, 1, 8, 8), yValue: 1.12),
    HourChartData(x: DateTime(2015, 1, 9, 9), yValue: 1.16),
    HourChartData(x: DateTime(2015, 1, 12, 12), yValue: 1.1),
  ];
  List<WeekChartData> weekChartData = <WeekChartData>[
    WeekChartData(x: "Sun", y: 0),
    WeekChartData(x: "Mon", y: 10),
    WeekChartData(x: "Tue", y: 3),
    WeekChartData(x: "Wed", y: 6),
    WeekChartData(x: "Thu", y: 2),
    WeekChartData(x: "Fri", y: 12),
    WeekChartData(x: "Sat", y: 7),
  ];
  List<YearChartData> yearChartData = <YearChartData>[
    YearChartData(x: "Jan", y: 0),
    YearChartData(x: "Feb", y: 10),
    YearChartData(x: "Mar", y: 3),
    YearChartData(x: "Apr", y: 6),
    YearChartData(x: "May", y: 2),
    YearChartData(x: "Jun", y: 12),
    YearChartData(x: "Jul", y: 11),
    YearChartData(x: "Aug", y: 3),
    YearChartData(x: "Sep", y: 7),
    YearChartData(x: "Oct", y: 10),
    YearChartData(x: "Nov", y: 14),
    YearChartData(x: "Dec", y: 11),
  ];
  List<AllChartData> allChartData = <AllChartData>[
    AllChartData(x: "2021", y: 0),
    AllChartData(x: "2020", y: 10),
    AllChartData(x: "2019", y: 3),
    AllChartData(x: "2018", y: 6),
    AllChartData(x: "2017", y: 2),
    AllChartData(x: "2016", y: 12),
    AllChartData(x: "2015", y: 7),
  ];

  List earningElements = [
    {
      "image": "earntrophybrown",
      "title": "Walk Challenge Win",
      "subtitle": "Yesterday",
      "symbol": "+",
      "value": "500.00",
      "type": "Gwei",
      "percentage": "53%",
    },
    {
      "image": "earndown",
      "title": "2 days ago",
      "subtitle": "3 days ago",
      "symbol": "-",
      "value": "220.00",
      "type": "Gwei",
      "percentage": "27%",
    },
    {
      "image": "earntrophygold",
      "title": "Run Challenge Win",
      "subtitle": "Yesterday",
      "symbol": "+",
      "value": "1000.00",
      "type": "Gwei",
      "percentage": "20%",
    },
    {
      "image": "earndown",
      "title": "Walk Challenge Win",
      "subtitle": "3 days ago",
      "symbol": "-",
      "value": "27.00",
      "type": "Gwei",
      "percentage": "53%",
    },
    {
      "image": "earnup",
      "title": "August 30th",
      "subtitle": "4 days ago",
      "symbol": "-",
      "value": "300.00",
      "type": "Gwei",
      "percentage": "27%",
    },
    {
      "image": "earntrophygold",
      "title": "Run Challenge Win",
      "subtitle": "Yesterday",
      "symbol": "+",
      "value": "1000.00",
      "type": "Gwei",
      "percentage": "20%",
    },
  ];
  var earningColors = [
    earningOrange,
    earningBlue,
    spendingPink,
    earningBlue,
    earningBlue,
    spendingPink,
  ];

  var earningSymbolColor = [
    spendingGreen,
    spendingPink,
    spendingGreen,
    spendingPink,
    spendingPink,
    spendingGreen,
  ];

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
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (_) => Tabscreen(
                          index: 1,
                        ),
                      ),
                    );
                  },
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  )),
            ),
          ),
        ),
        title: Text(
          // (lang.length != null &&
          //         lang.length != 0 &&
          //         userLanguage['myearnings'] != null)
          //     ? "${userLanguage['myearnings']}"
          //     :
          "MY EARNINGS",
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
                                height: 130,
                                fit: BoxFit.fill,
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
                      Container(
                        height: 56,
                        width: 280,
                        decoration: BoxDecoration(
                          color: Colors.black12,
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            GestureDetector(
                              onTap: () {
                                selectType = "";

                                setState(() {
                                  selectType = "Hour";
                                  isHour = false;
                                  isWeek = false;
                                  isYear = false;
                                  isAll = false;

                                  isHourChart = true;
                                  isWeekChart = false;
                                  isYearChart = false;
                                  isAllChart = true;
                                });
                              },
                              child: Container(
                                height: 48,
                                width: 70,
                                decoration: isHour == true
                                    ? BoxDecoration(
                                        color: button,
                                        borderRadius: BorderRadius.circular(25),
                                      )
                                    : BoxDecoration(),
                                child: Center(
                                  child: Text(
                                    "12H",
                                    style: GoogleFonts.poppins(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: isHour == true ? white : text1,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                selectType = "";
                                setState(() {
                                  selectType = "Week";
                                  isWeek = true;
                                  isHour = false;
                                  isYear = false;
                                  isAll = false;
                                  isHourChart = false;
                                  isWeekChart = true;
                                  isYearChart = false;
                                  isAllChart = false;
                                });
                              },
                              child: Container(
                                height: 48,
                                width: 70,
                                decoration: isWeek == true
                                    ? BoxDecoration(
                                        color: button,
                                        borderRadius: BorderRadius.circular(25),
                                      )
                                    : BoxDecoration(),
                                child: Center(
                                  child: Text(
                                    "1W",
                                    style: GoogleFonts.poppins(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: isWeek == true ? white : text1,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                selectType = "";
                                setState(() {
                                  selectType = "Year";
                                  isYear = false;
                                  isWeek = false;
                                  isHour = false;
                                  isAll = false;
                                  isHourChart = false;
                                  isWeekChart = false;
                                  isYearChart = true;
                                  isAllChart = true;
                                });
                              },
                              child: Container(
                                height: 48,
                                width: 70,
                                decoration: isYear == true
                                    ? BoxDecoration(
                                        color: button,
                                        borderRadius: BorderRadius.circular(25),
                                      )
                                    : BoxDecoration(),
                                child: Center(
                                  child: Text(
                                    "1Y",
                                    style: GoogleFonts.poppins(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: isYear == true ? white : text1,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                selectType = "";
                                setState(() {
                                  selectType = "All";
                                  isAll = true;
                                  isHour = false;
                                  isWeek = false;
                                  isYear = false;
                                  isHourChart = false;
                                  isWeekChart = false;
                                  isYearChart = false;
                                  isAllChart = true;
                                });
                              },
                              child: Container(
                                height: 48,
                                width: 70,
                                decoration: isAll == true
                                    ? BoxDecoration(
                                        color: button,
                                        borderRadius: BorderRadius.circular(25),
                                      )
                                    : BoxDecoration(),
                                child: Center(
                                  child: Text(
                                    (lang.length != null &&
                                            lang.length != 0 &&
                                            userLanguage['all'] != null)
                                        ? "${userLanguage['all']}"
                                        : "ALL",
                                    style: GoogleFonts.poppins(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: isAll == true ? white : text1,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),

                      SizedBox(
                        height: 30,
                      ),

                      /**Fl chart */

                      // Padding(
                      //   padding: const EdgeInsets.only(right: 20),
                      //   child: Container(
                      //     height: 300,
                      //     width: 400,
                      //     child: LineChart(
                      //       LineChartData(
                      //           borderData: FlBorderData(show: false),
                      //           lineBarsData: [
                      //             LineChartBarData(
                      //                 spots: [
                      //                   FlSpot(1, 3),
                      //                   FlSpot(2, 10),
                      //                   FlSpot(3, 7),
                      //                   FlSpot(4, 12),
                      //                   FlSpot(5, 13),
                      //                   FlSpot(6, 17),
                      //                   FlSpot(7, 15),
                      //                   FlSpot(8, 20),
                      //                 ],
                      //                 isCurved: true,
                      //                 colors: [Colors.orange])
                      //           ]),
                      //     ),
                      //   ),
                      // ),

                      /*****Beziwer chart */
                      // Container(
                      //   //color: Colors.red,
                      //   height: MediaQuery.of(context).size.height / 3,
                      //   width: MediaQuery.of(context).size.width * 0.9,
                      //   child: BezierChart(
                      //     bezierChartScale: BezierChartScale.CUSTOM,
                      //     xAxisCustomValues: const [0, 5, 10, 15, 20, 25, 30, 35],
                      //     series: const [
                      //       BezierLine(
                      //         data: const [
                      //           DataPoint<double>(value: 10, xAxis: 0),
                      //           DataPoint<double>(value: 130, xAxis: 5),
                      //           DataPoint<double>(value: 50, xAxis: 10),
                      //           DataPoint<double>(value: 150, xAxis: 15),
                      //           DataPoint<double>(value: 75, xAxis: 20),
                      //           DataPoint<double>(value: 0, xAxis: 25),
                      //           DataPoint<double>(value: 5, xAxis: 30),
                      //           DataPoint<double>(value: 45, xAxis: 35),
                      //         ],
                      //       ),
                      //     ],
                      //     config: BezierChartConfig(
                      //       verticalIndicatorStrokeWidth: 3.0,
                      //       bubbleIndicatorColor: Colors.orange,
                      //       footerHeight: 40,
                      //       verticalIndicatorColor: Colors.white,
                      //       showVerticalIndicator: true,
                      //       //backgroundColor: Colors.red,
                      //       snap: true,
                      //     ),
                      //   ),
                      // ),
                      /****** syncfusion chart 1****** */
                      // Container(
                      //   height: 300,
                      //   //color: Colors.amberAccent,
                      //   child: SfCartesianChart(
                      //     //title: ChartTitle(text: 'Yearly sales analysis'),
                      //     // legend: Legend(isVisible: true),
                      //     tooltipBehavior: _tooltipBehavior,
                      //     series: <ChartSeries>[
                      //       LineSeries<SalesData, double>(
                      //         color: Colors.orange,
                      //         //name: 'Sales',
                      //         dataSource: _chartData,
                      //         xValueMapper: (SalesData sales, _) => sales.year,
                      //         yValueMapper: (SalesData sales, _) => sales.sales,
                      //         // dataLabelSettings: DataLabelSettings(
                      //         //     isVisible: true, color: Colors.orange),

                      //         enableTooltip: true,
                      //       ),
                      //     ],
                      //     primaryXAxis: NumericAxis(
                      //       edgeLabelPlacement: EdgeLabelPlacement.shift,
                      //     ),
                      //     // primaryYAxis: NumericAxis(
                      //     //     labelFormat: '{value}M',
                      //     //     numberFormat:
                      //     //         NumberFormat.simpleCurrency(decimalDigits: 0)),
                      //   ),
                      // ),

                      /**HOUR CHART */
                      Visibility(
                        visible: isHourChart,
                        child: Container(
                          height: 300,
                          width: 350,
                          child: SfCartesianChart(
                            zoomPanBehavior: ZoomPanBehavior(
                              enablePinching: true,
                              zoomMode: ZoomMode.x,
                              enablePanning: true,
                            ),
                            enableAxisAnimation: true,
                            tooltipBehavior: TooltipBehavior(
                                enable: true, color: Colors.orange),
                            isTransposed: false,
                            backgroundColor: backgroundcolor,

                            //Specifying date time interval type as hours
                            primaryXAxis: DateTimeAxis(
                                interval: 6,
                                majorGridLines: MajorGridLines(width: 0),
                                edgeLabelPlacement: EdgeLabelPlacement.shift,
                                intervalType: DateTimeIntervalType.hours),
                            series: <ChartSeries<HourChartData, DateTime>>[
                              SplineSeries<HourChartData, DateTime>(
                                color: Colors.orange,
                                dataSource: hourChartData,
                                xValueMapper: (HourChartData sales, _) =>
                                    sales.x,
                                yValueMapper: (HourChartData sales, _) =>
                                    sales.yValue,
                                // name: 'Sales',
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      /**WEEK CHART */
                      Visibility(
                        visible: isWeekChart,
                        child: Container(
                          height: 300,
                          width: 350,
                          // color: Colors.amber,
                          // child: Text("WEEK CHART"),
                          child: SfCartesianChart(
                            zoomPanBehavior: ZoomPanBehavior(
                              enablePinching: true,
                              zoomMode: ZoomMode.x,
                              enablePanning: true,
                            ),
                            enableAxisAnimation: true,
                            tooltipBehavior: TooltipBehavior(
                                enable: true, color: Colors.orange),
                            isTransposed: false,
                            backgroundColor: backgroundcolor,

                            //Specifying date time interval type as hours
                            primaryXAxis: CategoryAxis(
                              interval: 1,
                              majorGridLines: MajorGridLines(width: 0),
                              edgeLabelPlacement: EdgeLabelPlacement.shift,
                            ),
                            series: <ChartSeries<WeekChartData, String>>[
                              SplineSeries<WeekChartData, String>(
                                color: Colors.orange,
                                dataSource: weekChartData,
                                xValueMapper: (WeekChartData sales, _) =>
                                    sales.x,
                                yValueMapper: (WeekChartData sales, _) =>
                                    sales.y,
                                name: 'Sales',
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      /**YEAR CHART */
                      Visibility(
                        visible: isYearChart,
                        child: Container(
                          height: 300,
                          width: 350,
                          //color: Colors.blueAccent,
                          //child: Text("YEAR CHART"),
                          child: SfCartesianChart(
                            zoomPanBehavior: ZoomPanBehavior(
                              enablePinching: true,
                              zoomMode: ZoomMode.x,
                              enablePanning: true,
                            ),
                            enableAxisAnimation: true,

                            tooltipBehavior: TooltipBehavior(
                                enable: true, color: Colors.orange),
                            isTransposed: false,
                            backgroundColor: backgroundcolor,

                            primaryXAxis: CategoryAxis(
                              labelRotation: -50,
                              interval: 1,
                              majorGridLines: MajorGridLines(width: 0),
                              edgeLabelPlacement: EdgeLabelPlacement.shift,
                              //intervalType: DateTimeIntervalType.years,
                            ),
                            series: <SplineSeries<YearChartData, String>>[
                              SplineSeries<YearChartData, String>(
                                  color: Colors.orange,
                                  dataSource: yearChartData,
                                  xValueMapper: (YearChartData sales, _) =>
                                      sales.x,
                                  yValueMapper: (YearChartData sales, _) =>
                                      sales.y,
                                  dataLabelSettings: DataLabelSettings(
                                      isVisible:
                                          false) // Enables the data label.
                                  )
                            ],
                            //Specifying date time interval type as hours
                          ),
                        ),
                      ),

                      SizedBox(
                        height: 10,
                      ),
                      /**ALL CHART */ /**YEAR CHART */
                      Visibility(
                        visible: isAllChart,
                        child: Container(
                          height: 300,
                          width: 450,
                          child: chartWidget(),
                          //color: Colors.blueAccent,
                          //child: Text("YEAR CHART"),
                          // child: SfCartesianChart(
                          //   zoomPanBehavior: ZoomPanBehavior(
                          //     enablePinching: true,
                          //     zoomMode: ZoomMode.x,
                          //     enablePanning: true,
                          //   ),
                          //   enableAxisAnimation: true,

                          //   tooltipBehavior: TooltipBehavior(
                          //       enable: true, color: Colors.orange),
                          //   isTransposed: false,
                          //   backgroundColor: backgroundcolor,

                          //   primaryXAxis: CategoryAxis(
                          //     interval: 1,
                          //     majorGridLines: MajorGridLines(width: 0),
                          //     edgeLabelPlacement: EdgeLabelPlacement.shift,
                          //     //intervalType: DateTimeIntervalType.years,
                          //   ),
                          //   series: <SplineSeries<AllChartData, String>>[
                          //     SplineSeries<AllChartData, String>(
                          //         color: Colors.orange,
                          //         dataSource: allChartData,
                          //         xValueMapper: (AllChartData sales, _) =>
                          //             sales.x,
                          //         yValueMapper: (AllChartData sales, _) =>
                          //             sales.y,
                          //         dataLabelSettings: DataLabelSettings(
                          //             isVisible:
                          //                 false) // Enables the data label.
                          //         )
                          //   ],
                          //   //Specifying date time interval type as hours
                          // ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: button,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(40),
                            topRight: Radius.circular(40),
                          ),
                        ),
                        //color: button,
                        child: Stack(
                          // crossAxisAlignment: CrossAxisAlignment,
                          alignment: Alignment.topCenter,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: Container(
                                height: 4,
                                width: 50,
                                decoration: BoxDecoration(
                                    color: text1,
                                    borderRadius: BorderRadius.circular(10)),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 20, left: 10),
                              child: ListTile(
                                title: Text(
                                  (lang.length != null &&
                                          lang.length != 0 &&
                                          userLanguage['activity'] != null)
                                      ? "${userLanguage['activity']}"
                                      : "Activity",
                                  style: GoogleFonts.poppins(
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 40),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  // Padding(
                                  //   padding: const EdgeInsets.only(left: 20),
                                  //   child: Text(
                                  //     (lang.length != null &&
                                  //             lang.length != 0 &&
                                  //             userLanguage['expenses'] != null)
                                  //         ? "${userLanguage['expenses']}"
                                  //         : "Expenses",
                                  //     style: GoogleFonts.poppins(
                                  //       fontSize: 20,
                                  //       color: Colors.white,
                                  //       fontWeight: FontWeight.w500,
                                  //     ),
                                  //   ),
                                  // ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 70),
                              // top: 50,
                              child: ListView.builder(
                                reverse: true,
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                // controller: myscrollController,
                                itemCount: myEarningActivity.length,
                                // padding: EdgeInsets.zero,
                                itemBuilder: (BuildContext context, int index) {
                                  return ListTile(
                                    leading: ClipRRect(
                                      borderRadius: BorderRadius.circular(30),
                                      child: Container(
                                        color: HexColor(
                                            myEarningActivity[index].color),
                                        child: Image.network(
                                          myEarningActivity[index].image,
                                          fit: BoxFit.none,
                                          width: 50,
                                          height: 50,
                                        ),
                                      ),
                                    ),
                                    title: Text(myEarningActivity[index].title,
                                        style: textsize),
                                    subtitle: Text(
                                      timeago.format(
                                          myEarningActivity[index].date),
                                      // earningElements[index]['subtitle'],
                                      style: GoogleFonts.poppins(
                                        fontSize: 9,
                                        color: text1,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    trailing: Container(
                                      height: 40,
                                      width: 100,
                                      decoration: BoxDecoration(
                                        color:
                                            Color(0xff707070).withOpacity(0.4),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(myEarningActivity[index].amount,
                                              style: textsize),
                                          SizedBox(
                                            width: 2,
                                          ),
                                          Text(
                                            " Gwei",
                                            style: GoogleFonts.poppins(
                                              fontSize: 9,
                                              color: Colors.orange,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                  // return transactions1[index].merchantName == null
                                  //     ? SizedBox()
                                  //     : Column(
                                  //         children: [
                                  //           SizedBox(
                                  //             height: 5,
                                  //           ),
                                  //           Container(
                                  //             child: ListTile(
                                  //               // contentPadding: EdgeInsets.only(
                                  //               //     top: 0, bottom: 0),
                                  //               //   leading: ClipRRect(
                                  //               //     borderRadius: BorderRadius.circular(30),
                                  //               //     child: Container(
                                  //               //         height: 60,
                                  //               //         width: 60,
                                  //               //         color: Colors.black54,
                                  //               //         child: Image.network(
                                  //               //           "https://c.static-nike.com/a/images/w_1920,c_limit/mdbgldn6yg1gg88jomci/image.jpg",
                                  //               //           fit: BoxFit.cover,
                                  //               //         )),
                                  //               //   ),
                                  //               title: Container(
                                  //                 padding: EdgeInsets.only(left: 20),
                                  //                 child: Text(
                                  //                   transactions1[index].merchantName,
                                  //                   style: GoogleFonts.poppins(
                                  //                       fontSize: 18,
                                  //                       fontWeight: FontWeight.w600,
                                  //                       color: Colors.white),
                                  //                 ),
                                  //               ),
                                  //               subtitle: Container(
                                  //                 padding: EdgeInsets.only(left: 20),
                                  //                 child: Text(
                                  //                   (DateFormat.yMMMd().format(
                                  //                           transactions1[index].date))
                                  //                       .toString(),
                                  //                   style: GoogleFonts.poppins(
                                  //                     fontSize: 12,
                                  //                     color: Color(0xff9395A4),
                                  //                   ),
                                  //                 ),
                                  //               ),
                                  //               trailing: Container(
                                  //                 height: 40,
                                  //                 width: 100,
                                  //                 decoration: BoxDecoration(
                                  //                   color: Color(0xff707070)
                                  //                       .withOpacity(0.4),
                                  //                   borderRadius:
                                  //                       BorderRadius.circular(10),
                                  //                 ),
                                  //                 child: Stack(
                                  //                   alignment: Alignment.center,
                                  //                   children: [
                                  //                     Positioned(
                                  //                       left: 14,
                                  //                       top: 15,
                                  //                       child: Text(
                                  //                         ((transactions1[index]
                                  //                                         .amount -
                                  //                                     transactions1[
                                  //                                             index]
                                  //                                         .amount
                                  //                                         .floorToDouble()) *
                                  //                                 100)
                                  //                             .toStringAsFixed(1),
                                  //                         style: GoogleFonts.montserrat(
                                  //                           fontSize: 12,
                                  //                           fontWeight: FontWeight.w500,
                                  //                           color: Colors.white,
                                  //                         ),
                                  //                       ),
                                  //                     ),
                                  //                     Positioned(
                                  //                       left: 50,
                                  //                       top: 15,
                                  //                       child: Text(
                                  //                         ' Gwei',
                                  //                         style: GoogleFonts.montserrat(
                                  //                           fontSize: 12,
                                  //                           color: Colors.orangeAccent,
                                  //                         ),
                                  //                       ),
                                  //                     ),
                                  //                   ],
                                  //                 ),
                                  //               ),
                                  //             ),
                                  //           ),
                                  //         ],
                                  //       );
                                },
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
    );
  }
  //  Future<void> getCoinsTimeSeries() async {
  //   String url =
  //       "https://min-api.cryptocompare.com/data/histoday?fsym=ETH&tsym=USD&limit=360&aggregate=1&e=CCCAGG";
  //   var response = await http
  //       .get(Uri.encodeFull(url), headers: {"Accept": "application/json"});

  //   if (this.mounted) {
  //     this.setState(() {
  //       var extractdata = json.decode(response.body);
  //       dataJSON = extractdata["Data"];
  //     });
  //   }
  // }

  List dataJSON;
  Widget chartWidget() {
    List<TimeSeriesPrice> tsdata = [];
    if (dataJSON != null) {
      for (Map m in dataJSON) {
        try {
          print("PAVITHRA");
          print(DateTime.parse(m['date']));
          tsdata.add(
              new TimeSeriesPrice(DateTime.now(), double.parse(m['amount'])));
        } catch (e) {
          print(e.toString());
        }
      }
    } else {
      // Dummy list to prevent dataJSON = NULL
      tsdata.add(new TimeSeriesPrice(new DateTime.now(), 0.0));
    }
    print("PAVITHRA");
    print(tsdata[0].time.runtimeType);

    var series = [
      new charts.Series<TimeSeriesPrice, DateTime>(
        id: 'Price',
        colorFn: (_, __) => charts.MaterialPalette.deepOrange.shadeDefault,
        domainFn: (TimeSeriesPrice coinsPrice, _) => coinsPrice.time,
        measureFn: (TimeSeriesPrice coinsPrice, _) => coinsPrice.price,
        data: tsdata,
      ),
    ];

    var chart = new charts.TimeSeriesChart(
      series,
      animate: true,
      animationDuration: Duration(seconds: 2),
      defaultRenderer:
          charts.LineRendererConfig(includeArea: true, stacked: true),
      primaryMeasureAxis: new charts.NumericAxisSpec(
        tickProviderSpec:
            new charts.BasicNumericTickProviderSpec(desiredTickCount: 6),
      ),

      domainAxis: new charts.DateTimeAxisSpec(
        tickFormatterSpec: new charts.AutoDateTimeTickFormatterSpec(
          day: new charts.TimeFormatterSpec(
              format: 'MM/dd', transitionFormat: 'MM/dd'),
        ),
      ),
      behaviors: [
        new charts.ChartTitle('Gwei',
            titleStyleSpec: charts.TextStyleSpec(
                color: charts.ColorUtil.fromDartColor(orange)),
            behaviorPosition: charts.BehaviorPosition.start,
            titleOutsideJustification:
                charts.OutsideJustification.middleDrawArea),
      ],
      // defaultRenderer: new charts.LineRendererConfig(includePoints: true)
    );

    return new Container(
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          new Padding(
            padding: new EdgeInsets.only(left: 5),
            child: new SizedBox(
              height: 300.0,
              width: 600,
              child: chart,
            ),
          ),
        ],
      ),
    );
  }

  List<SalesData> getChartData() {
    final List<SalesData> chartData = [
      SalesData(2017, 25),
      SalesData(2018, 12),
      SalesData(2019, 24),
      SalesData(2020, 18),
      SalesData(2021, 30)
    ];
    return chartData;
  }
}

class SalesData {
  SalesData(this.year, this.sales);
  final double year;
  final double sales;
}

class HourChartData {
  HourChartData({this.x, this.yValue});

  final DateTime x;
  final double yValue;
}

class WeekChartData {
  WeekChartData({this.x, this.y});

  final String x;
  final double y;
}

class YearChartData {
  YearChartData({this.x, this.y});

  final String x;
  final double y;
}

class AllChartData {
  AllChartData({this.x, this.y});

  final String x;
  final double y;
}

class TimeSeriesPrice {
  final DateTime time;
  final double price;
  TimeSeriesPrice(this.time, this.price);
}
