import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kubera/widgets/text.dart';
import 'package:syncfusion_flutter_core/core.dart';

import '../../widgets/appbar.dart';

class AboutUsView extends StatelessWidget {
  const AboutUsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        backicon: true,
        title: 'About us',
      ),
      body: ListView(
        children: [
          Card(
            child: ListTile(
              leading: Icon(Icons.home, color: Get.theme.primaryColor),
              title: Transform(
                  transform: Matrix4.translationValues(-16, 0.0, 0.0),
                  child: Txt(
                    text: 'Kuberaatechnologies',
                    fsize: 12,
                    weight: FontWeight.bold,
                  )),
            ),
          ),
          Card(
            child: ListTile(
              leading: Icon(Icons.mail, color: Get.theme.primaryColor),
              title: Transform(
                  transform: Matrix4.translationValues(-16, 0.0, 0.0),
                  child: Txt(
                    text: 'kuberaatechnologies@gmail.com',
                    fsize: 12,
                    weight: FontWeight.bold,
                  )),
            ),
          ),
          Card(
            child: ListTile(
              leading: Icon(Icons.web, color: Get.theme.primaryColor),
              title: Transform(
                  transform: Matrix4.translationValues(-16, 0.0, 0.0),
                  child: Txt(
                    text: 'Kuberaatechnologies.com',
                    fsize: 12,
                    weight: FontWeight.bold,
                  )),
            ),
          ),
          Card(
            child: ListTile(
              leading: Icon(Icons.person, color: Get.theme.primaryColor),
              title: Transform(
                  transform: Matrix4.translationValues(-16, 0.0, 0.0),
                  child: Txt(
                    text: 'Proprietor: Muthumani',
                    fsize: 12,
                    weight: FontWeight.bold,
                  )),
            ),
          ),
          Card(
            child: ListTile(
              leading: Icon(Icons.location_on, color: Get.theme.primaryColor),
              title: Transform(
                  transform: Matrix4.translationValues(-16, 0.0, 0.0),
                  child: Txt(
                    text: 'SPM COMPLEX ,KARAIKUDI, TAMILNADU - 630003.',
                    fsize: 11,
                    weight: FontWeight.bold,
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
