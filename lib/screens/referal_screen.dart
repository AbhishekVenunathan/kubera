import 'dart:async';

import 'package:clipboard/clipboard.dart';
import 'package:dotted_decoration/dotted_decoration.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:kubera/controller/init.dart';
import 'package:kubera/widgets/text.dart';
import 'package:share/share.dart';
import 'package:sizer/sizer.dart';
import 'dart:io';
import 'package:flutter_share_me/flutter_share_me.dart';
import 'package:share/share.dart';

class ReferScreen extends StatefulWidget {
  ReferScreen({Key? key}) : super(key: key);

  @override
  State<ReferScreen> createState() => _ReferScreenState();
}

class _ReferScreenState extends State<ReferScreen> {
  final InitCon icon = Get.find();
  bool _enabled = true;

  void _onTap(code) {
    setState(() => _enabled = false);
    Share.share(
      'Use this code $code join Kuberaa and earn money!!',
      subject: 'Check it out Kubera app',
    );
    Timer(Duration(seconds: 1), () => setState(() => _enabled = true));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            ListView(
              children: [
                Container(
                  child: Padding(
                    padding: EdgeInsets.all(10.0.sp),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            InkWell(
                              onTap: () {
                                Get.back();
                              },
                              child: Icon(
                                Icons.arrow_back_ios_new,
                                color: Colors.transparent,
                                size: 16.sp,
                              ),
                            )
                          ],
                        ),
                        Container(
                          height: 24.h,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              const Txt(
                                text: 'For each referral you  will get',
                                fsize: 10,
                                color: Colors.white,
                              ),
                              const Txt(
                                text: '1 refferal = Rs.15/-',
                                weight: FontWeight.bold,
                                color: Colors.white,
                              ),
                              Padding(
                                padding:
                                    EdgeInsets.symmetric(horizontal: 20.sp),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Column(
                                      children: [
                                        CircleAvatar(
                                          radius: 22.sp,
                                          backgroundColor: Colors.green[200],
                                          child: Image.asset(
                                              'assets/person.png',
                                              fit: BoxFit.cover),
                                        ),
                                        SizedBox(
                                          height: 8.sp,
                                        ),
                                        Txt(
                                          text: 'Refer a\nfriend',
                                          fsize: 9,
                                          color: Colors.white,
                                          iscenter: true,
                                        ),
                                      ],
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Icon(
                                          CupertinoIcons.arrow_right,
                                          color: Colors.white,
                                          size: 16.sp,
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        CircleAvatar(
                                          radius: 22.sp,
                                          backgroundColor: Colors.green[200],
                                          child: Image.asset(
                                              'assets/mobile.png',
                                              fit: BoxFit.cover),
                                        ),
                                        SizedBox(
                                          height: 8.sp,
                                        ),
                                        Txt(
                                          text: 'Rs.15/- on\nJoining',
                                          fsize: 9,
                                          color: Colors.white,
                                          iscenter: true,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  height: 33.h,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [
                          const Color(0xFF21A557),
                          const Color(0xFF4FAE76),
                        ],
                        begin: const FractionalOffset(0.0, 0.0),
                        end: const FractionalOffset(1.0, 0.0),
                        stops: [0.0, 1.0],
                        tileMode: TileMode.clamp),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.sp),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 15.sp),
                        child: const Txt(
                          text: 'How it works',
                          fsize: 11,
                          weight: FontWeight.bold,
                        ),
                      ),
                      Stack(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(left: 13, top: 50),
                            width: 2,
                            height: 170,
                            color: Colors.grey[300],
                          ),
                          Column(
                            children: [
                              statusWidget(
                                  'Send your referral code to your friend',
                                  false),
                              statusWidget(
                                  'If your friend successfully use your\nreferal code,you can get Rs 15/- on\nyour wallet',
                                  false),
                              statusWidget(
                                  'You can transfer the wallet amount to \nyour bank account',
                                  false),
                            ],
                          ),
                        ],
                      ),
                      Txt(
                        text: 'REFERAL CODE',
                        fsize: 11,
                        color: Colors.grey[700]!,
                      ),
                      SizedBox(
                        height: 10.sp,
                      ),
                      Container(
                          decoration: DottedDecoration(
                              shape: Shape.box,
                              borderRadius: BorderRadius.circular(15.sp)),
                          child: InkWell(
                            onTap: () {
                              if (icon.userData[0]['kubera_id'].toString() !=
                                  'null') {
                                FlutterClipboard.copy(icon.userData[0]
                                            ['kubera_id']
                                        .toString())
                                    .then((value) {
                                  Fluttertoast.showToast(msg: 'Copied');
                                });
                              }
                            },
                            child: Container(
                              height: 10.h,
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20.0.sp, vertical: 10.sp),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            if (icon.userData[0]['kubera_id']
                                                    .toString() !=
                                                'null') {
                                              FlutterClipboard.copy(icon
                                                      .userData[0]['kubera_id']
                                                      .toString())
                                                  .then((value) {
                                                Fluttertoast.showToast(
                                                    msg: 'Copied');
                                              });
                                            }
                                          },
                                          child: Txt(
                                            text: 'Tap to copy',
                                            fsize: 11,
                                            color: Colors.grey[400]!,
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            if (icon.userData[0]['kubera_id']
                                                    .toString() !=
                                                'null') {
                                              FlutterClipboard.copy(icon
                                                      .userData[0]['kubera_id']
                                                      .toString())
                                                  .then((value) {
                                                Fluttertoast.showToast(
                                                    msg: 'Copied');
                                              });
                                            }
                                          },
                                          child: Txt(
                                            text: icon.userData[0]['kubera_id']
                                                        .toString() ==
                                                    'null'
                                                ? 'Purchase book to get code'
                                                : icon.userData[0]['kubera_id']
                                                    .toString(),
                                            fsize: 12,
                                          ),
                                        )
                                      ],
                                    ),
                                    InkWell(
                                      onTap: () async {
                                        if (icon.userData[0]['kubera_id']
                                                .toString() !=
                                            'null') {
                                          onButtonTap(Share1.whatsapp);
                                        }
                                      },
                                      child: Image.asset(
                                        'assets/whatsapplogo.png',
                                        fit: BoxFit.cover,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              decoration: BoxDecoration(
                                  color: Colors.grey[100],
                                  borderRadius: BorderRadius.circular(15.sp)),
                            ),
                          )),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 20.sp),
                        child: InkWell(
                          onTap: () {
                            if (icon.userData[0]['kubera_id'].toString() !=
                                'null') {
                              if (_enabled)
                                _onTap(
                                    icon.userData[0]['kubera_id'].toString());
                            }
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(
                                  color: Get.theme.primaryColor,
                                ),
                                borderRadius: BorderRadius.circular(10.sp)),
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 12.sp),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Txt(
                                    text: 'Share Via',
                                    fsize: 13,
                                    color: Get.theme.primaryColor,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
                top: 15.sp,
                left: 10.sp,
                child: InkWell(
                  onTap: () => Get.back(),
                  child: Icon(
                    Icons.arrow_back_ios_new,
                    color: Colors.white,
                    size: 16.sp,
                  ),
                ))
          ],
        ),
      ),
    );
  }

  Container statusWidget(String status, bool isActive) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Container(
            height: 20,
            width: 30,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: (isActive) ? Colors.green : Colors.white,
                border: Border.all(
                    color: (isActive) ? Colors.transparent : Colors.grey[300]!,
                    width: 2)),
          ),
          const SizedBox(
            width: 15,
          ),
          Column(
            children: [
              Container(
                height: 20,
                width: 30,
              ),
              Txt(
                text: status,
                weight: FontWeight.w500,
                color: (isActive) ? Colors.green : Colors.black,
                fsize: 14,
                defalutsize: true,
              ),
              Container(
                height: 20,
                width: 40,
              ),
            ],
          )
        ],
      ),
    );
  }

  Future<void> onButtonTap(Share1 share) async {
    String msg =
        'Join Jaadu and earn money!! ${icon.userData[0]['kubera_id'].toString()} Use this code for joining under me App link :play link  User guide :https://youtube.com/channel/UCaif8R1qsFc8z-7nPBKtlOA';

    String? response;
    final FlutterShareMe flutterShareMe = FlutterShareMe();
    try {
      switch (share) {
        case Share1.facebook:
          response = await flutterShareMe.shareToFacebook(msg: msg);
          break;
        case Share1.messenger:
          response = await flutterShareMe.shareToMessenger(msg: msg);
          break;
        case Share1.twitter:
          response = await flutterShareMe.shareToTwitter(msg: msg);
          break;
        case Share1.whatsapp:
          response = await flutterShareMe.shareToWhatsApp(msg: msg);

          break;
        case Share1.whatsapp_business:
          response = await flutterShareMe.shareToWhatsApp(msg: msg);
          break;
        case Share1.share_system:
          response = await flutterShareMe.shareToSystem(msg: msg);
          break;
        case Share1.whatsapp_personal:
          response = await flutterShareMe.shareWhatsAppPersonalMessage(
              message: msg, phoneNumber: 'phone-number-with-country-code');
          break;

        case Share1.share_telegram:
          response = await flutterShareMe.shareToTelegram(msg: msg);
          break;
        default:
          response = await flutterShareMe.shareToWhatsApp(msg: msg);
      }
    } catch (e) {
      print(e.toString());
    }

    if (response!.contains('Plat')) {
      Fluttertoast.showToast(msg: 'Whatsapp not installed');
    }
  }
}

enum Share1 {
  facebook,
  messenger,
  twitter,
  whatsapp,
  whatsapp_personal,
  whatsapp_business,
  share_system,
  share_instagram,
  share_telegram
}
