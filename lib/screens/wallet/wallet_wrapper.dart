import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kubera/widgets/text.dart';
import 'package:sizer/sizer.dart';

import 'add_account_tab.dart';
import 'add_bank.dart';
import 'add_upi.dart';

class WalletRapper extends StatelessWidget {
  const WalletRapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: 31.h,
        left: 3.w,
        right: 3.w,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.sp)),
              elevation: 3,
              child: Container(
                height: 50.h,
                width: 90.w,
                child: Padding(
                  padding: EdgeInsets.all(15.0.sp),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Txt(
                            text: 'Get Started',
                            weight: FontWeight.bold,
                          ),
                        ],
                      ),
                      Spacer(),
                      ListTile(
                        onTap: () {
                          Get.to(
                            () => BankMain(index: 0),
                          );
                        },
                        contentPadding: EdgeInsets.all(0),
                        leading: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset('assets/person.png'),
                        ),
                        minLeadingWidth: -3,
                        tileColor: Colors.grey[100],
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.sp)),
                        trailing: Padding(
                          padding: EdgeInsets.all(8.0.sp),
                          child: Icon(Icons.arrow_forward_ios, size: 14.sp),
                        ),
                        title: Transform.translate(
                          offset: Offset(-16, 0),
                          child: Row(
                            children: [
                              Txt(
                                text: 'Add your bank account ',
                                fsize: 9,
                                weight: FontWeight.bold,
                              ),
                              Icon(
                                Icons.info,
                                color: Colors.orange[700],
                                size: 13.sp,
                              )
                            ],
                          ),
                        ),
                      ),
                      Spacer(),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: 0.5,
                              color: Colors.grey,
                            ),
                          ),
                          Txt(
                            text: '  OR  ',
                            fsize: 12,
                            color: Colors.grey[400]!,
                          ),
                          Expanded(
                            child: Container(
                              height: 0.5,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                      Spacer(),
                      ListTile(
                        onTap: () {
                          Get.to(
                            () => BankMain(index: 1),
                          );
                        },
                        contentPadding: EdgeInsets.all(0),
                        leading: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset('assets/person.png'),
                        ),
                        minLeadingWidth: -3,
                        tileColor: Colors.grey[100],
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.sp)),
                        trailing: Padding(
                          padding: EdgeInsets.all(8.0.sp),
                          child: Icon(Icons.arrow_forward_ios, size: 14.sp),
                        ),
                        title: Transform.translate(
                          offset: Offset(-16, 0),
                          child: Row(
                            children: [
                              Txt(
                                text: 'Add UPI ID account ',
                                fsize: 9,
                                weight: FontWeight.bold,
                              ),
                              Icon(
                                Icons.info,
                                color: Colors.orange[700],
                                size: 13.sp,
                              )
                            ],
                          ),
                        ),
                      ),
                      Spacer(),
                      Spacer()
                    ],
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
