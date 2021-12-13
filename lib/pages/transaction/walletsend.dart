import 'dart:math';
import 'dart:convert';
import 'package:decimal/decimal.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:momerlin/data/localstorage/userdata_source.dart';
import 'package:momerlin/pages/transaction/wallet_final.dart';
import 'package:momerlin/services/toast.dart';
import 'package:momerlin/theme/theme.dart';
import 'package:momerlin/wallet%20api/eth_formetter.dart';
import 'package:momerlin/wallet%20api/validate_address.dart';
import 'package:momerlin/wallet%20api/wallet_api.dart';
import '/models/ethgas.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qrscan/qrscan.dart' as scanner;
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

  Future _scan() async {
    await Permission.camera.request();
    String barcode = await scanner.scan();
    if (barcode == null) {
    } else {
      this._controller.text = barcode;
    }
  }

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
                          context,
                          MaterialPageRoute(
                              builder: (context) => WalletFinal()));
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
        transactionAlert(false);
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
    return Container(
      color: backgroundcolor,
      child: SafeArea(
        child: Scaffold(
            key: _scaffoldKey,
            backgroundColor: backgroundcolor,
            body: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Container(
                          color: backgroundcolor,
                          child: Column(
                            children: [
                              Container(
                                margin: EdgeInsets.only(top: 5),
                                child: Row(
                                  children: [
                                    Container(
                                        margin: EdgeInsets.only(left: 10),
                                        child: IconButton(
                                          icon: Icon(
                                            Icons.arrow_back_ios,
                                            size: 25,
                                            color: white,
                                          ),
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                        )),
                                    Container(
                                      alignment: Alignment.centerLeft,
                                      padding: EdgeInsets.only(left: 5),
                                      child: Text(
                                        'Send to..',
                                        overflow: TextOverflow.ellipsis,
                                        style: GoogleFonts.poppins(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              gotbalance
                                  ? Container(
                                      margin: EdgeInsets.only(top: 5, right: 5),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Container(
                                            child: Text(
                                              "Balance: ",
                                              style: GoogleFonts.poppins(
                                                fontSize: 17,
                                                fontWeight: FontWeight.w400,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            child: Text(
                                              commonbalance.toString(),
                                              style: GoogleFonts.poppins(
                                                fontSize: 17,
                                                fontWeight: FontWeight.w400,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  : Container(),
                              Container(
                                padding: EdgeInsets.only(
                                    left: 20, top: 0, right: 15),
                                child: Column(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(top: 20),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            child: Text(
                                              "Amount: ",
                                              style: GoogleFonts.poppins(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              Container(
                                                alignment: Alignment.center,
                                                width: 100,
                                                height: 45,
                                                margin:
                                                    EdgeInsets.only(left: 10),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                  color: white,
                                                ),
                                                child: TextField(
                                                  keyboardType:
                                                      TextInputType.number,
                                                  controller: _amount,
                                                  textAlign: TextAlign.center,
                                                  showCursor: false,
                                                  style: TextStyle(
                                                      color: theme.textTheme
                                                          .bodyText1.color,
                                                      fontSize: 20),
                                                  onChanged: (value) {
                                                    setState(() {
                                                      amountError = false;
                                                      sending = false;
                                                    });
                                                  },
                                                  decoration: InputDecoration(
                                                    contentPadding:
                                                        EdgeInsets.only(top: 0),
                                                    border: InputBorder.none,
                                                    hintText: '0',
                                                    hintStyle:
                                                        GoogleFonts.poppins(
                                                      fontSize: 17,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: amountError
                                                          ? Colors.red
                                                          : theme.textTheme
                                                              .bodyText1.color,
                                                    ),
                                                    alignLabelWithHint: true,
                                                  ),
                                                  onTap: () {},
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  4.25)
                                        ],
                                      ),
                                    ),
                                    amountError
                                        ? Container(
                                            margin: EdgeInsets.only(top: 5),
                                            alignment: Alignment.topLeft,
                                            child: Container(
                                              child: Text(
                                                errorMessage2,
                                                style: GoogleFonts.poppins(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400,
                                                  color: amountError
                                                      ? Colors.red
                                                      : theme.textTheme
                                                          .bodyText1.color,
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          )
                                        : Container(),
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    top: 20, left: 20, right: 20),
                                alignment: Alignment.center,
                                width: MediaQuery.of(context).size.width,
                                height: 45,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  color: white,
                                ),
                                child: TextField(
                                  controller: _controller,
                                  textAlign: TextAlign.start,
                                  style: GoogleFonts.poppins(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black,
                                  ),
                                  onChanged: (value) {
                                    setState(() {
                                      addressError = false;
                                    });
                                  },
                                  decoration: InputDecoration(
                                      hintText: 'Enter the address',
                                      hintStyle: TextStyle(
                                          color:
                                              theme.textTheme.bodyText1.color),
                                      suffixIcon: IconButton(
                                        onPressed: () {
                                          _scan();
                                        },
                                        icon: Icon(
                                          Icons.qr_code_2,
                                          color:
                                              theme.textTheme.bodyText1.color,
                                          size: 30,
                                        ),
                                      ),
                                      contentPadding:
                                          EdgeInsets.only(left: 10, top: 10),
                                      border: InputBorder.none),
                                  onTap: () {},
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
                              Align(
                                  alignment: Alignment.center,
                                  child: Container(
                                      height: 40,
                                      margin: EdgeInsets.only(top: 15),
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 30),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          color: blue1),
                                      child: TextButton(
                                        onPressed: sending
                                            ? null
                                            : () {
                                                if (_amount.text == '') {
                                                  setState(() {
                                                    errorMessage2 =
                                                        'Please enter amount';
                                                    amountError = true;
                                                    sending = true;
                                                  });
                                                } else if (_controller.text ==
                                                    '') {
                                                  setState(() {
                                                    errorMessage =
                                                        'Please enter address';
                                                    addressError = true;
                                                  });
                                                } else if (ValidateETH()
                                                    .isValidEthereumAddress(
                                                        _controller.text)) {
                                                   sendTransaction(_amount.text);
                                                } else {
                                                  setState(() {
                                                    errorMessage =
                                                        'Not a valid address';
                                                    addressError = true;
                                                  });
                                                }
                                              },
                                        child: Text(
                                          sending ? "Sending" : "Send",
                                          style: GoogleFonts.poppins(
                                              color: white,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),),),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )),
      ),
    );
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
