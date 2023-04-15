import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:kubera/controller/init.dart';
import 'package:kubera/widgets/text.dart';
import 'package:kubera/widgets/textfield.dart';
import 'package:sizer/sizer.dart';

import '../../widgets/appbar.dart';

class HelpNFeedView extends StatelessWidget {
  HelpNFeedView({Key? key}) : super(key: key);
  final TextEditingController con = TextEditingController();
  final InitCon icon = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        backicon: true,
        title: 'Help & Feedback',
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          children: [
            Txt(
              text: 'Enter Feed:',
              fsize: 12,
              weight: FontWeight.bold,
            ),
            CTextField(
              controller: con,
              maxlines: 5,
              // hint: 'Enter some feed',
              label: 'Enter some feed',
            ),
            SizedBox(
              height: 10.sp,
            ),
            Row(
              children: [
                Expanded(
                  child: CupertinoButton(
                      color: Get.theme.primaryColor,
                      child: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 3.5),
                        child: Txt(
                          text: 'Send',
                          color: Colors.white,
                          weight: FontWeight.bold,
                          defalutsize: true,
                        ),
                      ),
                      onPressed: () {
                        if (con.text.isEmpty) {
                          Fluttertoast.showToast(msg: 'Enter Feedback!');
                        } else {
                          icon.addFeedback(con.text);
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
