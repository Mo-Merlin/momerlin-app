import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scroll_snap_list/scroll_snap_list.dart';

class HorizontalList extends StatefulWidget {
  @override
  _HorizontalListState createState() => _HorizontalListState();
}

class _HorizontalListState extends State<HorizontalList> {
  List<int> data = [];
  int _focusedIndex = 0;
  int value = 0;

  @override
  void initState() {
    super.initState();

    for (int i = 0; i < 40; i++) {
      value = value + 5;
      data.add(value);
    }
  }

  void _onItemFocus(int index) {
    setState(() {
      _focusedIndex = index;
    });
  }

  Widget _buildListItem(BuildContext context, int index) {
    var blue = Color(0xFF282C4A);
    var orange = Color(0xFFFF8C00);
    var nonlabel = Color(0xFF808DA7);
    //horizontal
    return Container(
      width: 50,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            alignment: Alignment.centerLeft,
            child: Text("${data[index]}",
                textScaleFactor: 1.0,
                style: GoogleFonts.poppins(
                    color: _focusedIndex == index ? orange : nonlabel,
                    fontWeight: _focusedIndex == index
                        ? FontWeight.bold
                        : FontWeight.normal,
                    fontSize: _focusedIndex == index ? 25 : 20)),
          ),
          Container(
            margin: EdgeInsets.only(left: 3, top: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  height: 60,
                  width: 2,
                  decoration: BoxDecoration(
                    color: blue,
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                  ),
                ),
                Container(
                  height: 40,
                  width: 1,
                  decoration: BoxDecoration(
                    color: blue,
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                  ),
                ),
                Container(
                  height: 40,
                  width: 1,
                  decoration: BoxDecoration(
                    color: blue,
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(right: 7),
                  height: 40,
                  width: 1,
                  decoration: BoxDecoration(
                    color: blue,
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height * 0.13,
            child: ScrollSnapList(
              duration: 500,
              scrollPhysics: BouncingScrollPhysics(),
              onItemFocus: _onItemFocus,
              itemSize: 50,
              itemBuilder: _buildListItem,
              itemCount: data.length,
              reverse: false,
              dynamicItemSize: false,
            ),
          ),
        ],
      ),
    );
  }
}
