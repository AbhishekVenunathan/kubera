import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:kubera/widgets/appbar.dart';
import 'package:kubera/widgets/text.dart';
import 'package:sizer/sizer.dart';

import 'controller/auth.dart';
import 'controller/init.dart';
import 'screens/author_week_details.dart';

class AllAuthors extends StatelessWidget {
  AllAuthors({Key? key}) : super(key: key);
  final InitCon icon = Get.find();
  final AuthCon acon = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        backicon: true,
        title: 'Authors',
      ),
      body: GridView.builder(
          itemCount: icon.authorslist.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3, childAspectRatio: 0.8),
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                print('s');
                //print(icon.authorslist[index]['_id']);
              },
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.sp)),
                elevation: 0,
                child: InkWell(
                  onTap: () {
                    print('s');
                    // print(icon.authorslist[index]['_id']);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(.5),
                    child: Column(
                      //  mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        Expanded(
                            child: Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: Container(
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                    width: 1.6, color: Colors.transparent)),
                            child: Padding(
                              padding: EdgeInsets.all(3.0.sp),
                              child: InkWell(
                                onTap: () {
                                  print(icon.authorslist[index]['_id']);
                                  icon.authorBooks(
                                      icon.authorslist[index]['_id']);
                                  Get.to(() => AuthorWeek());
                                },
                                child: ClipOval(
                                  child: AspectRatio(
                                    aspectRatio: 1,
                                    child: CachedNetworkImage(
                                      imageUrl: icon.authorslist[index]
                                          ['image_url'],
                                      fit: BoxFit.cover,
                                      placeholder: (context, url) =>
                                          Container().animate().shimmer(),
                                      errorWidget: (context, url, error) =>
                                          Icon(Icons.error),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )),
                        const SizedBox(
                          height: 10,
                        ),
                        Txt(
                          text: icon.authorslist[index]['author_name'],
                          fsize: 11,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }
}
