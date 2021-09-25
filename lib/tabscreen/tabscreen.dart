import 'package:flutter/material.dart';
import 'package:momerlin/theme/theme.dart';
import 'package:momerlin/wallet_screens/wallet_challenges.dart';
import 'package:momerlin/wallet_screens/wallet_profile.dart';
import 'package:momerlin/wallet_screens/wallet_two.dart';

class Tabscreen extends StatefulWidget {
  @override
  _TabscreenState createState() => new _TabscreenState();
}

class _TabscreenState extends State<Tabscreen> {
  List<Widget> originalList;
  Map<int, bool> originalDic;
  List<Widget> listScreens;
  List<int> listScreensIndex;

  int tabIndex = 0;
  Color tabColor = Color(0xFFD3D3D3);
  Color selectedTabColor = blue;

  @override
  void initState() {
    super.initState();
    originalList = [
      WalletTwo(),
      WalletChallenges(),
      WalletProfile(),
    ];
    originalDic = {
      0: true,
      1: false,
      2: false,
    };
    listScreens = [
      WalletTwo(),
    ];
    listScreensIndex = [0];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: backgroundcolor,
      body: IndexedStack(
          index: listScreensIndex.indexOf(tabIndex), children: listScreens),
      bottomNavigationBar: AnimatedContainer(
        duration: Duration.zero,
        curve: Curves.easeOut,
        height: 80,
        // width: 270,
        margin: EdgeInsets.only(left: 50, right: 50, top: 10, bottom: 10),
        // padding: EdgeInsets.only(left: 5, right: 5),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: gridcolor,
          borderRadius: BorderRadius.circular(41),
        ),
        child: _buildTabBar(),
      ),
    );
  }

  void _selectedTab(int index) {
    if (originalDic[index] == false) {
      listScreensIndex.add(index);
      originalDic[index] = true;
      listScreensIndex.sort();
      listScreens = listScreensIndex.map((index) {
        return originalList[index];
      }).toList();
    }

    setState(() {
      tabIndex = index;
    });
  }

  Widget _buildTabBar() {
    var listItems = [
      BottomAppBarItem(
        iconData: Icons.attach_money_outlined,
      ),
      BottomAppBarItem(
        iconData: Icons.bar_chart,
      ),
      BottomAppBarItem(
        iconData: Icons.person_outline_outlined,
      ),
    ];

    var items = List.generate(listItems.length, (int index) {
      return _buildTabItem(
        item: listItems[index],
        index: index,
        onPressed: _selectedTab,
      );
    });

    return Container(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: items,
      ),
      // elevation: 3,
      // shape:CircularNotchedRectangle(),
      // color: Colors.white,
    );
  }

  Widget _buildTabItem({
    BottomAppBarItem item,
    int index,
    ValueChanged<int> onPressed,
  }) {
    var color = tabIndex == index ? blue1 : gridcolor;
    double height = tabIndex == index ? 24 : 24;
    double width = tabIndex == index ? 24 : 24;
    var s = tabIndex == 1 ? "red" : "grey";
    return Expanded(
      child: Container(
        // height: 60,
        // color: gridcolor,
        margin: EdgeInsets.only(right: 0),
        child: Material(
          type: MaterialType.transparency,
          color: gridcolor,
          child: InkWell(
            onTap: () => onPressed(index),
            child: Column(
              // mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                index == tabIndex
                    ? Container(
                        width: 70,
                        height: 70,
                        decoration: BoxDecoration(
                          color: blue1,
                          borderRadius: BorderRadius.circular(60),
                        ),
                        child: Icon(
                          item.iconData,
                          color: white,
                        ),
                      )
                    : Icon(
                        item.iconData,
                        color: grey,
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class BottomAppBarItem {
  BottomAppBarItem({this.iconData});
  IconData iconData;
}
