import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:kubera/controller/init.dart';
import 'package:kubera/widgets/home/search_bar.dart';
import 'package:sizer/sizer.dart';

import '../../widgets/appbar.dart';
import '../../widgets/text.dart';

class MyWishList extends StatefulWidget {
  MyWishList({Key? key}) : super(key: key);

  @override
  State<MyWishList> createState() => _MyWishListState();
}

class _MyWishListState extends State<MyWishList> {
  final InitCon icon = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        backicon: true,
        title: 'Wishlist',
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0.sp),
        child: Column(
          children: [
            Obx(() => icon.filterfavlist.isEmpty
                ? SizedBox()
                : SearchBar(
                    enabled: true,
                  )),
            Expanded(
                child: Obx(
              () => icon.filterfavlist.isEmpty
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('assets/empty_list.png'),
                        SizedBox(
                          height: 20.sp,
                        ),
                        Center(
                          child: Txt(
                            text: 'No Data Found',
                          ),
                        ),
                      ],
                    )
                  : GridView.builder(
                      itemCount: icon.filterfavlist.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2, childAspectRatio: 0.65),
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
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
                                  offset: Offset(
                                      0, 3), // changes position of shadow
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(10.sp),
                                      topRight: Radius.circular(10.sp)),
                                  child: Stack(
                                    children: [
                                      Image.network(
                                        icon.filterfavlist[index]
                                            ['book_cover_file_url'],
                                        height: 130.sp,
                                        width: double.infinity,
                                        fit: BoxFit.cover,
                                      ),
                                      Positioned(
                                        top: 6.sp,
                                        right: 6.sp,
                                        child: InkWell(
                                          onTap: () {
                                            setState(() {
                                              icon.addtoFav(
                                                  icon.filterfavlist[index]
                                                      ['_id'],
                                                  false);
                                            });
                                            icon.filterfavlist.removeAt(index);
                                          },
                                          child: CircleAvatar(
                                            radius: 12.sp,
                                            backgroundColor: Colors.white,
                                            child: Icon(
                                              CupertinoIcons.heart_fill,
                                              size: 15.sp,
                                              color: Colors.red,
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(6.0.sp),
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 2.sp,
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Txt(
                                              text: icon.filterfavlist[index]
                                                  ['book_name'],
                                              weight: FontWeight.bold,
                                              fsize: 10,
                                              lines: 2,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 6.0.sp),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Txt(
                                              text: icon.filterfavlist[index]
                                                      ['authorDetails'][0]
                                                  ['author_name'],
                                              weight: FontWeight.bold,
                                              fsize: 10,
                                              lines: 1,
                                              color: Colors.grey[400]!,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Spacer(),
                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 5.0.sp),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            children: [
                                              Row(
                                                children: [
                                                  Txt(
                                                    text:
                                                        '₹ ${icon.filterfavlist[index]['discount_price']} ',
                                                    weight: FontWeight.bold,
                                                    fsize: 10,
                                                  ),
                                                ],
                                              ),
                                              Txt(
                                                text:
                                                    '₹ ${icon.filterfavlist[index]['e_book_price']}',
                                                color: Colors.grey[400]!,
                                                fsize: 9,
                                                underline: true,
                                              ),
                                            ],
                                          ),
                                          Container(
                                            height: 20.sp,
                                            width: 15.w,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(3.sp),
                                                border: Border.all(
                                                    color: Get
                                                        .theme.primaryColor)),
                                            child: Center(
                                              child: Txt(
                                                text: 'Buy',
                                                color: Colors.green,
                                                fsize: 10,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Spacer(),
                                Spacer(),
                                Spacer(),
                              ],
                            ),
                          ),
                        );
                      }),
            ))
          ],
        ),
      ),
    );
  }
}
