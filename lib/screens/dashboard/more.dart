import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kubera/controller/init.dart';
import 'package:kubera/screens/auth/mobile_entry.dart';
import 'package:kubera/screens/more/about.dart';
import 'package:kubera/screens/more/settings.dart';
import 'package:kubera/widgets/text.dart';
import 'package:sizer/sizer.dart';

import '../../widgets/profile_tile.dart';
import '../faqview.dart';
import '../more/address.dart';
import '../more/bank_transfer.dart';
import '../more/chat_view.dart';
import '../more/help.dart';
import '../more/my_orders.dart';
import '../more/my_wishlist.dart';
import '../more/personal_details.dart';
import '../more/saved_payment.dart';
import 'package:get/get.dart';

class MoreView extends StatelessWidget {
  MoreView({Key? key}) : super(key: key);
  final InitCon icon = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Obx(
      () => Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.sp),
        child: ListView(children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 5.sp),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                  child: Stack(
                    children: <Widget>[
                      InkWell(
                        onTap: () {
                          Get.dialog(Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () {
                                Get.back();
                              },
                              child: Center(
                                child: Container(
                                  height: 140,
                                  child: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Column(
                                      children: [
                                        ListTile(
                                          onTap: () {
                                            icon.getgrpimage(ImageSource.camera,
                                                isUpdate: true);
                                          },
                                          leading: Icon(Iconsax.camera),
                                          title: Txt(
                                            text: 'Camera',
                                            defalutsize: true,
                                          ),
                                        ),
                                        const Divider(),
                                        ListTile(
                                          onTap: () {
                                            icon.getgrpimage(
                                                ImageSource.gallery,
                                                isUpdate: true);
                                          },
                                          leading: Icon(Iconsax.gallery),
                                          title: Txt(
                                            text: 'Gallery',
                                            defalutsize: true,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  decoration: BoxDecoration(
                                      color: Colors.grey[50],
                                      borderRadius: BorderRadius.circular(25)),
                                  width: 250,
                                ),
                              ),
                            ),
                          ));
                        },
                        child: CircleAvatar(
                          radius: 30.sp,
                          backgroundColor: Colors.grey[300],
                          child: ClipOval(
                            child: Container(
                              child: Stack(
                                children: [
                                  Stack(
                                    children: [
                                      InkWell(
                                        onTap: () {},
                                        child: icon.userData[0]
                                                        ['profile_image'] ==
                                                    'https://kuberatech-docs.s3.us-west-1.amazonaws.com/' ||
                                                icon.userData[0]
                                                        ['profile_image'] ==
                                                    'https://kuberatech-docs.s3.us-west-1.amazonaws.com/undefined'
                                            ? Image.asset(
                                                'assets/no_user.png',
                                                height: 60.sp,
                                                width: 60.sp,
                                              )
                                            : Image.network(
                                                icon.userData[0]
                                                    ['profile_image'],
                                                height: 60.sp,
                                                width: 60.sp,
                                              ),
                                      ),
                                      Positioned.fill(
                                        child: Container(
                                          color: Colors.black.withOpacity(0.5),
                                        ),
                                      )
                                    ],
                                  ),
                                  Positioned.fill(
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Txt(
                                        text: 'Click to\n  edit',
                                        fsize: 10,
                                        color: Colors.white,
                                        weight: FontWeight.bold,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              color: Colors.grey[300],
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                          bottom: 1,
                          right: 1,
                          child: InkWell(
                            onTap: () {
                              Get.dialog(Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  onTap: () {
                                    Get.back();
                                  },
                                  child: Center(
                                    child: Container(
                                      height: 140,
                                      child: Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Column(
                                          children: [
                                            ListTile(
                                              onTap: () {
                                                icon.getgrpimage(
                                                    ImageSource.camera,
                                                    isUpdate: true);
                                              },
                                              leading: Icon(Iconsax.camera),
                                              title: Txt(
                                                text: 'Camera',
                                                defalutsize: true,
                                              ),
                                            ),
                                            const Divider(),
                                            ListTile(
                                              onTap: () {
                                                icon.getgrpimage(
                                                    ImageSource.gallery,
                                                    isUpdate: true);
                                              },
                                              leading: Icon(Iconsax.gallery),
                                              title: Txt(
                                                text: 'Gallery',
                                                defalutsize: true,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      decoration: BoxDecoration(
                                          color: Colors.grey[50],
                                          borderRadius:
                                              BorderRadius.circular(25)),
                                      width: 250,
                                    ),
                                  ),
                                ),
                              ));
                            },
                            child: Container(
                              height: 18.sp,
                              width: 18.sp,
                              child: Icon(
                                Iconsax.edit,
                                color: Colors.white,
                                size: 12.sp,
                              ),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Get.theme.primaryColor,
                              ),
                            ),
                          ))
                    ],
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Txt(
                text: icon.pname.text,
                weight: FontWeight.w700,
              ),
            ],
          ),
          if (icon.userData[0]['currentLevel'].toString() != 'null')
            Padding(
              padding: EdgeInsets.symmetric(vertical: 6.sp),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(999),
                      color: Get.theme.primaryColor.withOpacity(0.2),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 12.sp, vertical: 4.sp),
                      child: Txt(
                        text: 'Level ' +
                            icon.userData[0]['currentLevel'].toString(),
                        fsize: 9,
                        weight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.sp, vertical: 10.sp),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15.sp),
                    topRight: Radius.circular(15.sp),
                    bottomLeft: Radius.circular(15.sp),
                    bottomRight: Radius.circular(15.sp)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.12),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Padding(
                padding: EdgeInsets.all(8.0.sp),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        InkWell(
                          onTap: () {
                            Get.to(() => SettingsView());
                          },
                          child: CircleAvatar(
                            radius: 18.sp,
                            backgroundColor: Colors.grey[300],
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Image.asset('assets/setting.png'),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 8.sp,
                        ),
                        Txt(
                          text: 'Settings',
                          fsize: 11,
                        )
                      ],
                    ),
                    Column(
                      children: [
                        InkWell(
                          onTap: () {
                            Get.to(() => ChatView());
                          },
                          child: CircleAvatar(
                            radius: 18.sp,
                            backgroundColor: Colors.grey[300],
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.asset('assets/msg.png'),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 8.sp,
                        ),
                        Txt(
                          text: 'My chats',
                          fsize: 11,
                        )
                      ],
                    ),
                    Column(
                      children: [
                        InkWell(
                          onTap: () {
                            icon.getOrders();
                            Get.to(() => MyOrdersView());
                          },
                          child: CircleAvatar(
                            radius: 18.sp,
                            backgroundColor: Colors.grey[300],
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Image.asset('assets/my_orders.png'),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 8.sp,
                        ),
                        Txt(
                          text: 'My orders',
                          fsize: 11,
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20.sp,
          ),
          Container(
            color: Colors.grey[100],
            child: Padding(
              padding: EdgeInsets.all(8.0.sp),
              child: Txt(
                text: 'USER DETAILS',
                fsize: 11,
                color: Colors.grey[500]!,
              ),
            ),
          ),
          ProfileTile(
            title: 'Personal details',
            icon: 'assets/Profile.svg',
            ontap: () {
              Get.to(() => PersonalDetails());
            },
          ),
          ProfileTile(
            title: 'Saved payment details',
            icon: 'assets/Wallet (1).svg',
            ontap: () {
              Get.to(() => BankTransfer());
            },
          ),
          ProfileTile(
            title: 'Saved address',
            icon: 'assets/Location.svg',
            ontap: () {
              Get.to(() => SavedAddress());
            },
          ),
          ProfileTile(
            title: 'My wishlist',
            icon: 'assets/heart.svg',
            ontap: () {
              icon.getFavList();
              Get.to(() => MyWishList());
            },
            isline: false,
          ),
          Container(
            color: Colors.grey[100],
            child: Padding(
              padding: EdgeInsets.all(8.0.sp),
              child: Txt(
                text: 'SUPPORT',
                fsize: 11,
                color: Colors.grey[500]!,
              ),
            ),
          ),
          ProfileTile(
            title: 'Help center',
            icon: 'assets/Call.svg',
            ontap: () {
              Get.to(() => HelpCenter());
            },
          ),
          ProfileTile(
            title: 'About us',
            icon: 'assets/Profile.svg',
            ontap: () {
              Get.to(() => AboutUsView());
              //
              //   var iss = GetStorage().remove('localusers');
              //    print(iss.toString());
            },
          ),
          ProfileTile(
            title: 'FAQs',
            icon: 'assets/Document.svg',
            ontap: () {
              Get.to(() => FAQView());
              //
              //   var iss = GetStorage().remove('localusers');
              //  print(iss.toString());
            },
          ),
          ProfileTile(
            islogout: true,
            title: 'Logout',
            isline: false,
            icon: 'assets/logout.svg',
            ontap: () {
              // GetStorage().remove('localusers');

              Get.offAll(() => MobileEntryView());
              GetStorage().remove('usertoken');
              icon.pemail.clear();
              icon.pcity.clear();
              icon.pphone.clear();
              icon.pname.clear();
              icon.userData[0]['profile_image'] =
                  'https://kuberatech-docs.s3.us-west-1.amazonaws.com/';
              icon.isOwn.value = false;
            },
          ),
          SizedBox(
            height: 20.sp,
          )
        ]),
      ),
    ));
  }
}
