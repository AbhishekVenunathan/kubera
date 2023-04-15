import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../text.dart';

class HeadTxt extends StatelessWidget {
  final String txt;
  final VoidCallback ontap;
  final bool isviewall;
  final String viewalltxt;
  final double padd;
  HeadTxt(
      {Key? key,
      this.txt = '',
      required this.ontap,
      this.isviewall = false,
      this.padd = 8.0,
      this.viewalltxt = 'View all'})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: padd.sp),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Txt(
            text: txt,
            fsize: 14,
            weight: FontWeight.bold,
          ),
          isviewall
              ? InkWell(
                  onTap: ontap,
                  child: Txt(
                    text: viewalltxt,
                    fsize: 11,
                    weight: FontWeight.bold,
                    color: Get.theme.primaryColor,
                  ),
                )
              : const SizedBox()
        ],
      ),
    );
  }
}
