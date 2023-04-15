import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kubera/faq_content.dart';
import 'package:kubera/widgets/text.dart';

import '../widgets/appbar.dart';

class FAQView extends StatefulWidget {
  const FAQView({super.key});

  @override
  State<FAQView> createState() => _FAQViewState();
}

class _FAQViewState extends State<FAQView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: false,
        title: Txt(
          lines: 1,
          text: 'FAQs',
          color: Colors.black,
          weight: FontWeight.w600,
          fsize: 18,
          defalutsize: true,
        ),
        actions: [
          Row(
            children: [
              const Txt(
                fsize: 10,
                text: 'த',
              ),
              Switch(
                  value: isTamil,
                  onChanged: (v) {
                    setState(() {
                      isTamil = !isTamil;
                      if (isTamil) {
                        faqContent = englishContent;
                      } else {
                        faqContent = tamilContent;
                      }
                    });
                    setState(() {});
                  },
                  activeColor: Get.theme.primaryColor),
              const Txt(
                fsize: 10,
                text: 'E',
              ),
              const SizedBox(
                width: 10,
              )
            ],
          ),
        ],
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: Colors.black87,
            )),
        backgroundColor: Colors.transparent,
      ),
      body: ListView.builder(
        itemCount: faqContent.length,
        itemBuilder: (BuildContext context, int index) {
          return ExpansionTile(
            title: Txt(
              fsize: 11,
              text: faqContent[index]['question']!,
            ),
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                ),
                child: Txt(
                  fsize: 11,
                  text: faqContent[index]['ans']!,
                ),
              ),
              SizedBox(
                height: 10,
              )
            ],
          );
        },
      ),
    );
  }
}
