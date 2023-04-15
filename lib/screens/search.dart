import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:kubera/controller/init.dart';
import 'package:sizer/sizer.dart';

import '../widgets/home/view_text.dart';
import '../widgets/icon_text_field.dart';
import '../widgets/text.dart';
import 'book_details.dart';

class SearchView extends StatefulWidget {
  SearchView({Key? key}) : super(key: key);

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  final TextEditingController _con = TextEditingController();
  final InitCon icon = Get.find();
  var searchlist = [];
  @override
  void initState() {
    super.initState();
    if (GetStorage().read('searchlist').toString() != 'null') {
      searchlist = GetStorage().read('searchlist');
    }
    print('heeeee' + GetStorage().read('searchlist').toString());
  }

  @override
  void dispose() {
    _con.clear();
    icon.filterBook.value = icon.bugetBookslist;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(8.0.sp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20.sp,
            ),
            ICTextField(
              autofocus: true,
              onsubmit: (o) {
                if (_con.text.trim().isEmpty ||
                    searchlist.contains(_con.text.trim())) {
                } else {
                  if (searchlist.contains(o)) {
                  } else {
                    if (searchlist.length >= 3) {
                      searchlist.removeLast();
                      searchlist.insert(0, o);
                    } else {
                      searchlist.add(o);
                    }
                    GetStorage().write('searchlist', searchlist);
                  }
                }
              },
              ontap: () {
                // Get.offAll(() => BottomBar(currentindex: 1));
              },
              controller: _con,
              onchage: (o) {
                icon.filterBooks(o);
                // setState(() {});
                // print(o);
              },
              hint: 'Search for book or authors etc...',
              label: 'Search for book or authors etc...',
              prefixedIcon: IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: Icon(
                    CupertinoIcons.back,
                    size: 17.sp,
                    color: Colors.grey[400],
                  )),
              ispreicon: false,
            ),
            if (GetStorage().read('searchlist').toString() != 'null')
              HeadTxt(
                txt: 'Recents',
                viewalltxt: 'Clear all',
                isviewall: true,
                ontap: () {
                  setState(() {
                    GetStorage().remove('searchlist');
                  });
                },
              ),
            if (GetStorage().read('searchlist').toString() != 'null')
              Wrap(
                alignment: WrapAlignment.start,
                spacing: 10,
                children: searchlist
                    .map((e) => InkWell(
                          onTap: () {
                            _con.text = e.toString();
                            icon.filterBooks(_con.text);
                            print(e.toString());
                          },
                          child: Chip(
                              backgroundColor: Colors.grey[200],
                              deleteIcon: Icon(
                                Icons.clear,
                                size: 14.sp,
                              ),
                              onDeleted: () {
                                setState(() {
                                  searchlist.remove(e);
                                  GetStorage().write('searchlist', searchlist);
                                });
                              },
                              avatar: Icon(Icons.access_time_rounded,
                                  size: 16.sp, color: Colors.grey[400]),
                              label: Txt(
                                text: e.toString(),
                                fsize: 11,
                              )),
                        ))
                    .toList()
                    .cast<Widget>(),
              ),
            SizedBox(
              height: 6,
            ),
            // if (_con.text != '')
            //   Txt(
            //     text: "Results for '${_con.text}'",
            //     fsize: 12,
            //   ),
            Obx(() => Expanded(
                  child: icon.filterBook.isEmpty
                      ? Container(
                          height: Get.height / 2 - 100,
                          child: Center(
                            child: Txt(
                              text: 'No Books Found',
                            ),
                          ),
                        )
                      : GridView.builder(
                          itemCount: icon.filterBook.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
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
                                            icon.filterBook[index]
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
                                                  icon.filterBook[index]
                                                          ['isFavourite'] =
                                                      !icon.filterBook[index]
                                                          ['isFavourite'];
                                                  icon.addtoFav(
                                                      icon.filterBook[index]
                                                          ['_id'],
                                                      icon.filterBook[index]
                                                          ['isFavourite']);
                                                });
                                                //icon.favlist.removeAt(index);
                                              },
                                              child: CircleAvatar(
                                                radius: 12.sp,
                                                backgroundColor: Colors.white,
                                                child: Icon(
                                                  icon.filterBook[index]
                                                          ['isFavourite']
                                                      ? CupertinoIcons
                                                          .heart_fill
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
                                                  text: icon.filterBook[index]
                                                      ['book_name'],
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
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 6.0.sp),
                                      child: Column(
                                        children: [
                                          Row(
                                            children: [
                                              Expanded(
                                                child: Txt(
                                                  text: icon.filterBook[index]
                                                          ['authorDetails'][0]
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
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 5.0.sp),
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
                                                            '₹ ${icon.filterBook[index]['discount_price']} ',
                                                        weight: FontWeight.bold,
                                                        fsize: 10,
                                                      ),
                                                    ],
                                                  ),
                                                  Txt(
                                                    text:
                                                        '₹ ${icon.filterBook[index]['e_book_price']}',
                                                    color: Colors.grey[400]!,
                                                    fsize: 9,
                                                    underline: true,
                                                  ),
                                                ],
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  icon.selectedBookId.value =
                                                      icon.filterBook[index]
                                                          ['_id'];
                                                  icon.getbookDetails();

                                                  Get.to(
                                                      () => BookDeatilsView());
                                                  print(icon.filterBook[index]
                                                      ['_id']);
                                                },
                                                child: Container(
                                                  height: 20.sp,
                                                  width: 15.w,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              3.sp),
                                                      border: Border.all(
                                                          color: Get.theme
                                                              .primaryColor)),
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
                ))
          ],
        ),
      ),
    );
  }
}

var genrelist = [
  'Fantacy',
  'comics',
  'Romance',
  'Culture',
  'comics',
  'comics',
  'comics'
];
