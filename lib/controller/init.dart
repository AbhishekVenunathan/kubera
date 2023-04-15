import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kubera/controller/auth.dart';
import 'package:kubera/widgets/bottom_navigation.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:sizer/sizer.dart';

import '../api_endpoints.dart';
import '../base_client.dart';
import '../widgets/dialog.dart';
import '../widgets/text.dart';

class InitCon extends GetxController with BaseController {
  var profileimg;
  var refundPics;
  var refundPicspath;
  var profileimgpath;
  // var profileimgfile;
  var refundfile;
  var refCount = 0.obs;
  var isOwn = false.obs;
  var isTamil = true.obs;
  var categorieslist = [].obs;
  var filterBook = [].obs;
  var showrefundlist = [].obs;
  var continueBooks = [].obs;
  var selctedindex = 0.obs;
  var bankId = ''.obs;
  var grptypelist = [
    {'group_type_id': '1', 'group_type_name': 'PhonePe'},
    {'group_type_id': '2', 'group_type_name': 'Paytm'},
    {'group_type_id': '4', 'group_type_name': 'Gpay'},
    {'group_type_id': '5', 'group_type_name': 'Paypal'},
    {'group_type_id': '6', 'group_type_name': 'Amazon Pay'},
  ].obs;
  var authorslist = [].obs;
  var newlaunchlist = [].obs;
  var bugetBookslist = [].obs;
  var moreAuthBooks = [].obs;
  var bookDetails = [].obs;
  var authorBooklist = [].obs;
  var categoryBooklist = [].obs;
  var translist = [].obs;
  var homeauthorslist = [].obs;
  var authorofweeklist = [].obs;
  var libraryCatBookList = [].obs;
  var popularBooksCat = [].obs;
  var treeData = [].obs;
  var favlist = [].obs;
  var filterfavlist = [].obs;
  var mycart = {}.obs;
  var myecart = {}.obs;
  var myaddress = {}.obs;
  var myaddresslist = [].obs;
  var userData = [].obs;
  var myorders = [].obs;
  var homecatlist = [].obs;
  var mylibbook = [].obs;
  var mypopBooks = [].obs;
  var chatlist = [].obs;
  var walletData = [].obs;
  var libraryBookList = [].obs;
  var popularBookList = [].obs;
  var notifications = [].obs;
  var iskuberaEdition = false.obs;
  var showLoad = false.obs;
  var ishome = true.obs;
  var selectedId = ''.obs;
  var EditId = ''.obs;
  var selectedBookId = ''.obs;
  var leftcurrentImg = ''.obs;
  var leftcurrentname = ''.obs;
  var leftcurrentkubid = ''.obs;
  var leftcurrentLevel = ''.obs;
  var treeMembers = ''.obs;
  var leftGrandImg = ''.obs;
  var leftGrandImg1 = ''.obs;
  var leftGrandname = ''.obs;
  var leftKubId = ''.obs;
  var leftKubIdSecond = ''.obs;
  var grandName = ''.obs;
  late Razorpay _razorpay;
  late Razorpay _razorpayCash;

  final TextEditingController name = TextEditingController();
  final TextEditingController doorno = TextEditingController();
  final TextEditingController streetname = TextEditingController();
  final TextEditingController city = TextEditingController();
  final TextEditingController landmark = TextEditingController();
  final TextEditingController pincode = TextEditingController();
  final TextEditingController pname = TextEditingController();
  final TextEditingController pcity = TextEditingController();
  final TextEditingController pemail = TextEditingController();
  final TextEditingController pphone = TextEditingController();

  ///Wallet///
  final TextEditingController wname = TextEditingController();
  final TextEditingController wacnumber = TextEditingController();
  final TextEditingController wacrenumber = TextEditingController();
  final TextEditingController wifsc = TextEditingController();
  final TextEditingController wbankname = TextEditingController();
  final TextEditingController wphone = TextEditingController();
  final TextEditingController wupi = TextEditingController();
  final TextEditingController wwalletType = TextEditingController();
  var count1 = 0.obs;
  final ScrollController scrollcontroller = ScrollController();

  void scrollUp() {
    scrollcontroller.animateTo(
      scrollcontroller.position.minScrollExtent,
      duration: Duration(seconds: 2),
      curve: Curves.fastOutSlowIn,
    );
  }

