import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:iconsax/iconsax.dart';
import 'package:kubera/screens/referal_screen.dart';

import '../faq_content.dart';
import '../screens/auth/mobile_entry.dart';
import '../screens/notification.dart';
import '../screens/wallet/wallet_main.dart';
import 'text.dart';

bool isTamil = false;

class BaseAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  final bool center;
  final bool switchLan;
  final bool backicon;
  final bool carticon;
  final bool ishome;
  final bool isSwitchUser;
  final VoidCallback ontap;
  static _defaultFunction() {
    Get.back();
  }

  BaseAppBar(
      {Key? key,
      this.title = '',
      this.center = true,
      this.switchLan = false,
      this.isSwitchUser = false,
      this.backicon = false,
      this.ishome = false,
      this.ontap = _defaultFunction,
      this.carticon = false})
      : super(key: key);

  @override
  State<BaseAppBar> createState() => _BaseAppBarState();

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _BaseAppBarState extends State<BaseAppBar> {
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.switchLan) {
      faqContent = tamilContent;
    }

    return AppBar(
      elevation: 0,
      centerTitle: widget.backicon ? false : widget.center,
      title: Txt(
        lines: 1,
        text: widget.title,
        color: widget.backicon ? Colors.black : Get.theme.primaryColor,
        weight: widget.backicon ? FontWeight.w600 : FontWeight.w800,
        fsize: widget.backicon ? 18 : 20,
        defalutsize: true,
      ),
      actions: [
        widget.switchLan
            ? Row(
                children: [
                  Txt(
                    fsize: 10,
                    text: 'த',
                  ),
                  Switch(
                      value: isTamil,
                      onChanged: (v) {
                        setState(() {
                          isTamil = !isTamil;
                          if (isTamil) {
                            faqContent = englishContent;
                          } else {
                            faqContent = tamilContent;
                          }
                        });
                        setState(() {});
                      },
                      activeColor: Get.theme.primaryColor),
                  Txt(
                    fsize: 10,
                    text: 'E',
                  ),
                  SizedBox(
                    width: 10,
                  )
                ],
              )
            : SizedBox(),
        widget.isSwitchUser
            ? IconButton(
                onPressed: () {
                  // GetStorage().remove('usertoken');
                  icon.libraryBookList.clear();
                  icon.mylibbook.clear();
                  // icon.userData.clear();
                  icon.walletData.clear();
                  icon.translist.clear();
                  icon.libraryCatBookList.clear();
                  Get.to(() => MobileEntryView());
                },
                icon: Icon(
                  CupertinoIcons.person_add_solid,
                  color: Get.theme.primaryColor,
                ))
            : SizedBox(),
        if (widget.carticon)
          Row(
            children: [
              InkWell(
                onTap: () {
                  Get.to(
                    () => ReferScreen(),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SvgPicture.asset('assets/refer &earn.svg'),
                ),
              ),
              InkWell(
                onTap: () {
                  Get.to(
                    () => WalletMain(),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SvgPicture.asset('assets/Wallet.svg'),
                ),
              ),
            ],
          )
      ],
      leading: widget.backicon
          ? IconButton(
              onPressed: widget.ontap,
              icon: const Icon(
                Icons.arrow_back_ios_new,
                color: Colors.black87,
              ))
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: InkWell(
                  onTap: () {
                    icon.getNotifications(icon.userData[0]['_id']);
                    Get.to(() => NotificationView());
                  },
                  child: SvgPicture.asset('assets/Notification (2).svg')),
            ),
      backgroundColor: Colors.transparent,
    );
  }
}
