import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kubera/controller/init.dart';
import 'package:kubera/widgets/bottom_navigation.dart';
import 'package:kubera/widgets/home/author_of_week.dart';
import 'package:kubera/widgets/home/choose_from.dart';
import 'package:kubera/widgets/home/circle_cat.dart';
import 'package:kubera/widgets/home/from_library.dart';
import 'package:kubera/widgets/home/new_launches.dart';
import 'package:kubera/widgets/home/popular.dart';
import 'package:kubera/widgets/home/recommended.dart';
import 'package:kubera/widgets/icon_text_field.dart';
import 'package:kubera/widgets/text.dart';
import 'package:sizer/sizer.dart';

import '../../all_authors.dart';
import '../../widgets/home/allbooks.dart';
import '../../widgets/home/search_bar.dart';
import '../../widgets/home/view_text.dart';
import '../author_week_details.dart';
import '../recommended.dart';

class HomeView extends StatelessWidget {
  final InitCon icon = Get.find();
  HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Obx(
      () => Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.sp),
        child: ListView(
          children: [
            SearchBar(),
            SizedBox(
              height: 8.sp,
            ),
            HeadTxt(
              txt: 'Newly launched',
              ontap: () {},
            ),
            NewLaunch(),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 7.sp),
              child: CircleCat(),
            ),
            if (icon.libraryBookList.isNotEmpty)
              HeadTxt(
                txt: 'From your library',
                ontap: () {},
              ),
            if (icon.libraryBookList.isNotEmpty) FromLibrary(),
            if (icon.libraryBookList.isNotEmpty)
              SizedBox(
                height: 8.sp,
              ),
            HeadTxt(
              txt: 'Choose from authors',
              isviewall: true,
              ontap: () {
                Get.to(() => AllAuthors());
              },
            ),
            FromAuthor(),
            SizedBox(
              height: 8.sp,
            ),
            HeadTxt(
              txt: 'Budget friendly book',
              isviewall: true,
              ontap: () {
                Get.to(() => ReccomendView(
                      title: 'Budget friendly book',
                      data: icon.bugetBookslist,
                    ));
              },
            ),
            Recommended(data: icon.bugetBookslist),
            HeadTxt(
              txt: 'Recommended for you',
              isviewall: true,
              ontap: () {
                Get.to(() => ReccomendView(
                      title: 'Recommended for you',
                    ));
              },
            ),
            Recommended(data: icon.bugetBookslist),
            if (icon.authorofweeklist.isNotEmpty)
              Padding(
                padding: EdgeInsets.symmetric(vertical: 15.sp),
                child: Container(
                  height: 10.sp,
                  color: Colors.grey[100],
                ),
              ),
            if (icon.authorofweeklist.isNotEmpty)
              HeadTxt(
                txt: 'Author of the week ',
                ontap: () {},
              ),
            if (icon.authorofweeklist.isNotEmpty)
              InkWell(
                  onTap: () {
                    icon.authorBooks(
                      icon.authorofweeklist[0]['author']['_id'],
                    );
                    Get.to(() => AuthorWeek());
                  },
                  child: AuthorOffView()),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 15.sp),
              child: Container(
                height: 10.sp,
                color: Colors.grey[100],
              ),
            ),
            HeadTxt(
              txt: 'Popular in each category',
              ontap: () {},
            ),
            Popular1(data: icon.popularBooksCat),
            SizedBox(
              height: 8.sp,
            ),
            Allbooks(isnum: true, data: icon.mypopBooks),
          ],
        ),
      ),
    ));
  }
}
