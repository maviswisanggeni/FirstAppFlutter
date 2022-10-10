import 'package:cobalatihan/ListFootballPL.dart';
import 'package:cobalatihan/fav.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:skeleton_loader/skeleton_loader.dart';

class TabbarExample extends StatefulWidget {
  const TabbarExample({Key? key}) : super(key: key);

  @override
  State<TabbarExample> createState() => _TabbarExampleState();
}

class _TabbarExampleState extends State<TabbarExample> with SingleTickerProviderStateMixin {
  late TabController _controller;
  int _selectedIndex = 0;

  List<Widget> list = [
    Tab(icon: Icon(Icons.sports_soccer_rounded, color: Colors.black,)),
    Tab(icon: Icon(Icons.favorite_rounded, color: Colors.black,)),
    Tab(icon: Icon(Icons.sports_basketball_rounded, color: Colors.black,)),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // Create TabController for getting the index of current tab
    _controller = TabController(length: list.length, vsync: this);

    _controller.addListener(() {
      setState(() {
        _selectedIndex = _controller.index;
      });
      print("Selected Index: " + _controller.index.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          shadowColor: Colors.transparent,
          bottom: TabBar(
            padding: EdgeInsets.only(left: 20, right: 20),
            indicatorColor: Colors.transparent,
            indicator: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              gradient: LinearGradient(
                colors: [
                  Colors.blueAccent,
                  Colors.purpleAccent,
                ],
              ),
            ),
            labelColor: Colors.blue,
            onTap: (index) {
              // Should not used it as it only called when tab options are clicked,
              // not when user swapped
            },
            controller: _controller,
            tabs: list,
          ),
          title: Center(
            child: Text('SPORTS',
              style: GoogleFonts.poppins(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 25.0,              ),
            ),
          ),
        ),
        body: TabBarView(
          controller: _controller,
          children: [
            ListFootballPL(),
            favPage(),
            Center(
                child: Text(
                  "Basketball",
                  style: TextStyle(
                    fontFamily: GoogleFonts.poppins().fontFamily,
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                )
            ),
          ],
        ),
      ),
    );
  }
}
