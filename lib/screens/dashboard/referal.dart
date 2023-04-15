import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:kubera/controller/init.dart';
import 'package:kubera/widgets/text.dart';
import 'package:kubera/widgets/textfield.dart';
import 'package:sizer/sizer.dart';

import '../ref_tree.dart';

class RefferalView extends StatelessWidget {
  RefferalView({Key? key}) : super(key: key);
  final TextEditingController controller = TextEditingController();
  final InitCon icon = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[50],
        resizeToAvoidBottomInset: false,
        body: Obx(
          () => ListView(
            children: [
              SizedBox(
                height: 1000,
                child: Stack(
                  children: [
                    if (icon.userData[0]['parentDetail'].toString() == 'null')
                      Column(
                        children: [
                          Container(
                            height: 130,
                            width: double.infinity,
                            color: Get.theme.primaryColor,
                            child: Image.asset('assets/ref_back.png',
                                fit: BoxFit.cover),
                          )
                        ],
                      ),
                    Positioned.fill(
                        top: icon.userData[0]['parentDetail'].toString() ==
                                'null'
                            ? 30
                            : 0,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                if (icon.userData[0]['parentDetail']
                                        .toString() ==
                                    'null')
                                  Container(
                                    child: Padding(
                                      padding: EdgeInsets.all(10.0.sp),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Txt(
                                            text: 'Enter your refferal ID',
                                            weight: FontWeight.w600,
                                          ),
                                          Row(
                                            children: [
                                              Expanded(
                                                child: Column(
                                                  children: [
                                                    CTextField(
                                                        pasteDisable: false,
                                                        hint: 'Eg: KUB12355',
                                                        iscap: true,
                                                        enabled:
                                                            icon.isOwn.value,
                                                        controller: controller),
                                                    SizedBox(
                                                      height: 5.sp,
                                                    ),
                                                    Txt(
                                                      text: !icon.isOwn.value
                                                          ? 'You haven’t purchsed any books'
                                                          : '',
                                                      fsize: 10,
                                                      color: Colors.red,
                                                    )
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                width: 6.sp,
                                              ),
                                              Column(
                                                children: [
                                                  InkWell(
                                                    onTap: () {
                                                      if (icon.isOwn.value) {
                                                        if (controller
                                                                .text.length !=
                                                            9) {
                                                          Fluttertoast.showToast(
                                                              msg:
                                                                  'Enter valid Referral ID');
                                                        } else {
                                                          icon.addRefID(
                                                              controller.text);
                                                        }
                                                      }
                                                    },
                                                    child: Container(
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        6.sp),
                                                            color: Get.theme
                                                                .primaryColor),
                                                        child: Padding(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      12.sp,
                                                                  vertical:
                                                                      13.sp),
                                                          child: const Txt(
                                                            text: ' Submit ',
                                                            color: Colors.white,
                                                            fsize: 13,
                                                            weight:
                                                                FontWeight.w800,
                                                          ),
                                                        )),
                                                  ),
                                                  SizedBox(
                                                    height: 12.sp,
                                                  )
                                                ],
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                    width: Get.width * .9,
                                    height: 120.sp,
                                    decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.1),
                                            spreadRadius: 5,
                                            blurRadius: 5,
                                            offset: const Offset(0,
                                                3), // changes position of shadow
                                          ),
                                        ],
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(15.sp),
                                          topRight: Radius.circular(15.sp),
                                          bottomRight: Radius.circular(15.sp),
                                          bottomLeft: Radius.circular(15.sp),
                                        ),
                                        color: Colors.white),
                                  ),
                              ],
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                  if (icon.userData[0]['parentDetail']
                                          .toString() !=
                                      'null')
                                    Padding(
                                      padding: EdgeInsets.all(10.0.sp),
                                      child: Container(
                                        decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20)),
                                          gradient: LinearGradient(
                                            colors: [
                                              Color(0xFFF5F7FA),
                                              Color(0xFFC3CFE2)
                                            ],
                                            begin: Alignment.centerLeft,
                                            end: Alignment.centerRight,
                                            stops: [0, 1],
                                          ),
                                        ),
                                        child: ListTile(
                                          title: Txt(
                                            text: icon.userData[0]
                                                    ['parentDetail']['name']
                                                .toString(),
                                            fsize: 12,
                                            weight: FontWeight.w700,
                                          ),
                                          subtitle: Txt(
                                            text: icon.userData[0]
                                                    ['parentDetail']
                                                    ['kubera_id']
                                                .toString(),
                                            fsize: 12,
                                            color: Colors.grey[500]!,
                                          ),
                                          leading: Container(
                                            height: 55,
                                            width: 55,
                                            child: ClipOval(
                                              child: icon.userData[0]
                                                              ['parentDetail']
                                                          ['profile_image'] ==
                                                      'https://kuberatech-docs.s3.us-west-1.amazonaws.com/'
                                                  ? Image.asset(
                                                      'assets/no_user.png',
                                                      height: 60,
                                                      width: 60,
                                                    )
                                                  : Image.network(
                                                      icon.userData[0]
                                                              ['parentDetail']
                                                          ['profile_image'],
                                                      height: 60,
                                                      width: 60,
                                                      fit: BoxFit.cover),
                                            ),
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors.grey[300]),
                                          ),
                                        ),
                                      ),
                                    ),
                                  if (icon.userData[0]['parentDetail']
                                          .toString() !=
                                      'null')
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Container(
                                            color: Get.theme.primaryColor,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 10),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Txt(
                                                    text:
                                                        'You’re under ${icon.userData[0]['parentDetail']['name']}',
                                                    color: Colors.white,
                                                    fsize: 11,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  SizedBox(
                                    height: icon.userData[0]['parentDetail']
                                                .toString() ==
                                            'null'
                                        ? 20.sp
                                        : 10.sp,
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10.sp),
                                    child: Row(
                                      children: const [
                                        Txt(
                                          text: 'League',
                                          weight: FontWeight.bold,
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 500,
                                    child: CarouselSlider(
                                      options: CarouselOptions(
                                          reverse: false,
                                          //  height: 200.0,
                                          // autoPlay: true,

                                          enableInfiniteScroll: false,
                                          aspectRatio: 0.75,
                                          enlargeCenterPage: true,
                                          viewportFraction: 0.6),
                                      items: refData.map((i) {
                                        return Builder(
                                          builder: (BuildContext context) {
                                            return Column(
                                              children: [
                                                Stack(
                                                  children: [
                                                    InkWell(
                                                        onTap: () {
                                                          if (icon.userData[0]['currentLevel'] == 1 ||
                                                              icon.userData[0][
                                                                      'currentLevel'] ==
                                                                  2 ||
                                                              icon.userData[0][
                                                                      'currentLevel'] ==
                                                                  3) {
                                                            if (i['league'] !=
                                                                    'Silver' &&
                                                                i['league'] !=
                                                                    'Gold') {
                                                              icon.leftcurrentname
                                                                      .value =
                                                                  'You';
                                                              icon.leftcurrentkubid
                                                                  .value = icon
                                                                      .userData[0]
                                                                  ['kubera_id'];
                                                              icon.leftcurrentImg
                                                                  .value = icon
                                                                      .userData[0]
                                                                  [
                                                                  'profile_image'];
                                                              icon.leftcurrentLevel
                                                                      .value =
                                                                  icon.userData[
                                                                          0][
                                                                          'currentLevel']
                                                                      .toString();
                                                              icon.getTree(
                                                                  icon.userData[
                                                                          0][
                                                                          'kubera_id']
                                                                      .toString(),
                                                                  isMine: true,
                                                                  leauge: i[
                                                                      'league']!);

                                                              Get.to(
                                                                  () => RefTree(
                                                                        title: i[
                                                                            'league']!,
                                                                      ));

                                                              print(
                                                                  i['league']);
                                                            } else if (icon.userData[
                                                                            0][
                                                                        'currentLevel'] ==
                                                                    2 ||
                                                                icon.userData[0]
                                                                        [
                                                                        'currentLevel'] ==
                                                                    3) {
                                                              if (i['league'] !=
                                                                      'Bronze' &&
                                                                  i['league'] !=
                                                                      'Gold') {
                                                                icon.leftcurrentname
                                                                        .value =
                                                                    'You';
                                                                icon.leftcurrentkubid
                                                                    .value = icon
                                                                        .userData[0]
                                                                    [
                                                                    'kubera_id'];
                                                                icon.leftcurrentImg
                                                                    .value = icon
                                                                        .userData[0]
                                                                    [
                                                                    'profile_image'];
                                                                icon.leftcurrentLevel
                                                                        .value =
                                                                    icon.userData[
                                                                            0][
                                                                            'currentLevel']
                                                                        .toString();
                                                                icon.getTree(
                                                                    icon.userData[
                                                                            0][
                                                                            'kubera_id']
                                                                        .toString(),
                                                                    isMine:
                                                                        true,
                                                                    leauge: i[
                                                                        'league']!);

                                                                Get.to(
                                                                    () =>
                                                                        RefTree(
                                                                          title:
                                                                              i['league']!,
                                                                        ));

                                                                print(i[
                                                                    'league']);
                                                              } else if (icon
                                                                          .userData[0]
                                                                      [
                                                                      'currentLevel'] ==
                                                                  3) {
                                                                if (i['league'] !=
                                                                        'Bronze' &&
                                                                    i['league'] !=
                                                                        'Silver') {
                                                                  icon.leftcurrentname
                                                                          .value =
                                                                      'You';
                                                                  icon.leftcurrentkubid
                                                                      .value = icon
                                                                          .userData[0]
                                                                      [
                                                                      'kubera_id'];
                                                                  icon.leftcurrentImg
                                                                      .value = icon
                                                                          .userData[0]
                                                                      [
                                                                      'profile_image'];
                                                                  icon.leftcurrentLevel.value = icon
                                                                      .userData[
                                                                          0][
                                                                          'currentLevel']
                                                                      .toString();
                                                                  icon.getTree(
                                                                      icon.userData[
                                                                              0]
                                                                              [
                                                                              'kubera_id']
                                                                          .toString(),
                                                                      isMine:
                                                                          true,
                                                                      leauge: i[
                                                                          'league']!);

                                                                  Get.to(() =>
                                                                      RefTree(
                                                                        title: i[
                                                                            'league']!,
                                                                      ));
                                                                  print(i[
                                                                      'league']);
                                                                }
                                                              }
                                                            }
                                                          } else {
                                                            print('ssssss');
                                                          }
                                                          // if (icon.userData[0]['currentLevel'] == 1 ||
                                                          //     icon.userData[0][
                                                          //             'currentLevel'] ==
                                                          //         2 ||
                                                          //     icon.userData[0][
                                                          //                 'currentLevel'] ==
                                                          //             3 &&
                                                          //         i['level'] ==
                                                          //             'Bronze') {
                                                          //   if (icon
                                                          //       .isOwn.value) {
                                                          //     if (i['league'] ==
                                                          //         'Bronze') {
                                                          //       icon.leftcurrentname
                                                          //               .value =
                                                          //           'You';
                                                          //       icon.leftcurrentkubid
                                                          //           .value = icon
                                                          //               .userData[0]
                                                          //           [
                                                          //           'kubera_id'];
                                                          //       icon.leftcurrentImg
                                                          //           .value = icon
                                                          //               .userData[0]
                                                          //           [
                                                          //           'profile_image'];
                                                          //       icon.leftcurrentLevel
                                                          //               .value =
                                                          //           icon.userData[
                                                          //                   0][
                                                          //                   'currentLevel']
                                                          //               .toString();
                                                          //       icon.getTree(
                                                          //           icon.userData[
                                                          //                   0][
                                                          //                   'kubera_id']
                                                          //               .toString(),
                                                          //           isMine:
                                                          //               true,
                                                          //           leauge: i[
                                                          //               'league']!);

                                                          //       Get.to(
                                                          //           () =>
                                                          //               RefTree(
                                                          //                 title:
                                                          //                     i['league']!,
                                                          //               ));
                                                          //     } else if (i[
                                                          //             'league'] ==
                                                          //         'Silver') {
                                                          //       icon.leftcurrentname
                                                          //               .value =
                                                          //           'You';
                                                          //       icon.leftcurrentkubid
                                                          //           .value = icon
                                                          //               .userData[0]
                                                          //           [
                                                          //           'kubera_id'];
                                                          //       icon.leftcurrentImg
                                                          //           .value = icon
                                                          //               .userData[0]
                                                          //           [
                                                          //           'profile_image'];
                                                          //       icon.leftcurrentLevel
                                                          //               .value =
                                                          //           icon.userData[
                                                          //                   0][
                                                          //                   'currentLevel']
                                                          //               .toString();
                                                          //       icon.getTree(
                                                          //           icon.userData[
                                                          //                   0][
                                                          //                   'kubera_id']
                                                          //               .toString(),
                                                          //           isMine:
                                                          //               true,
                                                          //           leauge: i[
                                                          //               'league']!);

                                                          //       Get.to(
                                                          //           () =>
                                                          //               RefTree(
                                                          //                 title:
                                                          //                     i['league']!,
                                                          //               ));
                                                          //     } else {
                                                          //       icon.leftcurrentname
                                                          //               .value =
                                                          //           'You';
                                                          //       icon.leftcurrentkubid
                                                          //           .value = icon
                                                          //               .userData[0]
                                                          //           [
                                                          //           'kubera_id'];
                                                          //       icon.leftcurrentImg
                                                          //           .value = icon
                                                          //               .userData[0]
                                                          //           [
                                                          //           'profile_image'];
                                                          //       icon.leftcurrentLevel
                                                          //               .value =
                                                          //           icon.userData[
                                                          //                   0][
                                                          //                   'currentLevel']
                                                          //               .toString();
                                                          //       icon.getTree(
                                                          //           icon.userData[
                                                          //                   0][
                                                          //                   'kubera_id']
                                                          //               .toString(),
                                                          //           isMine:
                                                          //               true,
                                                          //           leauge: i[
                                                          //               'league']!);

                                                          //       Get.to(
                                                          //           () =>
                                                          //               RefTree(
                                                          //                 title:
                                                          //                     i['league']!,
                                                          //               ));
                                                          //     }
                                                          //   }
                                                          // } else if (icon.userData[
                                                          //                 0][
                                                          //             'currentLevel'] ==
                                                          //         2 ||
                                                          //     icon.userData[0][
                                                          //                 'currentLevel'] ==
                                                          //             3 &&
                                                          //         i['league'] ==
                                                          //             'Silver') {
                                                          //   if (icon
                                                          //       .isOwn.value) {
                                                          //     if (i['league'] ==
                                                          //         'Bronze') {
                                                          //       icon.leftcurrentname
                                                          //               .value =
                                                          //           'You';
                                                          //       icon.leftcurrentkubid
                                                          //           .value = icon
                                                          //               .userData[0]
                                                          //           [
                                                          //           'kubera_id'];
                                                          //       icon.leftcurrentImg
                                                          //           .value = icon
                                                          //               .userData[0]
                                                          //           [
                                                          //           'profile_image'];
                                                          //       icon.leftcurrentLevel
                                                          //               .value =
                                                          //           icon.userData[
                                                          //                   0][
                                                          //                   'currentLevel']
                                                          //               .toString();
                                                          //       icon.getTree(
                                                          //           icon.userData[
                                                          //                   0][
                                                          //                   'kubera_id']
                                                          //               .toString(),
                                                          //           isMine:
                                                          //               true,
                                                          //           leauge: i[
                                                          //               'league']!);

                                                          //       Get.to(
                                                          //           () =>
                                                          //               RefTree(
                                                          //                 title:
                                                          //                     i['league']!,
                                                          //               ));
                                                          //     } else if (i[
                                                          //             'league'] ==
                                                          //         'Silver') {
                                                          //       icon.leftcurrentname
                                                          //               .value =
                                                          //           'You';
                                                          //       icon.leftcurrentkubid
                                                          //           .value = icon
                                                          //               .userData[0]
                                                          //           [
                                                          //           'kubera_id'];
                                                          //       icon.leftcurrentImg
                                                          //           .value = icon
                                                          //               .userData[0]
                                                          //           [
                                                          //           'profile_image'];
                                                          //       icon.leftcurrentLevel
                                                          //               .value =
                                                          //           icon.userData[
                                                          //                   0][
                                                          //                   'currentLevel']
                                                          //               .toString();
                                                          //       icon.getTree(
                                                          //           icon.userData[
                                                          //                   0][
                                                          //                   'kubera_id']
                                                          //               .toString(),
                                                          //           isMine:
                                                          //               true,
                                                          //           leauge: i[
                                                          //               'league']!);

                                                          //       Get.to(
                                                          //           () =>
                                                          //               RefTree(
                                                          //                 title:
                                                          //                     i['league']!,
                                                          //               ));
                                                          //     } else {
                                                          //       icon.leftcurrentname
                                                          //               .value =
                                                          //           'You';
                                                          //       icon.leftcurrentkubid
                                                          //           .value = icon
                                                          //               .userData[0]
                                                          //           [
                                                          //           'kubera_id'];
                                                          //       icon.leftcurrentImg
                                                          //           .value = icon
                                                          //               .userData[0]
                                                          //           [
                                                          //           'profile_image'];
                                                          //       icon.leftcurrentLevel
                                                          //               .value =
                                                          //           icon.userData[
                                                          //                   0][
                                                          //                   'currentLevel']
                                                          //               .toString();
                                                          //       icon.getTree(
                                                          //           icon.userData[
                                                          //                   0][
                                                          //                   'kubera_id']
                                                          //               .toString(),
                                                          //           isMine:
                                                          //               true,
                                                          //           leauge: i[
                                                          //               'league']!);

                                                          //       Get.to(
                                                          //           () =>
                                                          //               RefTree(
                                                          //                 title:
                                                          //                     i['league']!,
                                                          //               ));
                                                          //     }
                                                          //   }
                                                          // } else if (icon.userData[
                                                          //                 0][
                                                          //             'currentLevel'] ==
                                                          //         3 &&
                                                          //     i['league'] ==
                                                          //         'Gold') {
                                                          //   if (icon
                                                          //       .isOwn.value) {
                                                          //     if (i['league'] ==
                                                          //         'Bronze') {
                                                          //       icon.leftcurrentname
                                                          //               .value =
                                                          //           'You';
                                                          //       icon.leftcurrentkubid
                                                          //           .value = icon
                                                          //               .userData[0]
                                                          //           [
                                                          //           'kubera_id'];
                                                          //       icon.leftcurrentImg
                                                          //           .value = icon
                                                          //               .userData[0]
                                                          //           [
                                                          //           'profile_image'];
                                                          //       icon.leftcurrentLevel
                                                          //               .value =
                                                          //           icon.userData[
                                                          //                   0][
                                                          //                   'currentLevel']
                                                          //               .toString();
                                                          //       icon.getTree(
                                                          //           icon.userData[
                                                          //                   0][
                                                          //                   'kubera_id']
                                                          //               .toString(),
                                                          //           isMine:
                                                          //               true,
                                                          //           leauge: i[
                                                          //               'league']!);

                                                          //       Get.to(
                                                          //           () =>
                                                          //               RefTree(
                                                          //                 title:
                                                          //                     i['league']!,
                                                          //               ));
                                                          //     } else if (i[
                                                          //             'league'] ==
                                                          //         'Silver') {
                                                          //       icon.leftcurrentname
                                                          //               .value =
                                                          //           'You';
                                                          //       icon.leftcurrentkubid
                                                          //           .value = icon
                                                          //               .userData[0]
                                                          //           [
                                                          //           'kubera_id'];
                                                          //       icon.leftcurrentImg
                                                          //           .value = icon
                                                          //               .userData[0]
                                                          //           [
                                                          //           'profile_image'];
                                                          //       icon.leftcurrentLevel
                                                          //               .value =
                                                          //           icon.userData[
                                                          //                   0][
                                                          //                   'currentLevel']
                                                          //               .toString();
                                                          //       icon.getTree(
                                                          //           icon.userData[
                                                          //                   0][
                                                          //                   'kubera_id']
                                                          //               .toString(),
                                                          //           isMine:
                                                          //               true,
                                                          //           leauge: i[
                                                          //               'league']!);

                                                          //       Get.to(
                                                          //           () =>
                                                          //               RefTree(
                                                          //                 title:
                                                          //                     i['league']!,
                                                          //               ));
                                                          //     } else {
                                                          //       icon.leftcurrentname
                                                          //               .value =
                                                          //           'You';
                                                          //       icon.leftcurrentkubid
                                                          //           .value = icon
                                                          //               .userData[0]
                                                          //           [
                                                          //           'kubera_id'];
                                                          //       icon.leftcurrentImg
                                                          //           .value = icon
                                                          //               .userData[0]
                                                          //           [
                                                          //           'profile_image'];
                                                          //       icon.leftcurrentLevel
                                                          //               .value =
                                                          //           icon.userData[
                                                          //                   0][
                                                          //                   'currentLevel']
                                                          //               .toString();
                                                          //       icon.getTree(
                                                          //           icon.userData[
                                                          //                   0][
                                                          //                   'kubera_id']
                                                          //               .toString(),
                                                          //           isMine:
                                                          //               true,
                                                          //           leauge: i[
                                                          //               'league']!);

                                                          //       Get.to(
                                                          //           () =>
                                                          //               RefTree(
                                                          //                 title:
                                                          //                     i['league']!,
                                                          //               ));
                                                          //     }
                                                          //   }
                                                          // }
                                                        },
                                                        child: Image.asset(i['league'] ==
                                                                        'Bronze' &&
                                                                    icon.userData[0]['currentLevel'] ==
                                                                        1 ||
                                                                icon.userData[0]['currentLevel'] ==
                                                                    2 ||
                                                                icon.userData[0]['currentLevel'] == 3 &&
                                                                    i['league'] !=
                                                                        'Gold'
                                                            ? i['img']!
                                                            : i['league'] ==
                                                                        'Silver' &&
                                                                    icon.userData[0]['currentLevel'] ==
                                                                        2
                                                                ? i['img']!
                                                                : i['league'] ==
                                                                            'Gold' &&
                                                                        icon.userData[0]['currentLevel'] == 3
                                                                    ? i['img']!
                                                                    : 'assets/lock.png')),
                                                    Positioned(
                                                        bottom: 80,
                                                        left: 0,
                                                        right: 20,
                                                        child: Column(
                                                          children: [
                                                            Txt(
                                                              defalutsize: true,
                                                              text: i['league'] ==
                                                                              'Bronze' &&
                                                                          icon.userData[0]['currentLevel'] ==
                                                                              1 ||
                                                                      icon.userData[0]['currentLevel'] ==
                                                                              2||icon.userData[0]['currentLevel'] ==
                                                                              3 &&
                                                                          i['league'] !=
                                                                              'Gold'
                                                                  ? 'Unlocked'
                                                                  : i['league'] ==
                                                                              'Silver' &&
                                                                          icon.userData[0]['currentLevel'] ==
                                                                              2||icon.userData[0]['currentLevel'] ==
                                                                              3
                                                                      ? 'Unlocked'
                                                                      : i['league'] == 'Gold' &&
                                                                              icon.userData[0]['currentLevel'] == 3 &&
                                                                              i['league'] == 'Gold'
                                                                          ? 'Unlocked'
                                                                          : 'Locked',
                                                              color: Get.theme
                                                                  .primaryColor,
                                                              fsize: 12,
                                                              iscenter: true,
                                                            ),
                                                            const SizedBox(
                                                              height: 10,
                                                            ),
                                                            Txt(
                                                              defalutsize: true,
                                                              text:
                                                                  i['league']!,
                                                              fsize: 20,
                                                              weight: FontWeight
                                                                  .bold,
                                                              iscenter: true,
                                                            )
                                                          ],
                                                        ))
                                                  ],
                                                ),
                                                Txt(
                                                  defalutsize: true,
                                                  fsize: 13,
                                                  iscenter: true,
                                                  text: i['subtext']!,
                                                ),
                                                SizedBox(
                                                  height: 10.sp,
                                                ),
                                                if (i['league'] == 'Silver' &&
                                                    icon.userData[0][
                                                        'currentLevelIsCompleted'] &&
                                                    icon.userData[0]
                                                            ['currentLevel'] ==
                                                        2)
                                                  ElevatedButton(
                                                      // ignore: prefer_const_constructors
                                                      style: ElevatedButton.styleFrom(
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          6)),
                                                          backgroundColor: Get
                                                              .theme
                                                              .primaryColor,
                                                          elevation: 0),
                                                      child: const Padding(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                vertical: 3.5),
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  4.0),
                                                          child: Txt(
                                                            text:
                                                                'Go to next level',
                                                            color: Colors.white,
                                                            iscenter: true,
                                                            weight:
                                                                FontWeight.bold,
                                                            defalutsize: true,
                                                          ),
                                                        ),
                                                      ),
                                                      onPressed: () {
                                                        Get.bottomSheet(
                                                            Container(
                                                                child: Padding(
                                                                  padding: EdgeInsets
                                                                      .all(12.0
                                                                          .sp),
                                                                  child: Column(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceBetween,
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Column(
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        children: [
                                                                          const Txt(
                                                                            text:
                                                                                'Are you ready to move Gold Level?',
                                                                            weight:
                                                                                FontWeight.bold,
                                                                          ),
                                                                          SizedBox(
                                                                            height:
                                                                                9.sp,
                                                                          ),
                                                                          Row(
                                                                            children: const [
                                                                              Txt(
                                                                                text: 'Rs 5000 debited from your wallet',
                                                                                fsize: 13,
                                                                                weight: FontWeight.normal,
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      Row(
                                                                        children: [
                                                                          Expanded(
                                                                            child:
                                                                                InkWell(
                                                                              onTap: () => Get.back(),
                                                                              child: Container(
                                                                                height: 60,
                                                                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.sp), border: Border.all(color: Get.theme.primaryColor)),
                                                                                child: Center(
                                                                                  child: Txt(
                                                                                    text: 'Disagree',
                                                                                    color: Get.theme.primaryColor,
                                                                                    fsize: 14,
                                                                                    weight: FontWeight.w600,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          SizedBox(
                                                                            width:
                                                                                20.sp,
                                                                          ),
                                                                          Expanded(
                                                                            child:
                                                                                InkWell(
                                                                              onTap: () {
                                                                                icon.updateLevel();
                                                                              },
                                                                              child: Container(
                                                                                height: 60,
                                                                                decoration: BoxDecoration(color: Get.theme.primaryColor, borderRadius: BorderRadius.circular(10.sp), border: Border.all(color: Get.theme.primaryColor)),
                                                                                child: const Center(
                                                                                  child: Txt(
                                                                                    text: 'Agree',
                                                                                    color: Colors.white,
                                                                                    fsize: 14,
                                                                                    weight: FontWeight.w600,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                                height:
                                                                    Get.height *
                                                                        .3,
                                                                decoration: BoxDecoration(
                                                                    color: Colors
                                                                        .white,
                                                                    borderRadius: BorderRadius.only(
                                                                        topLeft:
                                                                            Radius.circular(20
                                                                                .sp),
                                                                        topRight:
                                                                            Radius.circular(20.sp)))));
                                                      }),
                                                if (i['league'] == 'Bronze' &&
                                                    icon.userData[0][
                                                        'currentLevelIsCompleted'] &&
                                                    icon.userData[0]
                                                            ['currentLevel'] ==
                                                        1)
                                                  ElevatedButton(
                                                      // ignore: prefer_const_constructors
                                                      style: ElevatedButton.styleFrom(
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          6)),
                                                          backgroundColor: Get
                                                              .theme
                                                              .primaryColor,
                                                          elevation: 0),
                                                      child: const Padding(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                vertical: 3.5),
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  4.0),
                                                          child: Txt(
                                                            text:
                                                                'Go to next level',
                                                            color: Colors.white,
                                                            iscenter: true,
                                                            weight:
                                                                FontWeight.bold,
                                                            defalutsize: true,
                                                          ),
                                                        ),
                                                      ),
                                                      onPressed: () {
                                                        Get.bottomSheet(
                                                            Container(
                                                                child: Padding(
                                                                  padding: EdgeInsets
                                                                      .all(12.0
                                                                          .sp),
                                                                  child: Column(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceBetween,
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Column(
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        children: [
                                                                          const Txt(
                                                                            text:
                                                                                'Are you ready to move Silver Level?',
                                                                            weight:
                                                                                FontWeight.bold,
                                                                          ),
                                                                          SizedBox(
                                                                            height:
                                                                                9.sp,
                                                                          ),
                                                                          Row(
                                                                            children: const [
                                                                              Txt(
                                                                                text: 'Rs 500 debited from your wallet',
                                                                                fsize: 13,
                                                                                weight: FontWeight.normal,
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      Row(
                                                                        children: [
                                                                          Expanded(
                                                                            child:
                                                                                InkWell(
                                                                              onTap: () => Get.back(),
                                                                              child: Container(
                                                                                height: 60,
                                                                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.sp), border: Border.all(color: Get.theme.primaryColor)),
                                                                                child: Center(
                                                                                  child: Txt(
                                                                                    text: 'Disagree',
                                                                                    color: Get.theme.primaryColor,
                                                                                    fsize: 14,
                                                                                    weight: FontWeight.w600,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          SizedBox(
                                                                            width:
                                                                                20.sp,
                                                                          ),
                                                                          Expanded(
                                                                            child:
                                                                                InkWell(
                                                                              onTap: () {
                                                                                icon.updateLevel();
                                                                              },
                                                                              child: Container(
                                                                                height: 60,
                                                                                decoration: BoxDecoration(color: Get.theme.primaryColor, borderRadius: BorderRadius.circular(10.sp), border: Border.all(color: Get.theme.primaryColor)),
                                                                                child: const Center(
                                                                                  child: Txt(
                                                                                    text: 'Agree',
                                                                                    color: Colors.white,
                                                                                    fsize: 14,
                                                                                    weight: FontWeight.w600,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                                height:
                                                                    Get.height *
                                                                        .3,
                                                                decoration: BoxDecoration(
                                                                    color: Colors
                                                                        .white,
                                                                    borderRadius: BorderRadius.only(
                                                                        topLeft:
                                                                            Radius.circular(20
                                                                                .sp),
                                                                        topRight:
                                                                            Radius.circular(20.sp)))));
                                                      }),
                                              ],
                                            );
                                          },
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ))
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}

var refData = [
  {
    'img': 'assets/Bronze.png',
    'league': 'Bronze',
    'level': 'Locked',
    'subtext':
        'In bronze level you will get rs 15 for each one joined under your referal code'
  },
  {
    'img': 'assets/silver.png',
    'league': 'Silver',
    'level': 'Locked',
    'subtext':
        'In silver level you will get rs 100 for each one joined under your referal code'
  },
  {
    'img': 'assets/gold.png',
    'league': 'Gold',
    'level': 'Locked',
    'subtext':
        'In gold level you will get rs 1000 for each one joined under your referal code'
  }
];
