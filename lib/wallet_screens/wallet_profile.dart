import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:momerlin/theme/theme.dart';
import 'package:google_fonts/google_fonts.dart';

class WalletProfile extends StatefulWidget {
  const WalletProfile({Key key}) : super(key: key);

  @override
  _WalletProfileState createState() => _WalletProfileState();
}

class _WalletProfileState extends State<WalletProfile> {
  String _chosenValue;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: backgroundcolor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 70,
              width: MediaQuery.of(context).size.width,
              //color: Colors.amber,
              child: Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: Container(
                        height: 50,
                        width: 50,
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
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Text(
                        "YOUR PROFILE",
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              height: 180,
              width: MediaQuery.of(context).size.width,
              //color: Colors.amber,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 25, left: 30),
                    child: Container(
                      //color: Colors.redAccent,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(40),
                          child: Container(
                            height: 80,
                            width: 80,
                            child: Image.network(
                              'https://www.pngitem.com/pimgs/m/78-786293_1240-x-1240-0-avatar-profile-icon-png.png',
                              fit: BoxFit.cover,
                            ),
                          )),
                    ),
                  ),
                  Container(
                    height: 200,
                    width: MediaQuery.of(context).size.width * 0.6,
                    //color: Colors.blue,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 25, left: 4),
                          child: Container(
                            height: 40,
                            width: 200,
                            //color: Colors.orange,
                            child: Text(
                              "Momo Omer",
                              style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontSize: 25,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                        Stack(
                          children: [
                            Container(
                              height: 45,
                              width: 200,
                              decoration: new BoxDecoration(
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.circular(10),
                                color: button,
                              ),
                              child: TextField(
                                //textAlign: TextAlign.left,
                                style: TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "A33HG469",
                                  hintStyle: GoogleFonts.montserrat(
                                    fontSize: 14,
                                    color: Colors.grey,
                                  ),
                                  contentPadding: EdgeInsets.only(left: 15),
                                ),
                              ),
                            ),
                            Positioned(
                              top: 5,
                              right: 5,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Container(
                                  height: 35,
                                  width: 35,
                                  color: blue1,
                                  child: IconButton(
                                      onPressed: () {},
                                      icon: Icon(
                                        Icons.copy,
                                        color: Colors.white,
                                        size: 15,
                                      )),
                                ),
                              ),
                            )
                          ],
                        ),
                        Container(
                          height: 50,
                          width: 200,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 5, left: 20),
                            child: Text(
                              "Earn 1% of referred earnings",
                              style: GoogleFonts.poppins(
                                  color: blue1,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Container(
                height: 90,
                decoration: BoxDecoration(
                  color: button,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 0, top: 15),
                          child: Text(
                            "MIN WITHDRAW",
                            style: GoogleFonts.poppins(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 15),
                          child: Container(
                            height: 35,
                            width: 80,
                            decoration: BoxDecoration(
                                color: backgroundcolor,
                                borderRadius: BorderRadius.circular(10)),
                            child: Center(
                              child: Text(
                                "\$5",
                                style: GoogleFonts.montserrat(
                                  color: Colors.white,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 13, top: 5),
                          child: Text(
                            "Current gas fee estimated",
                            style: GoogleFonts.poppins(
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                              color: blue1,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 25, top: 5),
                          child: Text(
                            "\$2.50",
                            style: GoogleFonts.montserrat(
                              color: blue1,
                              fontSize: 10,
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 15),
              child: Container(
                height: 90,
                decoration: BoxDecoration(
                  color: button,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 0, top: 30),
                          child: Text(
                            "SELECT CURRENCY",
                            style: GoogleFonts.poppins(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 30),
                          child: Container(
                            height: 35,
                            width: 80,
                            decoration: BoxDecoration(
                                color: backgroundcolor,
                                borderRadius: BorderRadius.circular(10)),
                            child: Center(
                              child: new Theme(
                                data: Theme.of(context).copyWith(
                                  canvasColor: backgroundcolor,
                                ),
                                child: DropdownButton<String>(
                                  //focusColor: backgroundcolor,
                                  value: _chosenValue,
                                  //elevation: 5,
                                  style: TextStyle(color: Colors.red),
                                  iconEnabledColor: blue1,
                                  items: <String>[
                                    '€ EUR',
                                    '£ GBP',
                                    '¥ JPY',
                                    '₴ UAH',
                                  ].map<DropdownMenuItem<String>>(
                                      (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(
                                        value,
                                        style: GoogleFonts.montserrat(
                                          fontSize: 15,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                  hint: Text("\$USD",
                                      style: GoogleFonts.montserrat(
                                        fontSize: 15,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                      )),
                                  onChanged: (String value) {
                                    setState(() {
                                      _chosenValue = value;
                                    });
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 15),
              child: Container(
                height: 90,
                decoration: BoxDecoration(
                  color: button,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 50, top: 20),
                          child: Text(
                            "SUPPORT",
                            style: GoogleFonts.poppins(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 50, top: 20),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Container(
                              height: 50,
                              width: 50,
                              color: backgroundcolor,
                              child: IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.search,
                                    color: blue1,
                                  )),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 15),
              child: Container(
                height: 90,
                decoration: BoxDecoration(
                  color: button,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 0, top: 20),
                          child: Text(
                            "FOLLOW US",
                            style: GoogleFonts.poppins(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 50, top: 20),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Container(
                              height: 50,
                              width: 50,
                              color: backgroundcolor,
                              child: IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    FontAwesomeIcons.twitter,
                                    color: blue1,
                                    size: 20,
                                  )),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 5, top: 20),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Container(
                              height: 50,
                              width: 50,
                              color: backgroundcolor,
                              child: IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    FontAwesomeIcons.facebook,
                                    color: blue1,
                                    size: 20,
                                  )),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 15),
              child: Container(
                height: 90,
                decoration: BoxDecoration(
                  color: button,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 23, top: 35),
                          child: Text(
                            "FOLLOW US",
                            style: GoogleFonts.poppins(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    ));
  }
}
