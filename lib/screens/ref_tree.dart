import 'dart:io';

import 'package:dotted_decoration/dotted_decoration.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kubera/controller/init.dart';
import 'package:kubera/widgets/appbar.dart';
import 'package:kubera/widgets/text.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

class RefTree extends StatefulWidget {
  final String title;
  RefTree({Key? key, this.title = ''}) : super(key: key);

  @override
  State<RefTree> createState() => _RefTreeState();
}

class _RefTreeState extends State<RefTree> {
  final InitCon icon = Get.find();
  @override
  void dispose() {
    icon.treeMembers.value = '';
    icon.refCount.value = 0;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var childCount = widget.title == 'Bronze'
        ? icon.userData[0]['childrenBronze']['count']
        : widget.title == 'Silver'
            ? icon.userData[0]['childrenSilver']['count']
            : icon.userData[0]['childrenGold']['count'];

    return Scaffold(
        appBar: BaseAppBar(
          backicon: true,
          title: '${widget.title} Level',
        ),
        body: Obx(
          () => icon.treeMembers.value == ''
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CupertinoActivityIndicator(),
                    ],
                  ),
                )
              : Scrollbar(
                  thumbVisibility: true,
                  child: ListView(
                    children: [
                      Container(
                        height: 150,
                        decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(30),
                                bottomRight: Radius.circular(30))),
                        child: Column(
                          children: [
                            ListTile(
                              title: Row(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      print(childCount);
                                    },
                                    child: Txt(
                                      text: 'Hi ${icon.pname.text} 👋',
                                      weight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12),
                              child: Row(
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 0, 0, 25),
                                    child: Stack(
                                      children: <Widget>[
                                        InkWell(
                                          onTap: () {},
                                          child: CircleAvatar(
                                            radius: 30,
                                            backgroundColor: Colors.grey[300],
                                            child: ClipOval(
                                              child: Container(
                                                child: Stack(
                                                  children: [
                                                    Stack(
                                                      children: [
                                                        InkWell(
                                                          onTap: () {},
                                                          child: icon.userData[
                                                                          0][
                                                                      'profile_image'] ==
                                                                  'https://kuberatech-docs.s3.us-west-1.amazonaws.com/'
                                                              ? Image.asset(
                                                                  'assets/no_user.png',
                                                                  height: 60,
                                                                  width: 60,
                                                                )
                                                              : Image.network(
                                                                  icon.userData[
                                                                          0][
                                                                      'profile_image'],
                                                                  height: 60,
                                                                  width: 60,
                                                                ),
                                                        ),
                                                        Positioned.fill(
                                                          child: Container(
                                                            color: Colors.black
                                                                .withOpacity(
                                                                    0.5),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                    // Positioned.fill(
                                                    //   child: Align(
                                                    //     alignment: Alignment.center,
                                                    //     child: Txt(
                                                    //       text: 'Click to\n  edit',
                                                    //       fsize: 10,
                                                    //       color: Colors.white,
                                                    //       weight: FontWeight.bold,
                                                    //     ),
                                                    //   ),
                                                    // )
                                                  ],
                                                ),
                                                color: Colors.grey[300],
                                              ),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                            bottom: 1,
                                            right: 1,
                                            child: InkWell(
                                              onTap: () {
                                                //    value.getImage();
                                              },
                                              child: Container(
                                                height: 18.sp,
                                                width: 18.sp,
                                                child: Icon(
                                                  Icons.star_outline,
                                                  color: Colors.white,
                                                  size: 12.sp,
                                                ),
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: Get.theme.primaryColor,
                                                ),
                                              ),
                                            ))
                                      ],
                                    ),
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                          width: Get.width * .70,
                                          child: Obx(
                                            () => Row(
                                              children: [
                                                Expanded(
                                                  child: LinearPercentIndicator(
                                                    barRadius:
                                                        Radius.circular(999),
                                                    lineHeight: 20.0,
                                                    percent: childCount == 0
                                                        ? 0.0
                                                        : double.parse(
                                                            ((childCount / 84) *
                                                                    1)
                                                                .toString()),
                                                    center: Txt(
                                                      text: 'Level ' +
                                                          icon.userData[0][
                                                                  'currentLevel']
                                                              .toString(),
                                                      color: Colors.white,
                                                      weight: FontWeight.bold,
                                                      fsize: 11,
                                                      defalutsize: true,
                                                    ),
                                                    backgroundColor:
                                                        Colors.white,
                                                    progressColor:
                                                        Get.theme.primaryColor,
                                                  ),
                                                ),
                                                Txt(
                                                  text: childCount.toString(),
                                                  weight: FontWeight.bold,
                                                  fsize: 13,
                                                  color: Get.theme.primaryColor,
                                                ),
                                                Txt(
                                                    text: '/84',
                                                    weight: FontWeight.bold,
                                                    fsize: 13,
                                                    color: Colors.grey),
                                              ],
                                            ),
                                          )),
                                      SizedBox(
                                        height: 4,
                                      ),
                                      Row(
                                        children: [
                                          SizedBox(
                                            width: 12,
                                          ),
                                          Txt(
                                            text:
                                                'Join ${-childCount + 84} friends to move level ${icon.userData[0]['currentLevel'] + 1}',
                                            fsize: 10,
                                            color: Colors.grey[500]!,
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 15,
                                      )
                                    ],
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        child: icon.showLoad.value
                            ? Center(
                                child: Container(
                                  height: 300.sp,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      CupertinoActivityIndicator(),
                                      SizedBox(height: 10),
                                      Text('Getting data...'),
                                    ],
                                  ),
                                ),
                              )
                            : Container(
                                height: 600,
                                child: Row(
                                  children: [
                                    Stack(
                                      children: [
                                        if (icon.refCount.value == 2)
                                          Positioned(
                                              top: 0,
                                              left: 25,
                                              child: Column(
                                                children: [
                                                  InkWell(
                                                    onTap: () {
                                                      icon.refCount--;

                                                      icon.getTree(
                                                          icon.leftKubIdSecond
                                                              .value,
                                                          leauge: widget.title,
                                                          isOther: true);
                                                      icon.leftcurrentname
                                                              .value =
                                                          icon.grandName.value;
                                                      icon.leftcurrentImg
                                                              .value =
                                                          icon.leftGrandImg1
                                                              .value;
                                                    },
                                                    child: CircleAvatar(
                                                      backgroundColor:
                                                          Colors.grey[300],
                                                      radius: 25,
                                                      child: ClipOval(
                                                          child: icon.userData[
                                                                          0][
                                                                      'profile_image'] ==
                                                                  'https://kuberatech-docs.s3.us-west-1.amazonaws.com/'
                                                              ? Image.asset(
                                                                  'assets/no_user.png',
                                                                  height: 50,
                                                                  width: 50,
                                                                )
                                                              : Image.network(
                                                                  icon.userData[
                                                                          0][
                                                                      'profile_image'],
                                                                  height: 50,
                                                                  width: 50,
                                                                )),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  Txt(
                                                    text: 'You',
                                                    defalutsize: true,
                                                    weight: FontWeight.bold,
                                                    fsize: 16,
                                                  ),
                                                  Container(
                                                    width: 2,
                                                    height: 30,
                                                    decoration:
                                                        DottedDecoration(
                                                            shape: Shape.line,
                                                            color: Get.theme
                                                                .primaryColor,
                                                            linePosition:
                                                                LinePosition
                                                                    .left),
                                                  ),
                                                  Transform.translate(
                                                    offset: Offset(0.0, -10.0),
                                                    child: Icon(
                                                      Icons.arrow_drop_down,
                                                      color: Get
                                                          .theme.primaryColor,
                                                    ),
                                                  )
                                                ],
                                              )),
                                        if (icon.refCount.value == 1 ||
                                            icon.refCount.value == 2)
                                          Positioned(
                                              top: 120,
                                              left: 25,
                                              child: Column(
                                                children: [
                                                  InkWell(
                                                    onTap: () {
                                                      print('ccc');
                                                      icon.refCount--;
                                                      if (icon.refCount.value ==
                                                          0) {
                                                        print('comming');
                                                        icon.leftcurrentImg
                                                            .value = icon
                                                                .userData[0]
                                                            ['profile_image'];
                                                        icon.getTree(
                                                            icon.userData[0]
                                                                ['kubera_id'],
                                                            leauge:
                                                                widget.title);
                                                        icon.leftcurrentname
                                                            .value = 'You';
                                                      }
                                                      if (icon.refCount.value ==
                                                          2) {
                                                        print('yesss');
                                                        icon.leftcurrentImg
                                                                .value =
                                                            icon.leftGrandImg1
                                                                .value;
                                                        icon.getTree(
                                                            icon.leftKubId
                                                                .value,
                                                            leauge:
                                                                widget.title);
                                                      }
                                                      if (icon.refCount.value ==
                                                          1) {
                                                        print('ccss');
                                                        icon.leftcurrentImg
                                                                .value =
                                                            icon.leftGrandImg1
                                                                .value;
                                                        icon.leftcurrentname
                                                                .value =
                                                            icon.leftGrandname
                                                                .value;
                                                        icon.getTree(
                                                            icon.leftKubIdSecond
                                                                .value,
                                                            leauge:
                                                                widget.title,
                                                            isOther: true);
                                                      }

                                                      if (icon.refCount.value ==
                                                          0) {}
                                                    },
                                                    child: CircleAvatar(
                                                        backgroundColor:
                                                            Colors.grey[300],
                                                        radius: 25,
                                                        child: icon.refCount
                                                                    .value ==
                                                                1
                                                            ? ClipOval(
                                                                child: icon.userData[0]
                                                                            [
                                                                            'profile_image'] ==
                                                                        'https://kuberatech-docs.s3.us-west-1.amazonaws.com/'
                                                                    ? Image
                                                                        .asset(
                                                                        'assets/no_user.png',
                                                                        height:
                                                                            50,
                                                                        width:
                                                                            50,
                                                                      )
                                                                    : Image
                                                                        .network(
                                                                        icon.userData[0]
                                                                            [
                                                                            'profile_image'],
                                                                        height:
                                                                            50,
                                                                        width:
                                                                            50,
                                                                        fit: BoxFit
                                                                            .cover,
                                                                      ))
                                                            : ClipOval(
                                                                child: icon.leftGrandImg
                                                                            .value ==
                                                                        'https://kuberatech-docs.s3.us-west-1.amazonaws.com/'
                                                                    ? Image
                                                                        .asset(
                                                                        'assets/no_user.png',
                                                                        height:
                                                                            50,
                                                                        width:
                                                                            50,
                                                                      )
                                                                    : Image
                                                                        .network(
                                                                        icon.leftGrandImg1
                                                                            .value,
                                                                        height:
                                                                            50,
                                                                        width:
                                                                            50,
                                                                        fit: BoxFit
                                                                            .cover,
                                                                      ))),
                                                  ),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  Txt(
                                                    text:
                                                        icon.refCount.value == 1
                                                            ? 'You'
                                                            : icon.leftGrandname
                                                                .value,
                                                    defalutsize: true,
                                                    weight: FontWeight.bold,
                                                    fsize: 16,
                                                  ),
                                                  Container(
                                                    width: 2,
                                                    height: 30,
                                                    decoration:
                                                        DottedDecoration(
                                                            shape: Shape.line,
                                                            color: Get.theme
                                                                .primaryColor,
                                                            linePosition:
                                                                LinePosition
                                                                    .left),
                                                  ),
                                                  Transform.translate(
                                                    offset: Offset(0.0, -10.0),
                                                    child: Icon(
                                                      Icons.arrow_drop_down,
                                                      color: Get
                                                          .theme.primaryColor,
                                                    ),
                                                  )
                                                ],
                                              )),
                                        Container(
                                          width: 100,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              CircleAvatar(
                                                radius: 40,
                                                backgroundColor:
                                                    Colors.grey[300],
                                                child: ClipOval(
                                                  child: icon.leftcurrentImg
                                                                  .value ==
                                                              'https://kuberatech-docs.s3.us-west-1.amazonaws.com/' ||
                                                          icon.leftcurrentImg
                                                                  .value ==
                                                              ''
                                                      ? Image.asset(
                                                          'assets/no_user.png',
                                                          height: 80,
                                                          width: 80,
                                                        )
                                                      : Image.network(
                                                          icon.leftcurrentImg
                                                              .value,
                                                          height: 80,
                                                          width: 80,
                                                        ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Txt(
                                                text:
                                                    icon.leftcurrentname.value,
                                                defalutsize: true,
                                                iscenter: true,
                                                weight: FontWeight.bold,
                                                fsize: 15,
                                              ),
                                              SizedBox(
                                                height: 3,
                                              ),
                                              Txt(
                                                text: icon.leftcurrentname
                                                            .value !=
                                                        'You'
                                                    ? ''
                                                    : 'Level ' +
                                                        icon.leftcurrentLevel
                                                            .value,
                                                defalutsize: true,
                                                fsize: 12,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          width: 10,
                                          height: 0.6,
                                          color: Get.theme.primaryColor,
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Txt(
                                          text: '',
                                          defalutsize: true,
                                          weight: FontWeight.bold,
                                          fsize: 16,
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Txt(
                                          text: '',
                                          defalutsize: true,
                                          fsize: 13.5,
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                top: 31.5, bottom: 63.5),
                                            child: Container(
                                              width: 1,
                                              color: Get.theme.primaryColor,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Expanded(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 10),
                                                  child: Row(
                                                    children: [
                                                      Expanded(
                                                        child: Column(
                                                          children: [
                                                            Container(
                                                                height: 1,
                                                                color: Color(
                                                                    0xFF4BF85C)),
                                                            SizedBox(
                                                              height: 3,
                                                            ),
                                                            Txt(
                                                              text: '',
                                                              lines: 1,
                                                              fsize: 12,
                                                              defalutsize: true,
                                                            ),
                                                            SizedBox(
                                                              height: 3,
                                                            ),
                                                            Txt(
                                                              text: '',
                                                              fsize: 10,
                                                              defalutsize: true,
                                                              color: Colors
                                                                  .grey[600]!,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Column(
                                                        children: [
                                                          Icon(
                                                            Icons.arrow_right,
                                                            color: Color(
                                                                0xFF4BF85C),
                                                          ),
                                                          SizedBox(
                                                            height: 3,
                                                          ),
                                                          Txt(
                                                            text: '',
                                                            lines: 1,
                                                            fsize: 12,
                                                            defalutsize: true,
                                                          ),
                                                          SizedBox(
                                                            height: 3,
                                                          ),
                                                          Txt(
                                                            text: '',
                                                            fsize: 10,
                                                            defalutsize: true,
                                                            color: Colors
                                                                .grey[600]!,
                                                          ),
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              icon.treeData.length == 1 ||
                                                      icon.treeData.length ==
                                                          2 ||
                                                      icon.treeData.length ==
                                                          3 ||
                                                      icon.treeData.length == 4
                                                  ? Container(
                                                      width: 64,
                                                      child: Column(
                                                        children: [
                                                          InkWell(
                                                            onTap: () {
                                                              if (icon.refCount
                                                                      .value
                                                                      .toString() ==
                                                                  '0') {
                                                                if (icon.refCount
                                                                        .value ==
                                                                    0) {
                                                                  icon.leftKubIdSecond
                                                                      .value = icon
                                                                          .treeData[0]
                                                                      [
                                                                      'kubera_id'];
                                                                  print('bbbb' +
                                                                      icon.leftKubIdSecond
                                                                          .value);
                                                                }
                                                                icon.leftGrandname
                                                                        .value =
                                                                    icon.treeData[
                                                                            0][
                                                                        'name'];
                                                                icon.leftGrandImg1
                                                                    .value = icon
                                                                        .treeData[0]
                                                                    [
                                                                    'profile_image'];
                                                                icon.leftKubId
                                                                    .value = icon
                                                                        .treeData[0]
                                                                    [
                                                                    'kubera_id'];
                                                                icon.grandName
                                                                        .value =
                                                                    icon.treeData[
                                                                            0][
                                                                        'name'];
                                                              }
                                                              print('kkk' +
                                                                  icon.refCount
                                                                      .value
                                                                      .toString());
                                                              print(icon
                                                                      .treeData[0]
                                                                  [
                                                                  'kubera_id']);

                                                              if (icon.refCount
                                                                      .value !=
                                                                  2) {
                                                                print('heys' +
                                                                    icon.refCount
                                                                        .toString());
                                                                print('hhh');

                                                                icon.refCount++;
                                                                icon.leftcurrentImg
                                                                    .value = icon
                                                                        .treeData[0]
                                                                    [
                                                                    'profile_image'];
                                                                icon.leftcurrentname
                                                                        .value =
                                                                    icon.treeData[
                                                                            0][
                                                                        'name'];
                                                                icon.getTree(
                                                                    icon.treeData[
                                                                            0][
                                                                        'kubera_id'],
                                                                    leauge: widget
                                                                        .title,
                                                                    isOther:
                                                                        true);
                                                                print(icon
                                                                    .refCount
                                                                    .value);
                                                              } else if (icon
                                                                      .refCount
                                                                      .value ==
                                                                  2) {
                                                              } else if (icon
                                                                      .refCount
                                                                      .value ==
                                                                  1) {
                                                                print('vvvv');
                                                                icon.leftcurrentImg
                                                                    .value = icon
                                                                        .userData[0]
                                                                    [
                                                                    'profile_image'];
                                                              }
                                                            },
                                                            child: CircleAvatar(
                                                              radius: 32,
                                                              backgroundColor:
                                                                  Color(
                                                                      0xFF4BF85C),
                                                              child:
                                                                  CircleAvatar(
                                                                radius: 30,
                                                                backgroundColor:
                                                                    Colors.grey[
                                                                        200],
                                                                child: ClipOval(
                                                                    child: icon.treeData[0]['profile_image'] ==
                                                                            ''
                                                                        ? Image
                                                                            .asset(
                                                                            'assets/no_user.png',
                                                                            height:
                                                                                60,
                                                                            width:
                                                                                60,
                                                                          )
                                                                        : Image
                                                                            .network(
                                                                            icon.treeData[0]['profile_image'],
                                                                            height:
                                                                                60,
                                                                            width:
                                                                                60,
                                                                            fit:
                                                                                BoxFit.cover,
                                                                          )),
                                                              ),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height: 3,
                                                          ),
                                                          Txt(
                                                            text:
                                                                icon.treeData[0]
                                                                    ['name'],
                                                            lines: 1,
                                                            fsize: 12,
                                                            defalutsize: true,
                                                          ),
                                                          SizedBox(
                                                            height: 3,
                                                          ),
                                                          Txt(
                                                            text: icon
                                                                    .treeData[0]
                                                                ['kubera_id'],
                                                            fsize: 10,
                                                            defalutsize: true,
                                                            color: Colors
                                                                .grey[600]!,
                                                          ),
                                                        ],
                                                      ),
                                                    )
                                                  : NoUser(),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Expanded(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 10),
                                                  child: Row(
                                                    children: [
                                                      Expanded(
                                                        child: Column(
                                                          children: [
                                                            Container(
                                                              height: 1,
                                                              color: Color(
                                                                  0XFFEE3C7C),
                                                            ),
                                                            SizedBox(
                                                              height: 3,
                                                            ),
                                                            Txt(
                                                              text: '',
                                                              lines: 1,
                                                              fsize: 12,
                                                              defalutsize: true,
                                                            ),
                                                            SizedBox(
                                                              height: 3,
                                                            ),
                                                            Txt(
                                                              text: '',
                                                              fsize: 10,
                                                              defalutsize: true,
                                                              color: Colors
                                                                  .grey[600]!,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Column(
                                                        children: [
                                                          Icon(
                                                            Icons.arrow_right,
                                                            color: Color(
                                                                0XFFEE3C7C),
                                                          ),
                                                          SizedBox(
                                                            height: 3,
                                                          ),
                                                          Txt(
                                                            text: '',
                                                            lines: 1,
                                                            fsize: 12,
                                                            defalutsize: true,
                                                          ),
                                                          SizedBox(
                                                            height: 3,
                                                          ),
                                                          Txt(
                                                            text: '',
                                                            fsize: 10,
                                                            defalutsize: true,
                                                            color: Colors
                                                                .grey[600]!,
                                                          ),
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              icon.treeData.length == 2 ||
                                                      icon.treeData.length ==
                                                          3 ||
                                                      icon.treeData.length == 4
                                                  ? Container(
                                                      width: 64,
                                                      child: Column(
                                                        children: [
                                                          CircleAvatar(
                                                            radius: 32,
                                                            backgroundColor:
                                                                Color(
                                                                    0XFFEE3C7C),
                                                            child: CircleAvatar(
                                                              radius: 32,
                                                              backgroundColor:
                                                                  Color(
                                                                      0XFFEE3C7C),
                                                              child: InkWell(
                                                                onTap: () {
                                                                  if (icon.refCount
                                                                          .value
                                                                          .toString() ==
                                                                      '0') {
                                                                    if (icon.refCount
                                                                            .value ==
                                                                        0) {
                                                                      icon.leftKubIdSecond
                                                                          .value = icon
                                                                              .treeData[1]
                                                                          [
                                                                          'kubera_id'];
                                                                      print('bbbb' +
                                                                          icon.leftKubIdSecond
                                                                              .value);
                                                                    }
                                                                    icon.leftGrandname
                                                                        .value = icon
                                                                            .treeData[1]
                                                                        [
                                                                        'name'];
                                                                    icon.leftGrandImg1
                                                                        .value = icon
                                                                            .treeData[1]
                                                                        [
                                                                        'profile_image'];
                                                                    icon.leftKubId
                                                                        .value = icon
                                                                            .treeData[1]
                                                                        [
                                                                        'kubera_id'];
                                                                    icon.grandName
                                                                        .value = icon
                                                                            .treeData[1]
                                                                        [
                                                                        'name'];
                                                                  }
                                                                  print('kkk' +
                                                                      icon.refCount
                                                                          .value
                                                                          .toString());
                                                                  print(icon
                                                                          .treeData[1]
                                                                      [
                                                                      'kubera_id']);

                                                                  if (icon.refCount
                                                                          .value !=
                                                                      2) {
                                                                    print(
                                                                        'hhh');
                                                                    if (icon.refCount
                                                                            .value ==
                                                                        1) {
                                                                      icon.leftKubIdSecond
                                                                          .value = icon
                                                                              .treeData[1]
                                                                          [
                                                                          'kubera_id'];
                                                                    }
                                                                    icon.refCount++;
                                                                    icon.leftcurrentImg
                                                                        .value = icon
                                                                            .treeData[1]
                                                                        [
                                                                        'profile_image'];
                                                                    icon.leftcurrentname
                                                                        .value = icon
                                                                            .treeData[1]
                                                                        [
                                                                        'name'];
                                                                    icon.getTree(
                                                                        icon.treeData[1]
                                                                            [
                                                                            'kubera_id'],
                                                                        leauge: widget
                                                                            .title,
                                                                        isOther:
                                                                            true);
                                                                    print(icon
                                                                        .refCount
                                                                        .value);
                                                                  } else if (icon
                                                                          .refCount
                                                                          .value ==
                                                                      2) {
                                                                  } else if (icon
                                                                          .refCount
                                                                          .value ==
                                                                      1) {
                                                                    icon.leftcurrentImg
                                                                        .value = icon
                                                                            .userData[0]
                                                                        [
                                                                        'profile_image'];
                                                                  }
                                                                },
                                                                child:
                                                                    CircleAvatar(
                                                                  radius: 30,
                                                                  backgroundColor:
                                                                      Colors.grey[
                                                                          200],
                                                                  child: ClipOval(
                                                                      child: icon.treeData[1]['profile_image'] == ''
                                                                          ? Image.asset(
                                                                              'assets/no_user.png',
                                                                              height: 60,
                                                                              width: 60,
                                                                            )
                                                                          : Image.network(
                                                                              icon.treeData[1]['profile_image'],
                                                                              height: 60,
                                                                              width: 60,
                                                                              fit: BoxFit.cover,
                                                                            )),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height: 3,
                                                          ),
                                                          Txt(
                                                            text:
                                                                icon.treeData[1]
                                                                    ['name'],
                                                            lines: 1,
                                                            fsize: 12,
                                                            defalutsize: true,
                                                          ),
                                                          SizedBox(
                                                            height: 3,
                                                          ),
                                                          Txt(
                                                            text: icon
                                                                    .treeData[1]
                                                                ['kubera_id'],
                                                            fsize: 10,
                                                            defalutsize: true,
                                                            color: Colors
                                                                .grey[600]!,
                                                          ),
                                                        ],
                                                      ),
                                                    )
                                                  : NoUser(),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Expanded(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 10),
                                                  child: Row(
                                                    children: [
                                                      Expanded(
                                                        child: Column(
                                                          children: [
                                                            Container(
                                                                height: 1,
                                                                color: Color(
                                                                    0XFF5E5BF2)),
                                                            SizedBox(
                                                              height: 3,
                                                            ),
                                                            Txt(
                                                              text: '',
                                                              lines: 1,
                                                              fsize: 12,
                                                              defalutsize: true,
                                                            ),
                                                            SizedBox(
                                                              height: 3,
                                                            ),
                                                            Txt(
                                                              text: '',
                                                              fsize: 10,
                                                              defalutsize: true,
                                                              color: Colors
                                                                  .grey[600]!,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Column(
                                                        children: [
                                                          Icon(
                                                            Icons.arrow_right,
                                                            color: Color(
                                                                0XFF5E5BF2),
                                                          ),
                                                          SizedBox(
                                                            height: 3,
                                                          ),
                                                          Txt(
                                                            text: '',
                                                            lines: 1,
                                                            fsize: 12,
                                                            defalutsize: true,
                                                          ),
                                                          SizedBox(
                                                            height: 3,
                                                          ),
                                                          Txt(
                                                            text: '',
                                                            fsize: 10,
                                                            defalutsize: true,
                                                            color: Colors
                                                                .grey[600]!,
                                                          ),
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              icon.treeData.length == 3 ||
                                                      icon.treeData.length == 4
                                                  ? Container(
                                                      width: 64,
                                                      child: Column(
                                                        children: [
                                                          InkWell(
                                                            onTap: () {
                                                              if (icon.refCount
                                                                      .value
                                                                      .toString() ==
                                                                  '0') {
                                                                if (icon.refCount
                                                                        .value ==
                                                                    0) {
                                                                  icon.leftKubIdSecond
                                                                      .value = icon
                                                                          .treeData[2]
                                                                      [
                                                                      'kubera_id'];
                                                                  print('bbbb' +
                                                                      icon.leftKubIdSecond
                                                                          .value);
                                                                }
                                                                icon.leftGrandname
                                                                        .value =
                                                                    icon.treeData[
                                                                            2][
                                                                        'name'];
                                                                icon.leftGrandImg1
                                                                    .value = icon
                                                                        .treeData[2]
                                                                    [
                                                                    'profile_image'];
                                                                icon.leftKubId
                                                                    .value = icon
                                                                        .treeData[2]
                                                                    [
                                                                    'kubera_id'];
                                                                icon.grandName
                                                                        .value =
                                                                    icon.treeData[
                                                                            2][
                                                                        'name'];
                                                              }
                                                              print('kkk' +
                                                                  icon.refCount
                                                                      .value
                                                                      .toString());
                                                              print(icon
                                                                      .treeData[2]
                                                                  [
                                                                  'kubera_id']);

                                                              if (icon.refCount
                                                                      .value !=
                                                                  2) {
                                                                print('hhh');
                                                                if (icon.refCount
                                                                        .value ==
                                                                    1) {
                                                                  icon.leftKubIdSecond
                                                                      .value = icon
                                                                          .treeData[2]
                                                                      [
                                                                      'kubera_id'];
                                                                }
                                                                icon.refCount++;
                                                                icon.leftcurrentImg
                                                                    .value = icon
                                                                        .treeData[2]
                                                                    [
                                                                    'profile_image'];
                                                                icon.leftcurrentname
                                                                        .value =
                                                                    icon.treeData[
                                                                            2][
                                                                        'name'];
                                                                icon.getTree(
                                                                    icon.treeData[
                                                                            2][
                                                                        'kubera_id'],
                                                                    leauge: widget
                                                                        .title,
                                                                    isOther:
                                                                        true);
                                                                print(icon
                                                                    .refCount
                                                                    .value);
                                                              } else if (icon
                                                                      .refCount
                                                                      .value ==
                                                                  2) {
                                                              } else if (icon
                                                                      .refCount
                                                                      .value ==
                                                                  1) {
                                                                icon.leftcurrentImg
                                                                    .value = icon
                                                                        .userData[0]
                                                                    [
                                                                    'profile_image'];
                                                              }
                                                            },
                                                            child: CircleAvatar(
                                                              radius: 32,
                                                              backgroundColor:
                                                                  Color(
                                                                      0XFF5E5BF2),
                                                              child:
                                                                  CircleAvatar(
                                                                radius: 30,
                                                                backgroundColor:
                                                                    Colors.grey[
                                                                        200],
                                                                child: ClipOval(
                                                                    child: icon.treeData[2]['profile_image'] ==
                                                                            ''
                                                                        ? Image
                                                                            .asset(
                                                                            'assets/no_user.png',
                                                                            height:
                                                                                60,
                                                                            width:
                                                                                60,
                                                                          )
                                                                        : Image
                                                                            .network(
                                                                            icon.treeData[2]['profile_image'],
                                                                            height:
                                                                                60,
                                                                            width:
                                                                                60,
                                                                            fit:
                                                                                BoxFit.cover,
                                                                          )),
                                                              ),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height: 3,
                                                          ),
                                                          Txt(
                                                            text:
                                                                icon.treeData[2]
                                                                    ['name'],
                                                            lines: 1,
                                                            fsize: 12,
                                                            defalutsize: true,
                                                          ),
                                                          SizedBox(
                                                            height: 3,
                                                          ),
                                                          Txt(
                                                            text: icon
                                                                    .treeData[2]
                                                                ['kubera_id'],
                                                            fsize: 10,
                                                            defalutsize: true,
                                                            color: Colors
                                                                .grey[600]!,
                                                          ),
                                                        ],
                                                      ),
                                                    )
                                                  : NoUser(),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Expanded(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 10),
                                                  child: Row(
                                                    children: [
                                                      Expanded(
                                                        child: Column(
                                                          children: [
                                                            Container(
                                                              height: 1,
                                                              color: Color(
                                                                  0XFFD93BF3),
                                                            ),
                                                            SizedBox(
                                                              height: 3,
                                                            ),
                                                            Txt(
                                                              text: '',
                                                              lines: 1,
                                                              fsize: 12,
                                                              defalutsize: true,
                                                            ),
                                                            SizedBox(
                                                              height: 3,
                                                            ),
                                                            Txt(
                                                              text: '',
                                                              fsize: 10,
                                                              defalutsize: true,
                                                              color: Colors
                                                                  .grey[600]!,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Column(
                                                        children: [
                                                          Icon(
                                                            Icons.arrow_right,
                                                            color: Color(
                                                                0XFFD93BF3),
                                                          ),
                                                          SizedBox(
                                                            height: 3,
                                                          ),
                                                          Txt(
                                                            text: '',
                                                            lines: 1,
                                                            fsize: 12,
                                                            defalutsize: true,
                                                          ),
                                                          SizedBox(
                                                            height: 3,
                                                          ),
                                                          Txt(
                                                            text: '',
                                                            fsize: 10,
                                                            defalutsize: true,
                                                            color: Colors
                                                                .grey[600]!,
                                                          ),
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              icon.treeData.length != 4
                                                  ? NoUser()
                                                  : Container(
                                                      width: 64,
                                                      child: Column(
                                                        children: [
                                                          InkWell(
                                                            onTap: () {
                                                              if (icon.refCount
                                                                      .value
                                                                      .toString() ==
                                                                  '0') {
                                                                if (icon.refCount
                                                                        .value ==
                                                                    0) {
                                                                  icon.leftKubIdSecond
                                                                      .value = icon
                                                                          .treeData[3]
                                                                      [
                                                                      'kubera_id'];
                                                                  print('bbbb' +
                                                                      icon.leftKubIdSecond
                                                                          .value);
                                                                }
                                                                icon.leftGrandname
                                                                        .value =
                                                                    icon.treeData[
                                                                            3][
                                                                        'name'];
                                                                icon.leftGrandImg1
                                                                    .value = icon
                                                                        .treeData[3]
                                                                    [
                                                                    'profile_image'];
                                                                icon.leftKubId
                                                                    .value = icon
                                                                        .treeData[3]
                                                                    [
                                                                    'kubera_id'];
                                                                icon.grandName
                                                                        .value =
                                                                    icon.treeData[
                                                                            3][
                                                                        'name'];
                                                              }
                                                              print('kkk' +
                                                                  icon.refCount
                                                                      .value
                                                                      .toString());
                                                              print(icon
                                                                      .treeData[3]
                                                                  [
                                                                  'kubera_id']);

                                                              if (icon.refCount
                                                                      .value !=
                                                                  2) {
                                                                print('hhh');
                                                                if (icon.refCount
                                                                        .value ==
                                                                    1) {
                                                                  icon.leftKubIdSecond
                                                                      .value = icon
                                                                          .treeData[3]
                                                                      [
                                                                      'kubera_id'];
                                                                }
                                                                icon.refCount++;
                                                                icon.leftcurrentImg
                                                                    .value = icon
                                                                        .treeData[3]
                                                                    [
                                                                    'profile_image'];
                                                                icon.leftcurrentname
                                                                        .value =
                                                                    icon.treeData[
                                                                            3][
                                                                        'name'];
                                                                icon.getTree(
                                                                    icon.treeData[
                                                                            3][
                                                                        'kubera_id'],
                                                                    leauge: widget
                                                                        .title,
                                                                    isOther:
                                                                        true);
                                                                print(icon
                                                                    .refCount
                                                                    .value);
                                                              } else if (icon
                                                                      .refCount
                                                                      .value ==
                                                                  2) {
                                                              } else if (icon
                                                                      .refCount
                                                                      .value ==
                                                                  1) {
                                                                icon.leftcurrentImg
                                                                    .value = icon
                                                                        .userData[0]
                                                                    [
                                                                    'profile_image'];
                                                              }
                                                            },
                                                            child: CircleAvatar(
                                                              radius: 32,
                                                              backgroundColor:
                                                                  Color(
                                                                      0xFFD93BF3),
                                                              child:
                                                                  CircleAvatar(
                                                                radius: 30,
                                                                backgroundColor:
                                                                    Colors.grey[
                                                                        200],
                                                                child: ClipOval(
                                                                    child: icon.treeData[3]['profile_image'] ==
                                                                            ''
                                                                        ? Image
                                                                            .asset(
                                                                            'assets/no_user.png',
                                                                            height:
                                                                                60,
                                                                            width:
                                                                                60,
                                                                          )
                                                                        : Image
                                                                            .network(
                                                                            icon.treeData[3]['profile_image'],
                                                                            height:
                                                                                60,
                                                                            width:
                                                                                60,
                                                                            fit:
                                                                                BoxFit.cover,
                                                                          )),
                                                              ),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height: 3,
                                                          ),
                                                          Txt(
                                                            text:
                                                                icon.treeData[3]
                                                                    ['name'],
                                                            lines: 1,
                                                            fsize: 12,
                                                            defalutsize: true,
                                                          ),
                                                          SizedBox(
                                                            height: 3,
                                                          ),
                                                          Txt(
                                                            text: icon
                                                                    .treeData[3]
                                                                ['kubera_id'],
                                                            fsize: 10,
                                                            defalutsize: true,
                                                            color: Colors
                                                                .grey[600]!,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: 30.sp,
                                    )
                                  ],
                                ),
                              ),
                      ),
                      SizedBox(
                        height: 80,
                      ),
                    ],
                  ),
                ),
        ));
  }
}

class NoUser extends StatelessWidget {
  const NoUser({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 64,
      child: Column(
        children: [
          CircleAvatar(
            radius: 32,
            backgroundColor: Colors.grey[200],
            child: CircleAvatar(
                radius: 30,
                backgroundColor: Colors.grey[200],
                child: ClipOval(
                    child: Image.asset(
                  'assets/no_user.png',
                  height: 60,
                  width: 60,
                ))),
          ),
          SizedBox(
            height: 3,
          ),
          Txt(
            text: 'No User',
            lines: 1,
            fsize: 12,
            defalutsize: true,
          ),
          SizedBox(
            height: 3,
          ),
          Txt(
            text: '',
            fsize: 10,
            defalutsize: true,
            color: Colors.grey[600]!,
          ),
        ],
      ),
    );
  }
}
