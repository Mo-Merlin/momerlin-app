import 'dart:math';
import 'dart:convert';
import 'package:decimal/decimal.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:momerlin/data/localstorage/userdata_source.dart';
import 'package:momerlin/pages/transaction/wallet_final.dart';
//import 'package:momerlin/services/toast.dart';
import 'package:momerlin/theme/theme.dart';
import 'package:momerlin/wallet%20api/eth_formetter.dart';
import 'package:momerlin/wallet%20api/validate_address.dart';
import 'package:momerlin/wallet%20api/wallet_api.dart';
import 'package:virtual_keyboard/virtual_keyboard.dart';
import '/models/ethgas.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:qrscan/qrscan.dart' as scanner;
import 'package:http/http.dart' as http;
import 'package:web3dart/web3dart.dart';
// import '../../remote/wallet api/validate_address.dart';

class SendWallet extends StatefulWidget {
  final myAddress;
  final coin;
  final encryptedSeed;
  const SendWallet({Key key, this.myAddress, this.coin, this.encryptedSeed})
      : super(key: key);

  @override
  _SendWalletState createState() => _SendWalletState();
}

class _SendWalletState extends State<SendWallet> with TickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  TextEditingController _controller = TextEditingController();
  TextEditingController _amount = TextEditingController();
  // ignore: unused_field
  TextEditingController _password = TextEditingController();
  AnimationController _lottie;
  bool addressError = false;
  bool amountError = false;
  String errorMessage = '';
  String errorMessage2 = '';
  String gasprice = '86';
  String myseed = '';
  bool sending = false;

  @override
  void initState() {
    getUserLanguage();
    getBalances();
    getEthGasPrice();
    _lottie = AnimationController(vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _lottie.dispose();
    super.dispose();
  }

  // Future _scan() async {
  Future<void> _scan() async {
    String barcodeScanRes;
    var response;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          "#ff6666", "Cancel", true, ScanMode.QR);
      if (barcodeScanRes == '-1') {
        setState(() {
          this._controller.text = '';
        });
      } else {
        response = barcodeScanRes.split(":");
        if (response.length == 2) {
          setState(() {
            this._controller.text = response[1].toString();
            _controller = TextEditingController(text: this._controller.text);
          });
        } else {
          setState(() {
            this._controller.text = barcodeScanRes;
            _controller = TextEditingController(text: barcodeScanRes);
          });
        }
      }
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }
  }
  // If the widget was removed from the tree while the asynchronous platform
  // message was in flight, we want to discard the reply rather than calling
  // setState to update our non-existent appearance.
  // if (!mounted) return;
  // }

  // await Permission.camera.request();
  // String barcode = await scanner.scan();
  // if (barcode == null) {
  // } else {
  //   this._controller.text = barcode;
  // }
  // }

  var etherAmountMain,
      etherAmountTest,
      binanceAmount,
      decrptedSeed,
      privatekey,
      commonbalance;
  String i = '86';
  bool gotbalance = false;
  Future<dynamic> getBalances() async {
    try {
      if (widget.coin == "Ethereum") {
        var res = await WalletApi().getBalanceEth(address: widget.myAddress);
        etherAmountTest =
            double.parse(EthAmountFormatter(res.getInWei).format());
        commonbalance = etherAmountTest;
      } else if (widget.coin == "Binance") {
        var bnb = await WalletApi().getBalanceBnb(address: widget.myAddress);
        binanceAmount = double.parse(EthAmountFormatter(bnb.getInWei).format());
        commonbalance = binanceAmount;
      }
      print(commonbalance);
      if (commonbalance < 1.0) {
        // availablity = "false";
      }
      gotbalance = true;
      setState(() {});
    } catch (e) {
      print("Can't get single user $e");
    }
  }

  Future<void> getEthGasPrice() async {
    final response = await http
        .get(Uri.parse("https://quickstart-1556528348680.web.app/gas"));
    var deres = EthGas.fromJson(json.decode(response.body));

    setState(() {
      gasprice = '${(deres.standard / 10)}';
      i = widget.coin == "Ethereum"
          ? '${(deres.standard / 10) * 21000 / 1e9}'
          : '${(deres.standard / 10) * 100000 / 1e9}';
    });
  }

  var userLanguage, user, lang = [];
  bool loading = true;
  Future<void> getUserLanguage() async {
    lang = await UserDataSource().getLanguage();
    user = await UserDataSource().getUser();
    // getuser();
    setState(() {
      loading = false;
    });
    if (lang.length != null && lang.length != 0) {
      userLanguage = lang[0];
    }
  }

  void sendTransaction(final amount) async {
    BigInt fees = BigInt.from(double.parse(gasprice));
    // decrptedSeed = decryptAESCryptoJS(widget.encryptedSeed, _password.text);
    privatekey = WalletApi.privateKeyFromMnemonic(user[0]["seed"]);
    myseed = decrptedSeed;
    setState(() {});

    // if (widget.coin == 'Ethereum') {
    double mytotal = double.parse(amount) + double.parse(i);
    if (etherAmountTest >= mytotal) {
      Decimal tokensAmountDecimal =
          Decimal.parse((double.parse(amount) * pow(10, 18)).toString());
      BigInt amount1 = BigInt.parse((tokensAmountDecimal).toString());
      EtherAmount newvalue =
          EtherAmount.fromUnitAndValue(EtherUnit.wei, amount1);
      print({_controller.text, privatekey, newvalue, fees});
      var res = await WalletApi()
          .sendTransactionEth(_controller.text, privatekey, newvalue, fees);
      // print(res['status']);
      if (res['status']) {
        setState(() {
          sending = false;
        });
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => WalletFinal()));
        // transactionAlert(true);s
        print("Payment success");
      } else {
        setState(() {
          sending = false;
        });

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Payment failed'),
          backgroundColor: Colors.red,
        ));
        //transactionAlert(false);
        print("Payment failed");
      }
    } else {
      setState(() {
        sending = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Insufficient balance'),
        backgroundColor: Colors.red,
      ));
      // Scaffold
      //   .of(context)
      //   .showSnackBar(SnackBar(content: Text('Insufficient balance'),backgroundColor: Colors.red,));
      // ToastMessage.toast("Insufficient balance");
    }
    // } else if (widget.coin == 'Binance') {
    //   double mytotal = double.parse(amount) + double.parse(i);
    //   if (commonbalance >= mytotal) {
    //     Decimal tokensAmountDecimal =
    //         Decimal.parse((double.parse(amount) * pow(10, 18)).toString());
    //     BigInt amount1 = BigInt.parse((tokensAmountDecimal).toString());
    //     EtherAmount newvalue =
    //         EtherAmount.fromUnitAndValue(EtherUnit.wei, amount1);
    //     var res = await WalletApi()
    //         .sendTransactionBNB(_controller.text, privatekey, newvalue, fees);
    //     if (res['status']) {
    //       setState(() {
    //         sending = false;
    //       });
    //       ToastMessage.toast('Payment success');
    //       transactionAlert(true);
    //       print("Payment success");
    //     } else {
    //       setState(() {
    //         sending = false;
    //       });
    //       ToastMessage.toast('Payment failed');
    //       transactionAlert(false);
    //       print("Payment failed");
    //     }
    //   } else {
    //     setState(() {
    //       sending = false;
    //     });
    //     ToastMessage.toast("Insufficient balance");
    //   }
    // } else {
    //   print("Invalid coin");
    //   ToastMessage.toast("Invalid Coin");
    // }
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Scaffold(
        key: _scaffoldKey,
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
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                Container(
                  margin: EdgeInsets.only(top: 5, right: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        height: 25,
                        width: 25,
                        child: CircleAvatar(
                          child: Image.asset(
                            "assets/images/ethereum_wallet.png",
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Container(
                        child: Text(
                          "BALANCE : ",
                          style: GoogleFonts.poppins(
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      gotbalance
                          ? Container(
                              child: Text(
                                commonbalance.toString(),
                                style: GoogleFonts.poppins(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                            )
                          : Container(),
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.04,
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
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.04,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      // color: Colors.amber,
                      width: MediaQuery.of(context).size.width * 0.25,
                      child: TextField(
                        keyboardType: TextInputType.number,
                        controller: _amount,
                        textAlign: TextAlign.center,
                        showCursor: false,
                        style: TextStyle(color: white, fontSize: 30),
                        onChanged: (value) {
                          setState(() {
                            amountError = false;
                            sending = false;
                          });
                        },
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(top: 0),
                          border: InputBorder.none,
                          hintText: '0',
                          hintStyle: GoogleFonts.poppins(
                            fontSize: 30,
                            fontWeight: FontWeight.w400,
                            color: amountError ? Colors.red : white,
                          ),
                          alignLabelWithHint: true,
                        ),
                        onTap: () {
                          _showVirutalkeyboardMobile();
                        },
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "ETH",
                      style: GoogleFonts.montserrat(
                        fontSize: 21,
                        color: orange,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                amountError
                    ? Container(
                        margin: EdgeInsets.only(top: 5),
                        alignment: Alignment.center,
                        child: Container(
                          child: Text(
                            errorMessage2,
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: amountError
                                  ? Colors.red
                                  : theme.textTheme.bodyText1.color,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      )
                    : Container(),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.04,
                ),
                Container(
                  // margin: EdgeInsets.only(top: 20, left: 20, right: 20),
                  // alignment: Alignment.center,
                  height: 80,
                  decoration: new BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(10),
                    color: gridcolor,
                  ),
                  margin: EdgeInsets.symmetric(horizontal: 1.0),
                  width: MediaQuery.of(context).size.width,
                  // height: 45,
                  // decoration: BoxDecoration(
                  //   borderRadius: BorderRadius.circular(10.0),
                  //   color: white,
                  // ),
                  child: Row(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width - 90,
                        padding: EdgeInsets.only(left: 5),
                        child: TextField(
                          controller: _controller,
                          textAlign: TextAlign.start,
                          style: GoogleFonts.poppins(
                            fontSize: 17,
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                          ),
                          onChanged: (value) {
                            setState(() {
                              addressError = false;
                            });
                          },
                          decoration: new InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12.0)),
                              borderSide: BorderSide(
                                  color: Colors.transparent, width: 2),
                            ),
                            filled: true,
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.transparent, width: 2),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                            ),
                            border: InputBorder.none,
                            hintStyle: TextStyle(color: Colors.white),
                            hintText: (lang.length != null && lang.length != 0)
                                ? "  ${userLanguage['enterAddressLable']}"
                                : '  Enter the Address',
                          ),

                          // decoration: InputDecoration(
                          //     hintText: 'Enter the address',
                          //     hintStyle: TextStyle(
                          //         color: theme.textTheme.bodyText1.color),
                          //     suffixIcon: IconButton(
                          //       onPressed: () {
                          //         _scan();
                          //       },
                          //       icon: Icon(
                          //         Icons.qr_code_2,
                          //         color: theme.textTheme.bodyText1.color,
                          //         size: 30,
                          //       ),
                          //     ),
                          //     contentPadding:
                          //         EdgeInsets.only(left: 10, top: 10),
                          //     border: InputBorder.none),
                          onTap: () {},
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
                                _scan();
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                addressError
                    ? Container(
                        alignment: Alignment.centerLeft,
                        margin: EdgeInsets.only(left: 25),
                        child: Row(
                          children: [
                            Icon(
                              FontAwesomeIcons.exclamationCircle,
                              size: 17,
                              color: Colors.red,
                            ),
                            SizedBox(width: 8),
                            Container(
                              margin: EdgeInsets.only(top: 5),
                              child: Text(
                                errorMessage,
                                style: TextStyle(
                                  fontFamily: 'Avenir',
                                  color: Colors.red,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ))
                    : Container(),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
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
                      Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        height: MediaQuery.of(context).size.height * 0.07,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: blue1),
                        child: TextButton(
                          onPressed: sending
                              ? null
                              : () {
                                  if (_amount.text == '') {
                                    setState(() {
                                      errorMessage2 = 'Please enter amount';
                                      amountError = true;
                                      sending = false;
                                    });
                                  } else if (_controller.text == '') {
                                    setState(() {
                                      errorMessage = 'Please enter address';
                                      addressError = true;
                                    });
                                  } else if (ValidateETH()
                                      .isValidEthereumAddress(
                                          _controller.text)) {
                                    sendTransaction(_amount.text);
                                  } else {
                                    setState(() {
                                      errorMessage = 'Not a valid address';
                                      addressError = true;
                                    });
                                  }
                                },
                          child: Text(
                            sending ? "SENDING" : "SEND NOW",
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
              ],
            ),
          ),
        ));
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
      _amount.text = _amount.text + (shiftEnabled ? key.capsText : key.text);
    } else if (key.keyType == VirtualKeyboardKeyType.Action) {
      switch (key.action) {
        case VirtualKeyboardKeyAction.Backspace:
          if (_amount.text != '' && _amount.text.length == 0) return;
          _amount.text = _amount.text.substring(0, _amount.text.length - 1);
          break;
        case VirtualKeyboardKeyAction.Return:
          _amount.text = _amount.text + '\n';
          break;
        case VirtualKeyboardKeyAction.Space:
          _amount.text = _amount.text + key.text;
          break;
        case VirtualKeyboardKeyAction.Shift:
          shiftEnabled = !shiftEnabled;
          break;
        default:
      }
    }
    // Update the screen
    setState(() {
      if (_amount.text != '') {
        setState(() {
          amountError = false;
        });
      }
    });
  }

  void transactionAlert(bool success) {
    ThemeData theme = Theme.of(this.context);
    Navigator.pop(context);
    showDialog(
        context: this.context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              elevation: 5,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30.0))),
              contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
              backgroundColor: theme.cardColor,
              content: Container(
                  height: MediaQuery.of(context).size.height / 2.25,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Center(
                        child: Container(
                          margin: EdgeInsets.only(top: 15),
                          child: Text(
                            success
                                ? "Transaction Success"
                                : "Transaction Failed!",
                            style: TextStyle(
                                fontFamily: 'Avenir',
                                color:
                                    Theme.of(context).textTheme.headline1.color,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.topCenter,
                        child: Lottie.asset(
                          success
                              ? 'assets/momerlin/lottie/success.json'
                              : 'assets/momerlin/lottie/try_again.json',
                          fit: BoxFit.scaleDown,
                          height: 250,
                          repeat: false,
                        ),
                      ),
                      Container(
                          height: 40,
                          // margin: EdgeInsets.only(top: 25),
                          padding: EdgeInsets.symmetric(horizontal: 40),
                          margin: EdgeInsets.only(bottom: 26),
                          decoration: new BoxDecoration(
                              // gradient: purpleGradient,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                              Navigator.pop(context);
                            },
                            child: Text(
                              success ? "Done" : "Close",
                              style: TextStyle(
                                  fontFamily: 'Avenir',
                                  color: Colors.white,
                                  fontSize: 17),
                            ),
                          ))
                    ],
                  )),
            );
          });
        });
  }
}
