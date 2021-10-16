import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:momerlin/data/localstorage/userdata_source.dart';
import 'package:momerlin/theme/theme.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import 'banklogin.dart';

class BankCreation extends StatefulWidget {
  @override
  _BankCreation createState() => _BankCreation();
}

class _BankCreation extends State<BankCreation> {
  var userLanguage, lang = [];
  var bank = [
    {"image": "bank1", "name": "TD Canada Trust"},
    {"image": "bank2", "name": "Wells Fargo"},
    {"image": "bank3", "name": "Citi Bank"},
    {"image": "bank4", "name": "RBC Bank"},
    {"image": "bank5", "name": "Chase Bank"},
    {"image": "bank6", "name": "Scotiabank"},
    {"image": "bank7", "name": "CIBC"},
    {"image": "bank8", "name": "Capital One Group"},
    {"image": "bank9", "name": "HSBC"},
  ];

  // ignore: todo
  //TODO :languagestart
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            Image.asset("assets/images/MOMERLIN.png"),
            Spacer(),
            LinearPercentIndicator(
              width: 102.0,
              lineHeight: 25.0,
              percent: 0.4,
              center: Text(
                "50%",
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
                    : "Connect your bank account ",
                style: GoogleFonts.poppins(
                    color: white, fontSize: 30, fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 5,
              ),
              TextField(
                decoration: InputDecoration(
                  fillColor: gridcolor,
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(
                      width: 0,
                      style: BorderStyle.none,
                    ),
                  ),
                  prefixIcon: Icon(
                    Icons.search,
                    color: Color(0xff9395A4),
                  ),
                  hintText: 'Can’t find your bank?',
                  hintStyle: TextStyle(
                    color: Color(0xff9395A4),
                    fontSize: 18,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              GridView.builder(
                shrinkWrap: true,
                itemCount: bank.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 0.8,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20),
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => BankLogin(bank[index])));
                    },
                    child: Column(
                      children: [
                        Container(
                          height: 100,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: gridcolor),
                          child: Center(
                            child: Image.asset(
                              "assets/images/${bank[index]['image']}.png",
                            ),
                          ),
                        ),
                        Text(
                          bank[index]['name'],
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                              color: white,
                              fontSize: 12,
                              fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ignore: todo
  //TODO: LanguageEnd
  Future<void> getUserLanguage() async {
    lang = await UserDataSource().getLanguage();
    if (lang.length != null && lang.length != 0) {
      userLanguage = lang[0];
    }
  }

  @override
  void initState() {
    super.initState();
    getUserLanguage();
  }
}
