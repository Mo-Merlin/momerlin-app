import 'package:flutter/material.dart';
import 'package:momerlin/theme/theme.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class WalletTwo extends StatefulWidget {
  const WalletTwo({Key key}) : super(key: key);

  @override
  _WalletTwoState createState() => _WalletTwoState();
}

class _WalletTwoState extends State<WalletTwo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundcolor,
      body: Stack(children: [
        Container(
          height: 460,
          width: MediaQuery.of(context).size.width,
          //color: Colors.amber,
          child: Column(
            children: [
              AnimatedContainer(
                duration: Duration(milliseconds: 200),
                //color: blue1,
                height: 315,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: blue1,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.elliptical(200, 180),
                    bottomRight: Radius.elliptical(270, 90),
                  ),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 40),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(30),
                          child: Container(
                            height: 60,
                            width: 60,
                            child: Image.network(
                              'https://www.pngitem.com/pimgs/m/78-786293_1240-x-1240-0-avatar-profile-icon-png.png',
                              fit: BoxFit.cover,
                            ),
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Text(
                        "Your balance is",
                        style: GoogleFonts.poppins(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Center(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          RichText(
                            text: TextSpan(
                              text: '355',
                              style: GoogleFonts.montserrat(
                                fontSize: 75,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                              children: <TextSpan>[
                                TextSpan(
                                  text: '.00',
                                  style: GoogleFonts.montserrat(
                                    fontSize: 15,
                                    //fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                // TextSpan(
                                //   text: 'SATs',
                                //   style: GoogleFonts.poppins(
                                //     fontSize: 15,
                                //     //fontWeight: FontWeight.bold,
                                //     color: Colors.black,
                                //   ),
                                // ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 15),
                            child: Text(
                              "SATs",
                              style: GoogleFonts.montserrat(
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      // color: button,
                      height: 40,
                      width: 100,
                      decoration: BoxDecoration(
                        color: Color(0xff707070).withOpacity(0.4),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          "0.64USD",
                          style: GoogleFonts.montserrat(
                            fontSize: 13,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                        height: 130,
                        width: 110,
                        //color: button,
                        decoration: BoxDecoration(
                          color: button,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 25),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(30),
                                child: Container(
                                  height: 50,
                                  width: 50,
                                  color: Colors.green[300],
                                  child: IconButton(
                                      onPressed: () {},
                                      icon: Icon(
                                        Icons.arrow_upward,
                                        color: Colors.white,
                                      )),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 15),
                              child: Text(
                                "Send",
                                style: GoogleFonts.poppins(
                                    fontSize: 15, color: Colors.grey),
                              ),
                            )
                          ],
                        )),
                    Container(
                        height: 130,
                        width: 110,
                        //color: button,
                        decoration: BoxDecoration(
                          color: button,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 25),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(30),
                                child: Container(
                                  height: 50,
                                  width: 50,
                                  color: blue1,
                                  child: IconButton(
                                      onPressed: () {},
                                      icon: Icon(
                                        Icons.arrow_downward,
                                        color: Colors.white,
                                      )),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 15),
                              child: Text(
                                "Receive",
                                style: GoogleFonts.poppins(
                                    fontSize: 15, color: Colors.grey),
                              ),
                            )
                          ],
                        )),
                    Container(
                        height: 130,
                        width: 110,
                        //color: button,
                        decoration: BoxDecoration(
                          color: button,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 25),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(30),
                                child: Container(
                                  height: 50,
                                  width: 50,
                                  color: Colors.orange[300],
                                  child: IconButton(
                                      onPressed: () {},
                                      icon: Icon(
                                        FontAwesomeIcons.dollarSign,
                                        color: Colors.white,
                                      )),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 15),
                              child: Text(
                                "Receive",
                                style: GoogleFonts.poppins(
                                    fontSize: 15, color: Colors.grey),
                              ),
                            )
                          ],
                        ))
                  ],
                ),
              ),
            ],
          ),
        ),
        DraggableScrollableSheet(
          initialChildSize: 0.4,
          minChildSize: 0.4,
          maxChildSize: 0.7,
          builder: (BuildContext context, myscrollController) {
            return Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: button,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  //color: button,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 30),
                        child: Container(
                          height: 6,
                          width: 80,
                          decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(10)),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: Text(
                                "Transaction",
                                style: GoogleFonts.poppins(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 20),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Container(
                                  height: 40,
                                  width: 40,
                                  color: Colors.black54,
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
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 100),
                  child: ListView.builder(
                    controller: myscrollController,
                    itemCount: 25,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Container(
                          child: ListTile(
                            leading: ClipRRect(
                              borderRadius: BorderRadius.circular(30),
                              child: Container(
                                  height: 60,
                                  width: 60,
                                  color: Colors.black54,
                                  child: Image.network(
                                    "https://c.static-nike.com/a/images/w_1920,c_limit/mdbgldn6yg1gg88jomci/image.jpg",
                                    fit: BoxFit.cover,
                                  )),
                            ),
                            title: Text(
                              'Nike.com',
                              style: GoogleFonts.poppins(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white),
                            ),
                            subtitle: Text(
                              '3 min ago',
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                color: Colors.white,
                              ),
                            ),
                            trailing: Container(
                              height: 40,
                              width: 100,
                              decoration: BoxDecoration(
                                color: Color(0xff707070).withOpacity(0.4),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                child: RichText(
                                  text: TextSpan(
                                    text: '-12.00 ',
                                    style: GoogleFonts.montserrat(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white,
                                    ),
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: ' SATS',
                                        style: GoogleFonts.montserrat(
                                          fontSize: 12,
                                          color: Colors.orangeAccent,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          },
        )
      ]),
    );
  }
}
