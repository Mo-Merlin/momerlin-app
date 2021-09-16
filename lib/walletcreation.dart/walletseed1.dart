import 'package:flutter/material.dart';
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
  @override
  void initState() {
    print(widget.seed);
    selectedseed = widget.seed;
    selectedseed.shuffle();
    super.initState();
    print(widget.seed1);
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
  storeUser() async {
    String _pk = Web3.privateKeyFromMnemonic(widget.seed1);
    var walletMain = bitcoins.WalletBTC(
        seed: bitcoins.mnemonicToSeed(widget.seed1), net: bitcoins.mainnet);
    print(walletMain.getAddress(0));
    var walletTest = bitcoins.WalletBTC(
        seed: bitcoins.mnemonicToSeed(widget.seed1), net: bitcoins.testnet3);
    print(walletTest.getAddress(0));
    String _address = await Web3().getAddressFromPrivateKey(_pk);
    print(_address);

    final usersave = await UserRepository().storeUser({
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
    print("usersave$usersave");
  }
  // String _pk = Web3.privateKeyFromMnemonic(seed);

  // String _address = await Web3.getAddressFromPrivateKey(_pk);
  // print("addrwss $_address");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundcolor,
      appBar: AppBar(
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
            Image.asset("assets/images/MOMERLIN.png"),
            Spacer(),
            LinearPercentIndicator(
              width: 102.0,
              lineHeight: 25.0,
              percent: 0.2,
              center: Text(
                "25%",
                textAlign: TextAlign.end,
                style: GoogleFonts.poppins(
                    color: white, fontSize: 12, fontWeight: FontWeight.w400),
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
              Text(
                (lang.length != null &&
                        lang.length != 0 &&
                        userLanguage['writedownthesewordsinorder'] != null)
                    ? "${userLanguage['writedownthesewordsinorder']}"
                    : "Arrange the 12 words in the correct order",
                style: GoogleFonts.poppins(
                    color: white,
                    letterSpacing: 1,
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
                      color: white,
                      letterSpacing: 1,
                      fontSize: 12,
                      fontWeight: FontWeight.w400),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              GridView.builder(
                shrinkWrap: true,
                itemCount: seed1.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 1.5,
                    crossAxisSpacing: 30,
                    mainAxisSpacing: 20),
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: seed1[index] == "" ? gridcolor : blue),
                      child: Center(
                        child: Text(
                          seed1[index],
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                              color: white,
                              letterSpacing: 1,
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
                  return InkWell(
                    onTap: () {
                      setState(() {
                        seed1[seedlength] = selectedseed[index];
                        selectedseed.removeAt(index);
                        seedlength += 1;
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50), color: blue),
                      child: Center(
                        child: Text(
                          selectedseed[index],
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                              color: white,
                              letterSpacing: 1,
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
              InkWell(
                onTap: () {
                  // if (seedlength == 12) {
                  //   widget.seed == seed1
                  // ?
                  storeUser();
                  // Navigator.push(context,
                  //     MaterialPageRoute(builder: (_) => WalletSucess()));
                  // // : _modalBottomSheetMenu3();
                  // }
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.08,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: seedlength == 12 ? blue : gridcolor),
                  child: Center(
                    child: Text(
                      (lang.length != null &&
                              lang.length != 0 &&
                              userLanguage['ihavewrittenthemdown'] != null)
                          ? "${userLanguage['ihavewrittenthemdown']}"
                          : "FINISHED",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                          color: seedlength == 12 ? white : blue,
                          letterSpacing: 1,
                          fontSize: 15,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ),
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
                Divider(color: blue),
                SizedBox(
                  height: 9,
                ),
                FlatButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => this.widget));
                  },
                  child: Text(
                    'Ok, Got it',
                    style: TextStyle(color: blue, fontSize: 20),
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
