import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:kubera/controller/init.dart';
import 'package:sizer/sizer.dart';

import '../text.dart';

class AuthorOffView extends StatelessWidget {
  AuthorOffView({Key? key}) : super(key: key);
  final InitCon icon = Get.find();
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.sp)),
      child: Stack(
        children: [
          Column(
            children: [
              Container(
                height: 19.h,
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15.sp),
                    topRight: Radius.circular(15.sp),
                  ),
                  child: CachedNetworkImage(
                    imageUrl: icon.authorofweeklist[0]['author']
                        ['cover_image_url'],
                    fit: BoxFit.cover,
                    width: double.infinity,
                    placeholder: (context, url) =>
                        Container().animate().shimmer(),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                ),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15.sp),
                  topRight: Radius.circular(15.sp),
                )),
              ),
              Container(
                child: Padding(
                  padding: EdgeInsets.all(8.0.sp),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Txt(
                            text: icon.authorofweeklist[0]['author']
                                ['author_name'],
                            weight: FontWeight.bold,
                            fsize: 12,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10.sp,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Txt(
                              text: icon.authorofweeklist[0]['author']
                                  ['description'],
                              fsize: 11,
                              lines: 4,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(15.sp),
                  bottomRight: Radius.circular(15.sp),
                )),
              ),
            ],
          ),
          Positioned(
              top: 15.h,
              right: 20.sp,
              child: CircleAvatar(
                radius: 24.sp,
                child: Padding(
                  padding: EdgeInsets.all(2.0.sp),
                  child: ClipOval(
                    child: Image.network(
                      icon.authorofweeklist[0]['author']['image_url'],
                      fit: BoxFit.cover,
                      width: 48.sp,
                      height: 48.sp,
                    ),
                  ),
                ),
                backgroundColor: Colors.white,
              ))
        ],
      ),
    );
  }
}