  @override
  void onInit() {
    super.onInit();
    _razorpayCash = Razorpay();
    _razorpayCash.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccessCash);
    _razorpayCash.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentErrorCash);
    _razorpayCash.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWalletCash);
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    getCategory();
    getAuthors();

    if (GetStorage().read('usertoken').toString() != 'null') {
      getuserData();
      getNewLaunchs();
      getChatList();
      getpopularBooks();
      getlibraryBooks();
      getauthorofweek();
      getCatlibraryBooks();
      getFavList();
      getBudgetBooks(isSuffle: true);
      getwithtokenAuthors();
      getwithtokenAuthors();
      getCart();
      getCart(type: 'eCart');
      getOrders();
      getTrasaction();
    }
  }

  void filterBooks(value) {
    filterBook.value = bugetBookslist
        .where((o) =>
            o['book_name'].toLowerCase().contains(value.toLowerCase()) ||
            o['authorDetails'][0]['author_name']
                .toLowerCase()
                .contains(value.toLowerCase()))
        .toList();
  }

  void filterFavList(value) {
    filterfavlist.value = favlist
        .where((o) =>
            o['book_name'].toLowerCase().contains(value.toLowerCase()) ||
            o['authorDetails'][0]['author_name']
                .toLowerCase()
                .contains(value.toLowerCase()))
        .toList();
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    getlibraryBooks();
    getCatlibraryBooks();
    getOrders();
    Get.dialog(
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DialogWidget(
              btnTap: () {
                getCart();
                Get.offAll(() => BottomBar(currentindex: 0));
              },
              title: 'Order placed successfully',
              subtile:
                  'Your tree is unlocked, Now you can refer your friend and start earn!',
              btntext: 'Go to Home',
              icon: 'assets/success.json',
            ),
          ],
        ),
        barrierDismissible: false);
    // Fluttertoast.showToast(
    //     msg: "SUCCESS: " + response.paymentId!,
    //     toastLength: Toast.LENGTH_SHORT);
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    Get.dialog(
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DialogWidget(
              btnTap: () {
                Get.back();
              },
              title: 'Payment failed',
              subtile:
                  'Something went wrong while payment. Please try again or after some time',
              btntext: 'Try again',
              icon: 'assets/fail.json',
            ),
          ],
        ),
        barrierDismissible: false);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    Fluttertoast.showToast(
        msg: "EXTERNAL_WALLET: " + response.walletName!,
        toastLength: Toast.LENGTH_SHORT);
  }

  void _handlePaymentSuccessCash(PaymentSuccessResponse response) {
    getuserData();
    getTrasaction();
    Get.dialog(
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DialogWidget(
              btnTap: () {
                getCart();
                Get.offAll(() => BottomBar(currentindex: 0));
              },
              title: 'Amount added successfully',
              subtile: 'It will reflect your wallet amount!',
              btntext: 'Go to Home',
              icon: 'assets/success.json',
            ),
          ],
        ),
        barrierDismissible: false);
    // Fluttertoast.showToast(
    //     msg: "SUCCESS: " + response.paymentId!,
    //     toastLength: Toast.LENGTH_SHORT);
  }

  void _handlePaymentErrorCash(PaymentFailureResponse response) {
    Get.dialog(
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DialogWidget(
              btnTap: () {
                Get.back();
              },
              title: 'Payment failed',
              subtile:
                  'Something went wrong while payment. Please try again or after some time',
              btntext: 'Try again',
              icon: 'assets/fail.json',
            ),
          ],
        ),
        barrierDismissible: false);
  }

  void _handleExternalWalletCash(ExternalWalletResponse response) {
    Fluttertoast.showToast(
        msg: "EXTERNAL_WALLET: " + response.walletName!,
        toastLength: Toast.LENGTH_SHORT);
  }

  Future getgrpimage(ImageSource source, {bool isUpdate = false}) async {
    final pickedFile =
        await ImagePicker().pickImage(source: source, imageQuality: 80);

    if (pickedFile != null) {
      profileimg = File(pickedFile.path);

      profileimgpath = pickedFile.path;

      if (Get.isDialogOpen!) Get.back();
      final AuthCon acon = Get.find();
      acon.getPreUrl(isUpdate: isUpdate);
      update();
    } else {
      print('No image selected.');
      if (Get.isDialogOpen!) Get.back();
      update();
    }
    // if (pickedFile != null) {
    //   List<int> imageBytes = profileimg.readAsBytesSync();
    //   String base64Image = base64.encode(imageBytes);
    //   profileimgfile = base64Image;
    //   // updatelistimages.add(base64Image);
    // }
    print(profileimg.toString());
  }

  Future refundpics(ImageSource source, {bool isUpdate = false}) async {
    final pickedFile =
        await ImagePicker().pickImage(source: source, imageQuality: 80);

    if (pickedFile != null) {
      refundPics = File(pickedFile.path);

      refundPicspath = pickedFile.path;

      if (Get.isDialogOpen!) Get.back();
      final AuthCon acon = Get.find();
      showrefundlist.add(refundPics);
      acon.getRefundPreUrl(isUpdate: isUpdate);
      update();
    } else {
      print('No image selected.');
      if (Get.isDialogOpen!) Get.back();
      update();
    }
    if (pickedFile != null) {
      List<int> imageBytes = refundPics.readAsBytesSync();
      String base64Image = base64.encode(imageBytes);
      refundfile = base64Image;
      // updatelistimages.add(base64Image);
    }
    print(profileimg.toString());
  }

  // void verifyOtp() async {
  //   showLoading();

  //   var response =
  //       await BaseClient().get(API().getauthcategory).catchError(handleError);
  //   if (response == null) return;
  //   var data = json.decode(response);
  //   print(data.toString());
  //   hideLoading();
  // }

  void getCategory() async {
    var response =
        await BaseClient().get(API().getauthcategory).catchError(handleError);
    if (response == null) return;
    var data = json.decode(response);

    categorieslist.value = data['data'];
  }

  void getauthorofweek() async {
    showLoad.value = true;
    var response =
        await BaseClient().get(API().getauthorofweek).catchError(handleError);
    if (response == null) return;
    var data = json.decode(response);

    authorofweeklist.value = data['data'];
    log('auttttt' + authorofweeklist.toString());
    showLoad.value = false;
  }

  void getTree(id, {isMine = false, leauge = '', isOther = false}) async {
    showLoad.value = true;
    var kubId = leauge == 'Bronze'
        ? userData[0]['treeDetails']['level_1_KUBID']
        : leauge == 'Silver'
            ? userData[0]['treeDetails']['level_2_KUBID']
            : userData[0]['treeDetails']['level_3_KUBID'];
    var finalid = isOther ? id : kubId;
    var response = await BaseClient()
        .get(API().getTree +
            finalid +
            '&level=${leauge == 'Bronze' ? '1' : leauge == 'Silver' ? '2' : '3'}')
        .catchError(handleError);
    if (response == null) return;
    var data = json.decode(response);

    log('Treeee' + data.toString());
    if (data['data'].toString() != '[]') {
      treeData.value = data['data'][0]['childrenProfileDetail'];
    } else {
      treeData.value = [];
      treeMembers.value = '0';
    }
    // print(data['data'][0]['greatGrantChildren'].toString() + 'dddddddd');
    print('dddddddd');
    if (isMine) {
      treeMembers.value = data['data'][0]['treeMembers'].toString() == 'null'
          ? '0'
          : data['data'][0]['treeMembers'].toString();
    }

    showLoad.value = false;
    print(userData[0]['currentLevel'].toString());
    print(userData[0]['currentLevelIsCompleted'].toString());
    // if (userData[0]['currentLevelIsCompleted'] &&
    //     userData[0]['currentLevel'] == 2 &&
    //     leauge == 'Silver') {
    //   Get.bottomSheet(Container(
    //       child: Padding(
    //         padding: EdgeInsets.all(12.0.sp),
    //         child: Column(
    //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //           crossAxisAlignment: CrossAxisAlignment.start,
    //           children: [
    //             Column(
    //               crossAxisAlignment: CrossAxisAlignment.start,
    //               children: [
    //                 Txt(
    //                   text: userData[0]['currentLevel'].toString() == '1'
    //                       ? 'Are you ready to move Silver Level?'
    //                       : 'Are you ready to move Gold Level?',
    //                   weight: FontWeight.bold,
    //                 ),
    //                 SizedBox(
    //                   height: 9.sp,
    //                 ),
    //                 Row(
    //                   children: [
    //                     Txt(
    //                       text: userData[0]['currentLevel'].toString() == '1'
    //                           ? 'Rs 500 debited from your wallet'
    //                           : 'Rs 5000 debited from your wallet',
    //                       fsize: 13,
    //                       weight: FontWeight.normal,
    //                     ),
    //                   ],
    //                 ),
    //               ],
    //             ),
    //             Row(
    //               children: [
    //                 Expanded(
    //                   child: InkWell(
    //                     onTap: () => Get.back(),
    //                     child: Container(
    //                       height: 60,
    //                       decoration: BoxDecoration(
    //                           borderRadius: BorderRadius.circular(10.sp),
    //                           border:
    //                               Border.all(color: Get.theme.primaryColor)),
    //                       child: Center(
    //                         child: Txt(
    //                           text: 'Disagree',
    //                           color: Get.theme.primaryColor,
    //                           fsize: 14,
    //                           weight: FontWeight.w600,
    //                         ),
    //                       ),
    //                     ),
    //                   ),
    //                 ),
    //                 SizedBox(
    //                   width: 20.sp,
    //                 ),
    //                 Expanded(
    //                   child: InkWell(
    //                     onTap: () {
    //                       updateLevel();
    //                     },
    //                     child: Container(
    //                       height: 60,
    //                       decoration: BoxDecoration(
    //                           color: Get.theme.primaryColor,
    //                           borderRadius: BorderRadius.circular(10.sp),
    //                           border:
    //                               Border.all(color: Get.theme.primaryColor)),
    //                       child: Center(
    //                         child: Txt(
    //                           text: 'Agree',
    //                           color: Colors.white,
    //                           fsize: 14,
    //                           weight: FontWeight.w600,
    //                         ),
    //                       ),
    //                     ),
    //                   ),
    //                 ),
    //               ],
    //             ),
    //           ],
    //         ),
    //       ),
    //       height: Get.height * .3,
    //       decoration: BoxDecoration(
    //           color: Colors.white,
    //           borderRadius: BorderRadius.only(
    //               topLeft: Radius.circular(20.sp),
    //               topRight: Radius.circular(20.sp)))));
    // }
    // if (userData[0]['currentLevelIsCompleted'] &&
    //     userData[0]['currentLevel'] == 1 &&
    //     leauge == 'Bronze') {
    //   Get.bottomSheet(Container(
    //       child: Padding(
    //         padding: EdgeInsets.all(12.0.sp),
    //         child: Column(
    //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //           crossAxisAlignment: CrossAxisAlignment.start,
    //           children: [
    //             Column(
    //               crossAxisAlignment: CrossAxisAlignment.start,
    //               children: [
    //                 Txt(
    //                   text: userData[0]['currentLevel'].toString() == '1'
    //                       ? 'Are you ready to move Silver Level?'
    //                       : 'Are you ready to move Gold Level?',
    //                   weight: FontWeight.bold,
    //                 ),
    //                 SizedBox(
    //                   height: 9.sp,
    //                 ),
    //                 Row(
    //                   children: [
    //                     Txt(
    //                       text: userData[0]['currentLevel'].toString() == '1'
    //                           ? 'Rs 500 debited from your wallet'
    //                           : 'Rs 5000 debited from your wallet',
    //                       fsize: 13,
    //                       weight: FontWeight.normal,
    //                     ),
    //                   ],
    //                 ),
    //               ],
    //             ),
    //             Row(
    //               children: [
    //                 Expanded(
    //                   child: InkWell(
    //                     onTap: () => Get.back(),
    //                     child: Container(
    //                       height: 60,
    //                       decoration: BoxDecoration(
    //                           borderRadius: BorderRadius.circular(10.sp),
    //                           border:
    //                               Border.all(color: Get.theme.primaryColor)),
    //                       child: Center(
    //                         child: Txt(
    //                           text: 'Disagree',
    //                           color: Get.theme.primaryColor,
    //                           fsize: 14,
    //                           weight: FontWeight.w600,
    //                         ),
    //                       ),
    //                     ),
    //                   ),
    //                 ),
    //                 SizedBox(
    //                   width: 20.sp,
    //                 ),
    //                 Expanded(
    //                   child: InkWell(
    //                     onTap: () {
    //                       updateLevel();
    //                     },
    //                     child: Container(
    //                       height: 60,
    //                       decoration: BoxDecoration(
    //                           color: Get.theme.primaryColor,
    //                           borderRadius: BorderRadius.circular(10.sp),
    //                           border:
    //                               Border.all(color: Get.theme.primaryColor)),
    //                       child: Center(
    //                         child: Txt(
    //                           text: 'Agree',
    //                           color: Colors.white,
    //                           fsize: 14,
    //                           weight: FontWeight.w600,
    //                         ),
    //                       ),
    //                     ),
    //                   ),
    //                 ),
    //               ],
    //             ),
    //           ],
    //         ),
    //       ),
    //       height: Get.height * .3,
    //       decoration: BoxDecoration(
    //           color: Colors.white,
    //           borderRadius: BorderRadius.only(
    //               topLeft: Radius.circular(20.sp),
    //               topRight: Radius.circular(20.sp)))));
    // }

    print('...' + data['data'][0]['treeMembers'].toString().toString());
  }

  void getFavList() async {
    var response = await BaseClient().get(API().getFav).catchError(handleError);
    if (response == null) return;
    var data = json.decode(response);
    print('My Fav' + data.toString());
    favlist.value = data['data'][0]['favourites'];
    filterfavlist.value = favlist;
  }

  void updateLevel() async {
    showLoading();
    var response =
        await BaseClient().post(API().updateLevel, {}).catchError(handleError);
    if (response == null) return;
    var data = json.decode(response);
    print('My Fav' + data.toString());
    Fluttertoast.showToast(msg: 'Unlocked successfully');
    Get.offAll(() => BottomBar(currentindex: 2));
    hideLoading();
  }

  void getMoreAuthBooks(id) async {
    var response = await BaseClient()
        .get(
          API().authorBooks + '?id=$id',
        )
        .catchError(handleError);
    if (response == null) return;
    var data = json.decode(response);

    moreAuthBooks.value = data['data'];
    log('moreBooks' + moreAuthBooks.toString());
  }

  void getChatList() async {
    var response =
        await BaseClient().get(API().mychats).catchError(handleError);
    if (response == null) return;
    var data = json.decode(response);
    print('My Chat' + data.toString());
    if (data['data'].toString() != '[]') {
      chatlist.value = data['data'][0]['messages'];
    }
  }

  void getAuthors() async {
    var response =
        await BaseClient().get(API().getauthers).catchError(handleError);
    if (response == null) return;
    var data = json.decode(response);

    authorslist.value = data['data'];
  }

  void getwithtokenAuthors() async {
    var response =
        await BaseClient().get(API().gethomeauthers).catchError(handleError);
    if (response == null) return;
    var data = json.decode(response);

    homeauthorslist.value = data['data'];
  }

  void getwithtokenCat() async {
    var response =
        await BaseClient().get(API().gethomecat).catchError(handleError);
    if (response == null) return;
    var data = json.decode(response);

    homecatlist.value = data['data'];
  }

  void getNewLaunchs() async {
    var response = await BaseClient()
        .get(API().getBooks + '/view?sort=desc')
        .catchError(handleError);
    if (response == null) return;
    var data = json.decode(response);
    log('Newwww' + data.toString());
    newlaunchlist.value = data['data'];
  }

  void getBudgetBooks({isSuffle = false}) async {
    var response = await BaseClient()
        .get(API().getBooks + '/view?sort=costAsc')
        .catchError(handleError);
    if (response == null) return;
    var data = json.decode(response);
    print(data.toString());
    bugetBookslist.value = data['data'];
    filterBook.value = bugetBookslist;
    if (isSuffle) {
      filterBook.shuffle();
    }
  }

  void getuserData() async {
    showLoad.value = true;
    print('sssss');
    var response =
        await BaseClient().get(API().getUserData).catchError(handleError);
    if (response == null) return;
    var data = json.decode(response);
    log('My Details' + data.toString());
    if (data['data'][0]['walletCount'] != 0) {
      walletData.value = data['data'][0]['walletData'];
    }

    print('My Wallet' + walletData.toString());
    userData.value = data['data'];
    pname.text = userData[0]['name'];
    pphone.text = userData[0]['phone_no'];
    pcity.text = userData[0]['city'];
    pemail.text = userData[0]['email'];
    isOwn.value = userData[0]['isBookOwner'];
    print('eeee' + userData[0]['parentDetail'].toString());
    showLoad.value = false;

    getNotifications(userData[0]['_id']);
  }

  void getNotifications(id) async {
    var response = await BaseClient()
        .get(API().getNotifications + id)
        .catchError(handleError);
    if (response == null) return;
    var data = json.decode(response);
    log('notiiii' + data.toString());
    notifications.value = data['data'];
  }

  void getbookDetails() async {
    // selectedBookId.value = id.toString();
    var response = await BaseClient()
        .get(API().getBooks + '/view?id=${selectedBookId.value}')
        .catchError(handleError);
    if (response == null) return;
    var data = json.decode(response);
    log(data.toString());
    bookDetails.value = data['data'];
    print('hhhhhh' + bookDetails[0]['authorDetails'][0]['_id']);
    getMoreAuthBooks(bookDetails[0]['authorDetails'][0]['_id']);
    // if (bookDetails[0]['paperBookPrice'] == null) {
    //   iskuberaEdition.value = true;
    // } else {
    //   iskuberaEdition.value = bookDetails[0]['cartCount'] >= 1 ? false : true;
    // }
  }

  void getCart({type = 'cart', screen = false}) async {
    var response =
        await BaseClient().get(API().getCart + type).catchError(handleError);
    if (response == null) return;
    var data = json.decode(response);
    log('My Cart' + data.toString());
    if (type == 'cart') {
      mycart.value = data['data']['cart'];
      print('ssss' + mycart.toString());
    } else {
      myecart.value = data['data']['eCart'];
      print('eeee' + myecart.toString());
    }
    if (screen) {
      print('amaaa');
      if (mycart['totalCartCount'] == 0) {
        Get.back();
      }
    }
    myaddress.value = data['data']['selectedAddress'];
    if (myaddress != {}) {
      selectedId.value = myaddress['id'].toString();
    }
    myaddresslist.value = data['data']['address'];
  }

  void getOrders() async {
    var response = await BaseClient()
        .get(API().getOrders + 'default')
        .catchError(handleError);
    if (response == null) return;
    var data = json.decode(response);
    log('My orders' + data.toString());
    myorders.value = data['data'];
  }

  void paymentIniate({type = 'cart'}) async {
    showLoading();
    print(GetStorage().read('usertoken').toString());
    var response = await BaseClient()
        .get(API().paymentinit + type)
        .catchError(handleError);
    if (response == null) return;
    var data = json.decode(response);
    hideLoading();
    print('My Pay' + data.toString());
    try {
      var options = {
        'key': 'rzp_test_mdSTqUKee9swri',
        'amount': data['data']['amount'],
        'order_id': '${data['data']['id']}',
        'name': 'Kuberaa Technologies',
        'description': 'Book',
        'retry': {'enabled': true, 'max_count': 1},
        'send_sms_hash': true,
        'external': {
          'wallets': ['paytm']
        }
      };
      _razorpay.open(options);
    } catch (e) {
      print(e.toString());
    }
  }

  void addtoCart(id, count,
      {type = 'cart', showload = true, iscartscreen = false}) async {
    print(count);
    showLoading();

    var request = {
      'id': id,
      'quantity': count,
      'cartType': iscartscreen
          ? type
          : iskuberaEdition.value
              ? 'eCart'
              : type
    };
    var response = await BaseClient()
        .post(API().addtoCart, request)
        .catchError(handleError);
    if (response == null) return;
    var data = json.decode(response);
    print(data.toString());
    getCart(screen: iscartscreen, type: type);
    getCart(screen: iscartscreen, type: 'eCart');

    getbookDetails();
    hideLoading();
  }

  void addtoFav(id, value, {isSuffle = false}) async {
    var request = {
      'id': id,
      'isFavourite': value,
    };
    var response = await BaseClient()
        .post(API().addtoFav, request)
        .catchError(handleError);
    if (response == null) return;
    var data = json.decode(response);
    print(data.toString());
    getFavList();
    getNewLaunchs();
    getBudgetBooks(isSuffle: isSuffle);
  }

  void addRefID(
    id,
  ) async {
    showLoading();
    var request = {
      'referralId': id,
    };
    var response = await BaseClient()
        .post(API().addtoRef, request)
        .catchError(handleError);
    if (response == null) return;
    var data = json.decode(response);
    print(data.toString());
    Fluttertoast.showToast(msg: data['message']);
    getuserData();
    hideLoading();
  }

  void savePage(bookId, pageNo) async {
    var request = {'bookId': bookId, 'pdfPageNo': pageNo};
    var response = await BaseClient()
        .post(API().saveBook, request)
        .catchError(handleError);
    if (response == null) return;
    var data = json.decode(response);
    print(data.toString());
    getlibraryBooks();
  }

  void addChat(
    msg,
  ) async {
    var request = {
      'message': msg,
    };
    var response = await BaseClient()
        .post(API().addmessage, request)
        .catchError(handleError);
    if (response == null) return;
    var data = json.decode(response);
    print(data.toString());
    getChatList();
  }

  void authorBooks(
    id,
  ) async {
    var response = await BaseClient()
        .get(
          API().authorBooks + '?id=$id',
        )
        .catchError(handleError);
    if (response == null) return;
    var data = json.decode(response);
    log('author Books' + data.toString());
    authorBooklist.value = data['data'];
    hideLoading();
  }

  void catWiseBooks(
    id,
  ) async {
    var response = await BaseClient()
        .get(
          API().getBooks + '/view?category=$id',
        )
        .catchError(handleError);
    if (response == null) return;
    var data = json.decode(response);
    print(data.toString());
    categoryBooklist.value = data['data'];
  }

  void getlibraryBooks() async {
    var response = await BaseClient()
        .get(
          API().libraryBooks,
        )
        .catchError(handleError);
    if (response == null) return;
    var data = json.decode(response);
    log('My Lib' + data.toString());
    mylibbook.clear();
    if (data['data'].toString() != '[]') {
      continueBooks.clear();

      libraryBookList.value = data['data'][0]['products'];

      mylibbook.value = libraryBookList;
      for (var i = 0; i < mylibbook.length; i++) {
        if (mylibbook[i]['pdfPageNo'].toString() != 'null') {
          continueBooks.add(mylibbook[i]);
          print(mylibbook[i]['pdfPageNo'] != 0);
        }
      }
    }
  }

  void getpopularBooks() async {
    var response = await BaseClient()
        .get(
          API().popularBooks,
        )
        .catchError(handleError);
    if (response == null) return;
    var data = json.decode(response);
    log('My Pop' + data.toString());
    // mylibbook.clear();
    // mypopBooks.clear();
    if (data['data'].toString() != '[]') {
      popularBooksCat.value = data['data'];
      for (int i = 0; i < popularBooksCat.length; i++) {
        if (popularBooksCat[i]['_id'] == 'All') {
          print('Heyyyy' + popularBooksCat[i]['products'].toString());
          mypopBooks.value = popularBooksCat[i]['products'];
        }
        // popularBookList.value = data['data'][0]['products'];

        // for (var i = 0; i < mypopBooks.length; i++) {
        //   if (mypopBooks[i]['pdfPageNo'].toString() != 'null') {
        //     continueBooks.add(mylibbook[i]);
        //     print(mypopBooks[i]['pdfPageNo'] != 0);
        //   }
        // }
      }
      // continueBooks.clear();

      // popularBookList.value = data['data'][0]['products'];

      // mylibbook.value = popularBookList;
      // for (var i = 0; i < mylibbook.length; i++) {
      //   if (mylibbook[i]['pdfPageNo'].toString() != 'null') {
      //     continueBooks.add(mylibbook[i]);
      //     print(mylibbook[i]['pdfPageNo'] != 0);
      //   }
      // }
    }
  }

  void getCatlibraryBooks() async {
    var response = await BaseClient()
        .get(
          API().libraryCatBooks,
        )
        .catchError(handleError);
    if (response == null) return;
    var data = json.decode(response);
    log('My Cat Lib' + data.toString());
    libraryCatBookList.value = data['data'];
    if (libraryCatBookList.length != 0) {
      // for (var i = 0; i < libraryCatBookList[0]['products'].length; i++) {
      //   mylibbook.add(libraryCatBookList[0]['products'][i]);
      // }
    }
  }

  void getPoplibraryBooks() async {
    var response = await BaseClient()
        .get(
          API().popularcatBooks,
        )
        .catchError(handleError);
    if (response == null) return;
    var data = json.decode(response);
    log('My Pop Lib' + data.toString());
    libraryCatBookList.value = data['data'];
    if (libraryCatBookList.length != 0) {
      // for (var i = 0; i < libraryCatBookList[0]['products'].length; i++) {
      //   mylibbook.add(libraryCatBookList[0]['products'][i]);
      // }
    }
  }

  void addAddress() async {
    showLoading();

    var request = {
      'address': {
        'name': name.text,
        'door_no': doorno.text,
        'street': streetname.text,
        'city': city.text,
        'landmark': landmark.text,
        'pincode': pincode.text,
        'type': ishome.value ? 'Home' : 'Office'
      },
    };
    var response = await BaseClient()
        .putReq(API().address, request)
        .catchError(handleError);
    if (response == null) return;
    var data = json.decode(response);
    print(data.toString());

    getCart();
    hideLoading();
    Get.back();
  }

  void deleteAddress(id) async {
    showLoading();

    var request = {
      "removeAddress": {
        "id": id,
      },
    };
    var response = await BaseClient()
        .putReq(API().address, request)
        .catchError(handleError);
    if (response == null) return;
    var data = json.decode(response);
    print(data.toString());

    getCart();
    hideLoading();
  }

  void editAddress() async {
    showLoading();

    var request = {
      "address": {
        "id": EditId.value,
        'name': name.text,
        'door_no': doorno.text,
        'street': streetname.text,
        'city': city.text,
        'landmark': landmark.text,
        'pincode': pincode.text,
        'type': ishome.value ? 'Home' : 'Office'
      },
    };
    var response = await BaseClient()
        .putReq(API().address, request)
        .catchError(handleError);
    if (response == null) return;
    var data = json.decode(response);
    print(data.toString());

    getCart();
    hideLoading();
    Get.back();
  }

  void addressSelect(
      id, name, doorno, street, city, landmark, pincode, type) async {
    // showLoading();

    var request = {
      "selectedAddress": {
        "id": id,
        'name': name,
        'door_no': doorno,
        'street': street,
        'city': city,
        'landmark': landmark,
        'pincode': pincode,
        'type': type
      },
    };
    var response = await BaseClient()
        .putReq(API().address, request)
        .catchError(handleError);
    if (response == null) return;
    var data = json.decode(response);
    print(data.toString());

    getCart();
    // hideLoading();
  }

  void profileUpdate() async {
    showLoading();

    var request = {
      'name': pname.text,
      'city': pcity.text,
      'email': pemail.text
    };
    var response = await BaseClient()
        .putReq(API().address, request)
        .catchError(handleError);
    if (response == null) return;
    var data = json.decode(response);
    print(data.toString());
    Fluttertoast.showToast(msg: 'Profile Updated!');
    getuserData();
    hideLoading();
  }

  void profileImgUpdate() async {
    final AuthCon acon = Get.find();

    var request = {
      'profile_image': acon.profilePicKey,
    };
    var response = await BaseClient()
        .putReq(API().address, request)
        .catchError(handleError);
    if (response == null) return;
    var data = json.decode(response);
    print(data.toString());

    getuserData();
  }

  ///Walllettttt/////

  void addBankAcc({type = 'bankAccount'}) async {
    showLoading();
    var bankRequest = {
      "accountType": type,
      "AccountHolderName": wname.text,
      "bankAccountNumber": wacnumber.text,
      "IFSC": wifsc.text,
      "bankName": wbankname.text,
    };
    var upiRequest = {
      "phoneNumber": wphone.text,
      if (wupi.text.isNotEmpty) "UPIID": wupi.text,
      "walletType": wwalletType.text,
      "accountType": "UPIAccount"
    };
    var response = await BaseClient()
        .post(
            API().addBankAcc, type == 'bankAccount' ? bankRequest : upiRequest)
        .catchError(handleError);
    if (response == null) return;
    var data = json.decode(response);
    hideLoading();
    Get.back();
    wname.clear();
    wacnumber.clear();
    wacrenumber.clear();
    wifsc.clear();
    wphone.clear();
    wupi.clear();
    wbankname.clear();
    wwalletType.clear();
    getuserData();
    print(data.toString());
    Fluttertoast.showToast(msg: data['message'].toString());
  }

  void updateBankAcc({type = 'bankAccount'}) async {
    showLoading();
    var bankRequest = {
      "accountType": type,
      "AccountHolderName": wname.text,
      "bankAccountNumber": wacnumber.text,
      "IFSC": wifsc.text,
      "bankName": wbankname.text,
      "id": bankId.value.toString(),
    };
    var upiRequest = {
      "phoneNumber": wphone.text,
      "UPIID": wupi.text,
      "walletType": wwalletType.text,
      "id": bankId.value.toString(),
    };
    var response = await BaseClient()
        .patch(API().updateBankAcc,
            type == 'bankAccount' ? bankRequest : upiRequest)
        .catchError(handleError);
    if (response == null) return;
    var data = json.decode(response);
    hideLoading();
    Get.back();
    wname.clear();
    wacnumber.clear();
    wacrenumber.clear();
    wifsc.clear();
    wphone.clear();
    wupi.clear();
    wbankname.clear();
    wwalletType.clear();
    getuserData();
    print(data.toString());
    Fluttertoast.showToast(msg: data['message'].toString());
  }

  void getTrasaction({type = 'all'}) async {
    translist.clear();
    var response = await BaseClient()
        .get(
          API().getTransactions + type,
        )
        .catchError(handleError);
    if (response == null) return;
    var data = json.decode(response);
    log('My Trans' + data.toString());
    translist.value = data['data'];
  }

  void withdrawReq(amount, wId) async {
    showLoading();
    var request = {'amount': amount, 'walletId': wId};
    var response = await BaseClient()
        .post(API().walletReq, request)
        .catchError(handleError);
    if (response == null) return;
    var data = json.decode(response);
    print(data.toString());
    hideLoading();
    getuserData();
    getTrasaction();
    Get.dialog(
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DialogWidget(
              btnTap: () {
                Get.offAll(() => BottomBar(currentindex: 0));
              },
              title: 'Congrats!',
              subtile:
                  'Your amount will be transfered from account 1 - 3 business days',
              btntext: 'Dismiss',
              icon: 'assets/success.json',
            ),
          ],
        ),
        barrierDismissible: false);
  }

  void addCashReq(amount) async {
    showLoading();
    var request = {
      'amount': amount,
    };
    var response =
        await BaseClient().post(API().addCash, request).catchError(handleError);
    if (response == null) return;
    var data = json.decode(response);
    print(data.toString());
    hideLoading();
    try {
      var options = {
        'key': 'rzp_test_mdSTqUKee9swri',
        'amount': data['data']['amount'],
        'order_id': '${data['data']['id']}',
        'name': 'Kuberaa Technologies',
        'description': 'Add Cash',
        'retry': {'enabled': true, 'max_count': 1},
        'send_sms_hash': true,
        'external': {
          'wallets': ['paytm']
        }
      };
      _razorpayCash.open(options);
    } catch (e) {
      print(e.toString());
    }
  }

  void refundReq(id, pId, count, reason) async {
    showLoading();
    final AuthCon acon = Get.find();
    var request = {
      "id": id.toString(),
      "productId": pId.toString(),
      "count": count.toString(),
      "reason": reason.toString(),
      "images": acon.refundPicsList
    };

    var response = await BaseClient()
        .post(API().refundReq, request)
        .catchError(handleError);
    if (response == null) return;
    var data = json.decode(response);
    print(data.toString());
    acon.refundPicsList.clear();
    acon.refundPicKey = '';
    acon.refundPicUrl.value = '';
    showrefundlist.clear();
    getOrders();
    hideLoading();

    Get.back();

    Fluttertoast.showToast(msg: data['message']);
  }

  void addFeedback(
    msg,
  ) async {
    showLoading();
    var request = {
      'message': msg,
    };
    var response =
        await BaseClient().post(API().addfeed, request).catchError(handleError);
    if (response == null) return;
    var data = json.decode(response);
    print(data.toString());
    Fluttertoast.showToast(msg: data['message']);

    hideLoading();
    Get.back();
  }
}
