import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:momerlin/data/localstorage/userdata_source.dart';
import 'package:momerlin/data/userrepository.dart';
import 'package:momerlin/data/web3.dart';
import 'package:momerlin/theme/theme.dart';
import 'package:momerlin/walletcreation.dart/walletsucess.dart';

import 'package:bitcoins/bitcoins.dart' as bitcoins;
import 'package:percent_indicator/linear_percent_indicator.dart';

class WalletSeedCheckPage extends StatefulWidget {
  WalletSeedCheckPage(this.seed, this.seed1);
  final seed;
  final seed1;

  @override
  _WalletSeedCheckPage createState() => _WalletSeedCheckPage();
}

class _WalletSeedCheckPage extends State<WalletSeedCheckPage> {
  var userLanguage, lang = [];

  List seed1 = [
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
  ];
  bool loading = false;
  var selectedseed;
  var seedcheck;
  // selectedseed= widget.seed;
  @override
  void initState() {
    loading = false;
    var seed2 = widget.seed1.split(" ");
    seedcheck = widget.seed1.split(" ");
    selectedseed = seed2;
    // selectedseed = widget.seed;
    print(widget.seed);
    selectedseed.shuffle();
    print("Selectedseed $seedcheck");
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

  final GlobalKey<ScaffoldState> scaffoldKeyWallet =
      new GlobalKey<ScaffoldState>();
  void _showScaffold(String message) {
    // ignore: deprecated_member_use
    scaffoldKeyWallet.currentState.showSnackBar(
      SnackBar(
        content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              message,
              style: GoogleFonts.poppins(
                color: white,
                fontSize: 17,
                fontWeight: FontWeight.w400,
              ),
            ),
            Icon(
              Icons.info_outline,
              color: Colors.white,
            )
          ],
        ),
        backgroundColor: Colors.red,
      ),
    );
  }

  // ignore: todo
  //TODO: LanguageEnd
  storeUser() async {
    loading = true;
    String _pk = Web3.privateKeyFromMnemonic(widget.seed1);
    var walletMain = bitcoins.WalletBTC(
        seed: bitcoins.mnemonicToSeed(widget.seed1), net: bitcoins.mainnet);
    print(walletMain.getAddress(0));
    var walletTest = bitcoins.WalletBTC(
        seed: bitcoins.mnemonicToSeed(widget.seed1), net: bitcoins.testnet3);
    print(walletTest.getAddress(0));
    String _address = await Web3().getAddressFromPrivateKey(_pk);
    print(_address);
    var user = await UserRepository().adduser({
      "ethAddress": _address,
      "btcAddress": walletMain.getAddress(0),
      "fullName": "NickName",
    });
    if (user == false) {
      _showScaffold('No Internet Connection');
    
    } else {
      print(user["success"]);
      if (user["success"] == false) {
        _showScaffold('Something Went Wrong!');
      } else {
        print(user["user"]["_id"]);
        final usersave = await UserRepository().storeUser({
          "uid": user["user"]["_id"],
          "address": _address,
          "btcTestnetAddress": walletTest.getAddress(0),
          "btcMainnetAddress": walletMain.getAddress(0),
          "seed": widget.seed1,
          "language": "English"
        });
        if (usersave == true) {
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => WalletSucess()));
        } else {
          print("PAVITHRA");
        }
      }
      //
    }
    print("uesrr12323 $user");

    // print("usersave$usersave");
  }

  @override
  Widget build(BuildContext context) {
    print(widget.seed);

    return Scaffold(
      key: scaffoldKeyWallet,
      backgroundColor: backgroundcolor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: backgroundcolor,
        leading: Container(
          padding: EdgeInsets.all(5),
          child: GestureDetector(
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
              percent: 0.2,

              center: Padding(
                padding: EdgeInsets.only(left: 50),
                child: Text(
                  "25%",
                  textAlign: TextAlign.end,
                  style: GoogleFonts.poppins(
                      color: white, fontSize: 12, fontWeight: FontWeight.w400),
                ),
              ),
              // trailing: Icon(Icons.mood),
              linearStrokeCap: LinearStrokeCap.roundAll,
              backgroundColor: gridcolor,
              progressColor: blue,
            ),
          ],
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          padding: EdgeInsets.only(left: 25, right: 25),
          child: Column(
            children: [
              SizedBox(
                height: 60,
              ),
              Text(
                (lang.length != null &&
                        lang.length != 0 &&
                        userLanguage['writedownthesewordsinorder'] != null)
                    ? "${userLanguage['writedownthesewordsinorder']}"
                    : "Arrange the 12 words in the correct order",
                style: GoogleFonts.poppins(
                    height: 1.2,
                    color: white,
                    fontSize: 30,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 5,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  (lang.length != null &&
                          lang.length != 0 &&
                          userLanguage['recoverykey'] != null)
                      ? "${userLanguage['recoverykey']}"
                      : "Drag each word into the same order it appeared!",
                  textAlign: TextAlign.start,
                  style: GoogleFonts.poppins(
                    color: grey,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              SizedBox(
                height: 50,
              ),
              GridView.builder(
                shrinkWrap: true,
                itemCount: seed1.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 1.8,
                    crossAxisSpacing: 30,
                    mainAxisSpacing: 30),
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        if (seedlength > 0) {
                          selectedseed.add(seed1[index]);
                          seed1.removeAt(index);
                          seed1.add("");

                          seedlength -= 1;
                        }
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: seed1[index] == "" ? gridcolor : blue1),
                      child: Center(
                        child: Text(
                          seed1[index],
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                              color: white,
                              fontSize: 15,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  );
                },
              ),
              SizedBox(
                height: 20,
              ),
              GridView.builder(
                shrinkWrap: true,
                itemCount: selectedseed.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    childAspectRatio: 2.5,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 20),
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        seed1[seedlength] = selectedseed[index];
                        selectedseed.removeAt(index);
                        seedlength += 1;
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: blue1),
                      child: Center(
                        child: Text(
                          selectedseed[index],
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                              color: white,
                              fontSize: 15,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  );
                },
              ),
              SizedBox(
                height: 40,
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    loading = true;
                  });
                  // if (seedlength == 12) {
                  if (seed1.toString() == seedcheck.toString()) {
                    storeUser();
                  } else {
                    _modalBottomSheetMenu3();
                  }
                  // }
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.07,
                  decoration: seedlength == 12
                      ? BoxDecoration(
                          borderRadius: BorderRadius.circular(28), color: blue1)
                      : BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: gridcolor),
                  child: Center(
                    child: loading == true
                        ? SpinKitThreeBounce(
                            color: white,
                            size: 30,
                          )
                        : Text(
                            (lang.length != null &&
                                    lang.length != 0 &&
                                    userLanguage['ihavewrittenthemdown'] !=
                                        null)
                                ? "${userLanguage['ihavewrittenthemdown']}"
                                : "FINISHED",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(
                                color: seedlength == 12 ? white : blue1,
                                fontSize: 15,
                                fontWeight: FontWeight.w600),
                          ),
                  ),
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  void _modalBottomSheetMenu3() {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(25.0))),
      // enableDrag: false,
      builder: (builder) {
        return new Padding(
          padding: EdgeInsets.all(30),
          child: Container(
            height: 280,
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.close,
                      color: Colors.red,
                      size: 25,
                    ),
                    Text(
                      "Seed is wrong",
                      style: (TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold)),
                      textAlign: TextAlign.start, // has impact
                    ),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  'Please enter valid seed',
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(
                  height: 25,
                ),
                Divider(color: blue1),
                SizedBox(
                  height: 9,
                ),
                // ignore: deprecated_member_use
                FlatButton(
                  onPressed: () {
                    // Navigator.pushReplacement(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (BuildContext context) => this.widget));
                    // var seed2 = widget.seed1.split(" ");
                    seedcheck = widget.seed1.split(" ");
                    setState(() {
                      var seed2 = widget.seed1.split(" ");

                      selectedseed = seed2;
                      // selectedseed = widget.seed;

                      selectedseed.shuffle();
                      seed1.clear();
                      Navigator.pop(context);
                      loading = false;
                      seed1.add("");
                      seed1.add("");
                      seed1.add("");
                      seed1.add("");
                      seed1.add("");
                      seed1.add("");
                      seed1.add("");
                      seed1.add("");
                      seed1.add("");
                      seed1.add("");
                      seed1.add("");
                      seed1.add("");
                      seedlength = 0;
                    });
                  },
                  child: Text(
                    'Ok, Got it',
                    style: TextStyle(color: blue1, fontSize: 20),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
