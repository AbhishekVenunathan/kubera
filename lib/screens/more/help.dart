import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kubera/screens/more/chat_view.dart';
import 'package:kubera/screens/more/help_feed.dart';
import 'package:kubera/widgets/text.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../widgets/appbar.dart';

class HelpCenter extends StatelessWidget {
  const HelpCenter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        backicon: true,
        title: 'Help center',
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0.sp),
        child: ListView(
          children: [
            SizedBox(
              height: 30.sp,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundColor: Colors.grey[200],
                  radius: 50.sp,
                  child: ClipOval(
                      child: Image.asset(
                    'assets/help.png',
                    height: 100.sp,
                    width: 100.sp,
                    fit: BoxFit.cover,
                  )),
                ),
              ],
            ),
            SizedBox(
              height: 20.sp,
            ),
            Column(
              children: [
                Txt(
                  text: 'Tell us how we can help you',
                  fsize: 14,
                  weight: FontWeight.w700,
                ),
                SizedBox(
                  height: 8.sp,
                ),
                Txt(
                  text:
                      'Our crew of superheros are standing\nfor service & support',
                  fsize: 10,
                  color: Colors.grey[600]!,
                  iscenter: true,
                ),
              ],
            ),
            SizedBox(
              height: 20.sp,
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.12),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Padding(
                padding: EdgeInsets.all(8.0.sp),
                child: Row(
                  children: [
                    Stack(
                      // overflow: Overflow.visible,
                      children: [
                        Container(
                          height: 10.5.h,
                          width: 10.5.h,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8.sp),
                            child: Lottie.asset(
                              'assets/msg_help.json',
                            ),
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          Get.to(() => ChatView());
                        },
                        child: Container(
                          child: ListTile(
                            subtitle: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Txt(
                                  text: 'Chat with us',
                                  weight: FontWeight.w700,
                                  fsize: 13,
                                ),
                                SizedBox(
                                  height: 2.sp,
                                ),
                                Txt(
                                  text:
                                      'Chat with our executive to clear your doubts',
                                  fsize: 9,
                                  lines: 2,
                                  color: Colors.grey[600]!,
                                ),
                                SizedBox(
                                  height: 5.sp,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                        onPressed: null,
                        icon: Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.black,
                        ))
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 10.sp,
            ),
            InkWell(
              onTap: () {
                var mobile = '+918056663491';
                launch("tel://$mobile");
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.12),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Padding(
                  padding: EdgeInsets.all(8.0.sp),
                  child: Row(
                    children: [
                      Stack(
                        // overflow: Overflow.visible,
                        children: [
                          Container(
                            height: 10.5.h,
                            width: 10.5.h,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8.sp),
                              child: Lottie.asset(
                                'assets/call_help.json',
                              ),
                            ),
                          ),
                        ],
                      ),
                      Expanded(
                        child: Container(
                          child: ListTile(
                            onTap: () {},
                            subtitle: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Txt(
                                  text: 'Talk to us',
                                  weight: FontWeight.w700,
                                  fsize: 13,
                                ),
                                SizedBox(
                                  height: 2.sp,
                                ),
                                Txt(
                                  text:
                                      'Our support executives will reach out to you within 24hrs.',
                                  fsize: 9,
                                  lines: 2,
                                  color: Colors.grey[600]!,
                                ),
                                SizedBox(
                                  height: 5.sp,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      IconButton(
                          onPressed: null,
                          icon: Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.black,
                          ))
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10.sp,
            ),
            //   Container(
            //     decoration: BoxDecoration(
            //       color: Colors.white,
            //       borderRadius: BorderRadius.only(
            //           topLeft: Radius.circular(10),
            //           topRight: Radius.circular(10),
            //           bottomLeft: Radius.circular(10),
            //           bottomRight: Radius.circular(10)),
            //       boxShadow: [
            //         BoxShadow(
            //           color: Colors.grey.withOpacity(0.12),
            //           spreadRadius: 5,
            //           blurRadius: 7,
            //           offset: Offset(0, 3), // changes position of shadow
            //         ),
            //       ],
            //     ),
            //     child: Padding(
            //       padding: EdgeInsets.all(8.0.sp),
            //       child: Row(
            //         children: [
            //           Stack(
            //             // overflow: Overflow.visible,
            //             children: [
            //               Container(
            //                 height: 10.5.h,
            //                 width: 10.5.h,
            //                 child: ClipRRect(
            //                     borderRadius: BorderRadius.circular(8.sp),
            //                     child: Lottie.asset('assets/call_support.json')),
            //               ),
            //             ],
            //           ),
            //           Expanded(
            //             child: InkWell(
            //               onTap: () {
            //                 Get.to(() => HelpNFeedView());
            //               },
            //               child: Container(
            //                 child: ListTile(
            //                   subtitle: Column(
            //                     mainAxisAlignment: MainAxisAlignment.center,
            //                     crossAxisAlignment: CrossAxisAlignment.start,
            //                     children: [
            //                       Txt(
            //                         text: 'Help and feedback',
            //                         weight: FontWeight.w700,
            //                         fsize: 13,
            //                       ),
            //                       SizedBox(
            //                         height: 2.sp,
            //                       ),
            //                       Txt(
            //                         text:
            //                             'Send us you valuable feedback or any help needed!',
            //                         fsize: 9,
            //                         lines: 3,
            //                         color: Colors.grey[600]!,
            //                       ),
            //                       SizedBox(
            //                         height: 5.sp,
            //                       ),
            //                     ],
            //                   ),
            //                 ),
            //               ),
            //             ),
            //           ),
            //           IconButton(
            //               onPressed: null,
            //               icon: Icon(
            //                 Icons.arrow_forward_ios,
            //                 color: Colors.black,
            //               ))
            //         ],
            //       ),
            //     ),
            //   ),
          ],
        ),
      ),
    );
  }
}
