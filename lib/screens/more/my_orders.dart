import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kubera/controller/init.dart';
import 'package:kubera/widgets/home/search_bar.dart';
import 'package:sizer/sizer.dart';

import '../../widgets/appbar.dart';
import '../../widgets/text.dart';
import 'order_details.dart';
import 'refund_req.dart';

class MyOrdersView extends StatelessWidget {
  MyOrdersView({Key? key}) : super(key: key);
  final InitCon icon = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: BaseAppBar(
          backicon: true,
          title: 'My orders',
        ),
        body: Obx(
          () => Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SearchBar(
                  enabled: true,
                ),
              ),
              Expanded(
                child: ListView.builder(
                    itemCount: icon.myorders.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.all(
                          8.0.sp,
                        ),
                        child: InkWell(
                          onTap: () {},
                          child: Container(
                            width: Get.width * .75,
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
                                  offset: const Offset(
                                      0, 3), // changes position of shadow
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(4.0.sp),
                                  child: InkWell(
                                    onTap: () {
                                      Get.to(() => OrderDetails(
                                            order: icon.myorders[index],
                                          ));
                                    },
                                    child: Row(
                                      children: [
                                        Stack(
                                          // overflow: Overflow.visible,
                                          children: [
                                            Container(
                                              height: 10.5.h,
                                              width: 10.5.h,
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(8.sp),
                                                child: Image.network(
                                                  icon.myorders[index]
                                                          ['products'][0]
                                                      ['book_cover_file_url'],
                                                  fit: BoxFit.cover,
                                                  height: 13.5.h,
                                                  width: 13.5.h,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Expanded(
                                          child: Container(
                                            child: ListTile(
                                              subtitle: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  // Row(
                                                  //   children: [
                                                  //     Container(
                                                  //       decoration:
                                                  //           BoxDecoration(
                                                  //               color: Get.theme
                                                  //                   .primaryColor
                                                  //                   .withOpacity(
                                                  //                       0.2),
                                                  //               borderRadius:
                                                  //                   BorderRadius
                                                  //                       .circular(5
                                                  //                           .sp),
                                                  //               border:
                                                  //                   Border.all(
                                                  //                 color: Get
                                                  //                     .theme
                                                  //                     .primaryColor,
                                                  //               )),
                                                  //       child: Padding(
                                                  //         padding: EdgeInsets
                                                  //             .symmetric(
                                                  //                 vertical:
                                                  //                     2.sp,
                                                  //                 horizontal:
                                                  //                     8.sp),
                                                  //         child: Txt(
                                                  //           text: 'On the way',
                                                  //           color: Get.theme
                                                  //               .primaryColor,
                                                  //           fsize: 10,
                                                  //         ),
                                                  //       ),
                                                  //     ),
                                                  //   ],
                                                  // ),
                                                  SizedBox(
                                                    height: 5.sp,
                                                  ),
                                                  Txt(
                                                    text: 'Order ID: ' +
                                                        icon.myorders[index]
                                                            ['orderId'],
                                                    weight: FontWeight.bold,
                                                    lines: 2,
                                                    fsize: 10,
                                                  ),
                                                  SizedBox(
                                                    height: 5.sp,
                                                  ),
                                                  Txt(
                                                    text: 'Items: ' +
                                                        icon.myorders[index]
                                                                ['productCount']
                                                            .toString(),
                                                    fsize: 9,
                                                    lines: 1,
                                                    color: Colors.grey[400]!,
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
                                              color: Colors.grey,
                                            ))
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: 8.sp),
                                  child: MySeparator(color: Colors.grey[300]!),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        Get.to(() => RefundReqView(
                                              ItemData: icon.myorders[index],
                                            ));
                                      },
                                      child: Txt(
                                        text: 'Refund request',
                                        fsize: 12,
                                        color: Get.theme.primaryColor,
                                      ),
                                    ),
                                    Container(
                                      height: 20.sp,
                                      width: 0.5,
                                      color: Colors.grey[300],
                                    ),
                                    Txt(
                                      text: 'Need help?',
                                      fsize: 12,
                                      color: Get.theme.primaryColor,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10.sp,
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
              )
            ],
          ),
        ));
  }
}

class MySeparator extends StatelessWidget {
  MySeparator({Key? key, this.height = 1, this.color = Colors.black})
      : super(key: key);
  final double height;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final boxWidth = constraints.constrainWidth();
        const dashWidth = 7.0;
        final dashHeight = height;
        final dashCount = (boxWidth / (2 * dashWidth)).floor();
        return Flex(
          children: List.generate(dashCount, (_) {
            return SizedBox(
              width: dashWidth,
              height: dashHeight,
              child: DecoratedBox(
                decoration: BoxDecoration(color: color),
              ),
            );
          }),
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          direction: Axis.horizontal,
        );
      },
    );
  }
}
