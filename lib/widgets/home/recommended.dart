import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:kubera/controller/init.dart';
import 'package:sizer/sizer.dart';

import '../../screens/book_details.dart';
import '../text.dart';

class Recommended extends StatefulWidget {
  final List? data;
  Recommended({Key? key, this.data}) : super(key: key);

  @override
  State<Recommended> createState() => _RecommendedState();
}

class _RecommendedState extends State<Recommended> {
  final InitCon icon = Get.find();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 41.h,
        child: Obx(
          () => ListView.builder(
              itemCount: widget.data!.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Row(
                  children: [
                    Card(
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.sp)),
                      child: Stack(
                        children: [
                          Container(
                            height: 38.h,
                            width: 48.w,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12.sp)),
                            child: Column(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(12.sp),
                                  child: CachedNetworkImage(
                                    imageUrl: widget.data![index]
                                        ['book_cover_file_url'],
                                    height: 25.h,
                                    width: 48.w,
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) =>
                                        Container().animate().shimmer(),
                                    errorWidget: (context, url, error) =>
                                        Icon(Icons.error),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(5.0.sp),
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 2.sp,
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Txt(
                                              text: widget.data![index]
                                                  ['book_name'],
                                              weight: FontWeight.bold,
                                              fsize: 11,
                                              lines: 1,
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
                                              text: widget.data![index]
                                                          ['authorDetails'][0]
                                                      ['author_name'] ??
                                                  'No name',
                                              weight: FontWeight.bold,
                                              fsize: 10,
                                              lines: 1,
                                              color: Colors.grey[500]!,
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
                                                        '₹ ${widget.data![index]['discount_price']}',
                                                    weight: FontWeight.bold,
                                                    fsize: 10,
                                                  ),
                                                ],
                                              ),
                                              Txt(
                                                text:
                                                    '₹ ${widget.data![index]['e_book_price']}',
                                                color: Colors.grey[400]!,
                                                fsize: 9,
                                                underline: true,
                                              ),
                                            ],
                                          ),
                                          InkWell(
                                            onTap: () {
                                              icon.selectedBookId.value =
                                                  widget.data![index]['_id'];
                                              icon.getbookDetails();

                                              Get.to(() => BookDeatilsView());
                                            },
                                            child: Container(
                                              height: 20.sp,
                                              width: 15.w,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          3.sp),
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
                          Positioned(
                            top: 6.sp,
                            right: 6.sp,
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  widget.data![index]['isFavourite'] =
                                      !widget.data![index]['isFavourite'];
                                  icon.addtoFav(widget.data![index]['_id'],
                                      widget.data![index]['isFavourite']);
                                });
                              },
                              child: CircleAvatar(
                                radius: 12.sp,
                                backgroundColor: Colors.white,
                                child: Icon(
                                  widget.data![index]['isFavourite']
                                      ? CupertinoIcons.heart_fill
                                      : CupertinoIcons.heart,
                                  size: 15.sp,
                                  color: Colors.red,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 5.sp,
                    )
                  ],
                );
              }),
        ));
  }
}
