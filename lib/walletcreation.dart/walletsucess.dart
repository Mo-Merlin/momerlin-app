import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:momerlin/data/localstorage/userdata_source.dart';
import 'package:momerlin/data/userrepository.dart';
import 'package:momerlin/theme/theme.dart';
import 'package:momerlin/wallet_screens/wallet_two.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:plaid_flutter/plaid_flutter.dart';

class WalletSucess extends StatefulWidget {
  @override
  _WalletSucess createState() => _WalletSucess();
}

class _WalletSucess extends State<WalletSucess> {
  PlaidLink _plaidLinkToken;
  var userLanguage, lang = [];
  bool loading = false;
  var selectedseed;
  var linktoken;
  @override
  void initState() {
    super.initState();
    loading = false;

    getUserLanguage();
  }

  int seedlength = 0;
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
  Future<void> _onSuccessCallback(
      String publicToken, LinkSuccessMetadata metadata) async {
    final usertoken =
        await UserRepository().updateToken({"public_token": publicToken});
    print("UserTokne $usertoken");
    final usersave = await UserRepository().storeUser({"token": publicToken});
    if (usersave == true) {
      Navigator.push(
          context, MaterialPageRoute(builder: (_) => WalletSucess()));
    } else {
      print("PAVITHRA");
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

  // Future<void> getToken() async {
  //   final usertoken1 = await UserRepository().getToken();
  //   linktoken = usertoken1["link_token"];
  //   print("token $linktoken");
  //   LinkTokenConfiguration linkTokenConfiguration = LinkTokenConfiguration(
  //     token: usertoken1["link_token"],
  //   );

  //   _plaidLinkToken = PlaidLink(
  //     configuration: linkTokenConfiguration,
  //     onSuccess: _onSuccessCallback,
  //     onEvent: _onEventCallback,
  //     onExit: _onExitCallback,
  //   );

  //   print("UserTokne $usertoken1");
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundcolor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: backgroundcolor,
        leading: Container(
          padding: EdgeInsets.all(5),
          child: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50), color: button),
              child: Icon(
                Icons.arrow_back,
                color: white,
                size: 30,
              ),
            ),
          ),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Spacer(),
            Image.asset(
              "assets/images/MOMERLIN.png",
              height: 40,
            ),
            Spacer(),
            LinearPercentIndicator(
              width: 102.0,
              lineHeight: 25.0,
              percent: 0.3,
              center: Padding(
                padding: const EdgeInsets.only(left: 50),
                child: Text(
                  "40%",
                  textAlign: TextAlign.end,
                  style: GoogleFonts.poppins(
                      color: white, fontSize: 12, fontWeight: FontWeight.w400),
                ),
              ),
              // trailing: Icon(Icons.mood),
              linearStrokeCap: LinearStrokeCap.roundAll,
              backgroundColor: Colors.grey,
              progressColor: blue,
            ),
          ],
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        // decoration: BoxDecoration(
        //   image: DecorationImage(
        //       image: AssetImage(
        //         "asstes/images/seed.png",
        //       ),
        //       fit: BoxFit.fill),
        // ),
        child: SingleChildScrollView(
          padding: EdgeInsets.only(left: 20, right: 20),
          child: Column(
            children: [
              Image.asset(
                "assets/images/btc.png",
              ),
              Text(
                (lang.length != null &&
                        lang.length != 0 &&
                        userLanguage['writedownthesewordsinorder'] != null)
                    ? "${userLanguage['writedownthesewordsinorder']}"
                    : "Would you like to earn Crypto in exchange for your anonymous payment data? ",
                style: GoogleFonts.poppins(
                    color: white, fontSize: 25, fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 70,
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (_) => WalletTwo()));
                },
                child: Container(
                  width: MediaQuery.of(context).size.width / 1.5,
                  height: MediaQuery.of(context).size.height / 11,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20), color: blue1),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/images/btcoin.png",
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        (lang.length != null &&
                                lang.length != 0 &&
                                userLanguage['ihavewrittenthemdown'] != null)
                            ? "${userLanguage['ihavewrittenthemdown']}"
                            : "Yes, I want free Crypto",
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
                height: 30,
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (_) => WalletTwo()));
                },
                child: Container(
                  width: MediaQuery.of(context).size.width / 1.5,
                  height: MediaQuery.of(context).size.height / 10,
                  // decoration: BoxDecoration(
                  //     borderRadius: BorderRadius.circular(20), color: blue),
                  child: Text(
                    (lang.length != null &&
                            lang.length != 0 &&
                            userLanguage['ihavewrittenthemdown'] != null)
                        ? "${userLanguage['ihavewrittenthemdown']}"
                        : "No, thank you",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                        color: white,
                        fontSize: 15,
                        fontWeight: FontWeight.w700),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
