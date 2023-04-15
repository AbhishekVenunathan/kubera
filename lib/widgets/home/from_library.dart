import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:kubera/controller/init.dart';
import 'package:sizer/sizer.dart';

import '../../screens/pdf_view.dart';
import '../text.dart';

class FromLibrary extends StatelessWidget {
  FromLibrary({Key? key}) : super(key: key);

  final InitCon icon = Get.find();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30.h,
      child: ListView.builder(
          itemCount: icon.libraryBookList.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return Row(
              children: [
                InkWell(
                  onTap: () {
                    print(icon.libraryBookList[index].toString());
                    Get.to(() => PdfView(
                          id: icon.libraryBookList[index]['_id'],
                          title: icon.libraryBookList[index]['book_name'],
                          url: icon.libraryBookList[index]['book_file_url'],
                          pgNo: icon.libraryBookList[index]['pdfPageNo']
                                      .toString() ==
                                  'null'
                              ? '0'
                              : icon.libraryBookList[index]['pdfPageNo']
                                  .toString(),
                        ));
                  },
                  child: Card(
                    elevation: 0.5,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.sp)),
                    child: Container(
                      height: 30.h,
                      width: 40.w,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.sp)),
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(12.sp),
                                topRight: Radius.circular(12.sp)),
                            child: CachedNetworkImage(
                              imageUrl: icon.libraryBookList[index]
                                  ['book_cover_file_url'],
                              height: 18.h,
                              width: 52.w,
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
                                Row(
                                  children: [
                                    Expanded(
                                      child: Txt(
                                        text: icon.libraryBookList[index]
                                            ['book_name'],
                                        weight: FontWeight.bold,
                                        lines: 2,
                                        fsize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 4.0.sp),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Txt(
                                      text: icon.libraryBookList[index]
                                          ['author_id'][0]['author_name'],
                                      weight: FontWeight.bold,
                                      fsize: 11,
                                      lines: 1,
                                      color: Colors.grey[400]!,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 5.sp,
                )
              ],
            );
          }),
    );
  }
}
