import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kubera/controller/init.dart';

import '../../screens/search.dart';
import '../icon_text_field.dart';

class SearchBar extends StatelessWidget {
  final bool enabled;
  SearchBar({Key? key, this.enabled = false}) : super(key: key);
  final TextEditingController _con = TextEditingController();
  final InitCon icon = Get.find();
  @override
  Widget build(BuildContext context) {
    return ICTextField(
      enabled: enabled,
      onchage: (o) {
        icon.filterFavList(o);
      },
      ontap: () {
        enabled ? null : Get.to(() => SearchView());
      },
      controller: _con,
      hint: 'Search for book or authors etc...',
      label: 'Search for book or authors etc...',
      preicon: CupertinoIcons.search,
      ispreicon: true,
    );
  }
}
