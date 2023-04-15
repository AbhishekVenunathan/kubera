import 'package:dotted_decoration/dotted_decoration.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:kubera/controller/init.dart';
import 'package:kubera/screens/wallet/add_account_tab.dart';
import 'package:kubera/widgets/text.dart';
import 'package:kubera/widgets/textfield.dart';
import 'package:sizer/sizer.dart';

class WithdrawCashView extends StatefulWidget {
  WithdrawCashView({Key? key}) : super(key: key);

  @override
  State<WithdrawCashView> createState() => _WithdrawCashViewState();
}

class _WithdrawCashViewState extends State<WithdrawCashView> {
  final TextEditingController _con = TextEditingController();
  var selectedindex = -1;
  var selectbank = -1;
  var selectedId = '';
  final InitCon icon = Get.find();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    /*24 is for notification bar on Android*/
    final double itemHeight = (size.height - kToolbarHeight - 24) / 2;
    final double itemWidth = size.width / 2;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: IconButton(
              onPressed: () => Get.back(),
              icon: const Icon(
                Icons.clear,
                color: Colors.black,
              )),
          centerTitle: true,
          elevation: 0,
          title: Txt(
            text: 'Withdraw Cash',
            defalutsize: true,
            weight: FontWeight.bold,
          )),
      body: Padding(
        padding: EdgeInsets.all(10.0.sp),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  SizedBox(
                    height: 12.sp,
                  ),
                  Row(
                    children: const [
                      Txt(
                        text: 'Enter amount',
                        fsize: 11,
                      ),
                    ],
                  ),
                  CTextField(
                    hint: 'Eg.₹1000',
                    label: 'Eg.₹1000',
                    max: 6,
                    keyboard: TextInputType.number,
                    controller: _con,
                  ),
                  SizedBox(
                    height: 20.sp,
                  ),
                  SizedBox(
                    height: 30.sp,
                    child: GridView.builder(
                        itemCount: rupees.length,
                        physics: NeverScrollableScrollPhysics(),
                        // shrinkWrap: true,
                        gridDelegate:
                            SliverGridDelegateWithFixedCrossAxisCountAndFixedHeight(
                          crossAxisCount: 4,
                          crossAxisSpacing: 5,
                          mainAxisSpacing: 5,
                          height: 30.sp,
                        ),
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              setState(() {
                                selectedindex = index;
                                _con.text = rupees[index];
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6.sp),
                                  color: selectedindex == index
                                      ? Get.theme.primaryColor
                                      : Colors.transparent,
                                  border: Border.all(
                                      color: Get.theme.primaryColor)),
                              child: Center(
                                child: Txt(
                                  fsize: 10,
                                  text: '₹' + rupees[index],
                                  color: selectedindex == index
                                      ? Colors.white
                                      : Get.theme.primaryColor,
                                ),
                              ),
                            ),
                          );
                        }),
                  ),
                  SizedBox(
                    height: 20.sp,
                  ),
                  Row(
                    children: [
                      Txt(
                        text: 'Choose an account',
                        fsize: 11,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 16.sp,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.sp),
                        color: Colors.grey[200]),
                    child: Padding(
                        padding: EdgeInsets.all(8.0.sp),
                        child: Obx(
                          () => Column(
                            children: [
                              ListView.builder(
                                  itemCount: icon.walletData.length,
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    return Column(
                                      children: [
                                        ListTile(
                                          onTap: () {
                                            setState(() {
                                              selectbank = index;
                                              selectedId =
                                                  icon.walletData[index]['_id'];
                                            });
                                          },
                                          leading: Image.asset(
                                              'assets/bank_ac.png',
                                              height: 50),
                                          title: Txt(
                                            text: icon.walletData[index]
                                                        ['accountType'] ==
                                                    'bankAccount'
                                                ? icon.walletData[index]
                                                    ['bankName']
                                                : icon.walletData[index]
                                                    ['walletType'],
                                            fsize: 11,
                                          ),
                                          trailing: Icon(
                                            selectbank == index
                                                ? Icons.radio_button_checked
                                                : Icons.radio_button_unchecked,
                                            color: Get.theme.primaryColor,
                                            size: 17.sp,
                                          ),
                                          subtitle: Txt(
                                            text: icon.walletData[index]
                                                        ['accountType'] ==
                                                    'bankAccount'
                                                ? '***' +
                                                    icon.walletData[index]['bankAccountNumber']
                                                        .substring(icon
                                                                .walletData[index]
                                                                    [
                                                                    'bankAccountNumber']
                                                                .length -
                                                            3)
                                                : icon.walletData[index]
                                                                ['UPIID']
                                                            .toString() ==
                                                        'null'
                                                    ? icon.walletData[index]
                                                            ['phoneNumber']
                                                        .toString()
                                                    : icon.walletData[index]
                                                        ['UPIID'],
                                            fsize: 9,
                                            color: Colors.grey[700]!,
                                          ),
                                        ),
                                        Container(
                                          height: 0.5,
                                          color: Colors.black,
                                        )
                                      ],
                                    );
                                  }),
                              ListTile(
                                onTap: () {
                                  Get.to(() => BankMain());
                                },
                                leading: Padding(
                                  padding: EdgeInsets.all(2.0.sp),
                                  child: Container(
                                    decoration: DottedDecoration(
                                        strokeWidth: 1,
                                        shape: Shape.box,
                                        color: Get.theme.primaryColor,
                                        borderRadius:
                                            BorderRadius.circular(2.sp)),
                                    child: Container(
                                      height: 30.sp,
                                      width: 30.sp,
                                      child: Center(
                                          child: Icon(
                                        Icons.add,
                                        size: 20.sp,
                                        color: Get.theme.primaryColor,
                                      )),
                                    ),
                                  ),
                                ),
                                title: Txt(
                                  text: 'Add new bank account',
                                  fsize: 11,
                                  weight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        )),
                  ),
                  SizedBox(
                    height: 50,
                  )
                ],
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: CupertinoButton(
                      color: Get.theme.primaryColor,
                      child: const Txt(
                        text: 'Continue',
                        color: Colors.white,
                        weight: FontWeight.bold,
                        defalutsize: true,
                      ),
                      onPressed: () {
                        if (_con.text.isEmpty || _con.text == '0') {
                          Fluttertoast.showToast(msg: 'Enter valid amount');
                        } else if (selectbank == -1) {
                          Fluttertoast.showToast(msg: 'Select bank');
                        } else {
                          icon.withdrawReq(_con.text, selectedId.toString());
                        }
                        print(selectbank);
                      }),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

var rupees = ['100', '500', '1000', '2000'];

class SliverGridDelegateWithFixedCrossAxisCountAndFixedHeight
    extends SliverGridDelegate {
  /// Creates a delegate that makes grid layouts with a fixed number of tiles in
  /// the cross axis.
  ///
  /// All of the arguments must not be null. The `mainAxisSpacing` and
  /// `crossAxisSpacing` arguments must not be negative. The `crossAxisCount`
  /// and `childAspectRatio` arguments must be greater than zero.
  const SliverGridDelegateWithFixedCrossAxisCountAndFixedHeight({
    required this.crossAxisCount,
    this.mainAxisSpacing = 0.0,
    this.crossAxisSpacing = 0.0,
    this.height = 56.0,
  })  : assert(crossAxisCount != null && crossAxisCount > 0),
        assert(mainAxisSpacing != null && mainAxisSpacing >= 0),
        assert(crossAxisSpacing != null && crossAxisSpacing >= 0),
        assert(height != null && height > 0);

  /// The number of children in the cross axis.
  final int crossAxisCount;

  /// The number of logical pixels between each child along the main axis.
  final double mainAxisSpacing;

  /// The number of logical pixels between each child along the cross axis.
  final double crossAxisSpacing;

  /// The height of the crossAxis.
  final double height;

  bool _debugAssertIsValid() {
    assert(crossAxisCount > 0);
    assert(mainAxisSpacing >= 0.0);
    assert(crossAxisSpacing >= 0.0);
    assert(height > 0.0);
    return true;
  }

  @override
  SliverGridLayout getLayout(SliverConstraints constraints) {
    assert(_debugAssertIsValid());
    final double usableCrossAxisExtent =
        constraints.crossAxisExtent - crossAxisSpacing * (crossAxisCount - 1);
    final double childCrossAxisExtent = usableCrossAxisExtent / crossAxisCount;
    final double childMainAxisExtent = height;
    return SliverGridRegularTileLayout(
      crossAxisCount: crossAxisCount,
      mainAxisStride: childMainAxisExtent + mainAxisSpacing,
      crossAxisStride: childCrossAxisExtent + crossAxisSpacing,
      childMainAxisExtent: childMainAxisExtent,
      childCrossAxisExtent: childCrossAxisExtent,
      reverseCrossAxis: axisDirectionIsReversed(constraints.crossAxisDirection),
    );
  }

  @override
  bool shouldRelayout(
      SliverGridDelegateWithFixedCrossAxisCountAndFixedHeight oldDelegate) {
    return oldDelegate.crossAxisCount != crossAxisCount ||
        oldDelegate.mainAxisSpacing != mainAxisSpacing ||
        oldDelegate.crossAxisSpacing != crossAxisSpacing ||
        oldDelegate.height != height;
  }
}
