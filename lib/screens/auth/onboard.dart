import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kubera/screens/auth/mobile_entry.dart';
import 'package:sizer/sizer.dart';

import '../../utils/utils.dart';
import '../../widgets/text.dart';

class OnboardView extends StatefulWidget {
  const OnboardView({Key? key}) : super(key: key);

  @override
  State<OnboardView> createState() => _OnboardViewState();
}

class _OnboardViewState extends State<OnboardView> {
  int _currentPage = 0;
  Timer? _timer;
  final PageController _pageController = PageController(
    initialPage: 0,
  );

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 5), (Timer timer) {
      if (_currentPage < 2) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }

      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeIn,
      );
    });
  }

  @override
  void dispose() {
    super.dispose();
    _timer?.cancel();

    _pageController.dispose();
  }

  var selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 82.h,
            child: PageView.builder(
              itemCount: 3,
              onPageChanged: (o) {
                setState(() {
                  selectedIndex = o;
                });
              },
              controller: _pageController,
              itemBuilder: (context, index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Spacer(),
                    const Spacer(),
                    SizedBox(
                      height: Get.height / 1.5 - 30.sp,
                      child: Image.asset(onBoardData[index]['image']!),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0.sp),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Txt(
                            text: onBoardData[index]['title'].toString(),
                            weight: FontWeight.bold,
                          ),
                          SizedBox(
                            height: 12.sp,
                          ),
                          Txt(
                            text: onBoardData[index]['desc'].toString(),
                            fsize: 12,
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          SizedBox(
            height: 18.h,
            child: Padding(
              padding: EdgeInsets.all(8.0.sp),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                        3,
                        (index) => AnimatedContainer(
                              duration: const Duration(milliseconds: 400),
                              curve: Curves.decelerate,
                              margin: const EdgeInsets.all(4),
                              width: selectedIndex == index ? 10 : 10,
                              height: selectedIndex == index ? 10 : 10,
                              decoration: BoxDecoration(
                                color: selectedIndex == index
                                    ? Get.theme.primaryColor
                                    : Colors.grey[300],
                                shape: BoxShape.circle,
                              ),
                            )),
                  ),
                  const Spacer(),
                  SizedBox(
                    height: 10.sp,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: CupertinoButton(
                            color: Get.theme.primaryColor,
                            // ignore: prefer_const_constructors
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 3.5),
                              child: const Txt(
                                text: 'Get Started',
                                color: Colors.white,
                                weight: FontWeight.bold,
                                defalutsize: true,
                              ),
                            ),
                            onPressed: () {
                              Get.to(() => MobileEntryView());
                            }),
                      ),
                    ],
                  ),
                  const Spacer(),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
