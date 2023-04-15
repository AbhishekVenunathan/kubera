import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kubera/controller/init.dart';
import 'package:kubera/widgets/appbar.dart';
import 'package:kubera/widgets/text.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class NotificationView extends StatelessWidget {
  NotificationView({Key? key}) : super(key: key);
  final InitCon icon = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: BaseAppBar(
          backicon: true,
          title: 'Notification',
        ),
        body: Obx(
          () => icon.notifications.isEmpty
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(0.0.sp),
                      child: Image.asset('assets/empty_noti.png', height: 150),
                    ),
                    SizedBox(
                      height: 20.sp,
                    ),
                    Center(
                      child: Txt(
                        text: "You have’nt received any notifications yet.",
                        fsize: 11,
                      ),
                    ),
                  ],
                )
              : ListView.builder(
                  itemCount: icon.notifications.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      trailing: Txt(
                        text:
                            icon.notifications[index]['dateString'].toString(),
                        color: Colors.grey[400]!,
                        fsize: 13,
                        defalutsize: true,
                      ),
                      leading: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Get.theme.primaryColor),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: icon.notifications[index]['description']
                                    .toString()
                                    .contains('Book')
                                ? SvgPicture.asset(
                                    'assets/Document.svg',
                                    color: Colors.white,
                                    height: 26,
                                  )
                                : SvgPicture.asset('assets/Wallet.svg',
                                    color: Colors.white),
                          )),
                      title: Txt(
                        text:
                            icon.notifications[index]['description'].toString(),
                        fsize: 11,
                        weight: FontWeight.w600,
                      ),
                    );
                  },
                ),
        ));
  }
}
