import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:momerlin/theme/theme.dart';
import 'package:momerlin/walletcreation.dart/walletseed.dart';

class WalletHomePage extends StatefulWidget {
  @override
  _WalletHomePage createState() => _WalletHomePage();
}

class _WalletHomePage extends State<WalletHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Color(0xff6C6AEB),
          image: DecorationImage(
              image: AssetImage(
                "asstes/images/Login2.png",
              ),
              fit: BoxFit.fill),
        ),
        child: SingleChildScrollView(
          padding: EdgeInsets.only(left: 20, right: 20, top: 270),
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.55,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: backgroundcolor),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Hey there,\nyou new here?",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                            color: blue,
                            letterSpacing: 1,
                            fontSize: 30,
                            fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => WalletSeedPage()));
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.7,
                          height: MediaQuery.of(context).size.height * 0.09,
                          padding: EdgeInsets.only(left: 20),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: blue),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Icon(
                                Icons.add,
                                color: white,
                              ),
                              Text(
                                "Create Wallet",
                                style: GoogleFonts.poppins(
                                    color: white,
                                    letterSpacing: 1,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                            ],
                            // ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      InkWell(
                        onTap: () {},
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.7,
                          height: MediaQuery.of(context).size.height * 0.09,
                          padding: EdgeInsets.only(left: 20),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: button),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Icon(
                                Icons.file_upload_outlined,
                                color: white,
                              ),
                              Text(
                                "Import Wallet",
                                style: GoogleFonts.poppins(
                                    color: white,
                                    letterSpacing: 1,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 60),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.7,
                        child: Row(
                          children: [
                            Text(
                              "Terms & Conditions",
                              style: GoogleFonts.poppins(
                                  color: button,
                                  letterSpacing: 1,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400),
                            ),
                            Spacer(),
                            Text(
                              "Privacy Policy",
                              style: GoogleFonts.poppins(
                                  color: button,
                                  letterSpacing: 1,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400),
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
        ),
      ),
    );
  }
}
