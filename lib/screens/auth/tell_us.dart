import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:kubera/controller/auth.dart';
import 'package:kubera/screens/auth/inspire.dart';
import 'package:kubera/screens/auth/profileview.dart';
import 'package:kubera/widgets/bottom_navigation.dart';
import 'package:kubera/widgets/text.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:sizer/sizer.dart';

import 'intrest.dart';

class TellusView extends StatefulWidget {
  const TellusView({Key? key}) : super(key: key);

  @override
  State<TellusView> createState() => _TellusViewState();
}

class _TellusViewState extends State<TellusView> {
  var currentint = 0;
  var sliderval = 0.3;
  final PageController _pageController = PageController(
    initialPage: 0,
  );
  final AuthCon acon = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,

      // ),
      body: Column(
        children: [
          SizedBox(
            height: 35.sp,
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10.sp, horizontal: 8.sp),
            child: Row(
              children: [
                Txt(
                  text: currentint == 0
                      ? 'Tell us about you'
                      : currentint == 1
                          ? 'Choose your interest!'
                          : 'Who insprires you?',
                  weight: FontWeight.bold,
                  defalutsize: true,
                  fsize: 18,
                ),
              ],
            ),
          ),
          LinearPercentIndicator(
            barRadius: Radius.circular(30),
            lineHeight: 10.0,
            percent: sliderval,
            backgroundColor: Get.theme.primaryColor.withOpacity(0.2),
            progressColor: Get.theme.primaryColor,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.sp),
            child: Column(
              children: [
                SizedBox(
                  height: 10.sp,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Txt(
                      text: 'Step ${currentint + 1} of 3',
                      fsize: 10,
                      weight: FontWeight.bold,
                    ),
                    if (currentint == 2)
                      InkWell(
                        onTap: () {
                          acon.signup(acon.name.text, acon.emailCon.text,
                              acon.mobile.text, acon.city.text);
                        },
                        child: Txt(
                          text: 'Skip',
                          fsize: 10,
                          color: Get.theme.primaryColor,
                          weight: FontWeight.bold,
                        ),
                      )
                  ],
                ),
              ],
            ),
          ),
          Expanded(
              child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.sp),
            child: Container(
              child: PageView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: 3,
                  controller: _pageController,
                  onPageChanged: (o) {
                    setState(() {
                      currentint = o;
                    });
                  },
                  itemBuilder: (context, index) {
                    return index == 0
                        ? ProfileView()
                        : index == 1
                            ? IntrestView()
                            : InspireView();
                  }),
            ),
          )),
          SizedBox(
            height: 10.sp,
          ),
          currentint == 0
              ? Padding(
                  padding: EdgeInsets.all(10.0.sp),
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () {
                          Get.back();
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Get.theme.primaryColor,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          height: 55,
                          width: 55,
                          child: Center(
                              child: Icon(Icons.arrow_back_ios_new,
                                  color: Get.theme.primaryColor)),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: CupertinoButton(
                            color: Get.theme.primaryColor,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 3.5),
                              child: const Txt(
                                text: 'Next',
                                color: Colors.white,
                                weight: FontWeight.bold,
                                defalutsize: true,
                              ),
                            ),
                            onPressed: () {
                              if (currentint == 0) {
                                if (acon.name.text.isEmpty ||
                                    acon.city.text.isEmpty) {
                                  Fluttertoast.showToast(
                                      msg: 'Please fill mandatory fields');
                                } else {
                                  _pageController.animateToPage(
                                    1,
                                    duration: const Duration(milliseconds: 350),
                                    curve: Curves.easeIn,
                                  );
                                  sliderval = 0.5;
                                }
                              } else {
                                _pageController.animateToPage(
                                  2,
                                  duration: const Duration(milliseconds: 350),
                                  curve: Curves.easeIn,
                                );
                                sliderval = 1.0;
                              }
                            }),
                      ),
                    ],
                  ),
                )
              : currentint == 1
                  ? Padding(
                      padding: EdgeInsets.all(10.0.sp),
                      child: Row(
                        children: [
                          InkWell(
                            onTap: () {
                              sliderval = 0.3;
                              _pageController.previousPage(
                                duration: const Duration(milliseconds: 350),
                                curve: Curves.easeIn,
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Get.theme.primaryColor,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              height: 55,
                              width: 55,
                              child: Center(
                                  child: Icon(Icons.arrow_back_ios_new,
                                      color: Get.theme.primaryColor)),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                              child: Obx(
                            () => CupertinoButton(
                                color: acon.selectedList.length < 3
                                    ? Get.theme.primaryColor.withOpacity(0.6)
                                    : Get.theme.primaryColor,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 3.5),
                                  child: const Txt(
                                    text: 'Choose min 3',
                                    color: Colors.white,
                                    weight: FontWeight.bold,
                                    defalutsize: true,
                                  ),
                                ),
                                disabledColor:
                                    Get.theme.primaryColor.withOpacity(0.6),
                                onPressed: acon.selectedList.length < 3
                                    ? null
                                    : () {
                                        if (currentint == 0) {
                                          if (acon.name.text.isEmpty ||
                                              acon.city.text.isEmpty) {
                                            Fluttertoast.showToast(
                                                msg:
                                                    'Please fill mandatory fields');
                                          } else {
                                            _pageController.animateToPage(
                                              1,
                                              duration: const Duration(
                                                  milliseconds: 350),
                                              curve: Curves.easeIn,
                                            );
                                            sliderval = 0.5;
                                          }
                                        } else {
                                          if (acon.selectedList.length < 3) {
                                          } else {
                                            _pageController.animateToPage(
                                              2,
                                              duration: const Duration(
                                                  milliseconds: 350),
                                              curve: Curves.easeIn,
                                            );
                                            sliderval = 1.0;
                                          }
                                        }
                                      }),
                          )),
                        ],
                      ),
                    )
                  : Padding(
                      padding: EdgeInsets.all(10.0.sp),
                      child: Row(
                        children: [
                          InkWell(
                            onTap: () {
                              sliderval = 0.5;
                              _pageController.previousPage(
                                duration: const Duration(milliseconds: 350),
                                curve: Curves.easeIn,
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Get.theme.primaryColor,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              height: 55,
                              width: 55,
                              child: Center(
                                  child: Icon(Icons.arrow_back_ios_new,
                                      color: Get.theme.primaryColor)),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: CupertinoButton(
                                color: Get.theme.primaryColor,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 3.5),
                                  child: const Txt(
                                    text: 'Done',
                                    color: Colors.white,
                                    weight: FontWeight.bold,
                                    defalutsize: true,
                                  ),
                                ),
                                onPressed: () {
                                  acon.signup(
                                      acon.name.text,
                                      acon.emailCon.text,
                                      acon.mobile.text,
                                      acon.city.text);
                                  // Get.offAll(() => BottomBar(currentindex: 0));
                                }),
                          ),
                        ],
                      ),
                    ),
          SizedBox(
            height: 4.sp,
          )
        ],
      ),
    );
  }
}
