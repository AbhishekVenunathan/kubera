import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kubera/controller/auth.dart';
import 'package:kubera/controller/init.dart';
import 'package:kubera/widgets/text.dart';
import 'package:sizer/sizer.dart';

class InspireView extends StatefulWidget {
  const InspireView({Key? key}) : super(key: key);

  @override
  State<InspireView> createState() => _InspireViewState();
}

class _InspireViewState extends State<InspireView> {
  var selectedList = [];
  var isselect = false;
  final InitCon icon = Get.find();
  final AuthCon acon = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.builder(
          itemCount: icon.authorslist.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3, childAspectRatio: 0.8),
          itemBuilder: (context, index) {
            return Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.sp)),
              elevation: 0,
              child: Container(
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
                                  width: 1.6,
                                  color: acon.selectedauthorList.contains(
                                          icon.authorslist[index]['_id'])
                                      ? Get.theme.primaryColor
                                      : Colors.transparent)),
                          child: Padding(
                            padding: EdgeInsets.all(3.0.sp),
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  if (acon.selectedauthorList.contains(
                                      icon.authorslist[index]['_id'])) {
                                    acon.selectedauthorList
                                        .remove(icon.authorslist[index]['_id']);
                                  } else {
                                    acon.selectedauthorList
                                        .add(icon.authorslist[index]['_id']);
                                  }
                                  print(acon.selectedauthorList);
                                });
                              },
                              child: ClipOval(
                                child: AspectRatio(
                                  aspectRatio: 1,
                                  child: Image.network(
                                    icon.authorslist[index]['image_url'],
                                    fit: BoxFit.cover,
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
            );
          }),
    );
  }
}
