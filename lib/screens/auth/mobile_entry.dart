import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:iconsax/iconsax.dart';
import 'package:kubera/controller/auth.dart';
import 'package:kubera/controller/init.dart';
import 'package:kubera/screens/auth/tell_us.dart';
import 'package:kubera/widgets/text.dart';
import 'package:sizer/sizer.dart';

import '../../widgets/icon_text_field.dart';
import '../../widgets/textfield.dart';

class MobileEntryView extends StatefulWidget {
  MobileEntryView({Key? key}) : super(key: key);

  @override
  State<MobileEntryView> createState() => _MobileEntryViewState();
}

class _MobileEntryViewState extends State<MobileEntryView> {
  final TextEditingController _con = TextEditingController();

  final AuthCon acon = Get.find();
  final InitCon icon = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.0.sp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Row(
                  children: [
                    IconButton(
                        onPressed: () => Get.back(),
                        icon: Icon(
                          Icons.arrow_back_ios,
                          color: Colors.black,
                          size: 16.sp,
                        )),
                    const Txt(
                      text: 'Get Started',
                      weight: FontWeight.bold,
                      fsize: 18,
                    )
                  ],
                ),
                SizedBox(
                  height: 20.sp,
                ),
                Row(
                  children: const [
                    Txt(
                      text: 'Mobile Number',
                      fsize: 12,
                    ),
                  ],
                ),
                CTextField(
                  hint: 'Enter phone no',
                  label: 'Enter phone no',
                  controller: acon.mobile,
                  max: 10,
                  keyboard: TextInputType.number,
                  onchage: (o) {
                    print(o);
                    if (o.length == 10) {
                      print('sss');
                      FocusManager.instance.primaryFocus?.unfocus();
                      setState(() {});
                    }
                  },
                ),
                SizedBox(
                  height: 10.sp,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Txt(
                      text: 'or',
                      fsize: 12,
                    ),
                  ],
                ),
                SizedBox(
                  height: 10.sp,
                ),
                InkWell(
                  onTap: () {
                    acon.googleauth();
                  },
                  child: Card(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.sp)),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset:
                                  Offset(0, 3), // changes position of shadow
                            ),
                          ],
                          borderRadius: BorderRadius.circular(8.sp)),
                      height: 40.sp,
                      child: Row(
                        children: [
                          SizedBox(
                            width: 10.sp,
                          ),
                          Padding(
                            padding: EdgeInsets.all(4.0.sp),
                            child: Image.asset('assets/gicon.png',
                                fit: BoxFit.cover),
                          ),
                          SizedBox(
                            width: 10.sp,
                          ),
                          const Txt(
                            text: 'Continue with google',
                            weight: FontWeight.bold,
                            fsize: 12,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 8.0.sp),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Txt(
                        text: 'By continuing you agree to the',
                        fsize: 10,
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Txt(
                        text: 'Terms & Conditions',
                        color: Get.theme.primaryColor,
                        fsize: 10,
                      )
                    ],
                  ),
                  SizedBox(
                    height: 12.sp,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: CupertinoButton(
                            disabledColor:
                                Get.theme.primaryColor.withOpacity(0.6),
                            color: Get.theme.primaryColor,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 3.5),
                              child: const Txt(
                                text: 'Continue',
                                color: Colors.white,
                                weight: FontWeight.bold,
                                defalutsize: true,
                              ),
                            ),
                            onPressed: acon.mobile.text.length != 10
                                ? null
                                : () {
                                    icon.libraryBookList.clear();
                                    icon.mylibbook.clear();
                                    // icon.userData.clear();
                                    icon.walletData.clear();
                                    icon.translist.clear();
                                    icon.libraryCatBookList.clear();
                                    icon.userData.clear();
                                    icon.pname.clear();
                                    icon.pphone.clear();
                                    icon.pcity.clear();
                                    icon.pemail.clear();
                                    if (acon.mobile.text.length != 10) {
                                      Fluttertoast.showToast(
                                          msg: 'Enter valid Mobile');
                                    } else {
                                      acon.isenabled.value = false;
                                      acon.sendotp();
                                    }
                                  }),
                      )
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
