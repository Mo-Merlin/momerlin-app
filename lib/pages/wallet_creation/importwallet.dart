//import 'package:bitcoins/bitcoins.dart' as bitcoins;
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:momerlin/data/localstorage/userdata_source.dart';
import 'package:momerlin/data/userrepository.dart';
import 'package:momerlin/data/web3.dart';
import 'package:momerlin/tabscreen/tabscreen.dart';
import 'package:momerlin/theme/theme.dart';

class ImportWalletPage extends StatefulWidget {
  @override
  _ImportWalletPage createState() => _ImportWalletPage();
}

class _ImportWalletPage extends State<ImportWalletPage> {
  var userLanguage, lang = [];

  @override
  void initState() {
    super.initState();

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

  TextEditingController _controller;
  bool loading = false;
  String seed;
  // ignore: todo
  //TODO: LanguageEnd
  storeUser() async {
    // String seed1 = _controller.text;
    String _pk = Web3.privateKeyFromMnemonic(seed);
    // var walletMain = bitcoins.WalletBTC(
    //     seed: bitcoins.mnemonicToSeed(seed), net: bitcoins.mainnet);
    // print(walletMain.getAddress(0));
    // var walletTest = bitcoins.WalletBTC(
    //     seed: bitcoins.mnemonicToSeed(seed), net: bitcoins.testnet3);
    // print(walletTest.getAddress(0));
    String _address = await Web3().getAddressFromPrivateKey(_pk);
    print(_address);
    var res = await UserRepository().getUser(_address);
    print(res);
    if (res['user'] != null) {
      //  print(user["user"]["_id"]);
      final usersave = await UserRepository().storeUser({
        "uid": res["user"]["_id"],
        "address": _address,
        // "btcTestnetAddress": walletTest.getAddress(0),
        // "btcMainnetAddress": walletMain.getAddress(0),
        "seed": seed,
        "language": "English",
        "googlefitenable": 0,
        "plaidlogin": 0,
        "healthfitenable": 0
      });
      if (usersave == true) {
        Navigator.push(context, MaterialPageRoute(builder: (_) => Tabscreen()));
      } else {}
    } else {
      var user = await UserRepository().adduser({
        "ethAddress": _address,
        "imageUrl":"",
        // "btcAddress": walletMain.getAddress(0),
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
            // "btcTestnetAddress": walletTest.getAddress(0),
            // "btcMainnetAddress": walletMain.getAddress(0),
            "seed": seed,
            "language": "English",
            "googlefitenable": 0,
            "healthfitenable": 0,
          });
          if (usersave == true) {
            Navigator.push(
                context, MaterialPageRoute(builder: (_) => Tabscreen()));
          } else {}
        }
        //
      }
    }
    // final usersave = await UserRepository().storeUser({
    //   "uid": user["user"]["_id"],
    //       "address": _address,
    //       "btcTestnetAddress": walletTest.getAddress(0),
    //       "btcMainnetAddress": walletMain.getAddress(0),
    //       "seed": seed,
    //       "language": "English",
    //       "googlefitenable":0,

    // });
    // if (usersave == true) {
    //   Navigator.push(context, MaterialPageRoute(builder: (_) => Tabscreen()));
    // } else {
    //   print("PAVITHRA");
    // }
    // print("usersave$usersave");
  }
  // String _pk = Web3.privateKeyFromMnemonic(seed);

  // String _address = await Web3.getAddressFromPrivateKey(_pk);
  // print("addrwss $_address");

  final GlobalKey<ScaffoldState> scaffoldKeyWallet =
      new GlobalKey<ScaffoldState>();
  void _showScaffold(String message) {
    // ignore: deprecated_member_use
    scaffoldKeyWallet.currentState.showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: GoogleFonts.poppins(
            color: white,
            fontSize: 17,
            fontWeight: FontWeight.w400,
          ),
        ),
        backgroundColor: blue1,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
                    : "Import an Account with Seed Phrase",
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
                      : "Enter your secret 12 word phrase here to restore your wallet!",
                  textAlign: TextAlign.start,
                  style: GoogleFonts.poppins(
                      color: grey, fontSize: 12, fontWeight: FontWeight.w400),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Image.asset(
                "assets/images/importwallet.png",
                width: 300,
                // height: 00,
                fit: BoxFit.fill,
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.only(left: 5),
                child: TextField(
                  maxLines: 4,
                  onChanged: (value) {
                    seed = value;
                    seedlength = seed.length;
                  },
                  controller: _controller,
                  decoration: new InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12.0)),
                      borderSide: BorderSide(color: gridcolor, width: 2),
                    ),
                    filled: true,
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: gridcolor, width: 2),
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                    border: InputBorder.none,
                    hintStyle: TextStyle(color: Colors.white),
                    hintText: (lang.length != null && lang.length != 0)
                        ? "  ${userLanguage['enterAddressLable']}"
                        : '  Enter the Seed',
                  ),
                  style: TextStyle(fontSize: 13, color: white),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              GestureDetector(
                onTap: () {
                  print(seed);
                  // setState(() {
                  //   seed.length == 12 ? loading = true : loading = false;
                  // });
                  // seed.length == 12
                  // ?
                  storeUser();
                  // : _showScaffold('Please enter valid seed phrase');

                  // }
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.07,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: seedlength == 12 ? blue1 : gridcolor),
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
                                : "Import Wallet",
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
}
