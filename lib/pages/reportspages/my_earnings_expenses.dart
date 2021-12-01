import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:momerlin/data/localstorage/userdata_source.dart';
import 'package:momerlin/pages/transaction/wallet_profile.dart';
import 'package:momerlin/theme/theme.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class MyEarningsExpenses extends StatefulWidget {
  const MyEarningsExpenses({Key key}) : super(key: key);

  @override
  _MyEarningsExpensesState createState() => _MyEarningsExpensesState();
}

class _MyEarningsExpensesState extends State<MyEarningsExpenses> {
  List<GDPData> _chartData;
  TooltipBehavior _tooltipBehavior;

  var balance = 0.00;
  var imageFile="";
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundcolor,
      appBar: AppBar(
        backgroundColor: blue1,
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
                          fit: BoxFit.cover,
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
                                fontSize: 60,
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
                      Container(
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
                Container(
                  height: 300,
                  //color: Colors.amberAccent,
                  child: SfCircularChart(
                    palette: <Color>[
                      blue1,
                      Colors.pinkAccent,
                      Colors.greenAccent,
                    ],
                    title: ChartTitle(
                        text: "Select a portion of the chart to view details",
                        textStyle: GoogleFonts.poppins(
                          fontSize: 10,
                          color: text1,
                        )),
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
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 400,
                )
              ],
            ),
          ),
          DraggableScrollableSheet(
            initialChildSize: 0.22,
            minChildSize: 0.22,
            maxChildSize: 0.4,
            builder: (BuildContext context, myscrollController) {
              return Container(
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
                      padding: const EdgeInsets.only(top: 40),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Text(
                              (lang.length != null &&
                                      lang.length != 0 &&
                                      userLanguage['expenses'] != null)
                                  ? "${userLanguage['expenses']}"
                                  : "Expenses",
                              style: GoogleFonts.poppins(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 50),
                      // top: 50,
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: AlwaysScrollableScrollPhysics(),
                        controller: myscrollController,
                        itemCount: 20,
                        // padding: EdgeInsets.zero,
                        itemBuilder: (BuildContext context, int index) {
                          return ListTile(
                            leading: ClipRRect(
                              borderRadius: BorderRadius.circular(30),
                              child: Container(
                                color: blue1,
                                child: Image.asset(
                                  "assets/images/berger.png",
                                  fit: BoxFit.contain,
                                  width: 46,
                                  height: 46,
                                ),
                              ),
                            ),
                            title: Text(
                              'Food',
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            subtitle: Text(
                              '134 Transactions',
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
                        },
                      ),
                    ),
                  ],
                ),
              );
            },
          )
        ],
      ),
    );
  }

  List<GDPData> getChartData() {
    final List<GDPData> chartData = [
      GDPData('Oceania', 4000),
      GDPData('Africa', 1400),
      GDPData('S America', 1420),
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
