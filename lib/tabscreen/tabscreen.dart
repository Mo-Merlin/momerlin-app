import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:momerlin/pages/reportspages/my_reports.dart';
import 'package:momerlin/pages/transaction/wallet_main.dart';
import 'package:momerlin/pages/transaction/wallet_profile.dart';
import 'package:momerlin/pages/wallet_challenge/wallet_challenges.dart';
import 'package:momerlin/theme/theme.dart';

class Tabscreen extends StatefulWidget {
  final index;

  const Tabscreen({Key key, this.index}) : super(key: key);
  @override
  _TabscreenState createState() => new _TabscreenState();
}

class _TabscreenState extends State<Tabscreen> with TickerProviderStateMixin {
  int _selectedIndex = 0;
  bool showJades = false;
  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      value: 2.0,
      duration: Duration(milliseconds: 10),
    );
    animation = Tween(begin: 0.0, end: 1.0).animate(_animationController);

    if (widget.index != null) {
      setState(() {
        _selectedIndex = widget.index;
      });
    }
  }

  AnimationController _animationController;
  Animation animation;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: backgroundcolor,
      body: Stack(
        alignment: Alignment.center,
        children: [
          IndexedStack(
            index: _selectedIndex,
            children: [
              MyAnimation(animation: animation, child: WalletTwo()),
              MyAnimation(animation: animation, child: MyReports(selectindex:selectindex)),
              MyAnimation(animation: animation, child: WalletChallenges(selectindex:selectindex)),
              MyAnimation(animation: animation, child: WalletProfile(selectindex:selectindex))
            ],
          ),
          Positioned(
              bottom: 5,
              child: AnimatedContainer(
                alignment: Alignment.center,
                // margin: EdgeInsets.only(
                //   left: 40,
                //   right: 30,
                // ),
                height: 90,
                width: 330,
                duration: Duration(seconds: 0),
                child: Center(
                  child: Card(
                    // elevation: 5,
                    color: _selectedIndex == 0 ? backgroundcolor : gridcolor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(41),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          height: 70,
                          // width: 280,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _onItemTapped(0);
                                  });
                                },
                                child: Container(
                                  width: 70,
                                  height: 80,
                                  decoration: _selectedIndex == 0
                                      ? new BoxDecoration(
                                          color: blue1,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(50)),
                                        )
                                      : new BoxDecoration(),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Container(
                                        child: Icon(Icons.attach_money_outlined,
                                            size: 35,
                                            color: _selectedIndex == 0
                                                ? white
                                                : grey),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _onItemTapped(1);
                                  });
                                },
                                child: Container(
                                  width: 70,
                                  height: 80,
                                  decoration: _selectedIndex == 1
                                      ? new BoxDecoration(
                                          color: blue1,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(50)),
                                        )
                                      : new BoxDecoration(),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Container(
                                        child: Icon(Icons.bar_chart_rounded,
                                            size: 35,
                                            color: _selectedIndex == 1
                                                ? white
                                                : grey),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _onItemTapped(2);
                                    });
                                  },
                                  child: Container(
                                    width: 70,
                                    height: 80,
                                    decoration: _selectedIndex == 2
                                        ? new BoxDecoration(
                                            color: blue1,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(50)),
                                          )
                                        : new BoxDecoration(),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(top: 5),
                                          child: Icon(FontAwesomeIcons.award,
                                              size: 30,
                                              color: _selectedIndex == 2
                                                  ? white
                                                  : grey),
                                        ),
                                      ],
                                    ),
                                  )),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _onItemTapped(3);
                                  });
                                },
                                child: Container(
                                  width: 70,
                                  height: 80,
                                  decoration: _selectedIndex == 3
                                      ? new BoxDecoration(
                                          color: blue1,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(50)),
                                        )
                                      : new BoxDecoration(),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Container(
                                        child: Icon(Icons.person_outline,
                                            size: 35,
                                            color: _selectedIndex == 3
                                                ? white
                                                : grey),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )),
        ],
      ),
    );
  }

  var selectindex = 0;
  void _onItemTapped(int index) async {
    setState(() {
      selectindex = _selectedIndex;
      print("PAVITHRA $selectindex");
    });
    setState(() {
      _selectedIndex = index;
      FocusScope.of(context).requestFocus(FocusNode());
      _animationController.reset();
      _animationController.forward();
    });
  }
}

class MyAnimation extends AnimatedWidget {
  MyAnimation({key, animation, this.child})
      : super(
          key: key,
          listenable: animation,
        );

  final Widget child;

  @override
  Widget build(BuildContext context) {
    Animation<double> animation = listenable;
    return Opacity(
      opacity: animation.value,
      child: child,
    );
  }
}
