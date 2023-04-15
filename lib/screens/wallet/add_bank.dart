import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kubera/controller/init.dart';
import 'package:kubera/widgets/text.dart';
import 'package:sizer/sizer.dart';

import '../../widgets/textfield.dart';

class AddBankView extends StatelessWidget {
  final bool isUpdate;
  AddBankView({Key? key, this.isUpdate = false}) : super(key: key);
  final FocusNode _passwordEmail = FocusNode();
  final ScrollController _scrollController = ScrollController();
  final InitCon icon = Get.find();
  @override
  Widget build(BuildContext context) {
    // if (MediaQuery.of(context).viewInsets.bottom != 0) {
    //   _scrollController.animateTo(
    //     0.0,
    //     curve: Curves.easeOut,
    //     duration: const Duration(milliseconds: 300),
    //   );
    // }
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
      //     text: 'Add bank account',
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
                  // controller: _scrollController,
                  children: [
                    SizedBox(
                      height: 12.sp,
                    ),
                    Row(
                      children: const [
                        Txt(
                          text: 'Account holder name',
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
                            controller: icon.wname,
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
                              hintText: 'Eg.John Doe',
                              label: Text(
                                'Eg.John Doe',
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
                    // CTextField(
                    //   hint: 'Eg.John Doe',
                    //   label: 'Eg.John Doe',
                    //   enabled: true,
                    //   controller: icon.wname,

                    //   // autoFocus: true,
                    // ),
                    SizedBox(
                      height: 12.sp,
                    ),
                    Row(
                      children: const [
                        Txt(
                          text: 'Bank account number',
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
                      hint: 'Eg.144008865432536',
                      label: 'Eg.144008865432536',
                      controller: icon.wacnumber,
                    ),
                    SizedBox(
                      height: 12.sp,
                    ),
                    Row(
                      children: const [
                        Txt(
                          text: 'Re-enter bank account number',
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
                      hint: 'Eg.144008865432536',
                      label: 'Eg.144008865432536',
                      controller: icon.wacrenumber,
                    ),
                    SizedBox(
                      height: 12.sp,
                    ),
                    Row(
                      children: const [
                        Txt(
                          text: 'IFSC code',
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
                      hint: 'Eg.FF14466',
                      label: 'Eg.FF14466',
                      controller: icon.wifsc,
                    ),
                    SizedBox(
                      height: 12.sp,
                    ),
                    Row(
                      children: const [
                        Txt(
                          text: 'Bank name',
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
                      hint: 'Eg.HDFC bank',
                      label: 'Eg.HDFC bank',
                      controller: icon.wbankname,
                    ),
                    SizedBox(
                      height: 12.sp,
                    ),
                    if (MediaQuery.of(context).viewInsets.bottom != 0)
                      SizedBox(
                        height: MediaQuery.of(context).viewInsets.bottom + 10,
                      ),
                  ],
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              if (icon.wname.text.length < 2) {
                Fluttertoast.showToast(msg: 'Enter Valid Name');
              } else if (icon.wacnumber.text.length < 5) {
                Fluttertoast.showToast(msg: 'Enter Valid Account Number');
              } else if (icon.wacnumber.text != icon.wacrenumber.text) {
                Fluttertoast.showToast(msg: 'Enter Correct Account Number');
              } else if (icon.wifsc.text.length < 2) {
                Fluttertoast.showToast(msg: 'Enter Valid IFSC Code');
              } else if (icon.wbankname.text.length < 2) {
                Fluttertoast.showToast(msg: 'Enter Valid IFSC Code');
              } else {
                if (isUpdate) {
                  icon.updateBankAcc();
                } else {
                  icon.addBankAcc();
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
                    text: isUpdate ? 'Update' : 'Submit',
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
