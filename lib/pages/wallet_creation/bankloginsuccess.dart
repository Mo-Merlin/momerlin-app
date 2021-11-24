import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:momerlin/data/localstorage/userdata_source.dart';
import 'package:momerlin/pages/transaction/wallet_main.dart';
import 'package:momerlin/theme/theme.dart';

class BankLoginSuccess extends StatefulWidget {
  @override
  _BankLoginSuccess createState() => _BankLoginSuccess();
}

class _BankLoginSuccess extends State<BankLoginSuccess> {
  var userLanguage, lang = [];
  bool banklogin = false;
  @override
  void initState() {
    super.initState();
    getUserLanguage();
  }

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundcolor,
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          padding: EdgeInsets.only(left: 20, right: 20),
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Text(
                (lang.length != null &&
                        lang.length != 0 &&
                        userLanguage['writedownthesewordsinorder'] != null)
                    ? "${userLanguage['writedownthesewordsinorder']}"
                    : "Log in to your Wells Fargo account",
                style: GoogleFonts.poppins(
                    color: white, fontSize: 30, fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 15,
              ),
              Image.asset(
                "assets/images/bank2.png",
                height: 100,
                width: 100,
                fit: BoxFit.fill,
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30), color: gridcolor),
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    TextField(
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.account_circle_outlined,
                          color: orange,
                        ),
                        hintText: 'Username',
                        hintStyle: TextStyle(
                          color: Color(0xff9395A4),
                          fontSize: 18,
                        ),
                        border: InputBorder.none,
                      ),
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Divider(
                      color: Colors.grey,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextField(
                      decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.lock,
                            color: blue,
                          ),
                          hintText: 'Password',
                          hintStyle: TextStyle(
                            color: Color(0xff9395A4),
                            fontSize: 18,
                          ),
                          border: InputBorder.none),
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      onChanged: (value) {
                        setState(() {
                          banklogin = true;
                        });
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 50,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (_) => WalletTwo()));
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.08,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: banklogin == true ? blue : gridcolor),
                  child: Center(
                    child: Text(
                      (lang.length != null &&
                              lang.length != 0 &&
                              userLanguage['ihavewrittenthemdown'] != null)
                          ? "${userLanguage['ihavewrittenthemdown']}"
                          : "CONNECT",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                          color: banklogin == true ? white : blue,
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
}
