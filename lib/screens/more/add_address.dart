import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:kubera/controller/init.dart';
import 'package:sizer/sizer.dart';

import '../../widgets/appbar.dart';
import '../../widgets/text.dart';
import '../../widgets/textfield.dart';

class AddAddressView extends StatelessWidget {
  final bool isEdit;
  AddAddressView({Key? key, this.isEdit = false}) : super(key: key);
  final TextEditingController _con = TextEditingController();
  final InitCon icon = Get.find();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: BaseAppBar(
            backicon: true,
            title: isEdit ? 'Update address' : 'Add address',
          ),
          body: Obx(
            () => Padding(
              padding: EdgeInsets.all(8.0.sp),
              child: Column(
                children: [
                  Expanded(
                    child: ListView(
                      children: [
                        SizedBox(
                          height: 12.sp,
                        ),
                        Row(
                          children: const [
                            Txt(
                              text: 'Name',
                              fsize: 11,
                            ),
                            Txt(
                              text: ' *',
                              fsize: 12,
                              color: Colors.red,
                            ),
                          ],
                        ),
                        CTextField(
                          hint: 'Enter your name',
                          label: 'Enter your name',
                          controller: icon.name,
                        ),
                        SizedBox(
                          height: 12.sp,
                        ),
                        Row(
                          children: const [
                            Txt(
                              text: 'Door no/Building name',
                              fsize: 11,
                            ),
                            Txt(
                              text: ' *',
                              fsize: 12,
                              color: Colors.red,
                            ),
                          ],
                        ),
                        CTextField(
                          hint: 'Enter Door no',
                          label: 'Enter Door no',
                          controller: icon.doorno,
                        ),
                        SizedBox(
                          height: 12.sp,
                        ),
                        Row(
                          children: const [
                            Txt(
                              text: 'Street name',
                              fsize: 11,
                            ),
                            Txt(
                              text: ' *',
                              fsize: 12,
                              color: Colors.red,
                            ),
                          ],
                        ),
                        CTextField(
                          hint: 'Enter street name',
                          label: 'Enter street name',
                          controller: icon.streetname,
                        ),
                        SizedBox(
                          height: 12.sp,
                        ),
                        Row(
                          children: const [
                            Txt(
                              text: 'City',
                              fsize: 11,
                            ),
                            Txt(
                              text: ' *',
                              fsize: 12,
                              color: Colors.red,
                            ),
                          ],
                        ),
                        CTextField(
                          hint: 'Enter city name',
                          label: 'Enter city name',
                          controller: icon.city,
                        ),
                        SizedBox(
                          height: 12.sp,
                        ),
                        Row(
                          children: const [
                            Txt(
                              text: 'Landmark',
                              fsize: 11,
                            ),
                            Txt(
                              text: ' *',
                              fsize: 12,
                              color: Colors.red,
                            ),
                          ],
                        ),
                        CTextField(
                          hint: 'Enter landmark',
                          label: 'Enter landmark',
                          controller: icon.landmark,
                        ),
                        SizedBox(
                          height: 12.sp,
                        ),
                        Row(
                          children: const [
                            Txt(
                              text: 'Pincode',
                              fsize: 11,
                            ),
                            Txt(
                              text: ' *',
                              fsize: 12,
                              color: Colors.red,
                            ),
                          ],
                        ),
                        CTextField(
                          hint: 'Enter pincode',
                          label: 'Enter pincode',
                          controller: icon.pincode,
                        ),
                        if (MediaQuery.of(context).viewInsets.bottom != 0)
                          SizedBox(
                            height:
                                MediaQuery.of(context).viewInsets.bottom + 30,
                          ),
                        SizedBox(
                          height: 12.sp,
                        ),
                        Row(
                          children: const [
                            Txt(
                              text: 'Choose address type',
                              fsize: 11,
                            ),
                            Txt(
                              text: ' *',
                              fsize: 12,
                              color: Colors.red,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 8.sp,
                        ),
                        Row(
                          children: [
                            InkWell(
                              onTap: () {
                                icon.ishome.value = true;
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4.sp),
                                    border: Border.all(
                                        color: icon.ishome.value
                                            ? Get.theme.primaryColor
                                            : Colors.black)),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 8.0.sp, vertical: 4.sp),
                                  child: Row(
                                    children: [
                                      Icon(
                                        CupertinoIcons.home,
                                        size: 12.sp,
                                        color: icon.ishome.value
                                            ? Get.theme.primaryColor
                                            : Colors.black,
                                      ),
                                      SizedBox(
                                        width: 6.sp,
                                      ),
                                      Txt(
                                        text: 'Home',
                                        fsize: 10,
                                        color: icon.ishome.value
                                            ? Get.theme.primaryColor
                                            : Colors.black,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 12.sp,
                            ),
                            InkWell(
                              onTap: () {
                                icon.ishome.value = false;
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4.sp),
                                    border: Border.all(
                                        color: !icon.ishome.value
                                            ? Get.theme.primaryColor
                                            : Colors.black)),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 8.0.sp, vertical: 4.sp),
                                  child: Row(
                                    children: [
                                      Icon(CupertinoIcons.building_2_fill,
                                          size: 12.sp,
                                          color: !icon.ishome.value
                                              ? Get.theme.primaryColor
                                              : Colors.black),
                                      SizedBox(
                                        width: 6.sp,
                                      ),
                                      Txt(
                                          text: 'office',
                                          fsize: 10,
                                          color: !icon.ishome.value
                                              ? Get.theme.primaryColor
                                              : Colors.black)
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 30.sp,
                        )
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: CupertinoButton(
                            color: Get.theme.primaryColor,
                            child: const Txt(
                              text: 'Save address',
                              color: Colors.white,
                              weight: FontWeight.bold,
                              defalutsize: true,
                            ),
                            onPressed: () {
                              if (icon.name.text.isEmpty ||
                                  icon.doorno.text.isEmpty ||
                                  icon.streetname.text.isEmpty ||
                                  icon.city.text.isEmpty ||
                                  icon.pincode.text.isEmpty ||
                                  icon.landmark.text.isEmpty) {
                                Fluttertoast.showToast(msg: 'Fill all fields');
                              } else {
                                if (isEdit) {
                                  icon.editAddress();
                                } else {
                                  icon.addAddress();
                                }
                              }

                              // Get.back();
                            }),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
