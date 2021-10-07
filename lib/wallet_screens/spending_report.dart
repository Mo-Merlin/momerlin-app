import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:momerlin/data/localstorage/userdata_source.dart';
import 'package:momerlin/theme/theme.dart';
import 'package:momerlin/wallet_screens/wallet_profile.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
//import 'package:syncfusion_flutter_charts/sparkcharts.dart';
import 'package:percent_indicator/percent_indicator.dart';
//import 'package:pie_chart/pie_chart.dart';
//import 'package:fl_chart/fl_chart.dart';

class SpendingReport extends StatefulWidget {
  const SpendingReport({Key key}) : super(key: key);

  @override
  _SpendingReportState createState() => _SpendingReportState();
}

class _SpendingReportState extends State<SpendingReport> {
  bool isWeek = true;
  bool isMonth = false;
  bool isYear = false;
  bool isAll = false;
  var selectType;

  bool isVisibleInfo = true;
  bool chartClick = true;
  List<GDPData> _chartData;
  TooltipBehavior _tooltipBehavior;
  Map<String, double> dataMap = {
    "Flutter": 5,
    "React": 1,
    "Xamarin": 1,
  };

  var balance = 0.00;
  var userLanguage, lang = [];
  @override
  void initState() {
    super.initState();
    getUserLanguage();
    _chartData = getChartData();
    _tooltipBehavior = TooltipBehavior(enable: true);
  }

  // ignore: todo
  //TODO :languagestart
  Future<void> getUserLanguage() async {
    lang = await UserDataSource().getLanguage();
    if (lang.length != null && lang.length != 0) {
      userLanguage = lang[0];
    }
  }

  // ignore: todo
  //TODO: LanguageEnd

