import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kubera/widgets/text.dart';
import 'package:lottie/lottie.dart';

class DialogWidget extends StatelessWidget {
  final String? title, icon, subtile, btntext;
  final VoidCallback? btnTap;
  const DialogWidget(
      {Key? key,
      this.title,
      this.icon,
      this.subtile,
      this.btntext,
      this.btnTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Center(
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(15)),
          height: 280,
          width: 280,
          child: Padding(
            padding: EdgeInsets.only(top: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Container(
                      height: 100,
                      width: 100,
                      child: Lottie.asset(icon!, repeat: false),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Txt(
                      text: title!,
                      defalutsize: true,
                      fsize: 14,
                      weight: FontWeight.bold,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Txt(
                        text: subtile!,
                        defalutsize: true,
                        fsize: 14,
                        iscenter: true,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Container(
                      height: 0.5,
                      color: Colors.grey,
                    ),
                    InkWell(
                      onTap: btnTap,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 13),
                        child: Txt(
                          text: btntext!,
                          defalutsize: true,
                          fsize: 14,
                          color: Get.theme.primaryColor,
                          weight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
