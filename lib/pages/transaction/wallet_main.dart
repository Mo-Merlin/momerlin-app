//import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:momerlin/data/localstorage/userdata_source.dart';
import 'package:momerlin/data/userrepository.dart';
import 'package:momerlin/models/transactionmodel.dart';
//import 'package:momerlin/tabscreen/tabscreen.dart';
import 'package:momerlin/theme/theme.dart';
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

class WalletTwo extends StatefulWidget {
  const WalletTwo({Key key}) : super(key: key);

  @override
  _WalletTwoState createState() => _WalletTwoState();
}

class _WalletTwoState extends State<WalletTwo> with WidgetsBindingObserver {
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
        linktoken = usertoken1["link_token"];
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

  Future<void> getTransactionuseraddress() async {
    balance = 0;
    // setState(() {
    loading = false;
    // });
    var res = await UserRepository().getTransaction1(user[0]["walletaddress"]);

    if (res == false) {
      // Scaffold
      //     .of(context)
      //     .showSnackBar(SnackBar(content: Text('No Internet Connection'),backgroundColor: Colors.red,));
    } else {
      if (res["success"] == true) {
        transactions1 = [];

        for (var i = 0; i < res["transactions"].length; i++) {
          transactions1.add(Transaction.fromJson(res["transactions"][i]));

          // if (res["transactions"][i]["merchant_name"] != null) {
          //   balance += ((double.parse(res["transactions"][i]["amount"]) -
          //           double.parse(res["transactions"][i]["amount"])
          //               .floorToDouble()) *
          //       100);
          // } else {}
        }
        // var balance1 = balance.toStringAsFixed(2);
        // var valance2 = balance1.split(".");
        // splitvalue = valance2[1].toString();

        // print("token $linktoken");

      } else {
        Scaffold.of(context)
            // ignore: deprecated_member_use
            .showSnackBar(SnackBar(
          content: Text('Please Try Again!'),
          backgroundColor: Colors.red,
        ));
      }
      setState(() {
        loading = false;
      });
    }
  }

