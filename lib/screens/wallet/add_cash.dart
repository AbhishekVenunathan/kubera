import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:kubera/controller/init.dart';
import 'package:sizer/sizer.dart';

import '../../widgets/text.dart';
import 'add_cash_textfield.dart';

var seleted = -1;
var selectedAmount = '';

class AddCashView extends StatefulWidget {
  AddCashView({Key? key}) : super(key: key);

  @override
  State<AddCashView> createState() => _AddCashViewState();
}

final InitCon icon = Get.find();

class _AddCashViewState extends State<AddCashView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                GridView.builder(
                    itemCount: constamount.length,
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: MediaQuery.of(context).size.width /
                            (MediaQuery.of(context).size.height / 3),
                        crossAxisCount: 3),
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              seleted = index;
                              selectedAmount = constamount[index];
                              print(selectedAmount);
                            });
                          },
                          child: Container(
                            child: Center(
                              child: Txt(
                                text: '₹ ${constamount[index]}',
                                fsize: 12,
                              ),
                            ),
                            decoration: BoxDecoration(
                                color: seleted == index
                                    ? Colors.white
                                    : Colors.grey[200],
                                border: Border.all(
                                    color: seleted == index
                                        ? Get.theme.primaryColor
                                        : Colors.transparent),
                                borderRadius: BorderRadius.circular(10.sp)),
                          ),
                        ),
                      );
                    }),
                SizedBox(
                  height: 20.sp,
                ),
                InkWell(
                  onTap: () {
                    Get.to(() => AddCashEntryView());
                  },
                  child: Container(
                    height: 60,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Txt(
                          text: 'A Different Amount',
                          fsize: 12,
                        )
                      ],
                    ),
                    decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(10.sp)),
                  ),
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
                        if (seleted == -1) {
                          Fluttertoast.showToast(msg: 'Choose amount');
                        } else {
                          icon.addCashReq(selectedAmount);
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
