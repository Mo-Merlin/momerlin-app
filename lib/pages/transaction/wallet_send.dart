import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:momerlin/data/localstorage/userdata_source.dart';
import 'package:momerlin/theme/theme.dart';
import 'package:virtual_keyboard/virtual_keyboard.dart';
import 'wallet_final.dart';

class WalletSend extends StatefulWidget {
  const WalletSend({Key key}) : super(key: key);

  @override
  _WalletSendState createState() => _WalletSendState();
}

class _WalletSendState extends State<WalletSend> {
  var userLanguage, user, lang = [];
  double widthbtc = 110;
  String output = "0";

  @override
  void initState() {
    super.initState();
    getUserLanguage();

    _controller = TextEditingController(text: _scanBarcode);
  }

  // ignore: todo
  //TODO :languagestart
  Future<void> getUserLanguage() async {
    lang = await UserDataSource().getLanguage();

    user = await UserDataSource().getUser();
    if (lang.length != null && lang.length != 0) {
      userLanguage = lang[0];
    }
  }

  // ignore: todo
  //TODO: LanguageEnd

  String text = '';
  String _scanBarcode = "";
  TextEditingController _controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundcolor,
      appBar: AppBar(
        backgroundColor: backgroundcolor,
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
                  userLanguage['sendfunds'] != null)
              ? "${userLanguage['sendfunds']}"
              : "SEND FUNDS",
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 17,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 40,
            ),
            Text(
              (lang.length != null &&
                      lang.length != 0 &&
                      userLanguage['iwanttosend'] != null)
                  ? "${userLanguage['iwanttosend']}"
                  : "I want to send",
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 21,
                fontWeight: FontWeight.w500,
              ),
            ),
            Container(
              // height: MediaQuery.of(context).size.height / 8,
              width: MediaQuery.of(context).size.width,
              //color: Colors.amber,
              child: GestureDetector(
                onTap: () {
                  output = '';
                  _showVirutalkeyboardMobile();
                },
                child: Row(
                  // alignment: Alignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      output == '' ? text : output,
                      style: GoogleFonts.montserrat(
                        fontSize: 101,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 50),
                      child: Text(
                        " Gwei",
                        style: GoogleFonts.montserrat(
                          fontSize: 21,
                          color: orange,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      // ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "to:",
              style: GoogleFonts.poppins(
                fontSize: 21,
                color: Colors.white,
                fontWeight: FontWeight.w400,
              ),
              textAlign: TextAlign.left,
            ),
            SizedBox(height: 10),
            Container(
              decoration: new BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(10),
                color: gridcolor,
              ),
              margin: EdgeInsets.symmetric(horizontal: 1.0),
              // color: Colors.grey[100],
              height: 80,
              child: Row(
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width - 90,
                    padding: EdgeInsets.only(left: 5),
                    child: TextField(
                      onChanged: (value) {
                        _scanBarcode = value;
                      },
                      controller: _controller,
                      decoration: new InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12.0)),
                          borderSide:
                              BorderSide(color: Colors.transparent, width: 2),
                        ),
                        filled: true,
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.transparent, width: 2),
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                        border: InputBorder.none,
                        hintStyle: TextStyle(color: Colors.white),
                        hintText: (lang.length != null && lang.length != 0)
                            ? "  ${userLanguage['enterAddressLable']}"
                            : '  Enter the Address',
                      ),
                      style: TextStyle(fontSize: 13, color: white),
                    ),
                  ),
                  Center(
                    // alignment: Alignment.topCenter,
                    child: Padding(
                      padding: EdgeInsets.only(right: 0),
                      child: Container(
                        child: IconButton(
                          icon: Icon(
                            FontAwesomeIcons.qrcode,
                            color: white,
                            // color: AppColors.loginButton,
                          ),
                          onPressed: () {
                            scanQR();
                          },
                        ),
                      ),
                    ),
                  ),
                ], // NEW
              ), // NEW
            ),
            // SizedBox(
            //   height: 10,
            // ),
            Container(
              // height: 160,
              width: MediaQuery.of(context).size.width,
              //color: Colors.amber,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 50),
                          child: Container(
                            height: 11,
                            width: 11,
                            child: Icon(
                              Icons.fmd_bad_rounded,
                              color: blue1,
                              size: 10,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          (lang.length != null &&
                                  lang.length != 0 &&
                                  userLanguage[
                                          'pleasedoublecheckyourrecipientsinfo'] !=
                                      null)
                              ? "${userLanguage['pleasedoublecheckyourrecipientsinfo']}"
                              : "PLEASE DOUBLE CHECK YOUR RECIPIENTS INFO",
                          style: GoogleFonts.poppins(
                            fontSize: 9,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey,
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => WalletFinal()));
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                      height: MediaQuery.of(context).size.height * 0.07,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: blue1),
                      // height: 50,
                      // width: MediaQuery.of(context).size.width * 0.9,
                      // ignore: deprecated_member_use
                      child: Center(
                        child: Text(
                          (lang.length != null &&
                                  lang.length != 0 &&
                                  userLanguage['sendnow'] != null)
                              ? "${userLanguage['sendnow']}"
                              : 'SEND NOW',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> scanQR() async {
    String barcodeScanRes;
    var response;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          "#ff6666", "Cancel", true, ScanMode.QR);
      if (barcodeScanRes == '-1') {
        setState(() {
          _scanBarcode = '';
        });
      } else {
        response = barcodeScanRes.split(":");
        if (response.length == 2) {
          setState(() {
            _scanBarcode = response[1].toString();
            _controller = TextEditingController(text: _scanBarcode);
          });
        } else {
          setState(() {
            _scanBarcode = barcodeScanRes;
            _controller = TextEditingController(text: barcodeScanRes);
          });
        }
      }
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;
  }

  _showVirutalkeyboardMobile() {
    showModalBottomSheet(
      backgroundColor: backgroundcolor,
      isScrollControlled: true,
      context: context,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(25.0))),
      builder: (builder) {
        return new Wrap(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(18),
              // color: backgroundcolor,
              child: receiveContent(),
            ),
          ],
        );
      },
    );
  }

  Widget receiveContent() {
    return Container(
      color: backgroundcolor,
      child: VirtualKeyboard(
          height: 260,
          textColor: Colors.white,
          fontSize: 20,
          type: VirtualKeyboardType.Numeric,
          onKeyPress: _onKeyPress),
    );
  }

  bool shiftEnabled = false;
  bool isNumericMode = true;
  _onKeyPress(VirtualKeyboardKey key) {
    if (key.keyType == VirtualKeyboardKeyType.String) {
      text = text + (shiftEnabled ? key.capsText : key.text);
    } else if (key.keyType == VirtualKeyboardKeyType.Action) {
      switch (key.action) {
        case VirtualKeyboardKeyAction.Backspace:
          if (text != '' && text.length == 0) return;
          text = text.substring(0, text.length - 1);
          break;
        case VirtualKeyboardKeyAction.Return:
          text = text + '\n';
          break;
        case VirtualKeyboardKeyAction.Space:
          text = text + key.text;
          break;
        case VirtualKeyboardKeyAction.Shift:
          shiftEnabled = !shiftEnabled;
          break;
        default:
      }
    }
    // Update the screen
    setState(() {});
  }

  // void _onSendTransaction1(
  //     // BuildContext context,
  //     coin) async {
  //   String address = _controller.text;
  //   String seed = user[0]["seed"];
  //   var privatekey = Web3.privateKeyFromMnemonic(seed);
  //   // print(seed);
  //   BigInt fees = BigInt.from(double.parse(0.85.toString()));

  //   if (coin == 'EthereumMain') {
  //     double mytotal = double.parse(text) + double.parse(0.06.toString());
  //     // if (etherAmountTest >= mytotal) {
  //     Decimal tokensAmountDecimal = Decimal.parse(
  //         (double.parse(text.toString() * pow(10, 18)).toString()));
  //     BigInt amount1 = BigInt.parse((tokensAmountDecimal).toString());
  //     // print(amount1);
  //     EtherAmount newvalue =
  //         EtherAmount.fromUnitAndValue(EtherUnit.wei, amount1);

  //     // print(newvalue);
  //     var res =
  //         await Web3().sendTransactionMain(address, privatekey, newvalue, fees);
  //     // print("res");
  //     if (res['status']) {
  //       // setState(() {
  //       //   _transfer = false;
  //       // });
  //       // Navigator.of(context).push(
  //       //   MaterialPageRoute(
  //       //     builder: (context) => PaymentSuccessful(
  //       //       response: res,
  //       //       coin: coin,
  //       //     ),
  //       //   ),
  //       // );
  //     } else {
  //       // setState(() {
  //       //   _transfer = false;
  //       // });
  //       // Navigator.of(context).push(
  //       //   MaterialPageRoute(
  //       //     builder: (context) => PaymentFailed(),
  //       //   ),
  //       // );
  //     }
  //     // } else {
  //     //   _modalBottomSheetMenu3();
  //     // }
  //   } else if (coin == 'EthereumTest') {
  //     double mytotal =
  //         double.parse(text.toString()) + double.parse(0.06.toString());
  //     // if (etherAmountTest >= mytotal) {
  //     Decimal tokensAmountDecimal = Decimal.parse(
  //         (double.parse(text.toString()) * pow(10, 18)).toString());
  //     BigInt amount1 = BigInt.parse((tokensAmountDecimal).toString());
  //     EtherAmount newvalue =
  //         EtherAmount.fromUnitAndValue(EtherUnit.wei, amount1);
  //     // print("$address,$seed,$newvalue,$fees");
  //     var res =
  //         await Web3().sendTransactionTest(address, privatekey, newvalue, fees);
  //     // print(res['status']);
  //     if (res['status']) {
  //       // setState(() {
  //       //   _transfer = false;
  //       // });
  //       // Navigator.of(context).push(
  //       //   MaterialPageRoute(
  //       //     builder: (context) => PaymentSuccessful(
  //       //       response: res,
  //       //       coin: coin,
  //       //     ),
  //       //   ),
  //       // );
  //     } else {
  //       // setState(() {
  //       //   _transfer = false;
  //       // });
  //       // Navigator.of(context).push(
  //       //   MaterialPageRoute(
  //       //     builder: (context) => PaymentFailed(),
  //       //   ),
  //       // );
  //     }
  //     // } else {
  //     //   _modalBottomSheetMenu3();
  //     // }
  //   }
  // }
}
