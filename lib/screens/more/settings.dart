import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:kubera/widgets/profile_tile.dart';
import 'package:sizer/sizer.dart';

import '../../widgets/appbar.dart';
import 'switchuser.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: BaseAppBar(
          backicon: true,
          title: 'Settings',
        ),
        body: Padding(
          padding: EdgeInsets.all(8.0.sp),
          child: ListView(
            children: [
              // ProfileTile(
              //   icon: 'assets/Notification (3).svg',
              //   ontap: () {},
              //   isswitch: true,
              //   title: 'Notifications',
              // ),
              ProfileTile(
                icon: 'assets/Star.svg',
                ontap: () {},
                title: 'Rate us',
              ),
              ProfileTile(
                icon: 'assets/switch.svg',
                ontap: () {
                  Get.to(() => SwitchUServView());
                },
                title: 'Switch user',
              ),
            ],
          ),
        ));
  }
}
