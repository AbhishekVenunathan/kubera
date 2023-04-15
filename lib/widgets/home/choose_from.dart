import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:kubera/controller/init.dart';
import 'package:sizer/sizer.dart';

import '../../screens/author_week_details.dart';
import '../text.dart';

class FromAuthor extends StatelessWidget {
  FromAuthor({Key? key}) : super(key: key);
  final InitCon icon = Get.find();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 12.5.h,
      child: Obx(() => ListView.builder(
          itemCount: icon.authorslist.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                icon.authorBooks(icon.authorslist[index]['_id']);
                Get.to(() => AuthorWeek());
              },
              child: Card(
                elevation: 1,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.sp)),
                child: Stack(
                  children: [
                    Container(
                      width: 43.w,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(15.sp),
                            child: CachedNetworkImage(
                              imageUrl: icon.authorslist[index]['image_url'],
                              width: 43.w,
                              height: 12.5.h,
                              fit: BoxFit.cover,
                              placeholder: (context, url) =>
                                  Container().animate().shimmer(),
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.error),
                            ),
                          ),
                        ],
                      ),
                      foregroundDecoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.sp),
                        gradient: LinearGradient(
                          colors: [
                            Colors.black38,
                            Colors.black38,
                            Colors.black38,
                            Colors.black38,
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          stops: [0, 0.2, 0.8, 1],
                        ),
                      ),
                      decoration: BoxDecoration(
                          color: Color(0xFFF392F64),
                          borderRadius: BorderRadius.circular(15.sp)),
                    ),
                    Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        top: 0,
                        child: Center(
                          child: Txt(
                            text: icon.authorslist[index]['author_name'],
                            weight: FontWeight.bold,
                            color: Colors.white,
                            fsize: 12,
                          ),
                        ))
                  ],
                ),
              ),
            );
          })),
    );
  }
}
