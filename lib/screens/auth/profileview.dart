import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kubera/controller/auth.dart';
import 'package:kubera/controller/init.dart';
import 'package:kubera/widgets/text.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';
import '../../widgets/textfield.dart';

class ProfileView extends StatefulWidget {
  ProfileView({Key? key}) : super(key: key);

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final TextEditingController _con = TextEditingController();
  final InitCon icon = Get.find();
  final AuthCon acon = Get.find();
  bool showrefer = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: ListView(
          children: [
            Txt(
              text: 'Profile Photo',
              fsize: 11,
            ),
            SizedBox(
              height: 6.sp,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 25),
                  child: Stack(
                    children: <Widget>[
                      CircleAvatar(
                        radius: 23.sp,
                        backgroundColor: Colors.grey[300],
                        child: InkWell(
                          onTap: () {},
                          child: ClipOval(
                            child: GetBuilder<InitCon>(builder: (value) {
                              return Container(
                                child: value.profileimg != null
                                    ? Image.file(
                                        value.profileimg,
                                        height: 46.sp,
                                        width: 46.sp,
                                        fit: BoxFit.cover,
                                      )
                                    : Icon(Iconsax.gallery, color: Colors.grey),
                                color: Colors.grey[300],
                              );
                            }),

                            // child: value.image == null
                            //     ? Image.network(
                            //         'https://api.wedelis.com/images/users/default.jpg',
                            //         height: 150,
                            //         width: 150,
                            //         fit: BoxFit.cover,
                            //       )
                            //     : Image.file(
                            //         value.image,
                            //         height: 150,
                            //         width: 150,
                            //         fit: BoxFit.cover,
                            //       )
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
                                                    ImageSource.camera);
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
                                                    ImageSource.gallery);
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
                              height: 15.sp,
                              width: 15.sp,
                              child: Icon(
                                Icons.add,
                                color: Colors.white,
                                size: 12.sp,
                              ),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.grey[500],
                              ),
                            ),
                          ))
                    ],
                  ),
                ),
              ],
            ),
            Row(
              children: const [
                Txt(
                  text: 'Name',
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
              hint: 'Enter your name',
              label: 'Enter your name',
              controller: acon.name,
            ),
            SizedBox(
              height: 12.sp,
            ),
            Row(
              children: const [
                Txt(
                  text: 'City',
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
              hint: 'Enter your location',
              label: 'Enter your location',
              controller: acon.city,
            ),
            SizedBox(
              height: 12.sp,
            ),
            Row(
              children: const [
                Txt(
                  text: 'Email',
                  fsize: 11,
                ),
                // Txt(
                //   text: ' *',
                //   fsize: 12,
                //   color: Colors.red,
                // ),
              ],
            ),
            CTextField(
              hint: 'eg:mohan@kuberaa.com (Optional)',
              label: 'eg:mohan@kuberaa.com  (Optional)',
              controller: acon.emailCon,
            ),
            SizedBox(
              height: 8.sp,
            ),
            // Txt(
            //   text:
            //       'Enter the correct email id as all information will be communicated via the same.',
            //   fsize: 11,
            //   color: Colors.grey[400]!,
            // ),

            if (showrefer)
              Column(
                children: [
                  Row(
                    children: [
                      const Txt(
                        text: 'Referal code ',
                        fsize: 11,
                      ),
                      MyTooltip(
                        message: 'Use referal code your friend shared',
                        child: Icon(
                          Icons.info,
                          color: Colors.grey,
                          size: 14.sp,
                        ),
                      )
                    ],
                  ),
                  CTextField(
                    hint: 'Eg : KUR12345',
                    label: 'Eg : KUR12345',
                    controller: _con,
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}

class MyTooltip extends StatelessWidget {
  final Widget child;
  final String message;

  MyTooltip({required this.message, required this.child});

  @override
  Widget build(BuildContext context) {
    final key = GlobalKey<State<Tooltip>>();
    return Tooltip(
      key: key,
      message: message,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => _onTap(key),
        child: child,
      ),
    );
  }

  void _onTap(GlobalKey key) {
    final dynamic tooltip = key.currentState;
    tooltip?.ensureTooltipVisible();
  }
}
