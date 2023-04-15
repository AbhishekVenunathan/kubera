import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:kubera/controller/init.dart';
import 'package:kubera/widgets/text.dart';
import 'package:sizer/sizer.dart';

import '../../screens/book_details.dart';
import '../../screens/pdf_view.dart';

class Allbooks extends StatelessWidget {
  final bool isnum;
  final data;
  Allbooks({Key? key, this.isnum = false, this.data}) : super(key: key);
  final InitCon icon = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() => ListView.builder(
        itemCount: data.length,
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Column(
            children: [
              InkWell(
                onTap: () {
                  if (isnum) {
                    icon.selectedBookId.value = data[index]['_id'];
                    icon.getbookDetails();
                    //log(icon.newlaunchlist[index].toString());

                    icon.getMoreAuthBooks(data[index]['author_id'][0]['_id']);
                    Get.to(() => BookDeatilsView());
                  } else {
                    Get.to(() => PdfView(
                          id: data[index]['_id'],
                          title: data[index]['book_name'],
                          url: data[index]['book_file_url'],
                          pgNo: data[index]['pdfPageNo'].toString() == 'null'
                              ? '0'
                              : data[index]['pdfPageNo'].toString(),
                        ));
                  }
                  print(data[index]['book_file_url']);
                },
                child: Container(
                  height: 15.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.sp),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(8.0.sp),
                    child: Row(
                      children: [
                        Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Container(
                              height: 13.5.h,
                              width: 13.5.h,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8.sp),
                                child: CachedNetworkImage(
                                  imageUrl: data[index]['book_cover_file_url'],
                                  fit: BoxFit.cover,
                                  height: 13.5.h,
                                  width: 13.5.h,
                                  placeholder: (context, url) =>
                                      Container().animate().shimmer(),
                                  errorWidget: (context, url, error) =>
                                      Icon(Icons.error),
                                ),
                              ),
                            ),
                            if (isnum)
                              Positioned(
                                  bottom: 0,
                                  left: -5.sp,
                                  child: Stack(
                                    children: <Widget>[
                                      // Stroked text as border.
                                      Text(
                                        '${index + 1}',
                                        style: TextStyle(
                                          fontSize: 30.sp,
                                          foreground: Paint()
                                            ..style = PaintingStyle.stroke
                                            ..strokeWidth = 3
                                            ..color = Get.theme.primaryColor,
                                        ),
                                      ),
                                      // Solid text as fill.
                                      Text(
                                        '${index + 1}',
                                        style: TextStyle(
                                          fontSize: 30.sp,
                                          color: Colors.grey[200]!,
                                        ),
                                      ),
                                    ],
                                  ))
                          ],
                        ),
                        SizedBox(
                          width: 8.sp,
                        ),
                        Expanded(
                          child: Container(
                            child: ListTile(
                              title: Txt(
                                text: data[index]['book_name'],
                                weight: FontWeight.bold,
                                lines: 2,
                                fsize: 12,
                              ),
                              subtitle: Txt(
                                text: data[index]['author_id'][0]
                                    ['author_name'],
                                fsize: 11,
                                color: Colors.grey[400]!,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 5.sp,
              )
            ],
          );
        }));
  }
}
