import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kubera/controller/init.dart';
import 'package:kubera/widgets/text.dart';
import 'package:sizer/sizer.dart';

import '../../widgets/textfield.dart';

String? selectedValue;

class AddUPIView extends StatefulWidget {
  final String grpType;
  final bool isUpdate;
  AddUPIView({Key? key, this.grpType = 'grpType', this.isUpdate = false})
      : super(key: key);

  @override
  State<AddUPIView> createState() => _AddUPIViewState();
}

class _AddUPIViewState extends State<AddUPIView> {
  ScrollController _scrollController = ScrollController();

  final InitCon icon = Get.find();

  @override
  Widget build(BuildContext context) {
    if (MediaQuery.of(context).viewInsets.bottom != 0) {
      _scrollController.animateTo(
        0.0,
        curve: Curves.easeOut,
        duration: const Duration(milliseconds: 300),
      );
    }
    return Scaffold(
      resizeToAvoidBottomInset: false,
      // appBar: AppBar(
      //   elevation: 0,
      //   leading: IconButton(
      //       onPressed: () => Get.back(),
      //       icon: Icon(
      //         Icons.arrow_back_ios_new,
      //         color: Colors.black,
      //       )),
      //   backgroundColor: Colors.transparent,
      //   title: Txt(
      //     text: 'Add UPI account',
      //     fsize: 15,
      //     defalutsize: true,
      //     weight: FontWeight.bold,
      //   ),
      // ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              child: Padding(
                padding: EdgeInsets.all(8.0.sp),
                child: ListView(
                  controller: _scrollController,
                  children: [
                    SizedBox(
                      height: 12.sp,
                    ),
                    Row(
                      children: const [
                        Txt(
                          text: 'Phone number',
                          fsize: 11,
                        ),
                        Txt(
                          text: ' *',
                          fsize: 12,
                          color: Colors.red,
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        SizedBox(
                          height: 8.sp,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.grey[200]),
                          child: TextField(
                            autofocus: true,
                            controller: icon.wphone,
                            style: GoogleFonts.nunito(
                                textStyle: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black87,
                                    letterSpacing: .8)),
                            decoration: InputDecoration(
                              counterText: '',

                              fillColor: Colors.grey[100],
                              filled: true,
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,

                              labelStyle: GoogleFonts.nunito(
                                  textStyle: TextStyle(
                                      fontSize: 11.sp,
                                      color: Colors.black,
                                      letterSpacing: .8)),
                              hintStyle: GoogleFonts.nunito(
                                  textStyle: TextStyle(
                                      fontSize: 11.sp,
                                      color: Colors.grey,
                                      letterSpacing: .8)),
                              hintText: 'Eg.9876543210',
                              label: Text(
                                'Eg.9876543210',
                                style: GoogleFonts.nunito(
                                    textStyle: TextStyle(
                                        fontSize: 11.sp,
                                        color: Colors.grey,
                                        letterSpacing: .8)),
                              ),
                              // prefixIcon: !widget.ispreicon
                              //     ? SizedBox()
                              //     : Icon(widget.preicon,
                              //         color: widget.ispreicon
                              //             ? Colors.grey[300]
                              //             : Colors.transparent),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  color: Get.theme.primaryColor,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.grey.withOpacity(0.7)),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              disabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              contentPadding: EdgeInsets.all(14.sp),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 12.sp,
                    ),
                    Row(
                      children: const [
                        Txt(
                          text: 'Enter UPI id',
                          fsize: 11,
                        ),
                      ],
                    ),
                    CTextField(
                      hint: 'Eg.kuberaa@okaxis',
                      label: 'Eg.kuberaa@okaxis',
                      controller: icon.wupi,
                    ),
                    SizedBox(
                      height: 12.sp,
                    ),
                    Row(
                      children: const [
                        Txt(
                          text: 'Choose your wallet',
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
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey, width: 0.5),
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.grey[200]),
                      height: 40.sp,
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton2(
                          hint: Row(
                            children: [
                              Text(
                                '  Choose wallet type',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Theme.of(context).hintColor,
                                ),
                              ),
                            ],
                          ),
                          items: icon.grptypelist
                              .map((item) => DropdownMenuItem<String>(
                                    value: item['group_type_name'],
                                    child: Text(
                                      '   ' + item['group_type_name']!,
                                      style: const TextStyle(
                                        fontSize: 14,
                                      ),
                                    ),
                                  ))
                              .toList(),
                          value: selectedValue,
                          onChanged: (value) {
                            setState(() {
                              print(selectedValue);
                              selectedValue = value as String;
                              icon.wwalletType.text = selectedValue!;
                            });
                          },
                          buttonHeight: 40,
                          buttonWidth: 140,
                          itemHeight: 40,
                          dropdownDecoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            color: Colors.white,
                          ),
                          itemPadding: EdgeInsets.symmetric(horizontal: 10.sp),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              if (icon.wphone.text.length != 10) {
                Fluttertoast.showToast(msg: 'Enter Valid Mobile Number');
              } else if (icon.wwalletType.text.isEmpty) {
                Fluttertoast.showToast(msg: 'Choose Wallet Type');
              } else {
                if (widget.isUpdate) {
                  icon.updateBankAcc(type: 'UPIAccount');
                } else {
                  icon.addBankAcc(type: 'UPIAccount');
                }
              }
            },
            child: Container(
              height: kToolbarHeight,
              color: Get.theme.primaryColor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Txt(
                    text: widget.isUpdate ? 'Update' : 'Submit',
                    weight: FontWeight.bold,
                    color: Colors.white,
                    defalutsize: true,
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
