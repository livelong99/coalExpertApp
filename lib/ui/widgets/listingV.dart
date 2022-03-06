import 'package:coalexpert/Models/Ship.dart';
import 'package:coalexpert/internal/constants.dart';
import 'package:coalexpert/ui/widgets/listingsview.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ListV extends StatefulWidget {
  ListV(this.shipList);

  List<Ship> shipList = <Ship>[];

  @override
  _ListVState createState() => _ListVState();
}

class _ListVState extends State<ListV> {
  int _selectedIndex = 0;
  List<String> options = ["All", "USA", "Indonesia", "South Africa", "Others"];

  List<Ship> showList = <Ship>[];

  Widget buildChips() {
    List<Widget> chips = [];


    for (int i = 0; i < options.length; i++) {
      ChoiceChip choiceChip = ChoiceChip(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(
            width: 1,
            color: _selectedIndex == i ? Colors.transparent : Colors.black12,
          ),
        ),
        labelPadding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.03,
        ),
        label: Text(
          "${options[i]}",
          style: GoogleFonts.montserrat(textStyle: TextStyle(color: Colors.black,fontWeight: FontWeight.w400, fontSize: MediaQuery.of(context).size.height * 0.015)),
        ),
        selected: _selectedIndex == i,
        backgroundColor: Colors.white,
        selectedColor: kScaffoldBackgroundColor,
        onSelected: (bool selected) {
          setState(() {
            if (selected) {
              _selectedIndex = i;
              if(i == 0)
                showList = widget.shipList;
              else if(i == 1)
                showList = widget.shipList.where((ship) => (ship.origin==options[1] || ship.origin==options[1].toUpperCase()) ? true : false).toList();
              else if(i == 2)
                showList = widget.shipList.where((ship) => (ship.origin==options[2] || ship.origin==options[2].toUpperCase()) ? true : false).toList();
              else if(i == 3)
                showList = widget.shipList.where((ship) => (ship.origin==options[3] || ship.origin==options[3].toUpperCase()) ? true : false).toList();
              else if(i == 4)
                showList = widget.shipList.where((ship) => (ship.origin!=options[1]&&ship.origin!=options[2]&&ship.origin!=options[3]&&ship.origin!=options[1].toUpperCase()&&ship.origin!=options[2].toUpperCase()&&ship.origin!=options[3].toUpperCase()) ? true : false).toList();
            }
          });
        },
      );

      chips.add(Padding(
        padding: EdgeInsets.only(right: MediaQuery.of(context).size.width * 0.05),
        child: choiceChip,
      ));
    }

    return ListView(
      scrollDirection: Axis.horizontal,
      children: chips,
    );
  }

  @override
  Widget build(BuildContext context) {

    if(_selectedIndex==0)
      showList = widget.shipList;

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.01),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.04),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.07,
              child: buildChips(),
            ),
          ),
        ),
        Container(
          height: 2,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Color(0xffB8B8B8),
          ),
          width: MediaQuery.of(context).size.width * 0.95,
        ),
        ListingView(showList)
      ],
    );
  }
}
