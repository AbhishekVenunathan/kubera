import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:iconsax/iconsax.dart';
import 'package:kubera/controller/init.dart';
import 'package:kubera/widgets/text.dart';
import 'package:sizer/sizer.dart';

import '../../widgets/appbar.dart';
import 'add_address.dart';
import 'package:get/get.dart';

class SavedAddress extends StatelessWidget {
  SavedAddress({Key? key}) : super(key: key);
  final InitCon icon = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        backicon: true,
        title: 'Address',
      ),
      body: Column(
        children: [
          Expanded(
              child: Obx(
            () => icon.myaddresslist.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('assets/noaddress.png'),
                        SizedBox(
                          height: 5.sp,
                        ),
                        Txt(
                          text: 'You have’nt add any address yet.',
                          fsize: 12,
                          color: Colors.grey[500]!,
                        )
                      ],
                    ),
                  )
                : ListView.builder(
                    itemCount: icon.myaddresslist.length,
                    itemBuilder: ((context, index) {
                      final address = icon.myaddresslist[index];
                      return Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 4.sp, horizontal: 8.sp),
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
                                offset: const Offset(
                                    0, 3), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(8.0.sp),
                            child: ListTile(
                              onTap: () {
                                icon.selectedId.value =
                                    address['id'].toString();
                                icon.addressSelect(
                                    address['id'],
                                    address['name'],
                                    address['door_no'],
                                    address['street'],
                                    address['city'],
                                    address['landmark'],
                                    address['pincode'],
                                    address['type']);
                                Get.back();
                                print(address['id']);
                              },
                              leading: Icon(Icons.radio_button_checked,
                                  color: icon.selectedId.value ==
                                          address['id'].toString()
                                      ? Colors.black
                                      : Colors.transparent),
                              trailing: Container(
                                width: 80.sp,
                                child: Row(
                                  children: [
                                    IconButton(
                                        onPressed: () {
                                          icon.EditId.value =
                                              address['id'].toString();
                                          icon.name.text = address['name'];
                                          icon.doorno.text = address['door_no'];
                                          icon.streetname.text =
                                              address['street'];
                                          icon.city.text = address['city'];
                                          icon.landmark.text =
                                              address['landmark'];
                                          icon.pincode.text =
                                              address['pincode'];
                                          icon.ishome.value =
                                              address['type'] == 'Home'
                                                  ? true
                                                  : false;
                                          Get.to(() => AddAddressView(
                                                isEdit: true,
                                              ));
                                        },
                                        icon: Icon(
                                          Iconsax.edit,
                                          size: 16.sp,
                                          color: Get.theme.primaryColor,
                                        )),
                                    IconButton(
                                        onPressed: () {
                                          icon.deleteAddress(address['id']);
                                        },
                                        icon: Icon(
                                          Icons.delete_outline_outlined,
                                          size: 16.sp,
                                          color: Colors.red,
                                        )),
                                  ],
                                ),
                              ),
                              title: Transform(
                                transform:
                                    Matrix4.translationValues(-16, 0.0, 0.0),
                                child: Txt(
                                  text: '${address['name']}',
                                  fsize: 12,
                                  weight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Transform(
                                transform:
                                    Matrix4.translationValues(-16, 0.0, 0.0),
                                child: Txt(
                                  text:
                                      '${address['door_no']}, ${address['street']}, ${address['city']},${address['pincode']}\nlandmark: ${address['landmark']}',
                                  fsize: 10,
                                  color: Colors.grey[400]!,
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    })),
          )),
          Padding(
            padding: EdgeInsets.all(8.0.sp),
            child: Row(
              children: [
                Expanded(
                  child: CupertinoButton(
                      color: Get.theme.primaryColor,
                      child: const Txt(
                        text: 'Add new address',
                        color: Colors.white,
                        weight: FontWeight.bold,
                        defalutsize: true,
                      ),
                      onPressed: () {
                        Get.to(() => AddAddressView());
                      }),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
