//import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:momerlin/data/localstorage/userdata_source.dart';
import 'package:momerlin/data/userrepository.dart';
import 'package:momerlin/tabscreen/tabscreen.dart';
import 'package:momerlin/theme/theme.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:momerlin/wallet_screens/wallet_profile.dart';
import 'package:momerlin/wallet_screens/wallet_receive.dart';
import 'package:momerlin/wallet_screens/wallet_send.dart';
import 'package:plaid_flutter/plaid_flutter.dart';

class Transaction {
  var amount;

  DateTime date;
  String merchantName;
  Transaction({
    this.amount,
    this.date,
    this.merchantName,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) => Transaction(
        amount: json["amount"],
        date: DateTime.parse(json["time"]),
        merchantName:
            json["merchant_name"] == null ? null : json["merchant_name"],
      );
}

class WalletTwo extends StatefulWidget {
  const WalletTwo({Key key}) : super(key: key);

  @override
  _WalletTwoState createState() => _WalletTwoState();
}

class _WalletTwoState extends State<WalletTwo> {
  PlaidLink _plaidLinkToken;
  var userLanguage, user, lang = [];
  bool loading = true;
  var selectedseed;
  var linktoken;
  var splitvalue = "00";

  var balance = 0.00;
  List<Transaction> transactions1 = [];
  bool plaidconnect = false, buttonpressed = false;
  Future<void> getToken() async {
    final usertoken1 = await UserRepository().getToken();
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

    // print("UserTokne $usertoken1");
  }

  Future<void> getTransactionuseraddress() async {
   
    setState(() {
      loading = false;
    });
    var res = await UserRepository().getTransaction1(user[0]["walletaddress"]);
  
    // var res1 = await UserRepository().getTransaction1(user[0]["walletaddress"]);
    setState(() {
      loading = false;
    });
    transactions1 = [];

    for (var i = 0; i < res["transactions"].length; i++) {
      transactions1.add(Transaction.fromJson(res["transactions"][i]));

      if (res["transactions"][i]["merchant_name"] != null) {
        balance += ((double.parse(res["transactions"][i]["amount"]) -
                double.parse(res["transactions"][i]["amount"]).floorToDouble()) *
            100);
      } else {}
    }
    var balance1 = balance.toStringAsFixed(2);
    var valance2 = balance1.split(".");
    splitvalue = valance2[1].toString();
  }

  Future<void> getTransaction() async {
    setState(() {
      loading = false;
    });
    var res = await UserRepository().getTransaction(user[0]["walletaddress"]);
    getTransactionuseraddress();
    // var res1 = await UserRepository().getTransaction1(user[0]["walletaddress"]);
    // setState(() {
    //   loading = false;
    // });
    // transactions1 = [];

    // for (var i = 0; i < res["transactions"].length; i++) {
    //   transactions1.add(Transaction.fromJson(res["transactions"][i]));

    //   if (res["transactions"][i]["merchant_name"] != null) {
    //     balance += ((res["transactions"][i]["amount"] -
    //             res["transactions"][i]["amount"].floorToDouble()) *
    //         100);
    //   } else {}
    // }
    // var balance1 = balance.toStringAsFixed(2);
    // var valance2 = balance1.split(".");
    // splitvalue = valance2[1].toString();
  }

  Future<void> getUserLanguage() async {
    lang = await UserDataSource().getLanguage();
    user = await UserDataSource().getUser();
  
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
      loading = true;

      plaidconnect = false;
      buttonpressed = false;
    });

    await UserRepository().updateToken({"public_token": publicToken});
    getTransaction();
   
