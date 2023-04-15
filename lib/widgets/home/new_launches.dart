import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:kubera/controller/init.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../screens/book_details.dart';
import '../text.dart';

class NewLaunch extends StatefulWidget {
  NewLaunch({Key? key}) : super(key: key);

  @override
  State<NewLaunch> createState() => _NewLaunchState();
}

class _NewLaunchState extends State<NewLaunch> {
  final InitCon icon = Get.find();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 23.h,
      child: Obx(() => ListView.builder(
          itemCount: icon.newlaunchlist.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return Row(
              children: [
                InkWell(
                  onTap: () {
                    icon.selectedBookId.value =
                        icon.newlaunchlist[index]['_id'];
                    icon.getbookDetails();
                    //log(icon.newlaunchlist[index].toString());

                    icon.getMoreAuthBooks(
                        icon.newlaunchlist[index]['author_id'][0]);
                    Get.to(() => BookDeatilsView());
                    //  print(icon.newlaunchlist[index]['_id']);
                  },
                  child: Card(
                    elevation: 1,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.sp)),
                    child: Stack(
                      children: [
                        Container(
                          width: 60.w,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CachedNetworkImage(
                                imageUrl: icon.newlaunchlist[index]
                                            ['book_cover_file_url'] ==
                                        'https://kuberatech-docs.s3.us-west-1.amazonaws.com/'
                                    ? 'https://ui-avatars.com/api/?name=${icon.newlaunchlist[index]['book_name']}'
                                    : icon.newlaunchlist[index]
                                        ['book_cover_file_url'],
                                width: 30.w,
                                height: 23.h,
                                fit: BoxFit.cover,
                                progressIndicatorBuilder:
                                    (context, url, downloadProgress) =>
                                        Container().animate().shimmer(),
                                errorWidget: (context, url, error) =>
                                    Icon(Icons.error),
                              ),
                            ],
                          ),
                          foregroundDecoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.sp),
                            gradient: LinearGradient(
                              colors: [
                                Colors.black54,
                                Colors.transparent,
                                Colors.transparent,
                                Colors.black54
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              stops: [0, 0.2, 0.8, 1],
                            ),
                          ),
                          decoration: BoxDecoration(
                              color: HexColor(
                                  icon.newlaunchlist[index]['color_code']),
                              borderRadius: BorderRadius.circular(15.sp)),
                        ),
                        Positioned(
                            bottom: 5.sp,
                            left: 0,
                            right: 0,
                            child: Container(
                              height: 8.h,
                              child: ListTile(
                                trailing: InkWell(
                                  onTap: () {
                                    setState(() {
                                      icon.newlaunchlist[index]['isFavourite'] =
                                          !icon.newlaunchlist[index]
                                              ['isFavourite'];
                                      icon.addtoFav(
                                          icon.newlaunchlist[index]['_id'],
                                          icon.newlaunchlist[index]
                                              ['isFavourite']);
                                    });
                                  },
                                  child: CircleAvatar(
                                    radius: 15.sp,
                                    backgroundColor: Colors.white,
                                    child: Icon(
                                      icon.newlaunchlist[index]['isFavourite']
                                          ? CupertinoIcons.heart_fill
                                          : CupertinoIcons.heart,
                                      size: 18.sp,
                                      color: Colors.red,
                                    ),
                                  ),
                                ),
                                title: Txt(
                                  text: icon.newlaunchlist[index]['book_name'],
                                  fsize: 11.5,
                                  lines: 1,
                                  color: Colors.white,
                                  weight: FontWeight.bold,
                                ),
                                subtitle: Txt(
                                    text: icon.newlaunchlist[index]
                                        ['authorDetails'][0]['author_name'],
                                    fsize: 10,
                                    color: Colors.white70),
                              ),
                              color: Colors.transparent,
                            ))
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: 5.sp,
                ),
              ],
            );
          })),
    );
  }
}