  List spendingElements = [
    {
      "image": "berger",
      "title": "Food",
      "subtitle": "134 Transactions",
      "value": "-1654.12",
      "type": "Gwei",
      "percentage": "53%",
    },
    {
      "image": "coffee",
      "title": "Coffee",
      "subtitle": "24 Transactions",
      "value": "-254.12",
      "type": "Gwei",
      "percentage": "27%",
    },
    {
      "image": "spendingcoin",
      "title": "Transfers",
      "subtitle": "12 Transactions",
      "value": "-125.21",
      "type": "Gwei",
      "percentage": "20%",
    },
    {
      "image": "berger",
      "title": "Food",
      "subtitle": "134 Transactions",
      "value": "-1654.12",
      "type": "Gwei",
      "percentage": "53%",
    },
    {
      "image": "coffee",
      "title": "Coffee",
      "subtitle": "24 Transactions",
      "value": "-254.12",
      "type": "Gwei",
      "percentage": "27%",
    },
    {
      "image": "spendingcoin",
      "title": "Transfers",
      "subtitle": "12 Transactions",
      "value": "-125.21",
      "type": "Gwei",
      "percentage": "20%",
    },
  ];
  var spendingColors = [
    spendingBlue,
    spendingPink,
    spendingGreen,
    spendingBlue,
    spendingPink,
    spendingGreen,
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  userLanguage['spendingReports'] != null)
              ? "${userLanguage['spendingReports']}"
              : "SPENDING REPORTS",
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
      body: Stack(
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
                        top: 40,
                        child: Row(
                          children: [
                            Text(
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
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              balance.toStringAsFixed(2),
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
                      InkWell(
                        onTap: () {
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
                      InkWell(
                        onTap: () {
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
                                  borderRadius: BorderRadius.circular(25),
                                )
                              : BoxDecoration(),
                          child: Center(
                            child: Text(
                              "1M",
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: isMonth == true ? white : text1,
                              ),
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
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
                      InkWell(
                        onTap: () {
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
                  child: GestureDetector(
                    onTap: () {
                      isVisibleInfo = !isVisibleInfo;
                    },
                    child: SfCircularChart(
                      palette: <Color>[
                        spendingBlue,
                        spendingPink,
                        spendingGreen,
                      ],
                      annotations: <CircularChartAnnotation>[
                        CircularChartAnnotation(
                          widget: Container(
                            /**  TEXT DESIGN 1 **/
                            child: Text(
                                'Select a portion\nof the chart to\nview details',
                                style: GoogleFonts.poppins(
                                    fontSize: 10, color: text1)),

                            /**  TEXT DESIGN 2 **/

                            // child: RichText(
                            //   text: TextSpan(
                            //     text: '            FOOD',
                            //     style: GoogleFonts.poppins(
                            //       fontSize: 10,
                            //       color: white,
                            //       fontWeight: FontWeight.w600,
                            //     ),
                            //     children: <TextSpan>[
                            //       TextSpan(
                            //         text: '\n 53%',
                            //         style: GoogleFonts.montserrat(
                            //           fontSize: 31,
                            //           fontWeight: FontWeight.w600,
                            //           color: white,
                            //         ),
                            //       ),
                            //     ],
                            //   ),
                            // ),
                          ),
                        )
                      ],
                      // title: ChartTitle(
                      //     text: "Select a portion of the chart to view details",
                      //     textStyle: GoogleFonts.poppins(
                      //       fontSize: 10,
                      //       color: text1,
                      //     )),
                      // legend: Legend(
                      //     isVisible: true,
                      //     overflowMode: LegendItemOverflowMode.wrap),
                      tooltipBehavior: _tooltipBehavior,
                      series: <CircularSeries>[
                        DoughnutSeries<GDPData, String>(
                          dataSource: _chartData,
                          xValueMapper: (GDPData data, _) => data.continent,
                          yValueMapper: (GDPData data, _) => data.gdp,
                          //dataLabelSettings: DataLabelSettings(isVisible: true),
                          enableTooltip: true,
                          selectionBehavior:
                              SelectionBehavior(enable: chartClick),
                          explode: false,
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 2,
                ),
                Visibility(
                  visible: isVisibleInfo,
                  child: Container(
                    height: 148,
                    width: 335,
                    decoration: BoxDecoration(
                      color: button,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 20, left: 20),
                          child: Text(
                            (lang.length != null &&
                                    lang.length != 0 &&
                                    userLanguage['info'] != null)
                                ? "${userLanguage['info']}"
                                : "Info",
                            style: GoogleFonts.poppins(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 5, left: 20),
                          child: RichText(
                            text: TextSpan(
                              text: 'You Spent',
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                color: text1,
                              ),
                              children: <TextSpan>[
                                TextSpan(
                                  text: ' 1654.12',
                                  style: GoogleFonts.montserrat(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                                TextSpan(
                                  text: ' Gwei',
                                  style: GoogleFonts.montserrat(
                                    fontSize: 10,
                                    color: Colors.orange,
                                  ),
                                ),
                                TextSpan(
                                  text:
                                      ' on food this month, that’s higher than normal.',
                                  style: GoogleFonts.montserrat(
                                    fontSize: 14,
                                    color: text1,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10, left: 20),
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
                        padding: const EdgeInsets.only(top: 15, left: 15),
                        child: ListTile(
                          title: Text(
                            'Expenses',
                            style: GoogleFonts.poppins(
                              fontSize: 17,
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                      // Padding(
                      //   padding: const EdgeInsets.only(top: 70),
                      //   child: Container(
                      //     height: 2,
                      //     width: 150,
                      //     decoration: BoxDecoration(
                      //         color: grey,
                      //         borderRadius: BorderRadius.circular(10)),
                      //   ),
                      // ),
                      Padding(
                        padding: const EdgeInsets.only(top: 40),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          // controller: myscrollController,
                          itemCount: spendingElements.length,
                          // padding: EdgeInsets.zero,
                          itemBuilder: (BuildContext context, int index) {
                            return ListTile(
                              leading: ClipRRect(
                                borderRadius: BorderRadius.circular(30),
                                child: Container(
                                  color: spendingColors[index],
                                  child: Image.asset(
                                    "assets/images/${spendingElements[index]['image']}.png",
                                    fit: BoxFit.none,
                                    width: 50,
                                    height: 50,
                                  ),
                                ),
                              ),
                              title: Text(
                                // "Food",
                                spendingElements[index]["title"],
                                style: GoogleFonts.poppins(
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              subtitle: Text(
                                spendingElements[index]['subtitle'],
                                style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  color: text1,
                                  // fontWeight: FontWeight.w500,
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
                                      spendingElements[index]['percentage'],
                                      style: GoogleFonts.montserrat(
                                        fontSize: 10,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    progressColor: spendingColors[index],
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Container(
                                    height: 40,
                                    width: 100,
                                    decoration: BoxDecoration(
                                      color: Color(0xff707070).withOpacity(0.4),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          spendingElements[index]['value'],
                                          style: GoogleFonts.poppins(
                                            fontSize: 12,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 2,
                                        ),
                                        Text(
                                          spendingElements[index]['type'],
                                          style: GoogleFonts.poppins(
                                            fontSize: 9,
                                            color: Colors.orange,
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

  List<GDPData> getChartData() {
    final List<GDPData> chartData = [
      GDPData('Food', 4000),
      GDPData('Coffee', 1400),
      GDPData('Transfers', 1420),
      // GDPData('Europe', 23050),
      // GDPData('N America', 24880),
      // GDPData('Asia', 34390),
    ];
    return chartData;
  }
}

class GDPData {
  GDPData(this.continent, this.gdp);
  final String continent;
  final int gdp;
}
