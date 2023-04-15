import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kubera/controller/init.dart';
import 'package:sizer/sizer.dart';

import '../text.dart';

class Popular extends StatefulWidget {
  final data;
  final VoidCallback? onTap;
  final String type;
  Popular({Key? key, this.data, this.onTap, this.type = ''}) : super(key: key);

  @override
  State<Popular> createState() => _PopularState();
}

class _PopularState extends State<Popular> {
  final InitCon icon = Get.find();
  var selected = -1;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 5.h,
      child: ListView.builder(
        itemCount: widget.data.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          return Row(
            children: [
              index == 0
                  ? Row(
                      children: [
                        InkWell(
                          onTap: () {
                            setState(() {
                              selected = -1;
                              // icon.mylibbook.clear();

                              icon.getlibraryBooks();

                              log(icon.libraryBookList.toString());
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: selected == -1
                                    ? Get.theme.primaryColor
                                    : Colors.grey[200],
                                borderRadius: BorderRadius.circular(999)),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 14.0.sp, vertical: 5.sp),
                              child: Txt(
                                  text: 'All',
                                  fsize: 12,
                                  color: selected == -1
                                      ? Colors.white
                                      : Colors.black87),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 8.sp,
                        )
                      ],
                    )
                  : SizedBox(),
              InkWell(
                onTap: () {
                  setState(() {
                    selected = index;
                    icon.mylibbook.clear();
                    print(index);
                    for (var i = 0;
                        i < icon.libraryCatBookList[index]['products'].length;
                        i++) {
                      icon.mylibbook
                          .add(icon.libraryCatBookList[index]['products'][i]);
                    }

                    log(icon.mylibbook.toString());
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: selected == index
                          ? Get.theme.primaryColor
                          : Colors.grey[200],
                      borderRadius: BorderRadius.circular(999)),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: 14.0.sp, vertical: 5.sp),
                    child: Txt(
                        text: widget.data[index]['_id'],
                        fsize: 12,
                        color:
                            selected == index ? Colors.white : Colors.black87),
                  ),
                ),
              ),
              SizedBox(
                width: 8.sp,
              )
            ],
          );
        },
      ),
    );
  }
}

class Popular1 extends StatefulWidget {
  final data;
  final VoidCallback? onTap;
  final String type;
  Popular1({Key? key, this.data, this.onTap, this.type = ''}) : super(key: key);

  @override
  State<Popular1> createState() => _Popular1State();
}

class _Popular1State extends State<Popular1> {
  final InitCon icon = Get.find();
  var selected = 0;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 5.h,
        child: Obx(
          () => ListView.builder(
            // shrinkWrap: true,
            itemCount: widget.data.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (BuildContext context, int index) {
              return Row(
                children: [
                  // index == -1
                  //     ? Row(
                  //         children: [
                  //           InkWell(
                  //             onTap: () {
                  //               setState(() {
                  //                 // selected = -1;
                  //                 print('hey');
                  //                 // icon.mylibbook.clear();
                  //                 icon.mypopBooks.clear();
                  //                 for (var i = 0;
                  //                     i < icon.popularBooksCat.length;
                  //                     i++) {
                  //                   if (icon.popularBooksCat[i]['_id'] ==
                  //                       widget.data[index]['_id']) {
                  //                     print('buddy+$i');

                  //                     print('Heyyyy' +
                  //                         icon.popularBooksCat[i].toString());
                  //                     icon.mypopBooks.value =
                  //                         icon.popularBooksCat[i]['data'];
                  //                     // icon.mypopBooks.value
                  //                   }
                  //                 }
                  //                 // icon.getpopularBooks();
                  //                 // icon.mypopBooks.clear();
                  //                 // for (var i = 0;
                  //                 //     i <
                  //                 //         icon.popularBookList[index]['data']
                  //                 //             .length;
                  //                 //     i++) {
                  //                 //   if (icon.popularBookList[i]['_id'] == 'All') {
                  //                 //     icon.mypopBooks.value =
                  //                 //         icon.popularBookList[index]['products'];
                  //                 //   }
                  //                 // }
                  //                 // log(icon.mypopBooks.toString());
                  //               });
                  //             },
                  //             child: Container(
                  //               decoration: BoxDecoration(
                  //                   color: selected == -1
                  //                       ? Get.theme.primaryColor
                  //                       : Colors.grey[200],
                  //                   borderRadius: BorderRadius.circular(999)),
                  //               child: Padding(
                  //                 padding: EdgeInsets.symmetric(
                  //                     horizontal: 14.0.sp, vertical: 5.sp),
                  //                 child: Txt(
                  //                     text: 'All',
                  //                     fsize: 12,
                  //                     color: selected == -1
                  //                         ? Colors.white
                  //                         : Colors.black87),
                  //               ),
                  //             ),
                  //           ),
                  //           SizedBox(
                  //             width: 8.sp,
                  //           )
                  //         ],
                  //       )
                  //     : SizedBox(),
                  InkWell(
                    onTap: () {
                      setState(() {
                        selected = index;
                        print("sss" + widget.data[index]['_id']);
                        // icon.mypopBooks.clear();
                        for (var i = 0; i < icon.popularBooksCat.length; i++) {
                          if (icon.popularBooksCat[i]['_id'] ==
                              widget.data[index]['_id']) {
                            print('buddy+$i');

                            print('Heyyyy' + icon.popularBooksCat.toString());
                            if (widget.data[index]['_id'] == 'All') {
                              icon.mypopBooks.value =
                                  icon.popularBooksCat[i]['products'];
                            } else {
                              icon.mypopBooks.value =
                                  icon.popularBooksCat[i]['data'];
                            }
                          }
                        }

                        log(icon.mypopBooks.toString());
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: selected == index
                              ? Get.theme.primaryColor
                              : Colors.grey[200],
                          borderRadius: BorderRadius.circular(999)),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 14.0.sp, vertical: 5.sp),
                        child: Txt(
                            text: widget.data[index]['_id'],
                            fsize: 12,
                            color: selected == index
                                ? Colors.white
                                : Colors.black87),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 8.sp,
                  )
                ],
              );
            },
          ),
        ));
  }
}
