import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kubera/controller/init.dart';
import 'package:kubera/widgets/bottom_navigation.dart';
import 'package:sizer/sizer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../widgets/home/allbooks.dart';
import '../../widgets/home/popular.dart';
import '../../widgets/home/search_bar.dart';
import '../../widgets/home/view_text.dart';
import '../../widgets/text.dart';
import '../book_details.dart';
import '../pdf_view.dart';

class LibraryView extends StatefulWidget {
  LibraryView({Key? key}) : super(key: key);

  @override
  State<LibraryView> createState() => _LibraryViewState();
}

class _LibraryViewState extends State<LibraryView> {
  PageController pageController = PageController();
  final InitCon icon = Get.find();
  var _currentItem = 0;
  var selected = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Obx(() => Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.sp),
              child: icon.libraryBookList.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.asset('assets/empty_mylib.png'),
                          ),
                          SizedBox(
                            height: 15.sp,
                          ),
                          Txt(
                            text: 'You havn’t purchased any book yet !',
                            fsize: 12,
                            color: Colors.grey[500]!,
                          ),
                          SizedBox(
                            height: 20.sp,
                          ),
                          InkWell(
                            onTap: () {
                              Get.offAll(() => BottomBar(currentindex: 0));
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  border:
                                      Border.all(color: Get.theme.primaryColor),
                                  borderRadius: BorderRadius.circular(8.sp)),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 30.sp, vertical: 8.sp),
                                child: Txt(
                                    text: 'Buy now',
                                    fsize: 11,
                                    weight: FontWeight.w600,
                                    color: Get.theme.primaryColor),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 30.sp,
                          ),
                        ],
                      ),
                    )
                  : ListView(
                      children: [
                        Txt(
                          text: 'Hi ${icon.pname.text} 👋',
                          fsize: 14,
                          color: Colors.grey[500]!,
                        ),
                        InkWell(
                          onTap: () {
                            icon.getlibraryBooks();
                          },
                          child: Txt(
                            text: 'Enjoy your readings',
                            weight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 4.sp,
                        ),
                        SearchBar(),
                        if (icon.continueBooks.length != 0)
                          SizedBox(
                            height: 8.sp,
                          ),
                        if (icon.continueBooks.length != 0)
                          HeadTxt(
                            txt: 'Continue reading',
                            ontap: () {},
                          ),
                        if (icon.continueBooks.length != 0)
                          Container(
                            height: 13.h,
                            child: ListView.builder(
                                itemCount: icon.continueBooks.length,
                                controller: pageController,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  return VisibilityDetector(
                                    key: Key(index.toString()),
                                    onVisibilityChanged: (VisibilityInfo info) {
                                      if (info.visibleFraction == 1)
                                        setState(() {
                                          _currentItem = index;
                                          print(_currentItem);
                                        });
                                    },
                                    child: Row(
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            // print(icon.continueBooks[index]
                                            //     ['pdfPageNo']);
                                            Get.to(() => PdfView(
                                                  id: icon.continueBooks[index]
                                                      ['_id'],
                                                  title:
                                                      icon.continueBooks[index]
                                                          ['book_name'],
                                                  url: icon.continueBooks[index]
                                                      ['book_file_url'],
                                                  pgNo: icon.continueBooks[
                                                                  index]
                                                                  ['pdfPageNo']
                                                              .toString() ==
                                                          'null'
                                                      ? '0'
                                                      : icon
                                                          .continueBooks[index]
                                                              ['pdfPageNo']
                                                          .toString(),
                                                ));
                                            //   Get.to(() => BookDeatilsView());
                                          },
                                          child: Container(
                                            height: 12.h,
                                            width: Get.width * .75,
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.grey,
                                                  width: 0.5),
                                              borderRadius:
                                                  BorderRadius.circular(8.sp),
                                            ),
                                            child: Padding(
                                              padding: EdgeInsets.all(4.0.sp),
                                              child: Row(
                                                children: [
                                                  Stack(
                                                    // overflow: Overflow.visible,
                                                    children: [
                                                      Container(
                                                        height: 10.5.h,
                                                        width: 10.5.h,
                                                        child: ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      8.sp),
                                                          child: Image.network(
                                                            icon.continueBooks[
                                                                    index][
                                                                'book_cover_file_url'],
                                                            fit: BoxFit.cover,
                                                            height: 13.5.h,
                                                            width: 13.5.h,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Expanded(
                                                    child: Container(
                                                      child: ListTile(
                                                        subtitle: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Txt(
                                                              text: icon.continueBooks[
                                                                      index]
                                                                  ['book_name'],
                                                              weight: FontWeight
                                                                  .bold,
                                                              lines: 2,
                                                              fsize: 10,
                                                            ),
                                                            SizedBox(
                                                              height: 5.sp,
                                                            ),
                                                            Txt(
                                                              text: icon.continueBooks[
                                                                          index]
                                                                      [
                                                                      'author_id'][0]
                                                                  [
                                                                  'author_name'],
                                                              fsize: 9,
                                                              lines: 1,
                                                              color: Colors
                                                                  .grey[400]!,
                                                            ),
                                                            SizedBox(
                                                              height: 5.sp,
                                                            ),
                                                            Container(
                                                              height: 10.sp,
                                                              color:
                                                                  Colors.blue,
                                                            )
                                                          ],
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
                                          width: 20.sp,
                                        )
                                      ],
                                    ),
                                  );
                                }),
                          ),
                        if (icon.continueBooks.length != 0)
                          SizedBox(
                            height: 2.sp,
                          ),
                        if (icon.continueBooks.length != 0)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SmoothPageIndicator(
                                  controller: pageController, // PageController
                                  count: icon.continueBooks.length,

                                  // forcing the indicator to use a specific direction

                                  effect: JumpingDotEffect(
                                      activeDotColor: Get.theme.primaryColor,
                                      radius: 8,
                                      dotColor: Colors.grey[300]!,
                                      strokeWidth: 8,
                                      dotWidth: 12,
                                      dotHeight: 12)),
                            ],
                          ),
                        HeadTxt(
                          txt: 'All books',
                          ontap: () {},
                        ),
                        Popular(
                          data: icon.libraryCatBookList,
                        ),
                        SizedBox(
                          height: 8.sp,
                        ),
                        Allbooks(data: icon.mylibbook),
                      ],
                    ),
            )));
  }
}
