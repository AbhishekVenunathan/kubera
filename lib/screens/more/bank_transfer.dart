import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:kubera/controller/init.dart';
import 'package:kubera/screens/wallet/add_bank.dart';
import 'package:kubera/widgets/text.dart';
import 'package:sizer/sizer.dart';

import '../../widgets/appbar.dart';
import '../wallet/add_account_tab.dart';
import '../wallet/add_upi.dart';

class BankTransfer extends StatelessWidget {
  BankTransfer({Key? key}) : super(key: key);
  final InitCon icon = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        backicon: true,
        title: 'Bank Transfer',
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0.sp),
        child: Column(
          children: [
            icon.walletData.isEmpty
                ? Container(
                    height: Get.height - kBottomNavigationBarHeight - 100,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('assets/bank.png'),
                        SizedBox(
                          height: 20.sp,
                        ),
                        Center(
                          child: Txt(
                            text: 'No Data Found',
                          ),
                        ),
                      ],
                    ),
                  )
                : Expanded(
                    child: Obx(
                    () => ListView.builder(
                        itemCount: icon.walletData.length,
                        itemBuilder: ((context, index) {
                          return Padding(
                            padding: EdgeInsets.symmetric(vertical: 4.sp),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10),
                                    bottomLeft: Radius.circular(10),
                                    bottomRight: Radius.circular(10)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.12),
                                    spreadRadius: 5,
                                    blurRadius: 7,
                                    offset: Offset(
                                        0, 3), // changes position of shadow
                                  ),
                                ],
                              ),
                              child: ListTile(
                                trailing: IconButton(
                                    onPressed: () {
                                      icon.bankId.value =
                                          icon.walletData[index]['_id'];
                                      if (icon.walletData[index]
                                              ['accountType'] ==
                                          'bankAccount') {
                                        icon.wname.text = icon.walletData[index]
                                            ['AccountHolderName'];
                                        icon.wacnumber.text =
                                            icon.walletData[index]
                                                ['bankAccountNumber'];
                                        icon.wacrenumber.text =
                                            icon.walletData[index]
                                                ['bankAccountNumber'];
                                        icon.wifsc.text =
                                            icon.walletData[index]['IFSC'];
                                        icon.wbankname.text =
                                            icon.walletData[index]['bankName'];
                                        selectedValue = null;
                                      } else {
                                        icon.wphone.text = icon
                                            .walletData[index]['phoneNumber']
                                            .toString();
                                        icon.wupi.text = icon.walletData[index]
                                                        ['UPIID']
                                                    .toString() ==
                                                'null'
                                            ? ''
                                            : icon.walletData[index]['UPIID']
                                                .toString();
                                        icon.wwalletType.text = icon
                                            .walletData[index]['walletType'];

                                        selectedValue = icon.walletData[index]
                                                    ['walletType'] ==
                                                ''
                                            ? null
                                            : icon.walletData[index]
                                                ['walletType'];
                                      }

                                      Get.to(() => BankMain(
                                            index: icon.walletData[index]
                                                        ['accountType'] ==
                                                    'bankAccount'
                                                ? 0
                                                : 1,
                                            isUpdate: true,
                                            grpType: icon.walletData[index]
                                                    ['walletType']
                                                .toString(),
                                          ));
                                    },
                                    icon: Icon(
                                      Iconsax.edit,
                                      size: 16.sp,
                                      color: Get.theme.primaryColor,
                                    )),
                                // trailing: Container(
                                //   width: 80.sp,
                                //   child: Row(
                                //     children: [
                                //       IconButton(
                                //           onPressed: () {},
                                //           icon: Icon(
                                //             Iconsax.edit,
                                //             size: 16.sp,
                                //             color: Get.theme.primaryColor,
                                //           )),
                                //       // IconButton(
                                //       //     onPressed: () {},
                                //       //     icon: Icon(
                                //       //       Icons.delete_outline_outlined,
                                //       //       size: 16.sp,
                                //       //       color: Colors.red,
                                //       //     )),
                                //     ],
                                //   ),
                                // ),
                                title: Txt(
                                  text: icon.walletData[index]['accountType'] ==
                                          'bankAccount'
                                      ? icon.walletData[index]['bankName']
                                      : icon.walletData[index]['walletType'],
                                  fsize: 12,
                                  weight: FontWeight.bold,
                                ),
                                subtitle: Txt(
                                  text: icon.walletData[index]['accountType'] ==
                                          'bankAccount'
                                      ? '***' +
                                          icon.walletData[index]
                                                  ['bankAccountNumber']
                                              .substring(icon
                                                      .walletData[index]
                                                          ['bankAccountNumber']
                                                      .length -
                                                  3)
                                      : icon.walletData[index]['UPIID']
                                                  .toString() ==
                                              'null'
                                          ? icon.walletData[index]
                                                  ['phoneNumber']
                                              .toString()
                                          : icon.walletData[index]['UPIID']
                                              .toString(),
                                  fsize: 11,
                                  color: Colors.grey[400]!,
                                ),
                              ),
                            ),
                          );
                        })),
                  )),
            Row(
              children: [
                Expanded(
                  child: CupertinoButton(
                      color: Get.theme.primaryColor,
                      child: const Txt(
                        text: 'Add new account',
                        color: Colors.white,
                        weight: FontWeight.bold,
                        defalutsize: true,
                      ),
                      onPressed: () {
                        Get.to(() => BankMain());
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
