import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kubera/controller/auth.dart';
import 'package:kubera/screens/more/reasons.dart';
import 'package:kubera/widgets/appbar.dart';
import 'package:kubera/widgets/text.dart';
import 'package:sizer/sizer.dart';

import '../../controller/init.dart';
import '../../widgets/textfield.dart';

class RefundReqView extends StatefulWidget {
  final ItemData;
  RefundReqView({Key? key, this.ItemData}) : super(key: key);

  @override
  State<RefundReqView> createState() => _RefundReqViewState();
}

class _RefundReqViewState extends State<RefundReqView> {
  final TextEditingController con = TextEditingController();

  final InitCon icon = Get.find();
  final AuthCon acon = Get.find();
  @override
  void dispose() {
    // TODO: implement dispose
    icon.showrefundlist.clear();
    acon.refundPicsList.clear();
    acon.refundPicKey = '';
    acon.refundPicUrl.value = '';
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: BaseAppBar(
        backicon: true,
        title: 'Refund Request',
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Stack(
          children: [
            ListView(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Container(
                    //   height: 85,
                    //   width: 85,
                    //   child: ClipRRect(
                    //     borderRadius: BorderRadius.circular(8.sp),
                    //     child: Image.network(
                    //       'https://source.unsplash.com/random?sig=0',
                    //       fit: BoxFit.cover,
                    //       height: 85,
                    //       width: 85,
                    //     ),
                    //   ),
                    // ),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Txt(
                          text: 'Order ID: ' + widget.ItemData['orderId'],
                          weight: FontWeight.bold,
                          lines: 2,
                          fsize: 10,
                        ),
                        SizedBox(
                          height: 5.sp,
                        ),
                        Txt(
                          text: 'Items: ' +
                              widget.ItemData['productCount'].toString(),
                          fsize: 9,
                          lines: 1,
                          color: Colors.grey[400]!,
                        ),
                        SizedBox(
                          height: 5.sp,
                        ),
                        Txt(
                          text: '₹ ${widget.ItemData['total']}',
                          fsize: 11,
                          lines: 1,
                          color: Get.theme.primaryColor,
                          weight: FontWeight.bold,
                        )
                      ],
                    ),
                  ],
                ),
                ListView.builder(
                  itemCount: widget.ItemData['products'].length,
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
                                text:
                                    '${widget.ItemData['products'][index]['count']}x ',
                                fsize: 10,
                              ),
                            ),
                            Stack(
                              // overflow: Overflow.visible,

                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8.sp),
                                  child: Image.network(
                                    widget.ItemData['products'][index]
                                        ['book_cover_file_url'],
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
                                        text: widget.ItemData['products'][index]
                                            ['book_name'],
                                        weight: FontWeight.bold,
                                        lines: 2,
                                        fsize: 12,
                                      ),
                                      Txt(
                                        text: widget.ItemData['products'][index]
                                            ['book_name'],
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
                                            text: widget.ItemData['cartType'] ==
                                                    'cart'
                                                ? '₹ ${widget.ItemData['products'][index]['paperBookPrice']}'
                                                : '₹ ${widget.ItemData['products'][index]['e_book_price']}',
                                            fsize: 12,
                                            weight: FontWeight.bold,
                                            color: Get.theme.primaryColor,
                                          ),
                                          // if (widget.ItemData['cartType'] ==
                                          //     'cart')
                                          InkWell(
                                            onTap: () {
                                              if (!widget.ItemData['products']
                                                  [index]['isCancelled']) {
                                                print('sss' +
                                                    widget.ItemData.toString());
                                                Get.to(() => ResonPicRefundView(
                                                      itemData: widget.ItemData[
                                                          'products'][index],
                                                      id: widget
                                                          .ItemData['_id'],
                                                    ));
                                              }
                                            },
                                            child: Txt(
                                              text: widget.ItemData['products']
                                                      [index]['isCancelled']
                                                  ? 'Refund Requested'
                                                  : widget.ItemData[
                                                              'cartType'] ==
                                                          'cart'
                                                      ? 'Eligible>'
                                                      : 'Ebook not eligible for refund',
                                              fsize: widget.ItemData['products']
                                                      [index]['isCancelled']
                                                  ? 10
                                                  : 8,
                                              weight:
                                                  widget.ItemData['products']
                                                          [index]['isCancelled']
                                                      ? FontWeight.bold
                                                      : FontWeight.normal,
                                              color: widget.ItemData['products']
                                                      [index]['isCancelled']
                                                  ? Colors.red
                                                  : Colors.red,
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
                SizedBox(
                  height: 25,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
