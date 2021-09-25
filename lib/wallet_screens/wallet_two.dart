import 'dart:math';
import 'dart:ui';

// import 'package:intl/intl.dart';
import 'package:awesome_loader/awesome_loader.dart';
import 'package:clipboard/clipboard.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:momerlin/data/localstorage/userdata_source.dart';
import 'package:momerlin/data/userrepository.dart';
import 'package:momerlin/theme/theme.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:momerlin/wallet_screens/wallet_profile.dart';
import 'package:momerlin/wallet_screens/wallet_receive.dart';
import 'package:momerlin/wallet_screens/wallet_send.dart';
import 'package:plaid_flutter/plaid_flutter.dart';
import 'package:qr_flutter/qr_flutter.dart';

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
  @override
  void initState() {
    loading = true;

    getUserLanguage();
    getToken();
    super.initState();
  }

  var splitvalue = "00";
  // ignore: todo
  //TODO :languagestart
  Future<void> getUserLanguage() async {
    lang = await UserDataSource().getLanguage();
    user = await UserDataSource().getUser();
    // print(user[0]["walletaddress"]);
    if (lang.length != null && lang.length != 0) {
      userLanguage = lang[0];
    }

    getTransaction();
  }

  // ignore: todo
  //TODO: LanguageEnd
  var balance = 0.00;
  List<Transaction> transactions1 = [];
  Future<void> getTransaction() async {
    setState(() {
      loading = false;
    });
    var res = await UserRepository().getTransaction(user[0]["walletaddress"]);
    // var res1 = await UserRepository().getTransaction1(user[0]["walletaddress"]);
    setState(() {
      loading = false;
    });
    transactions1 = [];

    for (var i = 0; i < res["transactions"].length; i++) {
      transactions1.add(Transaction.fromJson(res["transactions"][i]));

      if (res["transactions"][i]["merchant_name"] != null) {
        balance += ((res["transactions"][i]["amount"] -
                res["transactions"][i]["amount"].floorToDouble()) *
            100);
      } else {}
    }
    var balance1 = balance.toStringAsFixed(2);
    var valance2 = balance1.split(".");
    splitvalue = valance2[1].toString();
  }

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

  Future<void> _onSuccessCallback(
      String publicToken, LinkSuccessMetadata metadata) async {
    print("asdfghjklsdfghj ${metadata.description()}");
    setState(() {
      loading = true;
    });
    final usertoken =
        await UserRepository().updateToken({"public_token": publicToken});
    // print("UserTokne $usertoken");
    final usersave = await UserRepository().storeUser({"token": publicToken});
    setState(() {
      loading = false;
    });
    if (usersave == true) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => WalletTwo()));
    } else {
      // print("PAVITHRA");
    }
    Navigator.push(context, MaterialPageRoute(builder: (_) => WalletTwo()));
    print("onSuccess: $publicToken, metadata: ${metadata.description()}");
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

  @override
  Widget build(BuildContext context) {
    return loading == true
        ? Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: white,
            child: Center(
              child: AwesomeLoader(
                loaderType: AwesomeLoader.AwesomeLoader3,
                color: backgroundcolor,
              ),
            ),
          )
        : Scaffold(
            backgroundColor: backgroundcolor,
            body: Stack(children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.6,
                width: MediaQuery.of(context).size.width,

                //color: Colors.amber,
                child: Column(
                  children: [
                    Container(
                      // clipper: CurvedBottomClipper(),
                      child: Container(
                        // duration: Duration(milliseconds: 200),
                        //color: blue1,
                        height: MediaQuery.of(context).size.height * 0.4,
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
                                width: MediaQuery.of(context).size.width,
                                // height: 1000,
                                fit: BoxFit.fill,
                              ),
                            ),
                            Positioned(
                              top: 45,
                              child: Center(
                                child: InkWell(
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
                              top: 110,
                              child: Text(
                                (lang.length != null &&
                                        lang.length != 0 &&
                                        userLanguage['yourBalanceIs'] != null)
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
                              top: 150,
                              child: Text(
                                balance.toStringAsFixed(0),
                                style: GoogleFonts.montserrat(
                                  fontSize: 75,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Positioned(
                              top: 170,
                              left: 270,
                              child: Text(
                                "Gwei",
                                style: GoogleFonts.montserrat(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                            Positioned(
                              top: 200,
                              left: 270,
                              child: Text(
                                ".${splitvalue.toString()}",
                                style: GoogleFonts.montserrat(
                                  fontSize: 17,
                                  color: white,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                            Positioned(
                              top: 240,
                              child: Container(
                                // color: button,
                                height: 32,
                                width: 82,
                                decoration: BoxDecoration(
                                  color: Color(0xff6B69C4),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Center(
                                  child: Text(
                                    (lang.length != null &&
                                            lang.length != 0 &&
                                            userLanguage['0.64USD'] != null)
                                        ? "${userLanguage['0.64USD']}"
                                        : "0.64USD",
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
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => WalletSend()));
                            },
                            child: Container(
                                height:
                                    MediaQuery.of(context).size.height / 6.5,
                                width: MediaQuery.of(context).size.width / 4,
                                //color: button,
                                decoration: BoxDecoration(
                                  color: button,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 25),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(30),
                                        child: Container(
                                          height: 42,
                                          width: 42,
                                          color: Colors.green[300],
                                          child: IconButton(
                                            onPressed: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          WalletSend()));
                                            },
                                            icon: Icon(
                                              Icons.file_upload_outlined,
                                              size: 20,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 15),
                                      child: Text(
                                        (lang.length != null &&
                                                lang.length != 0 &&
                                                userLanguage['send'] != null)
                                            ? "${userLanguage['send']}"
                                            : "Send",
                                        style: GoogleFonts.poppins(
                                          fontSize: 13,
                                          color: Colors.grey,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    )
                                  ],
                                )),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => WalletReceive()));
                              // _showReceiveMobile();
                            },
                            child: Container(
                              height: MediaQuery.of(context).size.height / 6.5,
                              width: MediaQuery.of(context).size.width / 4,
                              //color: button,
                              decoration: BoxDecoration(
                                color: button,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: InkWell(
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
                                      padding: const EdgeInsets.only(top: 25),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(30),
                                        child: Container(
                                          height: 42,
                                          width: 42,
                                          color: blue1,
                                          child: IconButton(
                                              onPressed: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            WalletReceive()));
                                              },
                                              icon: Icon(
                                                Icons.file_download_outlined,
                                                color: Colors.white,
                                                size: 20,
                                              )),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 15),
                                      child: Text(
                                        (lang.length != null &&
                                                lang.length != 0 &&
                                                userLanguage['receive'] != null)
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
                          ),
                          Container(
                            height: MediaQuery.of(context).size.height / 6.5,
                            width: MediaQuery.of(context).size.width / 4,

                            //color: button,
                            decoration: BoxDecoration(
                              color: button,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 25),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(30),
                                    child: Container(
                                      height: 42,
                                      width: 42,
                                      color: Colors.orange[300],
                                      child: IconButton(
                                          // onPressed: () {},
                                          onPressed: () =>
                                              _plaidLinkToken.open(),
                                          icon: Icon(
                                            Icons.attach_money_outlined,
                                            color: Colors.white,
                                            size: 20,
                                          )),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 15),
                                  child: Text(
                                    (lang.length != null &&
                                            lang.length != 0 &&
                                            userLanguage['earn'] != null)
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
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              transactions1.length == 0
                  ? SizedBox(
                      height: 0,
                      width: 0,
                    )
                  : DraggableScrollableSheet(
                      initialChildSize: 0.41,
                      minChildSize: 0.41,
                      maxChildSize: 0.7,
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 20),
                                      child: Text(
                                        (lang.length != null &&
                                                lang.length != 0 &&
                                                userLanguage['transaction'] !=
                                                    null)
                                            ? "${userLanguage['transaction']}"
                                            : "Transaction",
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
                                  itemCount: transactions1.length,
                                  // padding: EdgeInsets.zero,
                                  itemBuilder:
                                      (BuildContext context, int index) {
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
                                                    padding: EdgeInsets.only(
                                                        left: 20),
                                                    child: Text(
                                                      transactions1[index]
                                                          .merchantName,
                                                      style:
                                                          GoogleFonts.poppins(
                                                              fontSize: 18,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              color:
                                                                  Colors.white),
                                                    ),
                                                  ),
                                                  subtitle: Container(
                                                    padding: EdgeInsets.only(
                                                        left: 20),
                                                    child: Text(
                                                      (DateFormat.yMMMd()
                                                              .format(
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
                                                        alignment:
                                                            Alignment.center,
                                                        children: [
                                                          Positioned(
                                                            left: 14,
                                                            top: 15,
                                                            child: Text(
                                                              ((transactions1[index]
                                                                              .amount -
                                                                          transactions1[index]
                                                                              .amount
                                                                              .floorToDouble()) *
                                                                      100)
                                                                  .toStringAsFixed(
                                                                      1),
                                                              style: GoogleFonts
                                                                  .montserrat(
                                                                fontSize: 12,
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
                                                                fontSize: 12,
                                                                color: Colors
                                                                    .orangeAccent,
                                                              ),
                                                            ),
                                                          ),
                                                        ]),
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
                        );
                      },
                    )
            ]),
          );
  }

  _showReceiveMobile() {
    showModalBottomSheet(
      backgroundColor: Colors.white,
      isScrollControlled: true,
      context: context,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(25.0))),
      builder: (builder) {
        return new Wrap(children: <Widget>[
          Container(
            padding: EdgeInsets.all(18),
            child: receiveContent(),
          ),
        ]);
      },
    );
  }

  Widget receiveContent() {
    return Column(
      children: <Widget>[
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Receive",
                style: TextStyle(fontSize: 22, color: Colors.black),
              ),
              IconButton(
                icon: Icon(Icons.close, color: Colors.black),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
        SizedBox(
          height: 10,
        ),
        QrImage(
          data: user[0]["walletaddress"],
          size: 200.0,
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          user[0]["walletaddress"],
          style: TextStyle(fontSize: 14, color: Colors.black),
        ),
        SizedBox(
          height: 35,
        ),
        Container(
          height: 50,
          width: 250,
          // ignore: deprecated_member_use
          child: RaisedButton(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
                side: BorderSide(color: Colors.white)),
            onPressed: () async {
              FlutterClipboard.copy(
                user[0]["walletaddress"],
              ).then(
                (result) {
                  Navigator.of(context).pop();
                },
              );
            },
            color: blue1,
            textColor: Colors.white,
            child: Text("Copy", style: TextStyle(fontSize: 14)),
          ),
        ),
      ],
    );
  }
}

class CurvedBottomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    // I've taken approximate height of curved part of view
    // Change it if you have exact spec for it
    final roundingHeight = size.height * 2 / 6;

    // this is top part of path, rectangle without any rounding
    final filledRectangle =
        Rect.fromLTRB(0, 0, size.width, size.height - roundingHeight);

    // this is rectangle that will be used to draw arc
    // arc is drawn from center of this rectangle, so it's height has to be twice roundingHeight
    // also I made it to go 5 units out of screen on left and right, so curve will have some incline there
    final roundingRectangle = Rect.fromLTRB(
        -1, size.height - roundingHeight * 2, size.width + 3, size.height);

    final path = Path();
    path.addRect(filledRectangle);

    // so as I wrote before: arc is drawn from center of roundingRectangle
    // 2nd and 3rd arguments are angles from center to arc start and end points
    // 4th argument is set to true to move path to rectangle center, so we don't have to move it manually
    path.arcTo(roundingRectangle, pi, -pi, true);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    // returning fixed 'true' value here for simplicity, it's not the part of actual question, please read docs if you want to dig into it
    // basically that means that clipping will be redrawn on any changes
    return true;
  }
}

class Transaction {
  Transaction({
    this.amount,
    this.date,
    this.merchantName,
  });

  double amount;
  DateTime date;
  String merchantName;

  factory Transaction.fromJson(Map<String, dynamic> json) => Transaction(
        amount: json["amount"].toDouble(),
        date: DateTime.parse(json["date"]),
        merchantName:
            json["merchant_name"] == null ? null : json["merchant_name"],
      );
}
