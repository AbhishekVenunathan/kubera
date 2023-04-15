import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:iconsax/iconsax.dart';
import 'package:kubera/controller/auth.dart';
import 'package:sizer/sizer.dart';

import '../../controller/init.dart';
import '../../widgets/appbar.dart';
import '../../widgets/text.dart';

class SwitchUServView extends StatelessWidget {
  SwitchUServView({Key? key}) : super(key: key);
  final InitCon icon = Get.find();
  final AuthCon acon = Get.find();
  var localUsers = GetStorage().read('localusers');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        backicon: true,
        title: 'Switch User',
        isSwitchUser: true,
      ),
      body: ListView.builder(
          itemCount: 3,
          itemBuilder: ((context, index) {
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 4.sp, horizontal: 8.sp),
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
                      offset: const Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Padding(
                  padding: EdgeInsets.all(8.0.sp),
                  child: ListTile(
                    onTap: () {
                      acon.signup(
                          localUsers[index]['name'],
                          localUsers[index]['email'],
                          localUsers[index]['phone_no'],
                          localUsers[index]['city'],
                          isGoogle:
                              localUsers[index]['phone_no'].toString() == 'null'
                                  ? true
                                  : false);
                    },
                    leading: Icon(
                      Icons.radio_button_checked,
                      // color: icon.userData[0]['email'] ==
                      //         localUsers[index]['email']
                      //     ? Get.theme.primaryColor
                      //     : Colors.transparent,
                    ),
                    title: Transform(
                      transform: Matrix4.translationValues(-16, 0.0, 0.0),
                      child: Txt(
                        text: 'name',
                        // text: localUsers[index]['name'],
                        fsize: 12,
                        weight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Transform(
                      transform: Matrix4.translationValues(-16, 0.0, 0.0),
                      child: Txt(
                        text: 'email',
                        fsize: 10,
                        color: Colors.grey[400]!,
                      ),
                    ),
                  ),
                ),
              ),
            );
          })),
    );
  }
}
