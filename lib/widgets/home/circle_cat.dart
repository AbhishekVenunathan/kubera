import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:kubera/controller/init.dart';
import 'package:sizer/sizer.dart';

import '../../screens/recommended.dart';
import '../text.dart';

class CircleCat extends StatelessWidget {
  CircleCat({Key? key}) : super(key: key);
  final InitCon icon = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Obx(() => GridView.builder(
          itemCount:
              icon.categorieslist.length > 4 ? 4 : icon.categorieslist.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
          itemBuilder: (context, index) {
            return index != 3
                ? InkWell(
                    onTap: () {
                      icon.catWiseBooks(icon.categorieslist[index]['_id']);
                      Get.to(() => ReccomendView(
                            title:
                                """Books Under "${icon.categorieslist[index]['category_name']}" """,
                            data: icon.categoryBooklist,
                          ));
                    },
                    child: Column(
                      children: [
                        Spacer(),
                        CircleAvatar(
                          radius: 20.sp,
                          backgroundColor: Colors.grey[300],
                          child: ClipOval(
                            child: CachedNetworkImage(
                              imageUrl: icon.categorieslist[index]['image_url'],
                              height: 30.sp,
                              width: 30.sp,
                              fit: BoxFit.cover,
                              placeholder: (context, url) =>
                                  Container().animate().shimmer(),
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.error),
                            ),
                          ),
                        ),
                        Spacer(),
                        Txt(
                          text: icon.categorieslist[index]['category_name']
                              .toString(),
                          fsize: 10,
                          weight: FontWeight.w500,
                        ),
                        Spacer(),
                      ],
                    ),
                  )
                : Column(
                    children: [
                      Spacer(),
                      InkWell(
                        onTap: () {
                          Get.bottomSheet(Container(
                            height: Get.height / 2 + 18,
                            child: Column(
                              children: [
                                Container(
                                  height: 8,
                                  width: 60,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(999)),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  height: Get.height / 2,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(20.sp),
                                          topRight: Radius.circular(20.sp))),
                                  child: Center(
                                    child: Padding(
                                      padding: EdgeInsets.all(8.0.sp),
                                      child: Column(
                                        children: [
                                          Txt(
                                            text: 'All categories',
                                            fsize: 16,
                                            weight: FontWeight.bold,
                                          ),
                                          SizedBox(
                                            height: 8.sp,
                                          ),
                                          Expanded(
                                            child: GridView.builder(
                                                itemCount:
                                                    icon.categorieslist.length,
                                                //  shrinkWrap: true,
                                                physics:
                                                    const BouncingScrollPhysics(),
                                                gridDelegate:
                                                    SliverGridDelegateWithFixedCrossAxisCount(
                                                        crossAxisCount: 4),
                                                itemBuilder: (context, index) {
                                                  return InkWell(
                                                    onTap: () {
                                                      icon.catWiseBooks(
                                                          icon.categorieslist[
                                                              index]['_id']);
                                                      Get.to(
                                                          () => ReccomendView(
                                                                title:
                                                                    """Books Under "${icon.categorieslist[index]['category_name']}" """,
                                                                data: icon
                                                                    .categoryBooklist,
                                                              ));
                                                    },
                                                    child: Column(
                                                      children: [
                                                        Spacer(),
                                                        CircleAvatar(
                                                          radius: 24.sp,
                                                          backgroundColor:
                                                              Colors.grey[300],
                                                          child: ClipOval(
                                                            child:
                                                                CachedNetworkImage(
                                                              imageUrl:
                                                                  icon.categorieslist[
                                                                          index]
                                                                      [
                                                                      'image_url'],
                                                              height: 40.sp,
                                                              width: 40.sp,
                                                              fit: BoxFit.cover,
                                                              placeholder: (context,
                                                                      url) =>
                                                                  Container()
                                                                      .animate()
                                                                      .shimmer(),
                                                              errorWidget: (context,
                                                                      url,
                                                                      error) =>
                                                                  Icon(Icons
                                                                      .error),
                                                            ),
                                                          ),
                                                        ),
                                                        Spacer(),
                                                        Txt(
                                                          text: icon
                                                              .categorieslist[
                                                                  index][
                                                                  'category_name']
                                                              .toString(),
                                                          fsize: 10,
                                                          iscenter: true,
                                                          weight:
                                                              FontWeight.w500,
                                                        ),
                                                        Spacer(),
                                                      ],
                                                    ),
                                                  );
                                                }),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ));
                        },
                        child: CircleAvatar(
                          radius: 20.sp,
                          backgroundColor: Colors.grey[300],
                          child: ClipOval(
                            child: Image.asset(
                              'assets/more.png',
                              height: 25.sp,
                              width: 25.sp,
                            ),
                          ),
                        ),
                      ),
                      Spacer(),
                      Txt(
                        text: 'More',
                        fsize: 10,
                        weight: FontWeight.w500,
                      ),
                      Spacer(),
                    ],
                  );
          })),
    );
  }
}
