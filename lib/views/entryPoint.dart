// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, prefer_const_literals_to_create_immutables
// ignore_for_file: must_be_immutable
import 'package:dbestech/constants/constants.dart';
import 'package:dbestech/controllers/tab_index_controller.dart';
import 'package:dbestech/views/cart/cart_page.dart';
import 'package:dbestech/views/home/home_page.dart';
import 'package:dbestech/views/profile/profile_page.dart';
import 'package:dbestech/views/search/search_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';

class MainScreen extends StatelessWidget {
  MainScreen({super.key});
  List<Widget> pageList = [HomePage(), SearchPage(), CartPage(), ProfilePage()];

  @override
  Widget build(BuildContext context) {
    final TabIndexController tabIndexCtrl = Get.find<TabIndexController>();
    return Obx(() {
      return Scaffold(
        body: Stack(
          /// Main Pages
          children: [
            pageList[tabIndexCtrl.tabIndex],

            /// Bottom Navigation Bar
            Align(
              alignment: Alignment.bottomCenter,
              child: Theme(
                  data: Theme.of(context).copyWith(canvasColor: kPrimary),
                  child: BottomNavigationBar(
                    elevation: 0,
                    showUnselectedLabels: false,
                    showSelectedLabels: false,
                    unselectedIconTheme: IconThemeData(color: Colors.black38),
                    selectedIconTheme: IconThemeData(color: kSecondary),
                    onTap: (value) {
                      tabIndexCtrl.setTabIndex = value;
                    },
                    currentIndex: tabIndexCtrl.tabIndex,
                    items: [
                      BottomNavigationBarItem(
                          icon: Icon(tabIndexCtrl.tabIndex == 0
                              ? AntDesign.appstore1
                              : AntDesign.appstore_o),
                          label: 'Home'),
                      BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
                      BottomNavigationBarItem(
                          icon: Badge(
                            label: Text('1'),
                            child: Icon(FontAwesome.opencart),
                          ),
                          label: 'Cart'),
                      BottomNavigationBarItem(
                          icon: Icon(tabIndexCtrl.tabIndex == 3
                              ? FontAwesome.user_circle
                              : FontAwesome.user_circle_o),
                          label: 'Person'),
                    ],
                  )),
            ),
          ],
        ),
      );
    });
  }
}
