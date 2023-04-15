import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../widgets/appbar.dart';
import '../../widgets/text.dart';
import 'bank_transfer.dart';

class SavedPayment extends StatelessWidget {
  const SavedPayment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        backicon: true,
        title: 'Payments',
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.sp),
        child: Column(
          children: [
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
                padding: EdgeInsets.symmetric(vertical: 2.sp, horizontal: 5.sp),
                child: ListTile(
                  onTap: () {
                    Get.to(() => BankTransfer());
                  },
                  contentPadding: EdgeInsets.all(0),
                  leading: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset('assets/person.png'),
                  ),
                  minLeadingWidth: -3,
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
                          text: 'Bank transfer ',
                          fsize: 12,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
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
                padding: EdgeInsets.symmetric(vertical: 2.sp, horizontal: 5.sp),
                child: ListTile(
                  onTap: () {
                    // Get.to(() => AddBankView());
                  },
                  contentPadding: EdgeInsets.all(0),
                  leading: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset('assets/person.png'),
                  ),
                  minLeadingWidth: -3,
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
                          text: 'UPI ID ',
                          fsize: 12,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
