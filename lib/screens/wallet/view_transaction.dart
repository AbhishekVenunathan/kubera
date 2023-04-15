import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kubera/controller/init.dart';
import 'package:kubera/screens/wallet/view_all.dart';
import 'package:kubera/widgets/home/view_text.dart';
import 'package:kubera/widgets/text.dart';
import 'package:sizer/sizer.dart';

class ViewTransaction extends StatefulWidget {
  ViewTransaction({Key? key}) : super(key: key);

  @override
  State<ViewTransaction> createState() => _ViewTransactionState();
}

class _ViewTransactionState extends State<ViewTransaction> {
  final InitCon icon = Get.find();

  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: 31.h,
        left: 3.w,
        right: 3.w,
        bottom: -10,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.sp),
                topRight: Radius.circular(20.sp),
              )),
              elevation: 3,
              child: Container(
                width: 90.w,
                child: Padding(
                  padding: EdgeInsets.all(15.0.sp),
                  child: Column(
                    children: [
                      HeadTxt(
                        ontap: () {
                          icon.translist.clear();
                          icon.getTrasaction(type: 'credit');
                          Get.to(() => ViewAllView());
                        },
                        padd: 0,
                        txt: 'View transaction',
                        isviewall: true,
                      ),
                      Obx(
                        () => Expanded(
                          child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: icon.translist.length,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  contentPadding: EdgeInsets.all(0),
                                  trailing: Txt(
                                    text:
                                        '₹ ${icon.translist[index]['amount']}',
                                    fsize: 12,
                                    color: Colors.green,
                                    weight: FontWeight.bold,
                                  ),
                                  leading: CircleAvatar(
                                    radius: 18.sp,
                                    backgroundColor: icon.translist[index]
                                                ['type'] ==
                                            'Captured'
                                        ? Get.theme.primaryColor
                                        : Colors.red,
                                    child: Icon(
                                      icon.translist[index]['type'] ==
                                              'Captured'
                                          ? Icons.call_made_sharp
                                          : Icons.call_received_sharp,
                                      color: Colors.white,
                                      size: 16.sp,
                                    ),
                                  ),
                                  title: Txt(
                                    text: icon.translist[index]['type'] ==
                                            'Captured'
                                        ? 'Withdraw'
                                        : icon.translist[index]['type'],
                                    weight: FontWeight.bold,
                                    fsize: 12,
                                  ),
                                  subtitle: Txt(
                                    text: icon.translist[index]['dateString']
                                        .toString(),
                                    fsize: 11,
                                  ),
                                );
                              }),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
