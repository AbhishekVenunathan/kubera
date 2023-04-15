import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kubera/controller/init.dart';

import '../../widgets/text.dart';
import 'package:sizer/sizer.dart';

class EBookView extends StatefulWidget {
  EBookView({Key? key}) : super(key: key);

  @override
  State<EBookView> createState() => _EBookViewState();
}

class _EBookViewState extends State<EBookView> {
  final InitCon icon = Get.find();

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
              icon.myecart['itemsCount'] == 0
                  ? Container(
                      height: 100,
                      child: Center(
                          child: Txt(
                        text: 'No Items Found',
                      )))
                  : ListView.builder(
                      itemCount: icon.myecart['items'].length,
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        var item = icon.myecart['items'][index];
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
                                                    '₹ ${item['discount_price']}',
                                                fsize: 12,
                                                weight: FontWeight.bold,
                                                color: Get.theme.primaryColor,
                                              ),
                                              IconButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      icon.addtoCart(
                                                          item['_id'], -1,
                                                          iscartscreen: true,
                                                          type: 'eCart');
                                                    });
                                                  },
                                                  icon: Icon(
                                                    CupertinoIcons.delete,
                                                    color: Colors.red,
                                                  ))
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
                      text: 'x${icon.myecart['itemsCount']}',
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
                      text: '₹ ${icon.myecart['subtotal']}',
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
                      text: '₹ ${icon.myecart['gstAmount']}',
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
