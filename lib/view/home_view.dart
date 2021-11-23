import 'package:chaty/view/account_view.dart';
import 'package:chaty/view/chats_view.dart';
import 'package:chaty/view/people_view.dart';
import 'package:chaty/view_model/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeView extends GetWidget<HomeViewModel> {
  final List<Widget> _pages = [
    PeopleView(),
    ChatsView(),
    AccountView(),
  ];
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeViewModel>(builder: (ctr) {
      return Scaffold(
        body: _pages[ctr.currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          showSelectedLabels: false,
          showUnselectedLabels: false,
          onTap: (i) => ctr.changePage(i),
          currentIndex: ctr.currentIndex,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.people_sharp),
              label: "",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.chat),
              label: "",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle),
              label: "",
            ),
          ],
        ),
      );
    });
  }
}
