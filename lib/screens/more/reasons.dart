import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';

import '../../controller/auth.dart';
import '../../controller/init.dart';
import '../../widgets/appbar.dart';
import '../../widgets/text.dart';
import '../../widgets/textfield.dart';

class ResonPicRefundView extends StatefulWidget {
  final itemData, id;
  ResonPicRefundView({Key? key, this.itemData, this.id}) : super(key: key);

  @override
  State<ResonPicRefundView> createState() => _ResonPicRefundViewState();
}

class _ResonPicRefundViewState extends State<ResonPicRefundView> {
  final TextEditingController con = TextEditingController();

  final InitCon icon = Get.find();

  final AuthCon acon = Get.find();

  @override
  void dispose() {
    // TODO: implement dispose
    icon.showrefundlist.clear();
    acon.refundPicsList.clear();
    acon.refundPicKey = '';
    acon.refundPicUrl.value = '';
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: BaseAppBar(
        backicon: true,
        title: 'Reason Form',
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Stack(
          children: [
            ListView(
              children: [
                Row(
                  children: const [
                    Txt(
                      text: 'Reason for Refund',
                      fsize: 11,
                    ),
                    Txt(
                      text: ' *',
                      fsize: 12,
                      color: Colors.red,
                    ),
                  ],
                ),
                CTextField(
                  hint: 'Enter your reason',
                  label: 'Enter your reason',
                  controller: con,
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: const [
                    Txt(
                      text: 'Upload pictures of your book',
                      fsize: 11,
                    ),
                    Txt(
                      text: ' *',
                      fsize: 12,
                      color: Colors.red,
                    ),
                  ],
                ),
                Obx(() => GridView.builder(
                    itemCount: icon.showrefundlist.length + 1,
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3),
                    itemBuilder: (context, index) {
                      if (index != icon.showrefundlist.length) {
                        return Padding(
                          padding: EdgeInsets.all(4.0.sp),
                          child: Container(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Stack(
                                children: [
                                  Positioned.fill(
                                    child: Image.file(
                                      icon.showrefundlist[index],
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Container(
                                    color: Colors.black.withOpacity(0.4),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      }
                      return Padding(
                        padding: EdgeInsets.all(4.0.sp),
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
                                              icon.refundpics(
                                                ImageSource.camera,
                                              );
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
                                              icon.refundpics(
                                                ImageSource.gallery,
                                              );
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
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                SizedBox(
                                  height: 5.sp,
                                ),
                                Icon(
                                  Iconsax.gallery,
                                  color: Colors.grey[600],
                                ),
                                Txt(
                                  text: 'Add\nPicture',
                                  iscenter: true,
                                  color: Colors.grey[600]!,
                                  fsize: 11.5,
                                  weight: FontWeight.bold,
                                ),
                                SizedBox(
                                  height: 5.sp,
                                ),
                              ],
                            ),
                            decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(20)),
                          ),
                        ),
                      );
                    }))
              ],
            ),
            Positioned(
              bottom: 10,
              left: 10,
              right: 10,
              child: Row(
                children: [
                  Expanded(
                    child: CupertinoButton(
                        color: Get.theme.primaryColor,
                        child: const Txt(
                          text: 'Send request',
                          color: Colors.white,
                          weight: FontWeight.bold,
                          defalutsize: true,
                        ),
                        onPressed: () {
                          if (con.text.isEmpty) {
                            Fluttertoast.showToast(msg: 'Enter Reason');
                          } else if (icon.showrefundlist.isEmpty) {
                            Fluttertoast.showToast(msg: 'Add Picture');
                          } else {
                            icon.refundReq(widget.id, widget.itemData['id'],
                                widget.itemData['count'], con.text);
                          }

                          // log('aaa' + widget.itemData.toString(),);
                        }),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
