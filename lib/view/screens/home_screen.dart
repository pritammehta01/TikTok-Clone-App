import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tik_shok/constants.dart';
import 'package:tik_shok/view/widgets/custome_add_icon.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int pageIdx = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: pageIndex[pageIdx],
        ),
        bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: backgroundColor,
            onTap: (index) {
              setState(() {
                pageIdx = index;
              });
            },
            currentIndex: pageIdx,
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.home,
                    size: 25,
                  ),
                  label: "home"),
              BottomNavigationBarItem(
                  icon: Icon(
                    CupertinoIcons.search,
                    size: 25,
                  ),
                  label: "Search"),
              BottomNavigationBarItem(icon: CustomeAddIcon(), label: ""),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.message,
                    size: 25,
                  ),
                  label: "Messages"),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.person,
                    size: 25,
                  ),
                  label: "Profile"),
            ]));
  }
}
