import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:kubera/controller/init.dart';
import 'package:kubera/widgets/appbar.dart';
import 'package:kubera/widgets/text.dart';
import 'package:sizer/sizer.dart';

import '../../widgets/dialog.dart';
import 'add_bank.dart';
import 'add_upi.dart';

class BankMain extends StatefulWidget {
  int index;
  bool isUpdate;
  String grpType;
  BankMain({Key? key, this.index = 0, this.isUpdate = false, this.grpType = ''})
      : super(key: key);

  @override
  State<BankMain> createState() => _BankMainState();
}

class _BankMainState extends State<BankMain>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);

    super.initState();
  }

  final InitCon icon = Get.find();

  @override
  void dispose() {
    super.dispose();
    _tabController!.dispose();

    icon.wname.clear();
    icon.wacnumber.clear();
    icon.wacrenumber.clear();
    icon.wifsc.clear();
    icon.wphone.clear();
    icon.wupi.clear();
    icon.wbankname.clear();
    icon.wwalletType.clear();
  }

  @override
  Widget build(BuildContext context) {
    var currentInt = widget.index;
    if (currentInt == 0) {
      _tabController!.animateTo(0);
    } else {
      _tabController!.animateTo(1);
    }
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: BaseAppBar(backicon: true, title: 'Account Details'),
      body: Column(
        children: [
          Container(height: 0.2, color: Colors.grey[400]),
          Container(
            height: 45,
            child: TabBar(
              onTap: (o) {
                setState(() {
                  widget.index = o;
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
              labelStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              unselectedLabelColor: Colors.black,
              tabs: [
                // first tab [you can add an icon using the icon property]
                Tab(
                  child: Txt(
                    text: 'Bank Account',
                    defalutsize: true,
                    color:
                        currentInt == 0 ? Get.theme.primaryColor : Colors.black,
                  ),
                ),

                // second tab [you can add an icon using the icon property]
                Tab(
                  child: Txt(
                    text: 'UPI Account',
                    defalutsize: true,
                    color:
                        currentInt == 1 ? Get.theme.primaryColor : Colors.black,
                  ),
                ),
              ],
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
                AddBankView(isUpdate: widget.isUpdate),
                AddUPIView(isUpdate: widget.isUpdate),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
