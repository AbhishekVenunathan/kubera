import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:kubera/controller/init.dart';
import 'package:timer_count_down/timer_controller.dart';

import 'package:timer_count_down/timer_count_down.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:iconsax/iconsax.dart';
import 'package:kubera/widgets/bottom_navigation.dart';
import 'package:sizer/sizer.dart';
import '../api_endpoints.dart';
import '../base_client.dart';
import '../screens/auth/tell_us.dart';
import '../widgets/icon_text_field.dart';
import '../widgets/text.dart';

class AuthCon extends GetxController with BaseController {
  var selectedList = [].obs;
  var selectedauthorList = [].obs;
  var isenabled = false.obs;
  var profilePicKey = '';
  var refundPicKey = '';
  var profilePicUrl = ''.obs;
  var refundPicsList = [];
  var refundPicUrl = ''.obs;
  final TextEditingController mobile = TextEditingController();
  final TextEditingController otp = TextEditingController();
  final TextEditingController name = TextEditingController();
  final TextEditingController city = TextEditingController();
  final TextEditingController emailCon = TextEditingController();
  final CountdownController _controller = CountdownController(autoStart: true);
  void sendotp() async {
    showLoading();

    var request = {
      "phone_no": mobile.text,
    };
    var response =
        await BaseClient().post(API().otpSend, request).catchError(handleError);
    if (response == null) return;
    Get.back();

    if (Get.isBottomSheetOpen!) Get.back();

    Get.bottomSheet(Container(
      height: Get.height / 2 + 18,
      child: Column(
        children: [
          Container(
            height: 8,
            width: 35,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(999)),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            height: Get.height / 2,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.sp),
                    topRight: Radius.circular(20.sp))),
            child: Center(
              child: Padding(
                padding: EdgeInsets.all(8.0.sp),
                child: Column(
                  children: [
                    SizedBox(
                      height: 7.sp,
                    ),
                    Txt(
                      text: 'Enter OTP',
                      fsize: 20,
                      weight: FontWeight.bold,
                    ),
                    const Spacer(),
                    Txt(
                      text: 'Your code was sent to',
                      fsize: 12,
                      color: Colors.grey[400]!,
                    ),
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Txt(
                          text: '+91${mobile.text}',
                          fsize: 13,
                          color: Colors.grey[400]!,
                        ),
                        SizedBox(
                          width: 5.sp,
                        ),
                        InkWell(
                          onTap: () => Get.back(),
                          child: Icon(
                            Iconsax.edit,
                            size: 16,
                            color: Get.theme.primaryColor,
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    ICTextField(
                      hint: 'Enter OTP',
                      label: 'Enter OTP',
                      controller: otp,
                      ispreicon: true,
                      max: 6,
                      keyboard: TextInputType.number,
                      preicon: Iconsax.lock,
                      onchage: (o) {
                        if (o.length == 6) {
                          FocusManager.instance.primaryFocus?.unfocus();
                        }
                      },
                    ),
                    const Spacer(),
                    Obx(
                      () => Row(
                        children: [
                          if (!isenabled.value)
                            Countdown(
                              seconds: 90,
                              controller: _controller,
                              build: (BuildContext context, double time) => Row(
                                children: [
                                  Txt(
                                    text: 'Resending OTP in ',
                                    fsize: 11,
                                    color: Colors.grey[400]!,
                                  ),
                                  Txt(
                                    text: time.minutes
                                            .toString()
                                            .split(':')[0] +
                                        ':' +
                                        time.minutes.toString().split(':')[1] +
                                        ' Sec',
                                    color: Colors.black,
                                    fsize: 11,
                                  ),
                                ],
                              ),
                              interval: Duration(milliseconds: 100),
                              onFinished: () {
                                isenabled.value = true;
                              },
                            ),
                          // Txt(
                          //   text: 'Not getting OTP?',
                          //   fsize: 11,
                          //   color: Colors.grey[400]!,
                          // ),
                          if (isenabled.value)
                            Row(
                              children: [
                                Txt(
                                  text: 'Not getting OTP?',
                                  fsize: 11,
                                  color: Colors.grey[400]!,
                                ),
                                InkWell(
                                  onTap: () {
                                    isenabled.value = false;
                                    sendotp();
                                  },
                                  child: Txt(
                                    text: ' RESEND OTP',
                                    fsize: 10,
                                    weight: FontWeight.w700,
                                    color: Get.theme.primaryColor,
                                  ),
                                ),
                              ],
                            ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    const Spacer(),
                    const Spacer(),
                    const Spacer(),
                    const Spacer(),
                    const Spacer(),
                    const Spacer(),
                    const Spacer(),
                    const Spacer(),
                    Row(
                      children: [
                        Expanded(
                          child: CupertinoButton(
                              color: Get.theme.primaryColor,
                              child: const Padding(
                                padding: EdgeInsets.symmetric(vertical: 3.5),
                                child: Txt(
                                  text: 'Verify OTP ',
                                  color: Colors.white,
                                  weight: FontWeight.bold,
                                  defalutsize: true,
                                ),
                              ),
                              onPressed: () {
                                if (otp.text.length != 6) {
                                  Fluttertoast.showToast(
                                      msg: 'Enter valid OTP');
                                } else {
                                  verifyOtp();
                                }
                              }),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    ));
    hideLoading();
    // _controller.start();
  }

  void verifyOtp() async {
    showLoading();

    var request = {
      "otp": otp.text,
      "phone_no": mobile.text,
    };
    var response = await BaseClient()
        .post(API().otpVerify, request)
        .catchError(handleError);
    if (response == null) return;
    var data = json.decode(response);
    print('seeee' + data.toString());
    hideLoading();
    if (data['message'] == 'OTP verified successfully') {
      Get.back();
      if (data['isExistingUser']) {
        otp.clear();
        GetStorage().write('usertoken', data['token']);
        // GetStorage().write('userid', data['data']['_id']);
        final InitCon icon = Get.find();
        // Get.to(() => TellusView());
        icon.getuserData();
        icon.getNewLaunchs();
        icon.getChatList();
        icon.getlibraryBooks();
        icon.getCatlibraryBooks();
        icon.getFavList();
        icon.getauthorofweek();
        icon.getBudgetBooks();
        icon.getwithtokenAuthors();
        icon.getwithtokenAuthors();
        icon.getCart();
        icon.getCart(type: 'eCart');
        icon.getOrders();

        Get.offAll(() => BottomBar(currentindex: 0));
      } else {
        otp.clear();
        Get.to(() => TellusView());
      }
    } else {
      Fluttertoast.showToast(msg: data['message']);
    }
  }

  void getPreUrl({bool isUpdate = false}) async {
    final InitCon icon = Get.find();
    var imgType = getFileExtension(icon.profileimgpath);
    var uri = Uri.parse(
        "${API().baseURL}/user/aws/presigned-url?key=userProfileImage&fileNumber=1&contentType=image/$imgType");
    final r = await http.get(uri,
        headers: {'x-auth-token': GetStorage().read('usertoken').toString()});
    final response = json.decode(r.body);
    print(response);
    profilePicKey = response['result'][0]['Key'];
    profilePicUrl.value = response['result'][0]['url'];
    postS3Profile(isUpdate: isUpdate);
  }

  void getRefundPreUrl({bool isUpdate = false}) async {
    final InitCon icon = Get.find();
    var imgType = getFileExtension(icon.profileimgpath);
    var uri = Uri.parse(
        "${API().baseURL}/user/aws/presigned-url?key=refundReqImage&fileNumber=1&contentType=image/.jpg");
    final r = await http.get(uri,
        headers: {'x-auth-token': GetStorage().read('usertoken').toString()});
    final response = json.decode(r.body);
    print(uri.toString() + 'ffff');
    refundPicKey = response['result'][0]['Key'];
    refundPicUrl.value = response['result'][0]['url'];
    postS3Refund(isUpdate: isUpdate);
  }

  // void getPreUrlRefund({bool isUpdate = false}) async {
  //   final InitCon icon = Get.find();
  //   var imgType = getFileExtension(icon.refundPicspath);
  //   var uri = Uri.parse(
  //       "${API().baseURL}/user/aws/presigned-url?key=userProfileImage&fileNumber=1&contentType=image/$imgType");
  //   final r = await http.get(uri,
  //       headers: {'x-auth-token': GetStorage().read('usertoken').toString()});
  //   final response = json.decode(r.body);
  //   print(response);
  //   profilePicKey = response['result'][0]['Key'];
  //   profilePicUrl.value = response['result'][0]['url'];

  //   postS3Refund(isUpdate: isUpdate);
  // }

  void postS3Refund({bool isUpdate = false}) async {
    final InitCon icon = Get.find();
    var uri = Uri.parse(refundPicUrl.value.toString());
    var convimg = icon.refundPics.readAsBytesSync();
    var imgType = getFileExtension(icon.refundPicspath);
    print(imgType.toString() + 'typpp');
    print(convimg.toString() + 'convooo');
    // var fileContentBase64 = base64.encode(convimg);
    final r = await http.put(uri, body: convimg, headers: {
      'Content-Type': 'image/$imgType',
    });
    // final response = json.decode(r.body);
    print('codeee' + r.statusCode.toString());
    if (refundPicKey.isNotEmpty) refundPicsList.add(refundPicKey);
    print('Reeee' + refundPicsList.toString());
  }

  void postS3Profile({bool isUpdate = false}) async {
    final InitCon icon = Get.find();
    var uri = Uri.parse(profilePicUrl.value.toString());
    var convimg = icon.profileimg.readAsBytesSync();
    var imgType = getFileExtension(icon.profileimgpath);
    print(imgType);
    // var fileContentBase64 = base64.encode(convimg);
    final r = await http.put(uri, body: convimg, headers: {
      'Content-Type': 'image/$imgType',
    });
    // final response = json.decode(r.body);
    print(r.statusCode);

    if (isUpdate) {
      final InitCon icon = Get.find();
      icon.profileImgUpdate();
    }
  }

  String getFileExtension(String fileName) {
    try {
      return "." + fileName.split('.').last;
    } catch (e) {
      return 'png';
    }
  }

  void signup(namev, emailv, phonev, cityv, {isGoogle = false}) async {
    showLoading();
    final InitCon icon = Get.find();
    String? token = await FirebaseMessaging.instance.getToken();
    print('fcm' + token.toString());
    var request = {
      "name": namev,

      // "profile_image": '',
      if (emailv.toString().isNotEmpty) "email": emailv,
      "phone_no": phonev,
      "city": cityv,
      'interests': selectedList,
      'authors': selectedauthorList,
      'fcmToken': token.toString()
    };

    var grequest = {
      "name": namev,

      // "profile_image": '',
      "email": emailv,

      'fcmToken': token.toString()
    };
    var requestProfile = {
      "name": namev,
      "profile_image": profilePicKey,
      if (emailv.toString().isNotEmpty) "email": emailv,
      "phone_no": phonev,
      "city": cityv,
      'interests': selectedList,
      'authors': selectedauthorList,
      'fcmToken': token.toString()
    };

    var urll = isGoogle
        ? grequest
        : icon.profileimgpath.toString() == ''
            ? request
            : requestProfile;
    print(urll);
    print(urll);
    print(urll);
    var response =
        await BaseClient().post(API().signup, urll).catchError(handleError);
    if (response == null) return;
    var data = json.decode(response);
    log('loggg' + data.toString());

    GetStorage().write('usertoken', data['token']);
    var tok = GetStorage().read('usertoken');
    print('sas' + tok.toString());
    // GetStorage().write('userid', data['data']['_id']);

    icon.getuserData();
    icon.getNewLaunchs();
    icon.getChatList();
    icon.getlibraryBooks();
    icon.getCatlibraryBooks();
    icon.getFavList();
    icon.getauthorofweek();
    icon.getBudgetBooks();
    icon.getwithtokenAuthors();
    icon.getwithtokenAuthors();
    icon.getCart();
    icon.getCart(type: 'eCart');
    icon.getOrders();

    name.clear();
    city.clear();
    emailCon.clear();
    selectedList.clear();
    selectedauthorList.clear();
    profilePicKey = '';
    icon.profileimg = null;
    var localusers = [];
    localusers = GetStorage().read('localusers') ?? [];

    if (localusers.isEmpty) {
      localusers.add(isGoogle
          ? grequest
          : icon.profileimgpath.toString() == ''
              ? request
              : requestProfile);
      GetStorage().write('localusers', localusers);
    } else {
      var prodLists = localusers.where((prod) => prod["email"] == emailv);
      if (prodLists.isEmpty) {
        localusers.add(isGoogle
            ? grequest
            : icon.profileimgpath.toString() == ''
                ? request
                : requestProfile);
        GetStorage().write('localusers', localusers);
      }
      print('${prodLists}');
    }
    print('ddsss' + localusers.toString());

    print('ddss' + GetStorage().read('localusers').toString());

    // Get.to(() => TellusView());
    Get.offAll(() => BottomBar(currentindex: 0));
    hideLoading();
  }

  void getuserDetails(id, actoken, name, email, photo, idtoken) async {
    var uri = Uri.parse(
        "https://people.googleapis.com/v1/people/$id?personFields=birthdays,genders&access_token=$actoken");
    final r = await http.get(
      uri,
    );
    final response = json.decode(r.body);
    var gender = response['genders'][0]['formattedValue'];
    var dob =
        '${response['birthdays'][0]['date']['month']}/${response['birthdays'][0]['date']['day']}/${response['birthdays'][0]['date']['year']}';
    print(dob);
  }

  void googleauth() async {
    showLoading();
    final googleSignIn = GoogleSignIn();
    await googleSignIn.signOut();
    await googleSignIn.signIn().then((value) {
      print(value!.displayName);
      print(value.email);
      print(value.photoUrl);
      signup(value.displayName, value.email, '', '', isGoogle: true);
      // value.authentication.then((googleKey) async {
      //   // getuserDetails(value.id, googleKey.accessToken, value.displayName,
      //   //     value.email, value.photoUrl, googleKey.idToken);
      // }).catchError((err) {
      //   log(err);
      // });
    });
  }
}
