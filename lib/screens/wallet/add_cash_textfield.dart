import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:kubera/controller/init.dart';
import 'package:kubera/widgets/textfield.dart';
import 'package:sizer/sizer.dart';

import '../../widgets/text.dart';

class AddCashEntryView extends StatelessWidget {
  AddCashEntryView({Key? key}) : super(key: key);
  final TextEditingController _controller = TextEditingController();
  final InitCon icon = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: IconButton(
              onPressed: () => Get.back(),
              icon: const Icon(
                Icons.clear,
                color: Colors.black,
              )),
          centerTitle: true,
          elevation: 0,
          title: const Txt(
            text: 'Add Cash',
            defalutsize: true,
            weight: FontWeight.bold,
          )),
      body: Padding(
        padding: EdgeInsets.all(10.0.sp),
        child: Column(
          children: [
            Expanded(
                child: ListView(
              children: [
                SizedBox(
                  height: 20.sp,
                ),
                Txt(
                  text: 'How much do you want\nto transfer to wallet?',
                  iscenter: true,
                  fsize: 14,
                  weight: FontWeight.bold,
                ),
                SizedBox(
                  height: 20.sp,
                ),
                CTextField(
                    controller: _controller,
                    max: 6,
                    autoFocus: true,
                    isAlignCenter: true,
                    keyboard: TextInputType.number),
                SizedBox(
                  height: 20.sp,
                ),
              ],
            )),
            Row(
              children: [
                Expanded(
                  child: CupertinoButton(
                      color: Get.theme.primaryColor,
                      child: const Txt(
                        text: 'Continue',
                        color: Colors.white,
                        weight: FontWeight.bold,
                        defalutsize: true,
                      ),
                      onPressed: () {
                        if (_controller.text.isEmpty) {
                          Fluttertoast.showToast(msg: 'Enter valid amount');
                        } else {
                          icon.addCashReq(_controller.text);
                        }
                      }),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

var constamount = ['100', '250', '500', '1000', '1500', '2000'];
