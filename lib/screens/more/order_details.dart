import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kubera/widgets/text.dart';
import 'package:sizer/sizer.dart';

import '../../widgets/appbar.dart';

class OrderDetails extends StatelessWidget {
  final order;
  const OrderDetails({Key? key, this.order}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        backicon: true,
        title: 'Order details',
      ),
      body: ListView(
        children: [
          ListTile(
              trailing: SizedBox(
                width: 100.sp,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    // Container(
                    //   decoration: BoxDecoration(
                    //       color: Get.theme.primaryColor.withOpacity(0.2),
                    //       borderRadius: BorderRadius.circular(5.sp),
                    //       border: Border.all(
                    //         color: Get.theme.primaryColor,
                    //       )),
                    //   child: Padding(
                    //     padding: EdgeInsets.symmetric(
                    //         vertical: 2.sp, horizontal: 8.sp),
                    //     child: Txt(
                    //       text: 'On the way',
                    //       color: Get.theme.primaryColor,
                    //       fsize: 10,
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),
              title: Txt(
                text: '#${order['orderId']}',
                fsize: 12,
                weight: FontWeight.w600,
                color: Get.theme.primaryColor,
              ),
              subtitle: Txt(
                text: '23 nov 2021, 05:13 pm',
                fsize: 10,
                color: Colors.grey[400]!,
              )),
          Container(
            color: Colors.grey[100],
            child: Padding(
              padding: EdgeInsets.all(10.0.sp),
              child: Txt(
                text: 'ITEM LIST',
                fsize: 12,
                color: Colors.grey[400]!,
              ),
            ),
          ),
          ListView.builder(
            itemCount: order['products'].length,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              return Container(
                height: 15.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.sp),
                ),
                child: Padding(
                  padding: EdgeInsets.all(8.0.sp),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(4.0.sp),
                        child: Txt(
                          text: '${order['products'][index]['count']}x ',
                          fsize: 10,
                        ),
                      ),
                      Stack(
                        // overflow: Overflow.visible,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8.sp),
                            child: Image.network(
                              order['products'][index]['book_cover_file_url'],
                              fit: BoxFit.cover,
                              height: 11.5.h,
                              width: 11.5.h,
                            ),
                          ),
                        ],
                      ),
                      Expanded(
                        child: Container(
                          child: ListTile(
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Txt(
                                  text: order['products'][index]['book_name'],
                                  weight: FontWeight.bold,
                                  lines: 2,
                                  fsize: 12,
                                ),
                                Txt(
                                  text: order['products'][index]['book_name'],
                                  fsize: 11,
                                  color: Colors.grey[400]!,
                                ),
                                SizedBox(
                                  height: 3.sp,
                                ),
                                Txt(
                                  text: order['cartType'] == 'cart'
                                      ? '₹ ${order['products'][index]['paperBookPrice']}'
                                      : '₹ ${order['products'][index]['discount_price']}',
                                  fsize: 12,
                                  weight: FontWeight.bold,
                                  color: Get.theme.primaryColor,
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.sp),
            child: Container(
              height: 0.6,
              color: Colors.grey[200],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.sp, vertical: 8.sp),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Txt(
                  text: 'Sub total',
                  fsize: 13,
                ),
                Txt(
                  text: '₹ ${order['subtotal']}',
                  fsize: 15,
                  weight: FontWeight.w600,
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.sp, vertical: 8.sp),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Txt(
                  text: 'Shipping & Handling',
                  fsize: 13,
                ),
                Txt(
                  text: '₹ 0',
                  fsize: 13,
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.sp, vertical: 8.sp),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Txt(
                  text: 'GST',
                  fsize: 13,
                ),
                Txt(
                  text: '₹ ${order['gstAmount']}',
                  fsize: 13,
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.sp),
            child: Container(
              height: 0.6,
              color: Colors.grey[200],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.sp, vertical: 8.sp),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Txt(
                  text: 'Total',
                  color: Get.theme.primaryColor,
                  fsize: 13,
                ),
                Txt(
                  text: '₹ ${order['total']}',
                  fsize: 15,
                  weight: FontWeight.w600,
                ),
              ],
            ),
          ),
          Container(
            color: Colors.grey[100],
            child: Padding(
              padding: EdgeInsets.all(10.0.sp),
              child: Txt(
                text: 'PAYMENT DETAILS',
                fsize: 12,
                color: Colors.grey[400]!,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.sp, vertical: 8.sp),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Txt(
                  text: 'Amount Due:',
                  fsize: 13,
                ),
                Txt(
                  text: '₹ ${order['total']}',
                  fsize: 15,
                  weight: FontWeight.w600,
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.sp, vertical: 8.sp),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Txt(
                  text: 'Payment Status:',
                  fsize: 13,
                ),
                Txt(
                  text: 'Paid',
                  fsize: 15,
                  color: Get.theme.primaryColor,
                ),
              ],
            ),
          ),
          if (order['cartType'] == 'cart')
            Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        color: Colors.grey[100],
                        child: Padding(
                          padding: EdgeInsets.all(10.0.sp),
                          child: Txt(
                            text: 'DELIVERY DETAILS',
                            fsize: 12,
                            color: Colors.grey[400]!,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                ListTile(
                  title: Txt(
                    text: 'Customer name',
                    fsize: 12,
                    weight: FontWeight.w600,
                  ),
                  subtitle: Txt(
                    text: order['clientDetail']['selectedAddress']['name'],
                    fsize: 12,
                    color: Colors.grey[400]!,
                  ),
                ),
                ListTile(
                  title: Txt(
                    text: 'Phone number',
                    fsize: 12,
                    weight: FontWeight.w600,
                  ),
                  subtitle: Txt(
                    text: order['clientDetail']['phone_no'],
                    fsize: 12,
                    color: Colors.grey[400]!,
                  ),
                ),
                ListTile(
                  title: Txt(
                    text: 'Deliver to',
                    fsize: 12,
                    weight: FontWeight.w600,
                  ),
                  subtitle: Txt(
                    text:
                        '${order['clientDetail']['selectedAddress']['door_no']}, ${order['clientDetail']['selectedAddress']['street']}, ${order['clientDetail']['selectedAddress']['city']}, ${order['clientDetail']['selectedAddress']['pincode']}, Landmark:${order['clientDetail']['selectedAddress']['landmark']}',
                    fsize: 12,
                    color: Colors.grey[400]!,
                  ),
                ),
              ],
            ),
          SizedBox(
            height: 30.sp,
          )
        ],
      ),
    );
  }
}