    final usersave = await UserRepository().storeUser({"token": publicToken});
    setState(() {
      loading = false;
    });
    if (usersave == true) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => Tabscreen(
            index: 0,
          ),
        ),
      );
    } else {
      // print("PAVITHRA");
    }
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => Tabscreen(
          index: 0,
        ),
      ),
    );
    print("onSuccess: $publicToken, metadata: ${metadata.description()}");
  }

  @override
  Widget build(BuildContext context) {
    return loading == true
        ? Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: white,
            child: Center(
              child: SpinKitSpinningLines(
                color: backgroundcolor,
                size: 60,
              ),
            ),
          )
        : Scaffold(
            backgroundColor: backgroundcolor,
            body: plaidconnect == true
                ? Container(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 30,
                        ),
                        Align(
                          alignment: Alignment.topRight,
                          child: IconButton(
                              onPressed: () {
                                setState(() {
                                  plaidconnect = false;
                                  buttonpressed = false;
                                });
                              },
                              icon: Icon(
                                Icons.close,
                                color: white,
                                size: 30,
                              )),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Center(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: ColorFiltered(
                              child: Image.asset("assets/images/plaid.gif"),
                              colorFilter:
                                  ColorFilter.mode(gridcolor, BlendMode.color),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Plaid Connecting",
                          style: GoogleFonts.poppins(
                            fontSize: 25,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "We are going to launch plaid",
                          style: GoogleFonts.poppins(
                            fontSize: 19,
                            fontWeight: FontWeight.w400,
                            color: white,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              buttonpressed = true;
                            });

                            _plaidLinkToken.open();
                            // Navigator.push(context,
                            //     MaterialPageRoute(builder: (_) => Tabscreen()));
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width / 1.5,
                            height: MediaQuery.of(context).size.height * 0.09,
                            decoration: BoxDecoration(
                                borderRadius: buttonpressed == false
                                    ? BorderRadius.circular(15)
                                    : BorderRadius.circular(35),
                                color:
                                    buttonpressed == false ? gridcolor : blue1),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                buttonpressed == false
                                    ? Text(
                                        (lang.length != null &&
                                                lang.length != 0 &&
                                                userLanguage[
                                                        'ihavewrittenthemdown'] !=
                                                    null)
                                            ? "${userLanguage['ihavewrittenthemdown']}"
                                            : "Get Started!",
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.poppins(
                                            color: white,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w700),
                                      )
                                    : SpinKitThreeBounce(
                                        color: Colors.white,
                                        size: 30.0,
                                        // controller: AnimationController(
                                        //     // vsync: this,
                                        //     duration: const Duration(
                                        //         milliseconds: 1200)),
                                      ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                : Stack(
                    children: [
                      ListView(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
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
                                      //     bottomRight: Radius.elliptical(500, 150),
                                      //     bottomLeft: Radius.elliptical(300, 250)),
                                      // color: blue1,
                                      ),
                                  child: Stack(
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
                                        top:
                                            MediaQuery.of(context).size.height *
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
                                              child: Image.asset(
                                                "assets/images/profile.png",
                                                fit: BoxFit.fill,
                                                width: 60,
                                                height: 60,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        top:
                                            MediaQuery.of(context).size.height *
                                                0.18,
                                        child: Text(
                                          (lang.length != null &&
                                                  lang.length != 0 &&
                                                  userLanguage[
                                                          'yourBalanceIs'] !=
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
                                        top:
                                            MediaQuery.of(context).size.height *
                                                0.23,
                                        child: Row(
                                          children: [
                                            Text(
                                              balance.toStringAsFixed(2),
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
                                      Positioned(
                                        top:
                                            MediaQuery.of(context).size.height *
                                                0.3,
                                        child: Container(
                                          // color: button,
                                          height: 32,
                                          width: 82,
                                          decoration: BoxDecoration(
                                            color: Color(0xff6B69C4),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Center(
                                            child: Text(
                                              (lang.length != null &&
                                                      lang.length != 0 &&
                                                      userLanguage['0.64USD'] !=
                                                          null)
                                                  ? "${userLanguage['0.64USD']}"
                                                  : "0.64 USD",
                                              style: GoogleFonts.montserrat(
                                                fontSize: 10,
                                                color: Colors.white,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ),
                                        ),
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
                                                      WalletSend()));
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
                                                          top: 25),
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30),
                                                    child: Container(
                                                      height: 42,
                                                      width: 42,
                                                      color: Colors.green[300],
                                                      child: IconButton(
                                                        onPressed: () {
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          WalletSend()));
                                                        },
                                                        icon: Icon(
                                                          Icons
                                                              .file_upload_outlined,
                                                          size: 20,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 15),
                                                  child: Text(
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
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
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
                                          child: GestureDetector(
                                            onTap: () {
                                              // _showReceiveMobile();
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          WalletReceive()));
                                            },
                                            child: Column(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 25),
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30),
                                                    child: Container(
                                                      height: 42,
                                                      width: 42,
                                                      color: blue1,
                                                      child: IconButton(
                                                          onPressed: () {
                                                            Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                    builder:
                                                                        (context) =>
                                                                            WalletReceive()));
                                                          },
                                                          icon: Icon(
                                                            Icons
                                                                .file_download_outlined,
                                                            color: Colors.white,
                                                            size: 20,
                                                          )),
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 15),
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
                                      ),
                                      Container(
                                        height:
                                            MediaQuery.of(context).size.height /
                                                6.5,
                                        width:
                                            MediaQuery.of(context).size.width /
                                                4,

                                        //color: button,
                                        decoration: BoxDecoration(
                                          color: button,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              plaidconnect = true;
                                            });
                                          },
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 25),
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(30),
                                                  child: Container(
                                                    height: 42,
                                                    width: 42,
                                                    color: Colors.orange[300],
                                                    child: IconButton(
                                                        // onPressed: () {},
                                                        onPressed: () {
                                                          setState(() {
                                                            plaidconnect = true;
                                                          });
                                                        },
                                                        icon: Icon(
                                                          Icons
                                                              .attach_money_outlined,
                                                          color: Colors.white,
                                                          size: 20,
                                                        )),
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 15),
                                                child: Text(
                                                  (lang.length != null &&
                                                          lang.length != 0 &&
                                                          userLanguage[
                                                                  'earn'] !=
                                                              null)
                                                      ? "${userLanguage['earn']}"
                                                      : "Earn",
                                                  style: GoogleFonts.poppins(
                                                      fontSize: 13,
                                                      color: Colors.grey,
                                                      fontWeight:
                                                          FontWeight.w400),
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
                                            padding:
                                                const EdgeInsets.only(left: 25),
                                            child: Text(
                                              "Reports",
                                              style: GoogleFonts.poppins(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 25),
                                            child: Container(
                                              height: 35,
                                              width: 85,
                                              decoration: BoxDecoration(
                                                color: blue.withOpacity(0.2),
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              child: Center(
                                                child: Text(
                                                  "MORE DETAILS",
                                                  style: GoogleFonts.poppins(
                                                    fontSize: 8,
                                                    fontWeight: FontWeight.w600,
                                                    color: blue1,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                      SizedBox(height: 25),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 15),
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
                                                    style:
                                                        GoogleFonts.montserrat(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  TextSpan(
                                                    text: ' Gwei',
                                                    style:
                                                        GoogleFonts.montserrat(
                                                      fontSize: 10,
                                                      color: Colors.orange,
                                                    ),
                                                  ),
                                                  TextSpan(
                                                    text:
                                                        ' on food\nthis month, that’s higher\nthan normal.',
                                                    style:
                                                        GoogleFonts.montserrat(
                                                      fontSize: 14,
                                                      color: text1,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 15),
                                            child: Container(
                                              height: 54,
                                              width: 104,
                                              child: Image.asset(
                                                "assets/images/reportbar.png",
                                                fit: BoxFit.contain,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height:20),

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
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 40),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 20),
                                        child: Text(
                                          (lang.length != null &&
                                                  lang.length != 0 &&
                                                  userLanguage[
                                                          'transactions'] !=
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
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  left: 50, right: 50),
                                              child: Text(
                                                "Abracadabra look over here,Spend some Gwei and it will appea",
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
                                    : Padding(
                                        padding: EdgeInsets.only(top: 50),
                                        // top: 50,
                                        child: ListView.builder(
                                          shrinkWrap: true,
                                          // physics:
                                          //     AlwaysScrollableScrollPhysics(),
                                          // controller: myscrollController,
                                          itemCount: transactions1.length,
                                          // padding: EdgeInsets.zero,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return transactions1[index]
                                                        .merchantName ==
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
                                                                EdgeInsets.only(
                                                                    left: 20),
                                                            child: Text(
                                                              transactions1[
                                                                      index]
                                                                  .merchantName,
                                                              style: GoogleFonts.poppins(
                                                                  fontSize: 18,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                          ),
                                                          subtitle: Container(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    left: 20),
                                                            child: Text(
                                                              (DateFormat.yMMMd().format(
                                                                      transactions1[
                                                                              index]
                                                                          .date))
                                                                  .toString(),
                                                              style: GoogleFonts
                                                                  .poppins(
                                                                fontSize: 12,
                                                                color: Color(
                                                                    0xff9395A4),
                                                              ),
                                                            ),
                                                          ),
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
                                                            child: Stack(
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              children: [
                                                                Positioned(
                                                                  left: 14,
                                                                  top: 15,
                                                                  child: Text(
                                                                    ((double.parse(transactions1[index].amount) - double.parse(transactions1[index].amount).floorToDouble()) *
                                                                            100)
                                                                        .toStringAsFixed(
                                                                            1),
                                                                    style: GoogleFonts
                                                                        .montserrat(
                                                                      fontSize:
                                                                          12,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                      color: Colors
                                                                          .white,
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
                                                                      fontSize:
                                                                          12,
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
          );
  }
}
