import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kubera/controller/init.dart';
import 'package:kubera/widgets/text.dart';
import 'package:sizer/sizer.dart';

class ViewAllView extends StatefulWidget {
  ViewAllView({Key? key}) : super(key: key);

  @override
  State<ViewAllView> createState() => _ViewAllViewState();
}

class _ViewAllViewState extends State<ViewAllView>
    with TickerProviderStateMixin {
  TabController? _controller;
  @override
  void initState() {
    super.initState();
    _controller = TabController(vsync: this, length: 3);
  }

  var selctedindex = 0;
  final InitCon icon = Get.find();

  Future<bool> willpop() {
    icon.getTrasaction(type: 'all');

    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: willpop,
      child: Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.transparent,
            leading: IconButton(
                onPressed: () {
                  Get.back();
                  icon.getTrasaction(type: 'all');
                },
                icon: const Icon(
                  Icons.arrow_back_ios_new,
                  color: Colors.black,
                )),
            elevation: 0,
            title: Txt(
              text: 'View Transaction',
              defalutsize: true,
              weight: FontWeight.bold,
            )),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.sp),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 30.sp,
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: 3,
                  itemBuilder: (BuildContext context, int index) => Row(
                    children: [
                      InkWell(
                        onTap: () {
                          setState(() {
                            selctedindex = index;
                            print(selctedindex.toString());
                            if (selctedindex == 0) {
                              icon.getTrasaction(type: 'credit');
                            } else if (selctedindex == 1) {
                              icon.getTrasaction(type: 'withdraw');
                            } else if (selctedindex == 2) {
                              icon.getTrasaction(type: 'cancelled');
                            }
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6.sp),
                              border: Border.all(
                                  color: selctedindex == index && index == 0
                                      ? Colors.green
                                      : selctedindex == index && index == 1
                                          ? Colors.red[400]!
                                          : selctedindex == index && index == 2
                                              ? Colors.orange[200]!
                                              : Colors.grey)),
                          child: Center(
                            child: Txt(
                              text: index == 0
                                  ? '    Credit    '
                                  : index == 1
                                      ? '  Withdraw  '
                                      : '  Cancelled   ',
                              color: selctedindex == index && index == 0
                                  ? Colors.green
                                  : selctedindex == index && index == 1
                                      ? Colors.red[400]!
                                      : selctedindex == index && index == 2
                                          ? Colors.orange[200]!
                                          : Colors.grey,
                              fsize: 10,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10.sp,
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                  child: Obx(
                () => ListView.builder(
                    itemCount: icon.translist.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        contentPadding: EdgeInsets.all(0),
                        trailing: Txt(
                          text: '₹ ${icon.translist[index]['amount']}',
                          fsize: 12,
                          color: Colors.green,
                          weight: FontWeight.bold,
                        ),
                        leading: CircleAvatar(
                          radius: 18.sp,
                          backgroundColor: selctedindex == 1
                              ? Colors.red
                              : selctedindex == 2
                                  ? Colors.orange[200]!
                                  : Get.theme.primaryColor,
                          child: Icon(
                            selctedindex == 1
                                ? Icons.call_received_rounded
                                : selctedindex == 2
                                    ? Icons.info
                                    : Icons.call_made_rounded,
                            color: Colors.white,
                            size: 16.sp,
                          ),
                        ),
                        title: Txt(
                          text: icon.translist[index]['type'],
                          weight: FontWeight.bold,
                          fsize: 12,
                        ),
                        subtitle: Txt(
                          text: icon.translist[index]['dateString'].toString(),
                          fsize: 11,
                        ),
                      );
                    }),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
