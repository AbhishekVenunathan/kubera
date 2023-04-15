import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:kubera/controller/init.dart';
import 'package:kubera/widgets/appbar.dart';
import 'package:kubera/widgets/text.dart';
import 'package:sizer/sizer.dart';

import '../../widgets/dialog.dart';
import 'e-book.dart';
import 'hard_copy.dart';

class CartMain extends StatefulWidget {
  const CartMain({Key? key}) : super(key: key);

  @override
  State<CartMain> createState() => _CartMainState();
}

class _CartMainState extends State<CartMain>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    if (icon.mycart['itemsCount'].toString() == '0') {
      _tabController!.animateTo(1);
      currentInt = 1;
    } else if (icon.myecart['itemsCount'].toString() == '0') {
      _tabController!.animateTo(0);
      currentInt = 0;
    }
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController!.dispose();
  }

  var currentInt = 0;
  final InitCon icon = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(backicon: true, title: 'Cart'),
      body: Column(
        children: [
          Container(height: 0.2, color: Colors.grey[400]),
          Container(
            height: 45,
            child: IgnorePointer(
              ignoring: icon.mycart['itemsCount'].toString() == '0' ||
                      icon.myecart['itemsCount'].toString() == '0'
                  ? true
                  : false,
              child: TabBar(
                onTap: (o) {
                  setState(() {
                    currentInt = o;
                  });
                },
                controller: _tabController,
                indicatorColor: Get.theme.primaryColor,
                // give the indicator a decoration (color and border radius)
                // indicator: BoxDecoration(
                //     borderRadius: BorderRadius.circular(
                //       25.0,
                //     ),
                //     color: Get.theme.primaryColor),
                labelColor: Get.theme.primaryColor,
                labelStyle:
                    TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                unselectedLabelColor: Colors.black,
                tabs: [
                  // first tab [you can add an icon using the icon property]
                  Tab(
                    child: Txt(
                      text: 'Hardcopy',
                      defalutsize: true,
                      color: currentInt == 0
                          ? Get.theme.primaryColor
                          : Colors.black,
                    ),
                  ),

                  // second tab [you can add an icon using the icon property]
                  Tab(
                    child: Txt(
                      text: 'E-book',
                      defalutsize: true,
                      color: currentInt == 1
                          ? Get.theme.primaryColor
                          : Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: 0.7,
            color: Colors.grey[400],
          ),
          Expanded(
            child: TabBarView(
              physics: NeverScrollableScrollPhysics(),
              controller: _tabController,
              children: [
                HardCopyView(),
                EBookView(),
              ],
            ),
          ),
          Obx(
            () => Container(
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10.sp),
                    topRight: Radius.circular(10.sp),
                  ),
                  color: Colors.white),
              child: ListTile(
                title: Txt(
                  text: 'Total cost',
                  fsize: 11,
                  color: Colors.grey[400]!,
                ),
                trailing: InkWell(
                  onTap: () {
                    if (currentInt == 0) {
                      if (icon.myaddress.toString() == '{}') {
                        Fluttertoast.showToast(msg: 'Please add address');
                      } else if (icon.mycart['itemsCount'] == 0) {
                        Fluttertoast.showToast(msg: 'Please add books');
                      } else {
                        icon.paymentIniate();
                      }
                    } else {
                      if (icon.myecart['itemsCount'] == 0) {
                        Fluttertoast.showToast(msg: 'Please add books');
                      } else {
                        icon.paymentIniate(type: 'eCart');
                      }
                    }

                    //  Get.back();
                  },
                  child: Container(
                    width: 150.sp,
                    height: 50,
                    decoration: BoxDecoration(
                        color: Get.theme.primaryColor,
                        borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Txt(
                          text: 'Proceed to checkout',
                          color: Colors.white,
                          weight: FontWeight.w700,
                          fsize: 10,
                        ),
                      ],
                    ),
                  ),
                ),
                subtitle: Row(
                  children: [
                    Txt(
                      text: currentInt == 0
                          ? '${icon.mycart['itemsCount']} item '
                          : '${icon.myecart['itemsCount']} item ',
                      fsize: 12,
                      weight: FontWeight.w500,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 3.sp),
                      child: Container(
                        height: 20,
                        color: Colors.grey[400],
                        width: 0.3,
                      ),
                    ),
                    Txt(
                      text: currentInt == 0
                          ? '₹ ${icon.mycart['total']}'
                          : '₹ ${icon.myecart['total']}',
                      fsize: 12,
                      color: Get.theme.primaryColor,
                      weight: FontWeight.w800,
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
