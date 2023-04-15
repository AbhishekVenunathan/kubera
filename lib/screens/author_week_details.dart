import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:kubera/controller/init.dart';
import 'package:sizer/sizer.dart';

import '../widgets/text.dart';
import 'book_details.dart';

class AuthorWeek extends StatefulWidget {
  AuthorWeek({Key? key}) : super(key: key);

  @override
  State<AuthorWeek> createState() => _AuthorWeekState();
}

class _AuthorWeekState extends State<AuthorWeek> {
  final InitCon icon = Get.find();
  @override
  void dispose() {
    icon.authorBooklist.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Obx(
      () => icon.authorBooklist.isEmpty
          ? Center(
              child: CupertinoActivityIndicator(),
            )
          : ListView(
              shrinkWrap: true,
              children: [
                Card(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0.sp)),
                  child: Stack(
                    children: [
                      Column(
                        children: [
                          Container(
                            height: 30.h,
                            child: ClipRRect(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(0.sp),
                                topRight: Radius.circular(0.sp),
                              ),
                              child: CachedNetworkImage(
                                imageUrl: icon.authorBooklist[0]
                                        ['cover_image_url'] ??
                                    'https://source.unsplash.com/random?sig=0',
                                fit: BoxFit.cover,
                                width: double.infinity,
                                placeholder: (context, url) =>
                                    Container().animate().shimmer(),
                                errorWidget: (context, url, error) =>
                                    Icon(Icons.error),
                              ),
                            ),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(0.sp),
                              topRight: Radius.circular(0.sp),
                            )),
                          ),
                          Container(
                            child: Padding(
                              padding: EdgeInsets.all(8.0.sp),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 7.h,
                                  )
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
                          top: 23.h,
                          right: Get.width / 2 - 40.sp,
                          child: CircleAvatar(
                            radius: 40.sp,
                            child: Padding(
                              padding: EdgeInsets.all(2.0.sp),
                              child: ClipOval(
                                child: Image.network(
                                  icon.authorBooklist[0]['image_url'] ??
                                      'https://source.unsplash.com/random?sig=0',
                                  fit: BoxFit.cover,
                                  width: 80.sp,
                                  height: 80.sp,
                                ),
                              ),
                            ),
                            backgroundColor: Colors.white,
                          )),
                      AppBar(
                        backgroundColor: Colors.transparent,
                        elevation: 0,
                        leading: Center(
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            child: IconButton(
                                onPressed: () {
                                  Get.back();
                                },
                                icon: Icon(
                                  Icons.arrow_back_ios_new,
                                  color: Colors.black,
                                )),
                          ),
                        ),
                        actions: [
                          CircleAvatar(
                            backgroundColor: Colors.white,
                            child: IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.share_outlined,
                                  color: Colors.black,
                                )),
                          ),
                          SizedBox(
                            width: 8.sp,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.sp),
                  child: Column(
                    children: [
                      Txt(
                        text: icon.authorBooklist[0]['author_name'],
                        fsize: 12,
                        weight: FontWeight.w800,
                      ),
                      SizedBox(
                        height: 8.sp,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Txt(
                            text: icon.authorBooklist[0]['description'],
                            fsize: 11,
                            color: Colors.grey[500]!,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 15.sp,
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.sp),
                  child: GridView.builder(
                      itemCount: icon.authorBooklist[0]['books'].length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
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
                                        icon.authorBooklist[0]['books'][index]
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
                                              icon.authorBooklist[0]['books']
                                                      [index]['isFavourite'] =
                                                  !icon.authorBooklist[0]
                                                          ['books'][index]
                                                      ['isFavourite'];
                                              icon.addtoFav(
                                                  icon.authorBooklist[0]
                                                      ['books'][index]['_id'],
                                                  icon.authorBooklist[0]
                                                          ['books'][index]
                                                      ['isFavourite']);
                                            });
                                          },
                                          child: CircleAvatar(
                                            radius: 12.sp,
                                            backgroundColor: Colors.white,
                                            child: Icon(
                                              icon.authorBooklist[0]['books']
                                                      [index]['isFavourite']
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
                                              text: icon.authorBooklist[0]
                                                  ['books'][index]['book_name'],
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
                                              text: icon.authorBooklist[0]
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
                                                        '₹ ${icon.authorBooklist[0]['books'][index]['discount_price']} ',
                                                    weight: FontWeight.bold,
                                                    fsize: 10,
                                                  ),
                                                ],
                                              ),
                                              Txt(
                                                text:
                                                    '₹ ${icon.authorBooklist[0]['books'][index]['e_book_price']} ',
                                                color: Colors.grey[400]!,
                                                fsize: 9,
                                                underline: true,
                                              ),
                                            ],
                                          ),
                                          InkWell(
                                            onTap: () {
                                              icon.selectedBookId.value =
                                                  icon.authorBooklist[0]
                                                      ['books'][index]['_id'];
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
                        );
                      }),
                ),
              ],
            ),
    ));
  }
}
