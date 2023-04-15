import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kubera/controller/auth.dart';
import 'package:kubera/controller/init.dart';
import 'package:kubera/widgets/text.dart';
import 'package:sizer/sizer.dart';

class IntrestView extends StatefulWidget {
  const IntrestView({Key? key}) : super(key: key);

  @override
  State<IntrestView> createState() => _IntrestViewState();
}

class _IntrestViewState extends State<IntrestView> {
  final AuthCon acon = Get.find();
  final InitCon icon = Get.find();
  var selectedList = [];
  var isselect = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.builder(
          itemCount: icon.categorieslist.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3, childAspectRatio: 0.8),
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                setState(() {
                  if (acon.selectedList
                      .contains(icon.categorieslist[index]['_id'])) {
                    acon.selectedList.remove(icon.categorieslist[index]['_id']);
                  } else {
                    acon.selectedList.add(icon.categorieslist[index]['_id']);
                  }
                  print(acon.selectedList);
                });
              },
              child: Container(
                child: Card(
                  color: acon.selectedList
                          .contains(icon.categorieslist[index]['_id'])
                      ? Colors.white
                      : Colors.grey[200],
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.sp)),
                  elevation: 0,
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.sp),
                        border: Border.all(
                            width: 1.6,
                            color: acon.selectedList
                                    .contains(icon.categorieslist[index]['_id'])
                                ? Get.theme.primaryColor
                                : Colors.transparent)),
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
                            child: ClipOval(
                              child: AspectRatio(
                                aspectRatio: 1,
                                child: Image.network(
                                  icon.categorieslist[index]['image_url'],
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          )),
                          const SizedBox(
                            height: 10,
                          ),
                          Txt(
                            text: icon.categorieslist[index]['category_name'],
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
              ),
            );
          }),
    );
  }
}
