import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:kubera/controller/init.dart';
import 'package:kubera/widgets/appbar.dart';
import 'package:sizer/sizer.dart';

import '../../widgets/text.dart';
import '../../widgets/textfield.dart';

class PersonalDetails extends StatelessWidget {
  PersonalDetails({Key? key}) : super(key: key);
  final TextEditingController _controller = TextEditingController();
  final InitCon icon = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: BaseAppBar(
        backicon: true,
        title: 'Personal Details',
      ),
      body: Stack(
        children: [
          ListView(
            children: [
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: 10.sp, vertical: 8.sp),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: const [
                        Txt(
                          text: 'Name',
                          fsize: 11,
                        ),
                      ],
                    ),
                    CTextField(
                      hint: 'Enter your name',
                      label: 'Enter your name',
                      controller: icon.pname,
                    ),
                    SizedBox(
                      height: 12.sp,
                    ),
                    const Txt(
                      text: 'City',
                      fsize: 11,
                    ),
                    CTextField(
                      hint: 'Enter city',
                      label: 'Enter city',
                      controller: icon.pcity,
                    ),
                    SizedBox(
                      height: 12.sp,
                    ),
                    const Txt(
                      text: 'Email',
                      fsize: 11,
                    ),
                    CTextField(
                      hint: 'eg:mohan@kuberaa.com (Optional)',
                      label: 'eg:mohan@kuberaa.com (Optional)',
                      controller: icon.pemail,
                    ),
                    SizedBox(
                      height: 12.sp,
                    ),
                    const Txt(
                      text: 'phone number',
                      fsize: 11,
                    ),
                    CTextField(
                      hint: '+919876543210',
                      label: '+919876543210',
                      controller: icon.pphone,
                      enabled: icon.pphone.text.isEmpty ||
                              icon.pphone.text.length != 10
                          ? true
                          : false,
                    ),
                  ],
                ),
              )
            ],
          ),
          Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: InkWell(
                onTap: () {
                  if (icon.pname.text.isEmpty || icon.pcity.text.isEmpty) {
                    Fluttertoast.showToast(msg: 'Empty fields not allowed');
                  } else {
                    icon.profileUpdate();
                  }
                },
                child: Container(
                  height: kToolbarHeight,
                  color: Get.theme.primaryColor,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Txt(
                        text: 'Update',
                        weight: FontWeight.bold,
                        color: Colors.white,
                        defalutsize: true,
                      )
                    ],
                  ),
                ),
              ))
        ],
      ),
    );
  }
}
