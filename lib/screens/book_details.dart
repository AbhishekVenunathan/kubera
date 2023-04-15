import 'dart:developer';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:kubera/controller/init.dart';
import 'package:kubera/screens/pdf_view.dart';
import 'package:kubera/widgets/more_from.dart';
import 'package:kubera/widgets/text.dart';
import 'package:sizer/sizer.dart';

import '../widgets/home/recommended.dart';
import '../widgets/home/view_text.dart';
import 'author_week_details.dart';
import 'cart/cart_main.dart';

class BookDeatilsView extends StatefulWidget {
  BookDeatilsView({Key? key}) : super(key: key);

  @override
  State<BookDeatilsView> createState() => _BookDeatilsViewState();
}

class _BookDeatilsViewState extends State<BookDeatilsView> {
  final InitCon icon = Get.find();

  var productcount = 1;
  Future<bool> willpop() {
    return Future.value(true);
  }

  @override
  void dispose() {
    icon.bookDetails.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: willpop,
      child: Scaffold(
          body: Obx(
        () => icon.bookDetails.isEmpty
            ? const Center(child: CupertinoActivityIndicator())
            : Stack(
                children: [
                  ListView(
                    controller: icon.scrollcontroller,
                    children: [
                      Stack(
                        children: [
                          Positioned(
                            child: Container(
                                height: Get.height / 2 - 50.sp,
                                child: backgroudImage(
                                    icon.bookDetails[0]['book_cover_file_url'],
                                    isfav: icon.bookDetails[0]['isFavourite'])),
                          ),
                          Positioned.fill(
                              top: kToolbarHeight,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10.sp),
                                    child: Image.network(
                                      icon.bookDetails[0]
                                          ['book_cover_file_url'],
                                      width: Get.width / 2 - 18.sp,
                                      height: Get.height / 2 - 125.sp,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ],
                              ))
                        ],
                      ),
                      SizedBox(
                        height: 8.sp,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.sp),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Wrap(
                              spacing: 8.0.sp,
                              runSpacing: 8.0.sp,
                              children: [
                                for (int i = 0;
                                    i <
                                        icon.bookDetails[0]['categoryDetails']
                                            .length;
                                    i++)
                                  MyWidget(
                                      name: icon.bookDetails[0]
                                              ['categoryDetails'][i]
                                          ['category_name']),
                                // MyWidget(),
                              ],
                            ),
                            SizedBox(
                              height: 8.sp,
                            ),
                            ListTile(
                              contentPadding: EdgeInsets.all(0),
                              title: Txt(
                                text: icon.bookDetails[0]['book_name'],
                                weight: FontWeight.w800,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Txt(
                                      text: icon.iskuberaEdition.value
                                          ? '₹ ${icon.bookDetails[0]['discount_price']} '
                                          : '₹ ${icon.bookDetails[0]['paperBookPrice']}',
                                      weight: FontWeight.bold,
                                      color: Get.theme.primaryColor,
                                    ),
                                    if (icon.iskuberaEdition.value)
                                      Txt(
                                        text:
                                            '₹ ${icon.bookDetails[0]['e_book_price']}',
                                        fsize: 12,
                                        underline: true,
                                        color: Colors.grey[300]!,
                                      ),
                                  ],
                                ),
                                (icon.bookDetails[0]['isPurchased'] &&
                                        icon.iskuberaEdition.value)
                                    ? InkWell(
                                        onTap: () {
                                          if (icon.bookDetails[0]
                                                  ['isPurchased'] &&
                                              icon.iskuberaEdition.value) {
                                            Get.to(() => PdfView(
                                                  id: icon.bookDetails[0]
                                                      ['_id'],
                                                  title: icon.bookDetails[0]
                                                      ['book_name'],
                                                  url: icon.bookDetails[0]
                                                      ['book_file_url'],
                                                  pgNo: '0',
                                                ));
                                          } else {
                                            icon.bookDetails[0]['cartCount']++;
                                            icon.addtoCart(
                                                icon.bookDetails[0]['_id'],
                                                '1');
                                            print('${productcount++}');
                                          }
                                        },
                                        child: Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(4.sp),
                                                color: Get.theme.primaryColor),
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 12.sp,
                                                  vertical: 8.sp),
                                              child: Txt(
                                                text: icon.bookDetails[0][
                                                                    'isPurchased']
                                                                .toString() ==
                                                            'true' &&
                                                        icon.iskuberaEdition
                                                            .value
                                                    ? 'Read Now'
                                                    : 'Add to cart',
                                                color: Colors.white,
                                                fsize: 12,
                                                weight: FontWeight.w800,
                                              ),
                                            )),
                                      )
                                    : (icon.bookDetails[0]['cartCount']
                                                    .toString() !=
                                                '0' ||
                                            icon.bookDetails[0]['eCartCount']
                                                    .toString() !=
                                                '0')
                                        ? Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(6.sp),
                                                border: Border.all(
                                                    color:
                                                        Get.theme.primaryColor,
                                                    width: 0.5)),
                                            child: Padding(
                                              padding: EdgeInsets.all(5.0.sp),
                                              child: Row(
                                                children: [
                                                  InkWell(
                                                    onTap: () {
                                                      setState(() {
                                                        icon.addtoCart(
                                                            icon.bookDetails[0]
                                                                ['_id'],
                                                            '-1',
                                                            showload: false);
                                                        if (icon.iskuberaEdition
                                                                .value &&
                                                            icon.bookDetails[0][
                                                                    'eCartCount'] !=
                                                                0) {
                                                          icon.bookDetails[0]
                                                              ['eCartCount']--;
                                                        } else if (!icon
                                                                .iskuberaEdition
                                                                .value &&
                                                            icon.bookDetails[0][
                                                                    'cartCount'] !=
                                                                0) {
                                                          icon.bookDetails[0]
                                                              ['cartCount']--;
                                                        }
                                                      });
                                                    },
                                                    child: Icon(
                                                      Icons.remove,
                                                      size: 20.sp,
                                                      color: Get
                                                          .theme.primaryColor,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 8.sp,
                                                  ),
                                                  if (!icon
                                                      .iskuberaEdition.value)
                                                    Txt(
                                                      text:
                                                          'Qty ${icon.bookDetails[0]['eCartCount'].toString() == '1' && icon.iskuberaEdition.value ? icon.bookDetails[0]['eCartCount'].toString() : icon.bookDetails[0]['cartCount'].toString()}',
                                                      fsize: 12,
                                                    ),
                                                  if (icon
                                                      .iskuberaEdition.value)
                                                    Txt(
                                                      text:
                                                          'Qty ${icon.bookDetails[0]['eCartCount'].toString()}',
                                                      fsize: 12,
                                                    ),
                                                  SizedBox(
                                                    width: 8.sp,
                                                  ),
                                                  InkWell(
                                                    onTap: () {
                                                      if (icon.bookDetails[0][
                                                                      'eCartCount']
                                                                  .toString() ==
                                                              '1' &&
                                                          icon.iskuberaEdition
                                                              .value) {
                                                      } else {
                                                        icon.addtoCart(
                                                            icon.bookDetails[0]
                                                                ['_id'],
                                                            '1',
                                                            showload: false);
                                                        setState(() {
                                                          icon.bookDetails[0]
                                                              ['cartCount']++;
                                                        });
                                                      }
                                                    },
                                                    child: Icon(
                                                      Icons.add,
                                                      size: 20.sp,
                                                      color: Get
                                                          .theme.primaryColor,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          )
                                        : InkWell(
                                            onTap: () {
                                              if (icon.bookDetails[0]
                                                      ['isPurchased'] &&
                                                  icon.iskuberaEdition.value) {
                                                Get.to(() => PdfView(
                                                      id: icon.bookDetails[0]
                                                          ['_id'],
                                                      title: icon.bookDetails[0]
                                                          ['book_name'],
                                                      url: icon.bookDetails[0]
                                                          ['book_file_url'],
                                                      pgNo: '0',
                                                    ));
                                              } else {
                                                icon.bookDetails[0]
                                                    ['cartCount']++;
                                                icon.addtoCart(
                                                    icon.bookDetails[0]['_id'],
                                                    '1');
                                                print('${productcount++}');
                                              }
                                            },
                                            child: Container(
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            4.sp),
                                                    color:
                                                        Get.theme.primaryColor),
                                                child: Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 12.sp,
                                                      vertical: 8.sp),
                                                  child: Txt(
                                                    text: icon.bookDetails[0][
                                                                        'isPurchased']
                                                                    .toString() ==
                                                                'true' &&
                                                            icon.iskuberaEdition
                                                                .value
                                                        ? 'Read Now'
                                                        : 'Add to cart',
                                                    color: Colors.white,
                                                    fsize: 12,
                                                    weight: FontWeight.w800,
                                                  ),
                                                )),
                                          )
                              ],
                            ),
                            SizedBox(
                              height: 12.sp,
                            ),
                            Container(
                              height: 0.5,
                              color: Colors.grey[300],
                            ),
                            ListTile(
                              onTap: () {
                                icon.authorBooks(icon.bookDetails[0]
                                    ['authorDetails'][0]['_id']);
                                Get.to(() => AuthorWeek());
                              },
                              title: Txt(
                                text: icon.bookDetails[0]['authorDetails'][0]
                                        ['author_name']
                                    .toString(),
                                fsize: 12,
                                weight: FontWeight.w600,
                              ),
                              trailing: Icon(Icons.arrow_forward_ios_rounded,
                                  size: 15.sp),
                              contentPadding: EdgeInsets.all(0),
                              leading: ClipOval(
                                  child: Image.network(
                                icon.bookDetails[0]['authorDetails'][0]
                                        ['image_url']
                                    .toString(),
                                fit: BoxFit.cover,
                                height: 45,
                                width: 45,
                              )),
                            ),
                            Container(
                              height: 0.5,
                              color: Colors.grey[300],
                            ),
                            SizedBox(
                              height: 8.sp,
                            ),
                            // Txt(
                            //   text:
                            //       ,
                            // ),
                            ListTile(
                              contentPadding: EdgeInsets.all(0),
                              title: Txt(
                                text: 'Description',
                                fsize: 13,
                                weight: FontWeight.w800,
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 8.sp,
                                  ),
                                  Txt(
                                    text: icon.bookDetails[0]
                                        ['bookDescription'],
                                    fsize: 13,
                                    color: Colors.grey[400]!,
                                  ),
                                ],
                              ),
                            ),
                            ListTile(
                              contentPadding: EdgeInsets.all(0),
                              title: Txt(
                                text: 'Choose copy',
                                fsize: 13,
                                weight: FontWeight.w800,
                              ),
                            ),
                            Obx(
                              () => Row(
                                children: [
                                  Expanded(
                                    child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          icon.iskuberaEdition.value = true;
                                        });
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5.sp),
                                            color: icon.iskuberaEdition.value
                                                ? Get.theme.primaryColor
                                                    .withOpacity(0.2)
                                                : Colors.grey.withOpacity(0.2),
                                            border: Border.all(
                                              color: icon.iskuberaEdition.value
                                                  ? Get.theme.primaryColor
                                                  : Colors.grey[400]!,
                                            )),
                                        child: Column(
                                          children: [
                                            SizedBox(
                                              height: 5.sp,
                                            ),
                                            Txt(
                                              text: 'Kubera edition',
                                              fsize: 12,
                                            ),
                                            SizedBox(
                                              height: 5.sp,
                                            ),
                                            Txt(
                                              text:
                                                  '₹ ${icon.bookDetails[0]['discount_price']}',
                                              fsize: 11,
                                              color: icon.iskuberaEdition.value
                                                  ? Get.theme.primaryColor
                                                  : Colors.black,
                                            ),
                                            SizedBox(
                                              height: 5.sp,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 12.sp,
                                  ),
                                  Expanded(
                                    child: InkWell(
                                      onTap: icon.bookDetails[0]
                                                  ['paperBookPrice'] ==
                                              null
                                          ? null
                                          : () {
                                              setState(() {
                                                icon.iskuberaEdition.value =
                                                    false;
                                              });
                                            },
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5.sp),
                                            color: !icon.iskuberaEdition.value
                                                ? Get.theme.primaryColor
                                                    .withOpacity(0.2)
                                                : Colors.grey.withOpacity(0.2),
                                            border: Border.all(
                                              color: !icon.iskuberaEdition.value
                                                  ? Get.theme.primaryColor
                                                  : Colors.grey[400]!,
                                            )),
                                        child: Column(
                                          children: [
                                            SizedBox(
                                              height: 5.sp,
                                            ),
                                            Txt(
                                              text: 'Paper edition',
                                              fsize: 12,
                                            ),
                                            SizedBox(
                                              height: 5.sp,
                                            ),
                                            Txt(
                                              text: icon.bookDetails[0]
                                                          ['paperBookPrice'] ==
                                                      null
                                                  ? 'Unavailable'
                                                  : '₹ ${icon.bookDetails[0]['paperBookPrice']}',
                                              fsize: 11,
                                              color: icon.iskuberaEdition.value
                                                  ? Colors.black
                                                  : Get.theme.primaryColor,
                                            ),
                                            SizedBox(
                                              height: 5.sp,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 12.sp,
                            ),
                            HeadTxt(
                              // isviewall: true,
                              txt: 'More from the author',
                              ontap: () {
                                log(icon.moreAuthBooks.toString());
                              },
                            ),
                            MoreFrom(data: icon.moreAuthBooks),
                            SizedBox(
                              height: 100.sp,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  icon.bookDetails[0]['totalCartCount'] == 0
                      ? SizedBox()
                      : Positioned(
                          left: 10.sp,
                          right: 10.sp,
                          bottom: 8.sp,
                          child: Container(
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.2),
                                    spreadRadius: 2,
                                    blurRadius: 5,
                                    offset: Offset(
                                        0, 3), // changes position of shadow
                                  ),
                                ],
                                borderRadius: BorderRadius.circular(12),
                                color: Colors.white),
                            child: ListTile(
                              title: Txt(
                                text: 'Total cost',
                                fsize: 11,
                                color: Colors.grey[400]!,
                              ),
                              trailing: InkWell(
                                onTap: () {
                                  Get.to(() => CartMain());
                                },
                                child: Container(
                                  width: 150,
                                  height: 50,
                                  decoration: BoxDecoration(
                                      color: Get.theme.primaryColor,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(CupertinoIcons.cart_fill,
                                          color: Colors.white, size: 16.sp),
                                      SizedBox(
                                        width: 15.sp,
                                      ),
                                      Txt(
                                        text: 'View cart',
                                        color: Colors.white,
                                        weight: FontWeight.w600,
                                        fsize: 10,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              subtitle: Row(
                                children: [
                                  Txt(
                                    text:
                                        '${icon.bookDetails[0]['totalCartCount']} item ',
                                    fsize: 13,
                                    weight: FontWeight.w500,
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 6.sp),
                                    child: Container(
                                      height: 20,
                                      color: Colors.grey[400],
                                      width: 0.3,
                                    ),
                                  ),
                                  Txt(
                                    text:
                                        '₹ ${icon.bookDetails[0]['totalAmount']}',
                                    fsize: 13,
                                    color: Get.theme.primaryColor,
                                    weight: FontWeight.w800,
                                  ),
                                ],
                              ),
                            ),
                          ))
                ],
              ),
      )),
    );
  }

  Widget backgroudImage(image, {isfav = false}) {
    return Stack(
      children: [
        ShaderMask(
          shaderCallback: (bounds) => LinearGradient(
            colors: [
              Get.theme.primaryColor.withOpacity(0.5),
              Get.theme.primaryColor.withOpacity(0.5)
            ],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
          ).createShader(bounds),
          blendMode: BlendMode.darken,
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                  image,
                ),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(Colors.black38, BlendMode.darken),
              ),
            ),
          ),
        ),
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
            CircleAvatar(
              backgroundColor: Colors.white,
              child: IconButton(
                  onPressed: () {
                    setState(() {
                      icon.bookDetails[0]['isFavourite'] =
                          !icon.bookDetails[0]['isFavourite'];
                      icon.addtoFav(icon.bookDetails[0]['_id'],
                          icon.bookDetails[0]['isFavourite']);
                    });
                  },
                  icon: Icon(
                    isfav ? CupertinoIcons.heart_fill : CupertinoIcons.heart,
                    color: Colors.red,
                  )),
            ),
            SizedBox(
              width: 8.sp,
            ),
          ],
        )
      ],
    );
  }
}

class MyWidget extends StatelessWidget {
  final String? name;
  const MyWidget({Key? key, this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(2.sp),
          color: Get.theme.primaryColor.withOpacity(0.3)),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.sp, vertical: 3.sp),
        child: Txt(
          text: name!,
          color: Get.theme.primaryColor,
          fsize: 10,
        ),
      ),
    );
  }
}
