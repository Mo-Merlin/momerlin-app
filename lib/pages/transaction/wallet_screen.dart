//import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:momerlin/data/localstorage/userdata_source.dart';
import 'package:momerlin/data/userrepository.dart';
import 'package:momerlin/models/transactionmodel.dart';
import 'package:momerlin/pages/transaction/walletsend.dart';
//import 'package:momerlin/tabscreen/tabscreen.dart';
import 'package:momerlin/theme/theme.dart';
import 'package:momerlin/wallet%20api/eth_formetter.dart';
import 'package:momerlin/wallet%20api/wallet_api.dart';
import 'package:plaid_flutter/plaid_flutter.dart';

// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'wallet_profile.dart';
import 'wallet_receive.dart';
//import 'wallet_send.dart';

class Dialogs {
  static Future<void> showLoadingDialog(
      BuildContext context, GlobalKey key) async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new WillPopScope(
            onWillPop: () async => false,
            child: SimpleDialog(
              key: key,
              backgroundColor: Colors.black54,
              children: <Widget>[
                Center(
                  child: Column(
                    children: [
                      CircularProgressIndicator(),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Please Wait....",
                        style: TextStyle(color: Colors.blueAccent),
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }
}

// Future<void> _handleSubmit(BuildContext context) async {
//   try {
//     Dialogs.showLoadingDialog(context, _keyLoader); //invoking login
//     await serivce.login(user.uid);
//     Navigator.of(_keyLoader.currentContext, rootNavigator: true)
//         .pop(); //close the dialoge
//     Navigator.pushReplacementNamed(context, "/home");
//   } catch (error) {
//     print(error);
//   }
// }

class WalletScreen extends StatefulWidget {
  const WalletScreen({Key key}) : super(key: key);

  @override
  _WalletScreenState createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen>
    with WidgetsBindingObserver {
  // ignore: unused_field
  PlaidLink _plaidLinkToken;
  var userLanguage, user, lang = [];
  bool loading = true;
  var selectedseed;
  var linktoken;
  var splitvalue = "00";
  var refreshKey = GlobalKey<RefreshIndicatorState>();
  Future<Null> refreshList() async {
    refreshKey.currentState?.show(atTop: false);
    await Future.delayed(Duration(seconds: 2));
    balance = 0;
    getUserLanguage();

    return null;
  }

  var imageFile = "";
  var balance = 0.00;
  List<Transaction> transactions1 = [];
  bool plaidconnect = false, buttonpressed = false;

  var gweibalance = "0.0";
  var usdgweibalance = 0.0;
  Future<void> getUserLanguage() async {
    lang = await UserDataSource().getLanguage();
    user = await UserDataSource().getUser();
    // getUserbalance();
    var res = await UserRepository().getUser(user[0]["walletaddress"]);
    imageFile = res["user"]["imageUrl"];
    var res1 =
        await WalletApi().getBalanceEth(address: user[0]["walletaddress"]);
    var etherAmountTest =
        double.parse(EthAmountFormatter(res1.getInWei).format());
    setState(() {
      gweibalance = etherAmountTest.toString();
    });

    getTransactionList();
    // gweibalance = res["user"]["gwei"];

    //  var exchangeValueinUSD = '1.00';
    // var value = (double.parse(res["user"]["gwei"]) * double.parse(exchangeValueinUSD));

    // usdgweibalance = (value * 4000).toStringAsFixed(2);
    // usdgweibalance = double.parse(res["user"]["gwei"]) * 0.00000293;
    if (lang.length != null && lang.length != 0) {
      userLanguage = lang[0];
    }
    // getTransaction();
  }

  @override
  void initState() {
    loading = true;
    getUserLanguage();

    super.initState();
  }

  List transactions = [];
  void getTransactionList() async {
    var eth = await WalletApi().getEthTransactions(user[0]["walletaddress"]);
    if (eth['message'] == 'OK') {
      transactions = eth['result'];
    } else if (eth['message'] == 'No transactions found') {
      transactions.add('Empty');
    }

    setState(() {
      loading = false;
    });
  }

  final GlobalKey<ScaffoldState> _scaffoldstate =
      new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return loading == true
        ? Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: backgroundcolor,
            child: Center(
              child: Container(
                height: MediaQuery.of(context).size.height * 0.24,
                width: MediaQuery.of(context).size.width * 0.55,
                decoration: BoxDecoration(
                    color: white.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(24)),
                child: Center(child: SpinKitRing(color: blue2)),
              ),
            ),
          )
        : RefreshIndicator(
            key: refreshKey,
            onRefresh: refreshList,
            child: Scaffold(
              key: _scaffoldstate,
              backgroundColor: backgroundcolor,
              body: Stack(
                //key: scaffoldKeyWallet,
                children: [
                  ListView(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    children: [
                      Stack(
                        children: [
                          Container(
                            //height: MediaQuery.of(context).size.height * 0.9,
                            width: MediaQuery.of(context).size.width,

                            //color: Colors.amber,
                            child: Column(
                              children: [
                                Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.4,
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                      // borderRadius: new BorderRadius.only(
                                      //     bottomRight:
                                      //         Radius.elliptical(500, 150),
                                      //     bottomLeft:
                                      //         Radius.elliptical(300, 250)),
                                      // color: blue1,
                                      ),
                                  child: Stack(
                                    children: [
                                      Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          Positioned(
                                            child: Image.asset(
                                              "assets/images/Wallet.png",
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              // height: 1000,
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                          Align(
                                            alignment: Alignment.topLeft,
                                            child: Positioned(
                                              top: 300,
                                              left: 50,
                                              child: Column(
                                                children: [
                                                  SizedBox(
                                                    height: 30,
                                                  ),
                                                  ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30),
                                                    child: Container(
                                                      color: button,
                                                      child: IconButton(
                                                        onPressed: () {
                                                          Navigator.pop(
                                                              context);
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
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            top: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.1,
                                            child: Center(
                                              child: GestureDetector(
                                                onTap: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              WalletProfile()));
                                                },
                                                child: Container(
                                                  height: 60,
                                                  width: 60,
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            100),
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
                                            ),
                                          ),
                                          Positioned(
                                            top: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.18,
                                            child: Text(
                                              (lang.length != null &&
                                                      lang.length != 0 &&
                                                      userLanguage[
                                                              'yourBalance'] !=
                                                          null)
                                                  ? "${userLanguage['yourBalance']}"
                                                  : "Your balance",
                                              style: GoogleFonts.poppins(
                                                fontSize: 25,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            top: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.23,
                                            child: Row(
                                              children: [
                                                Text(
                                                  gweibalance.toString(),
                                                  style: GoogleFonts.montserrat(
                                                    fontSize: 30,
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                Text(
                                                  "  ETH",
                                                  style: GoogleFonts.montserrat(
                                                    fontSize: 17,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 0),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    SendWallet(
                                                  myAddress: user[0]
                                                      ["walletaddress"],
                                                  coin: "Ethereum",
                                                ),
                                              ));
                                        },
                                        child: Container(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                6.5,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                4,
                                            //color: button,
                                            decoration: BoxDecoration(
                                              color: button,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: Column(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 20),
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30),
                                                    child: Container(
                                                      height: 42,
                                                      width: 42,
                                                      color: Colors.green[300],
                                                      child: Icon(
                                                        Icons
                                                            .file_upload_outlined,
                                                        size: 20,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 5),
                                                  child: Column(
                                                    children: [
                                                      Text(
                                                        (lang.length != null &&
                                                                lang.length !=
                                                                    0 &&
                                                                userLanguage[
                                                                        'send'] !=
                                                                    null)
                                                            ? "${userLanguage['send']}"
                                                            : "Send",
                                                        style:
                                                            GoogleFonts.poppins(
                                                          fontSize: 13,
                                                          color: Colors.grey,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                        ),
                                                      ),
                                                      // Text("   (Coming Soon)   ",
                                                      //     style: GoogleFonts.poppins(
                                                      //       fontSize: 10,
                                                      //       color: text1,
                                                      //     ),
                                                      //     textAlign:
                                                      //         TextAlign.center),
                                                    ],
                                                  ),
                                                )
                                              ],
                                            )),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      WalletReceive()));
                                          // _showReceiveMobile();
                                        },
                                        child: Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              6.5,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              4,
                                          //color: button,
                                          decoration: BoxDecoration(
                                            color: button,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 20),
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(30),
                                                  child: Container(
                                                    height: 42,
                                                    width: 42,
                                                    color: blue1,
                                                    child: Icon(
                                                      Icons
                                                          .file_download_outlined,
                                                      color: Colors.white,
                                                      size: 20,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 5),
                                                child: Text(
                                                  (lang.length != null &&
                                                          lang.length != 0 &&
                                                          userLanguage[
                                                                  'receive'] !=
                                                              null)
                                                      ? "${userLanguage['receive']}"
                                                      : "Receive",
                                                  style: GoogleFonts.poppins(
                                                      fontSize: 13,
                                                      color: Colors.grey,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      // GestureDetector(
                                      //   onTap: () {
                                      //     print(user[0]["plaidlogin"]);
                                      //     if (user[0]["plaidlogin"] == 0) {
                                      //       plaidconnection(context);
                                      //     } else {
                                      //       plaidalredyconnection(context);
                                      //       // getTransaction();
                                      //     }
                                      //   },
                                      //   child: Container(
                                      //     height: MediaQuery.of(context).size.height /
                                      //         6.5,
                                      //     width:
                                      //         MediaQuery.of(context).size.width / 4,

                                      //     //color: button,
                                      //     decoration: BoxDecoration(
                                      //       color: button,
                                      //       borderRadius: BorderRadius.circular(10),
                                      //     ),
                                      //     child: Column(
                                      //       children: [
                                      //         Padding(
                                      //           padding:
                                      //               const EdgeInsets.only(top: 20),
                                      //           child: ClipRRect(
                                      //             borderRadius:
                                      //                 BorderRadius.circular(30),
                                      //             child: Container(
                                      //               height: 42,
                                      //               width: 42,
                                      //               color: Colors.orange[300],
                                      //               child: Icon(
                                      //                 Icons.attach_money_outlined,
                                      //                 color: Colors.white,
                                      //                 size: 20,
                                      //               ),
                                      //             ),
                                      //           ),
                                      //         ),
                                      //         Padding(
                                      //           padding:
                                      //               const EdgeInsets.only(top: 5),
                                      //           child: Text(
                                      //             (lang.length != null &&
                                      //                     lang.length != 0 &&
                                      //                     userLanguage['earn'] !=
                                      //                         null)
                                      //                 ? "${userLanguage['earn']}"
                                      //                 : "Earn",
                                      //             style: GoogleFonts.poppins(
                                      //                 fontSize: 13,
                                      //                 color: Colors.grey,
                                      //                 fontWeight: FontWeight.w400),
                                      //           ),
                                      //         ),
                                      //       ],
                                      //     ),
                                      //   ),
                                      // ),
                                    ],
                                  ),
                                ),
                                // SizedBox(
                                //   height: 25,
                                // ),
                                // Container(
                                //   height: 156,
                                //   width: 335,
                                //   decoration: BoxDecoration(
                                //     color: button,
                                //     borderRadius: BorderRadius.circular(30),
                                //   ),
                                //   child: Column(
                                //     children: [
                                //       SizedBox(
                                //         height: 20,
                                //       ),
                                //       Row(
                                //         mainAxisAlignment:
                                //             MainAxisAlignment.spaceBetween,
                                //         children: [
                                //           Padding(
                                //             padding: const EdgeInsets.only(left: 25),
                                //             child: Text(
                                //               "Reports",
                                //               style: GoogleFonts.poppins(
                                //                 fontSize: 20,
                                //                 fontWeight: FontWeight.w600,
                                //                 color: Colors.white,
                                //               ),
                                //             ),
                                //           ),
                                //         ],
                                //       ),
                                //       SizedBox(height: 25),
                                //       // Row(
                                //       //   mainAxisAlignment:
                                //       //       MainAxisAlignment.spaceBetween,
                                //       //   children: [
                                //       Container(
                                //         padding: EdgeInsets.only(left: 20, right: 20),
                                //         child: Align(
                                //           alignment: Alignment.center,
                                //           child: Text(
                                //             "We are processing your information. Please check back again later.",
                                //             style: GoogleFonts.poppins(
                                //               fontSize: 10,
                                //               color: text1,
                                //             ),
                                //             textAlign: TextAlign.center,
                                //           ),
                                //         ),
                                //       ),
                                //     ],
                                //   ),
                                // ),
                              ],
                            ),
                          ),

                          //*** LOADING DESIGN */
                          // loading == true
                          //     ? Positioned(
                          //         top: MediaQuery.of(context).size.height * 0.35,
                          //         left: MediaQuery.of(context).size.width * 0.2,
                          //         child: Center(
                          //           child: Container(
                          //             height:
                          //                 MediaQuery.of(context).size.height * 0.24,
                          //             width: MediaQuery.of(context).size.width * 0.55,
                          //             decoration: BoxDecoration(
                          //                 color: white.withOpacity(0.9),
                          //                 borderRadius: BorderRadius.circular(24)),
                          //             child: Center(child: SpinKitRing(color: blue2)),
                          //           ),
                          //         ),
                          //       )
                          //     : SizedBox(),
                        ],
                      ),
                      SizedBox(height: 20),
                      Container(
                        // height: MediaQuery.of(context).size.height,
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
                            Positioned(
                              top: 20,
                              child: Container(
                                height: 4,
                                width: 50,
                                decoration: BoxDecoration(
                                    color: text1,
                                    borderRadius: BorderRadius.circular(10)),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 30),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 20),
                                    child: Text(
                                      (lang.length != null &&
                                              lang.length != 0 &&
                                              userLanguage['transactions'] !=
                                                  null)
                                          ? "${userLanguage['transactions']}"
                                          : "Transactions",
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
                            transactions.isEmpty
                                ? Center(
                                    child: Container(
                                      padding: EdgeInsets.only(top: 80),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          SpinKitCircle(
                                            color: Colors.grey,
                                            size: 40,
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(top: 10),
                                            alignment: Alignment.center,
                                            child: Text(
                                              "please wait",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontFamily: 'Avenir',
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 100,
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                : transactions[0] == 'Empty'
                                    ? Container(
                                        padding: EdgeInsets.only(top: 140),
                                        alignment: Alignment.center,
                                        child: Column(
                                          children: [
                                            Text(
                                              'No transaction history',
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                color: white,
                                                fontWeight: FontWeight.normal,
                                                fontSize: 16,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 200,
                                            ),
                                          ],
                                        ),
                                      )
                                    : Container(
                                        child: ListView.builder(
                                          shrinkWrap: true,
                                          padding: EdgeInsets.only(
                                              bottom: 10, top: 60),
                                          itemCount: transactions.length,
                                          itemBuilder: (context, index) {
                                            var date = DateTime
                                                .fromMillisecondsSinceEpoch(
                                                    int.parse(
                                                            transactions[index]
                                                                ['timeStamp']) *
                                                        1000);
                                            var amount1 = double.tryParse(
                                                    transactions[index]
                                                        ['value']) /
                                                1e18;
                                            return Column(
                                              children: [
                                                GestureDetector(
                                                  onTap: () {
                                                    // _launchURL(
                                                    //     "$ethNetworkUrl${transactions[index]['hash']}");
                                                  },
                                                  child: Container(
                                                    // margin: EdgeInsets.only(
                                                    //     left: 10,
                                                    //     right: 10,
                                                    //     bottom: 10),
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 5),
                                                    // decoration: new BoxDecoration(
                                                    // color: theme.cardColor,
                                                    // borderRadius: BorderRadius.all(
                                                    //     Radius.circular(15)),
                                                    // boxShadow: [
                                                    //   new BoxShadow(
                                                    //       color: theme.shadowColor,
                                                    //       blurRadius: 2,
                                                    //       spreadRadius: 2),
                                                    //   ],
                                                    // ),
                                                    child: ListTile(
                                                      leading: Container(
                                                        // color:
                                                        //     Colors.amberAccent,
                                                        height: 50,
                                                        width: 50,
                                                        child: Icon(
                                                          transactions[index][
                                                                      'from'] ==
                                                                  user[0][
                                                                      "walletaddress"]
                                                              ? Icons
                                                                  .arrow_circle_up_outlined
                                                              : Icons
                                                                  .arrow_circle_down_outlined,
                                                          color: transactions[
                                                                          index]
                                                                      [
                                                                      'from'] ==
                                                                  user[0][
                                                                      "walletaddress"]
                                                              ? Colors
                                                                  .green[300]
                                                              : Colors.red,
                                                        ),
                                                      ),
                                                      title: Row(
                                                        children: [
                                                          SizedBox(
                                                            height: 20,
                                                          ),
                                                          Container(
                                                            // color: Colors.amber,
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                0.4,
                                                            child: transactions[
                                                                            index]
                                                                        [
                                                                        'from'] ==
                                                                    user[0][
                                                                        "walletaddress"]
                                                                ? Text(
                                                                    "Sent",
                                                                    style: GoogleFonts
                                                                        .poppins(
                                                                      fontSize:
                                                                          17,
                                                                      color: Colors
                                                                          .white,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400,
                                                                    ),
                                                                  )
                                                                : Text(
                                                                    "Received",
                                                                    style: GoogleFonts
                                                                        .poppins(
                                                                      fontSize:
                                                                          17,
                                                                      color: Colors
                                                                          .white,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400,
                                                                    ),
                                                                  ),
                                                          ),
                                                          Container(
                                                            // color: Colors.red,
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                0.3,
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .end,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceAround,
                                                              children: [
                                                                Text(
                                                                  amount1
                                                                      .toStringAsFixed(
                                                                          5),
                                                                  style: GoogleFonts
                                                                      .poppins(
                                                                    fontSize:
                                                                        15,
                                                                    color: Colors
                                                                        .white,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                  ),
                                                                ),
                                                                Text(
                                                                  DateFormat
                                                                          .yMMMd()
                                                                      .format(
                                                                          date),
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  style: GoogleFonts
                                                                      .poppins(
                                                                    fontSize:
                                                                        15,
                                                                    color: Colors
                                                                        .white,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          )
                                                          // color: transactions[index]
                                                          //             ['from'] ==
                                                          //        user[0]["walletaddress"]
                                                          //     ? Colors.red
                                                          //     : Theme.of(context)
                                                          //         .accentIconTheme
                                                          //         .color,
                                                        ],
                                                      ),

                                                      // title: Text(
                                                      //   DateFormat(
                                                      //           'MM/dd/yyyy, hh:mm a')
                                                      //       .format(date),
                                                      //   overflow:
                                                      //       TextOverflow.ellipsis,
                                                      //   style: TextStyle(
                                                      //       // color: theme
                                                      //       //     .textTheme.headline1.color,
                                                      //       fontWeight:
                                                      //           FontWeight.normal,
                                                      //       fontSize: 14),
                                                      // ),
                                                      // subtitle: Text(
                                                      //   amount.toStringAsFixed(5),
                                                      //   overflow:
                                                      //       TextOverflow.ellipsis,
                                                      //   style: TextStyle(
                                                      //       color: theme.textTheme
                                                      //           .headline1.color,
                                                      //       fontWeight:
                                                      //           FontWeight.normal,
                                                      //       fontSize: 15),
                                                      // ),
                                                      // trailing: Container(
                                                      //     height: 32,
                                                      //     width: 85,
                                                      //     decoration:
                                                      //         new BoxDecoration(
                                                      //             // color: primaryBlue,
                                                      //             border: Border.all(
                                                      //                 color: transactions[index]['from'] ==
                                                      //                         widget
                                                      //                             .userData.walletAddress
                                                      //                     ? Colors
                                                      //                         .red
                                                      //                     : Theme.of(context)
                                                      //                         .accentIconTheme
                                                      //                         .color,
                                                      //                 width: 1.3),
                                                      //             borderRadius: BorderRadius
                                                      //                 .all(Radius
                                                      //                     .circular(
                                                      //                         20))),
                                                      //     margin: EdgeInsets.only(
                                                      //         right: 15),
                                                      //     child: TextButton(
                                                      //       onPressed: () {
                                                      //         // getSingleUser();
                                                      //       },
                                                      //       child: Text(
                                                      //         transactions[index][
                                                      //                     'from'] ==
                                                      //                 widget
                                                      //                     .userData
                                                      //                     .walletAddress
                                                      //             ? 'Sent'
                                                      //             : 'Recieved',
                                                      //         textScaleFactor:
                                                      //             1.0,
                                                      //         style: TextStyle(
                                                      //             fontFamily: Theme.of(
                                                      //                     context)
                                                      //                 .textTheme
                                                      //                 .bodyText1
                                                      //                 .fontFamily,
                                                      //             color: transactions[index]
                                                      //                         [
                                                      //                         'from'] ==
                                                      //                     widget
                                                      //                         .userData
                                                      //                         .walletAddress
                                                      //                 ? Theme.of(
                                                      //                         context)
                                                      //                     .textTheme
                                                      //                     .headline1
                                                      //                     .color
                                                      //                 : Theme.of(
                                                      //                         context)
                                                      //                     .accentIconTheme
                                                      //                     .color,
                                                      //             fontSize: 14,
                                                      //             fontWeight:
                                                      //                 FontWeight
                                                      //                     .normal),
                                                      //       ),
                                                      //     )),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            );
                                          },
                                        ),
                                      ),
                          ],
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          );
  }
}
