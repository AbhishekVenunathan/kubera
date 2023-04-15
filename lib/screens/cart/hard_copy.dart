import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kubera/controller/init.dart';
import 'package:kubera/widgets/bottom_navigation.dart';

import '../../widgets/text.dart';
import 'package:sizer/sizer.dart';

import '../more/add_address.dart';
import '../more/address.dart';

class HardCopyView extends StatefulWidget {
  HardCopyView({Key? key}) : super(key: key);

  @override
  State<HardCopyView> createState() => _HardCopyViewState();
}

class _HardCopyViewState extends State<HardCopyView> {
  final InitCon icon = Get.find();
  var count = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Obx(
      () => Stack(
        children: [
          ListView(
            children: [
              SizedBox(
                height: 15.sp,
              ),
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
              icon.mycart['itemsCount'] == 0
                  ? Container(
                      height: 100,
                      child: Center(
                          child: Txt(
                        text: 'No Items Found',
                      )))
                  : ListView.builder(
                      itemCount: icon.mycart['items'].length,
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        final item = icon.mycart['items'][index];
                        int countint = item['count'];
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
                                Stack(
                                  // overflow: Overflow.visible,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(8.sp),
                                      child: Image.network(
                                        item['book_cover_file_url'],
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Txt(
                                            text: item['book_name'],
                                            weight: FontWeight.bold,
                                            lines: 2,
                                            fsize: 12,
                                          ),
                                          Txt(
                                            text: item['authorDetails'][0]
                                                ['author_name'],
                                            fsize: 11,
                                            color: Colors.grey[400]!,
                                          ),
                                          SizedBox(
                                            height: 3.sp,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Txt(
                                                text:
                                                    '₹ ${item['paperBookPrice']}',
                                                fsize: 12,
                                                weight: FontWeight.bold,
                                                color: Get.theme.primaryColor,
                                              ),
                                              Container(
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            6.sp),
                                                    border: Border.all(
                                                        color: Get
                                                            .theme.primaryColor,
                                                        width: 0.5)),
                                                child: Padding(
                                                  padding:
                                                      EdgeInsets.all(3.0.sp),
                                                  child: Row(
                                                    children: [
                                                      InkWell(
                                                        onTap: () {
                                                          if (countint != 0) {
                                                            countint - 1;
                                                            setState(() {
                                                              icon.addtoCart(
                                                                  item['_id'],
                                                                  -1,
                                                                  iscartscreen:
                                                                      true,
                                                                  type: 'cart');
                                                            });
                                                          } else {
                                                            if (item['count'] ==
                                                                    0 &&
                                                                item['items']
                                                                        .length ==
                                                                    0) {
                                                            } else {}
                                                            countint - 1;
                                                            setState(() {
                                                              icon.addtoCart(
                                                                  item['_id'],
                                                                  -1,
                                                                  iscartscreen:
                                                                      true,
                                                                  type: 'cart');
                                                            });
                                                          }
                                                        },
                                                        child: Icon(
                                                          Icons.remove,
                                                          size: 17.sp,
                                                          color: Get.theme
                                                              .primaryColor,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 8.sp,
                                                      ),
                                                      Txt(
                                                        text:
                                                            countint.toString(),
                                                        fsize: 11,
                                                      ),
                                                      SizedBox(
                                                        width: 8.sp,
                                                      ),
                                                      InkWell(
                                                        onTap: () {
                                                          setState(() {
                                                            // countint = countint++;
                                                            countint + 1;
                                                            print(countint + 1);
                                                            // print(countint + 1);
                                                            icon.addtoCart(
                                                                iscartscreen:
                                                                    true,
                                                                item['_id'],
                                                                1,
                                                                type: 'cart');
                                                          });
                                                        },
                                                        child: Icon(
                                                          Icons.add,
                                                          size: 17.sp,
                                                          color: Get.theme
                                                              .primaryColor,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              )
                                            ],
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
              Container(
                color: Colors.grey[100],
                child: Padding(
                  padding: EdgeInsets.all(10.0.sp),
                  child: Txt(
                    text: 'ADDRESS DETAILS',
                    fsize: 12,
                    color: Colors.grey[400]!,
                  ),
                ),
              ),
              icon.myaddress.toString() != '{}'
                  ? Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 10.sp, horizontal: 10.sp),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                            color: Colors.grey[400]!,
                          ),
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.0),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset: const Offset(
                                  0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(8.0.sp),
                          child: ListTile(
                            trailing: InkWell(
                              onTap: () {
                                Get.to(() => SavedAddress());
                              },
                              child: Txt(
                                text: 'Change',
                                fsize: 11,
                                color: Get.theme.primaryColor,
                              ),
                            ),
                            title: Row(
                              children: [
                                Icon(Icons.location_on,
                                    color: Colors.black, size: 14.sp),
                                SizedBox(
                                  width: 5.sp,
                                ),
                                Txt(
                                  text:
                                      'Deliver to : ${icon.myaddress['type']}',
                                  fsize: 12,
                                  weight: FontWeight.bold,
                                ),
                              ],
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 5.sp,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 3),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Txt(
                                        text: '${icon.myaddress['name']}',
                                        fsize: 10,
                                      ),
                                      SizedBox(
                                        height: 2.sp,
                                      ),
                                      Txt(
                                        text:
                                            'No.${icon.myaddress['door_no']},${icon.myaddress['street']}',
                                        fsize: 11,
                                      ),
                                      SizedBox(
                                        height: 2.sp,
                                      ),
                                      Txt(
                                        text:
                                            '${icon.myaddress['city']} - ${icon.myaddress['pincode']}',
                                        fsize: 10,
                                      ),
                                      SizedBox(
                                        height: 2.sp,
                                      ),
                                      Txt(
                                        text:
                                            'Landmark - ${icon.myaddress['landmark']}',
                                        fsize: 10,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                  : InkWell(
                      onTap: () {
                        Get.to(() => AddAddressView());
                      },
                      child: Container(
                        height: 120.sp,
                        child: Center(
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.sp),
                                border: Border.all(
                                  color: Get.theme.primaryColor,
                                )),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 30.sp, vertical: 10.sp),
                              child: Txt(
                                text: 'Add new address',
                                color: Get.theme.primaryColor,
                                fsize: 13,
                                weight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
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
                padding:
                    EdgeInsets.symmetric(horizontal: 12.sp, vertical: 8.sp),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Txt(
                      text: 'Total quantity',
                      fsize: 13,
                    ),
                    Txt(
                      text: 'x${icon.mycart['itemsCount']}',
                      fsize: 13,
                    ),
                  ],
                ),
              ),
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: 12.sp, vertical: 8.sp),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Txt(
                      text: 'Sub total',
                      fsize: 13,
                    ),
                    Txt(
                      text: '₹ ${icon.mycart['subtotal']}',
                      fsize: 13,
                    ),
                  ],
                ),
              ),
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: 12.sp, vertical: 8.sp),
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
                padding:
                    EdgeInsets.symmetric(horizontal: 12.sp, vertical: 8.sp),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Txt(
                      text: 'GST',
                      fsize: 13,
                    ),
                    Txt(
                      text: '₹ ${icon.mycart['gstAmount']}',
                      fsize: 13,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 100.sp,
              )
            ],
          ),
        ],
      ),
    ));
  }
}
