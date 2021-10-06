import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:momerlin/data/localstorage/userdata_source.dart';
import 'package:momerlin/theme/theme.dart';
// import 'package:momerlin/wallet_screens/my_earnings_expenses.da÷rt';
import 'package:momerlin/wallet_screens/wallet_profile.dart';
//import 'package:syncfusion_flutter_charts/charts.dart';
// import 'package:intl/intl.dart';
//import 'package:bezier_chart/bezier_chart.dart';
import 'package:fl_chart/fl_chart.dart';

class MyEarnings extends StatefulWidget {
  const MyEarnings({Key key}) : super(key: key);

  @override
  _MyEarningsState createState() => _MyEarningsState();
}

class _MyEarningsState extends State<MyEarnings> {
  // List<SalesData> _chartData;
  // TooltipBehavior _tooltipBehavior;

  var balance = 0.00;

  var userLanguage, lang = [];
  @override
  void initState() {
    super.initState();
    getUserLanguage();
    // _chartData = getChartData();
    // _tooltipBehavior = TooltipBehavior(enable: true);
  }

  bool tweleve = true;
  bool week = false;

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
                  )),
            ),
          ),
        ),
        title: Text(
          (lang.length != null &&
                  lang.length != 0 &&
                  userLanguage['myearnings'] != null)
              ? "${userLanguage['myearnings']}"
              : "MY EARNINGS",
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
                          height: 130,
                          fit: BoxFit.fill,
                        ),
                      ),
                      // Positioned(
                      //   top: 45,
                      //   child: Container(
                      //     //color: Colors.amber,
                      //     child: Row(
                      //       crossAxisAlignment: CrossAxisAlignment.center,
                      //       mainAxisAlignment: MainAxisAlignment.start,
                      //       children: [
                      //         Padding(
                      //           padding: const EdgeInsets.all(5.0),
                      //           child: ClipRRect(
                      //             borderRadius: BorderRadius.circular(30),
                      //             child: Container(
                      //               color: button,
                      //               child: IconButton(
                      //                   onPressed: () {
                      //                     Navigator.pop(context);
                      //                   },
                      //                   icon: Icon(
                      //                     Icons.arrow_back,
                      //                     color: Colors.white,
                      //                   )),
                      //             ),
                      //           ),
                      //         ),
                      //         SizedBox(
                      //           width: 15,
                      //         ),
                      //         Text(
                      //           (lang.length != null &&
                      //                   lang.length != 0 &&
                      //                   userLanguage['myearnings'] != null)
                      //               ? "${userLanguage['myearnings']}"
                      //               : "MY EARNINGS",
                      //           textAlign: TextAlign.center,
                      //           style: GoogleFonts.poppins(
                      //               color: white,
                      //               fontSize: 15,
                      //               fontWeight: FontWeight.w700),
                      //         ),
                      //         SizedBox(
                      //           width: MediaQuery.of(context).size.width / 2.7,
                      //         ),
                      //         Padding(
                      //           padding: const EdgeInsets.all(5.0),
                      //           child: InkWell(
                      //             onTap: () {
                      //               Navigator.push(
                      //                   context,
                      //                   MaterialPageRoute(
                      //                       builder: (context) =>
                      //                           WalletProfile()));
                      //             },
                      //             child: ClipRRect(
                      //               borderRadius: BorderRadius.circular(30),
                      //               child: Container(
                      //                 color: button,
                      //                 child: Image.asset(
                      //                   "assets/images/profile.png",
                      //                   fit: BoxFit.fill,
                      //                   width: 46,
                      //                   height: 46,
                      //                 ),
                      //               ),
                      //             ),
                      //           ),
                      //         ),
                      //       ],
                      //     ),
                      //   ),
                      // ),
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
                      GestureDetector(
                        onTap: () {
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => MyEarningsExpenses()));
                        },
                        child: Container(
                          height: 48,
                          width: 70,
                          decoration: BoxDecoration(
                            color: button,
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: Center(
                            child: Text(
                              "12H",
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: 48,
                        width: 70,
                        child: Center(
                          child: Text(
                            "1W",
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: text1,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: 48,
                        width: 70,
                        child: Center(
                          child: Text(
                            "1Y",
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: text1,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: 48,
                        width: 70,
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
                              color: text1,
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
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: Container(
                    height: 300,
                    width: 400,
                    child: LineChart(
                      LineChartData(
                          borderData: FlBorderData(show: false),
                          lineBarsData: [
                            LineChartBarData(
                                spots: [
                                  FlSpot(1, 3),
                                  FlSpot(2, 10),
                                  FlSpot(3, 7),
                                  FlSpot(4, 12),
                                  FlSpot(5, 13),
                                  FlSpot(6, 17),
                                  FlSpot(7, 15),
                                  FlSpot(8, 20),
                                ],
                                isCurved: true,
                                colors: [Colors.orange])
                          ]),
                    ),
                  ),
                ),

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
                /****** old chart 1****** */
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
                          height: 2,
                          width: 50,
                          decoration: BoxDecoration(
                              color: grey,
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
                          itemCount: 20,
                          // padding: EdgeInsets.zero,
                          itemBuilder: (BuildContext context, int index) {
                            return ListTile(
                              leading: ClipRRect(
                                borderRadius: BorderRadius.circular(30),
                                child: Container(
                                  color: button,
                                  child: Image.asset(
                                    "assets/images/profile.png",
                                    fit: BoxFit.fill,
                                    width: 46,
                                    height: 46,
                                  ),
                                ),
                              ),
                              title: Text(
                                'Walk Challenge Win',
                                style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              subtitle: Text(
                                'Yesterday',
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
                                  color: Color(0xff707070).withOpacity(0.4),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      '+ 500',
                                      style: GoogleFonts.poppins(
                                        fontSize: 12,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Text(
                                      'Gwei',
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
