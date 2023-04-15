import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:kubera/widgets/bottom_navigation.dart';
import 'package:lottie/lottie.dart';

import 'screens/auth/onboard.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 8000), () async {
      GetStorage().read('usertoken').toString() == 'null'
          ? Get.offAll(() => const OnboardView())
          : Get.offAll(() => BottomBar(currentindex: 0));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: Get.height,
        width: Get.width,
        color: Get.theme.primaryColor,
        child: Center(
          child: Lottie.asset(
            'assets/delivery (3).json',
            repeat: false,
            onLoaded: (v) {
              print('roooo');
            },
          ),
        ),
      ),
    );
  }
}
