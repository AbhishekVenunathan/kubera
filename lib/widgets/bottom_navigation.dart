import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:animations/animations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:iconsax/iconsax.dart';
import 'package:kubera/controller/init.dart';
import 'package:kubera/screens/dashboard/home.dart';
import 'package:kubera/screens/dashboard/library.dart';
import 'package:upgrader/upgrader.dart';

import '../screens/dashboard/more.dart';
import '../screens/dashboard/referal.dart';
import 'appbar.dart';

// ignore: must_be_immutable
class BottomBar extends StatefulWidget {
  int currentindex;
  BottomBar({Key? key, required this.currentindex}) : super(key: key);

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  final InitCon icon = Get.find();
  // final CartCon ccon = Get.find();
  // final HomeCon hcon = Get.find();
  List<Widget> _widgetOptions = <Widget>[
    HomeView(),
    LibraryView(),
    RefferalView(),
    MoreView(),
  ];
  Timer? timer;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(Duration(minutes: 1),
        (Timer t) => icon.getNotifications(icon.userData[0]['_id']));
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  void _onItemTapped(int index) {
    setState(() {
      widget.currentindex = index;
      if (GetStorage().read('usertoken').toString() != 'null') {
        icon.getuserData();
      }
      print(index);
    });
  }

  DateTime? currentBackPressTime;

  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      Fluttertoast.showToast(
          msg: 'Press back button again to Exit!',
          backgroundColor: Colors.black54);
      return Future.value(false);
    }
    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    Upgrader().clearSavedSettings();
    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: BaseAppBar(
          ishome: true,
          title: 'J A A D U',
          carticon: true,
        ),
        // endDrawer: EndDrawerWidget(),
        // drawer: DrawerWidget(),
        body: UpgradeAlert(
          debugLogging: true,
          showIgnore: false,
          showLater: false,
          canDismissDialog: false,

          // onIgnore: () {
          //   return true;
          // },
          dialogStyle: GetPlatform.isIOS
              ? UpgradeDialogStyle.cupertino
              : UpgradeDialogStyle.material,
          child: PageTransitionSwitcher(
            duration: const Duration(milliseconds: 800),
            transitionBuilder: (child, animation, secondaryAnimation) =>
                FadeThroughTransition(
              animation: animation,
              secondaryAnimation: secondaryAnimation,
              child: child,
            ),
            child: _widgetOptions.elementAt(widget.currentindex),
          ),
        ),

        bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(top: 8),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            elevation: 4,
            unselectedItemColor: Colors.grey,
            showUnselectedLabels: true,
            backgroundColor: Colors.white,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: SvgPicture.asset('assets/Home.svg'),
                activeIcon: SvgPicture.asset('assets/Home-active.svg'),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset('assets/book.svg'),
                activeIcon: SvgPicture.asset('assets/book-active.svg'),
                label: 'Library',
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset('assets/3 User.svg'),
                activeIcon: SvgPicture.asset('assets/3 User-active.svg'),
                label: 'Referal',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.menu, color: Colors.black),
                activeIcon: Icon(Icons.menu, color: Get.theme.primaryColor),
                label: 'More',
              ),
            ],
            currentIndex: widget.currentindex,
            selectedItemColor: Get.theme.primaryColor,
            onTap: _onItemTapped,
          ),
        ),
      ),
    );
  }
}