  Future<void> getTransaction() async {
    setState(() {
      loading = false;
    });

    // ignore: unused_local_variable
    var res = await UserRepository().getTransaction(user[0]["walletaddress"]);
    gweibalance = "0";

    if (res["success"] == true) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Transactions synced successfully'),
          backgroundColor: Colors.green,
        ),
      );

      var res = await UserRepository().getUser(user[0]["walletaddress"]);

      gweibalance = res["user"]["gwei"];
      getTransactionuseraddress();
      // Navigator.of(context).pushAndRemoveUntil(
      //     MaterialPageRoute(builder: (context) => Tabscreen()),
      //     (Route<dynamic> route) => false);

      // getUserLanguage();
    } else {
      plaidconnection(context);
    }
    user = await UserDataSource().getUser();
  }

  var gweibalance = "0";
  var usdgweibalance = 0.0;
  Future<void> getUserLanguage() async {
    lang = await UserDataSource().getLanguage();
    user = await UserDataSource().getUser();
    var res = await UserRepository().getUser(user[0]["walletaddress"]);
    imageFile = res["user"]["imageUrl"];
    gweibalance = res["user"]["gwei"];

    //  var exchangeValueinUSD = '1.00';
    // var value = (double.parse(res["user"]["gwei"]) * double.parse(exchangeValueinUSD));

    // usdgweibalance = (value * 4000).toStringAsFixed(2);
    usdgweibalance = double.parse(res["user"]["gwei"]) * 0.00000293;
    if (lang.length != null && lang.length != 0) {
      userLanguage = lang[0];
    }
    // getTransaction();
    getTransactionuseraddress();
  }

  @override
  void initState() {
    loading = true;
    getUserLanguage();
    getToken();
    super.initState();

    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // ignore: todo
    // TODO: implement didChangeAppLifecycleState
    super.didChangeAppLifecycleState(state);

    if (state == AppLifecycleState.resumed) {
      setState(() {});
      getUserLanguage();
      print("Gopi RESUMED wallet main...............................");
      WidgetsBinding.instance.addObserver(this);
    } else {
      setState(() {});
    }
//PAVI
    // switch (state) {
    //   case AppLifecycleState.paused:
    //     print("GOPI PAUSED wallet main");
    //     break;
    //   case AppLifecycleState.resumed:
    //     print("GOPI Resumed wallet main");
    //     setState(() {});
    //     getUserLanguage();

    //     WidgetsBinding.instance.addObserver(this);

    //     break;
    //   case AppLifecycleState.inactive:
    //     print('Gopi inactive wallet main');
    //     break;
    //   case AppLifecycleState.detached:
    //     print('Gopi detached wallet main');
    //     break;
    //   default:
    // if (state == AppLifecycleState.resumed) {
    //   setState(() {});
    //   getUserLanguage();
    //   WidgetsBinding.instance.addObserver(this);
    // } else {
    //   setState(() {});
    // }
  }

  void _onEventCallback(String event, LinkEventMetadata metadata) {
    setState(() {
      plaidconnect = false;
      buttonpressed = false;
    });
    print("onEvent: $event, metadata: ${metadata.description()}");
  }

  void _onExitCallback(LinkError error, LinkExitMetadata metadata) {
    setState(() {
      plaidconnect = false;
      buttonpressed = false;
    });
    print("onExit metadata: ${metadata.description()}");

    if (error != null) {
      print("onExit error: ${error.description()}");
    }
  }

  Future<void> _onSuccessCallback(
      String publicToken, LinkSuccessMetadata metadata) async {
    setState(() {
      plaidconnect = false;
      buttonpressed = false;
    });
    await UserRepository().updateToken({"public_token": publicToken});
    // getTransaction();
    // ignore: unused_local_variable
    var res1 = await UserRepository().updateplaidlogin(1);
    gweibalance = "0";
    usdgweibalance = 0;

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
      usdgweibalance = double.parse(res["user"]["gwei"]) * 0.00000293;
      getTransactionuseraddress();
      // Navigator.of(context).pushAndRemoveUntil(
      //     MaterialPageRoute(builder: (context) => Tabscreen()),
      //     (Route<dynamic> route) => false);

      // getUserLanguage();
    }
    user = await UserDataSource().getUser();
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

  final GlobalKey<ScaffoldState> _scaffoldstate =
      new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return
        // loading == true
        //     ? Container(
        //         height: MediaQuery.of(context).size.height,
        //         width: MediaQuery.of(context).size.width,
        //         color: backgroundcolor,
        //         child: Center(
        //           child: SpinKitRing(
        //             color: white,
        //             size: 60,
        //           ),
        //         ),
        //       )
        //     :
        RefreshIndicator(
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
                            height: MediaQuery.of(context).size.height * 0.4,
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
                                        width:
                                            MediaQuery.of(context).size.width,
                                        // height: 1000,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                    Positioned(
                                      top: MediaQuery.of(context).size.height *
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
                                                  BorderRadius.circular(100),
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
                                      top: MediaQuery.of(context).size.height *
                                          0.18,
                                      child: Text(
                                        (lang.length != null &&
                                                lang.length != 0 &&
                                                userLanguage['yourBalanceIs'] !=
                                                    null)
                                            ? "${userLanguage['yourBalanceIs']}"
                                            : "Your balance is",
                                        style: GoogleFonts.poppins(
                                          fontSize: 25,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      top: MediaQuery.of(context).size.height *
                                          0.23,
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
                                          Text(
                                            "  Gwei",
                                            style: GoogleFonts.montserrat(
                                              fontSize: 17,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    // Positioned(
                                    //   top: MediaQuery.of(context).size.height *
                                    //       0.3,
                                    //   child: Container(
                                    //     // color: button,
                                    //     height: 32,
                                    //     width: 82,
                                    //     decoration: BoxDecoration(
                                    //       color: Color(0xff6B69C4),
                                    //       borderRadius:
                                    //           BorderRadius.circular(10),
                                    //     ),
                                    //     child: Center(
                                    //       child: Text(
                                    //         usdgweibalance.toStringAsFixed(3) +
                                    //             " USD",
                                    //         style: GoogleFonts.montserrat(
                                    //           fontSize: 10,
                                    //           color: Colors.white,
                                    //           fontWeight: FontWeight.w400,
                                    //         ),
                                    //       ),
                                    //     ),
                                    //   ),
                                    // ),
                                  ],
                                ),
                                // Positioned(
                                //   child: Center(
                                //     child: Container(
                                //       height: MediaQuery.of(context)
                                //               .size
                                //               .height *
                                //           0.24,
                                //       width: MediaQuery.of(context)
                                //               .size
                                //               .width *
                                //           0.55,
                                //       decoration: BoxDecoration(
                                //           color: white.withOpacity(0.9),
                                //           borderRadius:
                                //               BorderRadius.circular(
                                //                   24)),
                                //       child: Center(
                                //           child: SpinKitRing(
                                //               color: blue2)),
                                //     ),
                                //   ),
                                // )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    // Navigator.push(
                                    //     context,
                                    //     MaterialPageRoute(
                                    //         builder: (context) =>
                                    //             WalletSend()));
                                  },
                                  child: Container(
                                      height:
                                          MediaQuery.of(context).size.height /
                                              6.5,
                                      width:
                                          MediaQuery.of(context).size.width / 4,
                                      //color: button,
                                      decoration: BoxDecoration(
                                        color: button,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 20),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                              child: Container(
                                                height: 42,
                                                width: 42,
                                                color: Colors.green[300],
                                                child: Icon(
                                                  Icons.file_upload_outlined,
                                                  size: 20,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 5),
                                            child: Column(
                                              children: [
                                                Text(
                                                  (lang.length != null &&
                                                          lang.length != 0 &&
                                                          userLanguage[
                                                                  'send'] !=
                                                              null)
                                                      ? "${userLanguage['send']}"
                                                      : "Send",
                                                  style: GoogleFonts.poppins(
                                                    fontSize: 13,
                                                    color: Colors.grey,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                                Text("   (Coming Soon)   ",
                                                    style: GoogleFonts.poppins(
                                                      fontSize: 10,
                                                      color: text1,
                                                    ),
                                                    textAlign:
                                                        TextAlign.center),
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
                                    height: MediaQuery.of(context).size.height /
                                        6.5,
                                    width:
                                        MediaQuery.of(context).size.width / 4,
                                    //color: button,
                                    decoration: BoxDecoration(
                                      color: button,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 20),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(30),
                                            child: Container(
                                              height: 42,
                                              width: 42,
                                              color: blue1,
                                              child: Icon(
                                                Icons.file_download_outlined,
                                                color: Colors.white,
                                                size: 20,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 5),
                                          child: Text(
                                            (lang.length != null &&
                                                    lang.length != 0 &&
                                                    userLanguage['receive'] !=
                                                        null)
                                                ? "${userLanguage['receive']}"
                                                : "Receive",
                                            style: GoogleFonts.poppins(
                                                fontSize: 13,
                                                color: Colors.grey,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    print(user[0]["plaidlogin"]);
                                    if (user[0]["plaidlogin"] == 0) {
                                      plaidconnection(context);
                                    } else {
                                      plaidalredyconnection(context);
                                      // getTransaction();
                                    }
                                  },
                                  child: Container(
                                    height: MediaQuery.of(context).size.height /
                                        6.5,
                                    width:
                                        MediaQuery.of(context).size.width / 4,

                                    //color: button,
                                    decoration: BoxDecoration(
                                      color: button,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 20),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(30),
                                            child: Container(
                                              height: 42,
                                              width: 42,
                                              color: Colors.orange[300],
                                              child: Icon(
                                                Icons.attach_money_outlined,
                                                color: Colors.white,
                                                size: 20,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 5),
                                          child: Text(
                                            (lang.length != null &&
                                                    lang.length != 0 &&
                                                    userLanguage['earn'] !=
                                                        null)
                                                ? "${userLanguage['earn']}"
                                                : "Earn",
                                            style: GoogleFonts.poppins(
                                                fontSize: 13,
                                                color: Colors.grey,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          Container(
                            height: 156,
                            width: 335,
                            decoration: BoxDecoration(
                              color: button,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 25),
                                      child: Text(
                                        "Reports",
                                        style: GoogleFonts.poppins(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    // Padding(
                                    //   padding: const EdgeInsets.only(
                                    //       right: 25),
                                    //   child: Container(
                                    //     height: 35,
                                    //     width: 85,
                                    //     decoration: BoxDecoration(
                                    //       color: blue.withOpacity(0.2),
                                    //       borderRadius:
                                    //           BorderRadius.circular(10),
                                    //     ),
                                    //     child: Center(
                                    //       child: Text(
                                    //         "MORE DETAILS",
                                    //         style: GoogleFonts.poppins(
                                    //           fontSize: 8,
                                    //           fontWeight:
                                    //               FontWeight.w600,
                                    //           color: blue1,
                                    //         ),
                                    //       ),
                                    //     ),
                                    //   ),
                                    // )
                                  ],
                                ),
                                SizedBox(height: 25),
                                // Row(
                                //   mainAxisAlignment:
                                //       MainAxisAlignment.spaceBetween,
                                //   children: [
                                Container(
                                  padding: EdgeInsets.only(left: 20, right: 20),
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      "We are processing your information. Please check back again later.",
                                      style: GoogleFonts.poppins(
                                        fontSize: 10,
                                        color: text1,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                                // Padding(
                                //   padding: const EdgeInsets.only(
                                //       left: 15),
                                //   child: RichText(
                                //     text: TextSpan(
                                //       text: 'You Spent',
                                //       style: GoogleFonts.poppins(
                                //         fontSize: 12,
                                //         color: text1,
                                //       ),
                                //       children: <TextSpan>[
                                //         TextSpan(
                                //           text: ' 1654.12',
                                //           style: GoogleFonts
                                //               .montserrat(
                                //             fontSize: 14,
                                //             fontWeight:
                                //                 FontWeight.w600,
                                //             color: Colors.white,
                                //           ),
                                //         ),
                                //         TextSpan(
                                //           text: ' Gwei',
                                //           style: GoogleFonts
                                //               .montserrat(
                                //             fontSize: 10,
                                //             color: Colors.orange,
                                //           ),
                                //         ),
                                //         TextSpan(
                                //           text:
                                //               ' on food\nthis month, that’s higher\nthan normal.',
                                //           style: GoogleFonts
                                //               .montserrat(
                                //             fontSize: 14,
                                //             color: text1,
                                //           ),
                                //         ),
                                //       ],
                                //     ),
                                //   ),
                                // ),
                                // Padding(
                                //   padding: const EdgeInsets.only(
                                //       right: 15),
                                //   child: Container(
                                //     height: 54,
                                //     width: 104,
                                //     child: Image.asset(
                                //       "assets/images/reportbar.png",
                                //       fit: BoxFit.contain,
                                //     ),
                                //   ),
                                // )
                                //   ],
                                // ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    loading == true
                        ? Positioned(
                            top: MediaQuery.of(context).size.height * 0.35,
                            left: MediaQuery.of(context).size.width * 0.2,
                            child: Center(
                              child: Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.24,
                                width: MediaQuery.of(context).size.width * 0.55,
                                decoration: BoxDecoration(
                                    color: white.withOpacity(0.9),
                                    borderRadius: BorderRadius.circular(24)),
                                child: Center(child: SpinKitRing(color: blue2)),
                              ),
                            ),
                          )
                        : SizedBox(),
                  ],
                ),
                SizedBox(height: 20),
                Container(
                  height: MediaQuery.of(context).size.height * 0.5,
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: Text(
                                (lang.length != null &&
                                        lang.length != 0 &&
                                        userLanguage['transactions'] != null)
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
                      transactions1.length == 0
                          ? Container(
                              padding: EdgeInsets.only(top: 80),
                              child: ListView(
                                // physics:
                                //     AlwaysScrollableScrollPhysics(),
                                // controller: myscrollController,
                                children: [
                                  Image.asset(
                                    "assets/images/Wallet2.png",
                                    width: MediaQuery.of(context).size.width,
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.only(left: 50, right: 50),
                                    child: Text(
                                      "Abracadabra look over here,Spend some Gwei and it will appear",
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.poppins(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.white38),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : Container(
                              margin: EdgeInsets.only(top: 60,bottom: 80),
                            //  padding: EdgeInsets.only(top: 30),
                              // top: 50,
                              child: ListView.builder(
                                shrinkWrap: true,
                                // physics:
                                //     AlwaysScrollableScrollPhysics(),
                                // controller: myscrollController,
                                itemCount: transactions1.length,
                                // padding: EdgeInsets.zero,
                                itemBuilder: (BuildContext context, int index) {
                                  return transactions1[index].merchantName ==
                                          null
                                      ? SizedBox()
                                      : Column(
                                          children: [
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Container(
                                              child: ListTile(
                                                // contentPadding: EdgeInsets.only(
                                                //     top: 0, bottom: 0),
                                                //   leading: ClipRRect(
                                                //     borderRadius: BorderRadius.circular(30),
                                                //     child: Container(
                                                //         height: 60,
                                                //         width: 60,
                                                //         color: Colors.black54,
                                                //         child: Image.network(
                                                //           "https://c.static-nike.com/a/images/w_1920,c_limit/mdbgldn6yg1gg88jomci/image.jpg",
                                                //           fit: BoxFit.cover,
                                                //         )),
                                                //   ),
                                                title: Container(
                                                  padding:
                                                      EdgeInsets.only(left: 20),
                                                  child: Text(
                                                    transactions1[index]
                                                        .merchantName
                                                        .toString(),
                                                    style: GoogleFonts.poppins(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: Colors.white),
                                                  ),
                                                ),
                                                subtitle: Row(
                                                  children: [
                                                    Container(
                                                      padding: EdgeInsets.only(
                                                          left: 20),
                                                      child: Text(
                                                        (DateFormat.yMMMd().format(
                                                                transactions1[
                                                                        index]
                                                                    .date))
                                                            .toString(),
                                                        style:
                                                            GoogleFonts.poppins(
                                                          fontSize: 12,
                                                          color:
                                                              Color(0xff9395A4),
                                                        ),
                                                      ),
                                                    ),
                                                    Icon(
                                                      Icons.more_vert_outlined,
                                                      color: white,
                                                    ),
                                                    Text(
                                                      transactions1[index]
                                                              .amount
                                                              .toString() +
                                                          " " +
                                                          transactions1[index]
                                                              .isoCurrencyCode,
                                                      style:
                                                          GoogleFonts.poppins(
                                                        fontSize: 12,
                                                        color: white,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                trailing: Container(
                                                  height: 40,
                                                  width: 100,
                                                  decoration: BoxDecoration(
                                                    color: Color(0xff707070)
                                                        .withOpacity(0.4),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                  child: Stack(
                                                    alignment: Alignment.center,
                                                    children: [
                                                      Positioned(
                                                        left: 14,
                                                        top: 15,
                                                        child: Text(
                                                          transactions1[index]
                                                              .sats
                                                              .toInt()
                                                              .toString(),
                                                          style: GoogleFonts
                                                              .montserrat(
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                      Positioned(
                                                        left: 50,
                                                        top: 15,
                                                        child: Text(
                                                          ' Gwei',
                                                          style: GoogleFonts
                                                              .montserrat(
                                                            fontSize: 12,
                                                            color: Colors
                                                                .orangeAccent,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
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
            // DraggableScrollableSheet(
            //   initialChildSize: 0.2,
            //   minChildSize: 0.2,
            //   maxChildSize: 0.5,
            //   builder: (BuildContext context, myscrollController) {
            //     return Container(
            //       decoration: BoxDecoration(
            //         color: button,
            //         borderRadius: BorderRadius.only(
            //           topLeft: Radius.circular(40),
            //           topRight: Radius.circular(40),
            //         ),
            //       ),
            //       //color: button,
            //       child: Stack(
            //         // crossAxisAlignment: CrossAxisAlignment,
            //         alignment: Alignment.topCenter,
            //         children: [
            //           Positioned(
            //             top: 20,
            //             child: Container(
            //               height: 4,
            //               width: 50,
            //               decoration: BoxDecoration(
            //                   color: text1,
            //                   borderRadius:
            //                       BorderRadius.circular(10)),
            //             ),
            //           ),
            //           Padding(
            //             padding: const EdgeInsets.only(top: 40),
            //             child: Row(
            //               mainAxisAlignment:
            //                   MainAxisAlignment.spaceBetween,
            //               children: [
            //                 Padding(
            //                   padding:
            //                       const EdgeInsets.only(left: 20),
            //                   child: Text(
            //                     (lang.length != null &&
            //                             lang.length != 0 &&
            //                             userLanguage[
            //                                     'transactions'] !=
            //                                 null)
            //                         ? "${userLanguage['transactions']}"
            //                         : "Transactions",
            //                     style: GoogleFonts.poppins(
            //                       fontSize: 20,
            //                       color: Colors.white,
            //                       fontWeight: FontWeight.w500,
            //                     ),
            //                   ),
            //                 ),
            //               ],
            //             ),
            //           ),
            //           transactions1.length == 0
            //               // ? Padding(
            //               //     padding: EdgeInsets.only(top: 50),
            //               //     // top: 50,
            //               //     child: ListView.builder(
            //               //       shrinkWrap: true,
            //               //       physics:
            //               //           AlwaysScrollableScrollPhysics(),
            //               //       controller: myscrollController,
            //               //       itemCount: 12,
            //               //       // padding: EdgeInsets.zero,
            //               //       itemBuilder: (BuildContext context,
            //               //           int index) {
            //               //         return Column(
            //               //           children: [
            //               //             SizedBox(
            //               //               height: 5,
            //               //             ),
            //               //             Container(
            //               //               child: ListTile(
            //               //                 contentPadding:
            //               //                     EdgeInsets.only(
            //               //                         top: 0, bottom: 0),
            //               //                 leading: ClipRRect(
            //               //                   borderRadius:
            //               //                       BorderRadius.circular(
            //               //                           30),
            //               //                   child: Container(
            //               //                       height: 60,
            //               //                       width: 60,
            //               //                       color: Colors.black54,
            //               //                       child: Image.network(
            //               //                         "https://c.static-nike.com/a/images/w_1920,c_limit/mdbgldn6yg1gg88jomci/image.jpg",
            //               //                         fit: BoxFit.cover,
            //               //                       )),
            //               //                 ),
            //               //                 title: Container(
            //               //                   padding: EdgeInsets.only(
            //               //                       left: 20),
            //               //                   child: Text(
            //               //                     "TRANS DETAILS",
            //               //                     style:
            //               //                         GoogleFonts.poppins(
            //               //                             fontSize: 18,
            //               //                             fontWeight:
            //               //                                 FontWeight
            //               //                                     .w600,
            //               //                             color: Colors
            //               //                                 .white),
            //               //                   ),
            //               //                 ),
            //               //                 subtitle: Container(
            //               //                   padding: EdgeInsets.only(
            //               //                       left: 20),
            //               //                   child: Text(
            //               //                     "Date and time",
            //               //                     style:
            //               //                         GoogleFonts.poppins(
            //               //                       fontSize: 12,
            //               //                       color:
            //               //                           Color(0xff9395A4),
            //               //                     ),
            //               //                   ),
            //               //                 ),
            //               //                 trailing: Container(
            //               //                   height: 40,
            //               //                   width: 100,
            //               //                   decoration: BoxDecoration(
            //               //                     color: Color(0xff707070)
            //               //                         .withOpacity(0.4),
            //               //                     borderRadius:
            //               //                         BorderRadius
            //               //                             .circular(10),
            //               //                   ),
            //               //                   child: Stack(
            //               //                     alignment:
            //               //                         Alignment.center,
            //               //                     children: [
            //               //                       Positioned(
            //               //                         left: 14,
            //               //                         top: 15,
            //               //                         child: Text(
            //               //                           "-12.00",
            //               //                           style: GoogleFonts
            //               //                               .montserrat(
            //               //                             fontSize: 12,
            //               //                             fontWeight:
            //               //                                 FontWeight
            //               //                                     .w500,
            //               //                             color: Colors
            //               //                                 .white,
            //               //                           ),
            //               //                         ),
            //               //                       ),
            //               //                       Positioned(
            //               //                         left: 50,
            //               //                         top: 15,
            //               //                         child: Text(
            //               //                           ' Gwei',
            //               //                           style: GoogleFonts
            //               //                               .montserrat(
            //               //                             fontSize: 12,
            //               //                             color: Colors
            //               //                                 .orangeAccent,
            //               //                           ),
            //               //                         ),
            //               //                       ),
            //               //                     ],
            //               //                   ),
            //               //                 ),
            //               //               ),
            //               //             ),
            //               //           ],
            //               //         );
            //               //       },
            //               //     ),
            //               //   )
            //               ? Container(
            //                   padding: EdgeInsets.only(top: 80),
            //                   child: ListView(
            //                     physics:
            //                         AlwaysScrollableScrollPhysics(),
            //                     controller: myscrollController,
            //                     children: [
            //                       Image.asset(
            //                         "assets/images/Wallet2.png",
            //                         width: MediaQuery.of(context)
            //                             .size
            //                             .width,
            //                       ),
            //                       Padding(
            //                         padding: EdgeInsets.only(
            //                             left: 50, right: 50),
            //                         child: Text(
            //                           "Abracadabra look over here,Spend some Gwei and it will appea",
            //                           textAlign: TextAlign.center,
            //                           style: GoogleFonts.poppins(
            //                               fontSize: 13,
            //                               fontWeight: FontWeight.w400,
            //                               color: Colors.white38),
            //                         ),
            //                       ),
            //                     ],
            //                   ))
            //               : Padding(
            //                   padding: EdgeInsets.only(top: 50),
            //                   // top: 50,
            //                   child: ListView.builder(
            //                     shrinkWrap: true,
            //                     physics:
            //                         AlwaysScrollableScrollPhysics(),
            //                     controller: myscrollController,
            //                     itemCount: transactions1.length,
            //                     // padding: EdgeInsets.zero,
            //                     itemBuilder: (BuildContext context,
            //                         int index) {
            //                       return transactions1[index]
            //                                   .merchantName ==
            //                               null
            //                           ? SizedBox()
            //                           : Column(
            //                               children: [
            //                                 SizedBox(
            //                                   height: 5,
            //                                 ),
            //                                 Container(
            //                                   child: ListTile(
            //                                     // contentPadding: EdgeInsets.only(
            //                                     //     top: 0, bottom: 0),
            //                                     //   leading: ClipRRect(
            //                                     //     borderRadius: BorderRadius.circular(30),
            //                                     //     child: Container(
            //                                     //         height: 60,
            //                                     //         width: 60,
            //                                     //         color: Colors.black54,
            //                                     //         child: Image.network(
            //                                     //           "https://c.static-nike.com/a/images/w_1920,c_limit/mdbgldn6yg1gg88jomci/image.jpg",
            //                                     //           fit: BoxFit.cover,
            //                                     //         )),
            //                                     //   ),
            //                                     title: Container(
            //                                       padding:
            //                                           EdgeInsets.only(
            //                                               left: 20),
            //                                       child: Text(
            //                                         transactions1[
            //                                                 index]
            //                                             .merchantName,
            //                                         style: GoogleFonts.poppins(
            //                                             fontSize: 18,
            //                                             fontWeight:
            //                                                 FontWeight
            //                                                     .w600,
            //                                             color: Colors
            //                                                 .white),
            //                                       ),
            //                                     ),
            //                                     subtitle: Container(
            //                                       padding:
            //                                           EdgeInsets.only(
            //                                               left: 20),
            //                                       child: Text(
            //                                         (DateFormat.yMMMd().format(
            //                                                 transactions1[
            //                                                         index]
            //                                                     .date))
            //                                             .toString(),
            //                                         style: GoogleFonts
            //                                             .poppins(
            //                                           fontSize: 12,
            //                                           color: Color(
            //                                               0xff9395A4),
            //                                         ),
            //                                       ),
            //                                     ),
            //                                     trailing: Container(
            //                                       height: 40,
            //                                       width: 100,
            //                                       decoration:
            //                                           BoxDecoration(
            //                                         color: Color(
            //                                                 0xff707070)
            //                                             .withOpacity(
            //                                                 0.4),
            //                                         borderRadius:
            //                                             BorderRadius
            //                                                 .circular(
            //                                                     10),
            //                                       ),
            //                                       child: Stack(
            //                                         alignment:
            //                                             Alignment
            //                                                 .center,
            //                                         children: [
            //                                           Positioned(
            //                                             left: 14,
            //                                             top: 15,
            //                                             child: Text(
            //                                               ((transactions1[index].amount - transactions1[index].amount.floorToDouble()) *
            //                                                       100)
            //                                                   .toStringAsFixed(
            //                                                       1),
            //                                               style: GoogleFonts
            //                                                   .montserrat(
            //                                                 fontSize:
            //                                                     12,
            //                                                 fontWeight:
            //                                                     FontWeight
            //                                                         .w500,
            //                                                 color: Colors
            //                                                     .white,
            //                                               ),
            //                                             ),
            //                                           ),
            //                                           Positioned(
            //                                             left: 50,
            //                                             top: 15,
            //                                             child: Text(
            //                                               ' Gwei',
            //                                               style: GoogleFonts
            //                                                   .montserrat(
            //                                                 fontSize:
            //                                                     12,
            //                                                 color: Colors
            //                                                     .orangeAccent,
            //                                               ),
            //                                             ),
            //                                           ),
            //                                         ],
            //                                       ),
            //                                     ),
            //                                   ),
            //                                 ),
            //                               ],
            //                             );
            //                     },
            //                   ),
            //                 ),
            //         ],
            //       ),
            //     );
            //   },
            // )
          ],
        ),
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

  void plaidalredyconnection(BuildContext context) {
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
                              height: MediaQuery.of(context).size.height * 0.4,
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
                                  Container(
                                    padding:
                                        EdgeInsets.only(left: 20, right: 20),
                                    child: Text(
                                      "We will sync transactions from your bank account. Please click proceed to continue",
                                      style: GoogleFonts.poppins(
                                        fontSize: 19,
                                        fontWeight: FontWeight.w400,
                                        color: white,
                                      ),
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
                                        getTransaction();
                                        Navigator.pop(context);
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "Proceed",
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
