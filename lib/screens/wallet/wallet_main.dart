import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:kubera/controller/init.dart';
import 'package:kubera/screens/wallet/wallet_wrapper.dart';
import 'package:kubera/widgets/text.dart';
import 'package:sizer/sizer.dart';

import 'add_bank.dart';
import 'add_cash.dart';
import 'withdraw_cash.dart';
import 'add_upi.dart';
import 'view_transaction.dart';

class WalletMain extends StatefulWidget {
  WalletMain({Key? key}) : super(key: key);

  @override
  State<WalletMain> createState() => _WalletMainState();
}

bool iswrapper = true;
final InitCon icon = Get.find();

class _WalletMainState extends State<WalletMain> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Obx(
      () => Stack(
        children: [
          Column(
            children: [
              Container(
                height: 40.h,
                color: Get.theme.primaryColor,
                child: Stack(
                  children: [
                    Positioned.fill(
                        child: Image.asset(
                      'assets/wallet_bg.png',
                      height: 40.sp,
                      fit: BoxFit.cover,
                    )),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Txt(
                              text: 'My balance ',
                              color: Colors.white,
                              fsize: 14,
                            ),
                            Icon(
                              Icons.info_outline,
                              color: Colors.white,
                              size: 13.sp,
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 2.h),
                          child: Txt(
                            text: '₹ ${icon.userData[0]['amountEarned'] ?? 0}',
                            color: Colors.white,
                            fsize: 18,
                            weight: FontWeight.bold,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () {
                                Get.to(() => AddCashView());
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12.sp),
                                    color: Colors.black.withOpacity(0.2)),
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.all(8.0.sp),
                                      child: Txt(
                                        text: '   Add cash   ',
                                        fsize: 12,
                                        weight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Container(
                                      height: 2.8.h,
                                      color: Colors.white,
                                      width: 0.8,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        if (icon.userData[0]['amountEarned'] ==
                                                null ||
                                            icon.userData[0]['amountEarned'] ==
                                                0) {
                                          Fluttertoast.showToast(
                                              msg: 'Your wallet amount is 0');
                                        } else {
                                          Get.to(
                                            () => WithdrawCashView(),
                                          );
                                        }
                                      },
                                      child: Padding(
                                        padding: EdgeInsets.all(8.0.sp),
                                        child: Txt(
                                          text: '   Withdraw   ',
                                          fsize: 12,
                                          weight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          icon.userData[0]['walletCount'] == 0
              ? WalletRapper()
              : ViewTransaction(),
          Positioned(
              top: 20.sp,
              child: IconButton(
                  onPressed: () => Get.back(),
                  icon: Icon(
                    Icons.arrow_back_ios_new,
                    color: Colors.white,
                    size: 16.sp,
                  ))),
        ],
      ),
    ));
  }
}
