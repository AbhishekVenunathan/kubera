import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kubera/controller/init.dart';
import 'package:kubera/widgets/appbar.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PdfView extends StatefulWidget {
  final String title, url, id, pgNo;
  const PdfView(
      {Key? key,
      this.title = '',
      this.url = '',
      this.id = '',
      required this.pgNo})
      : super(key: key);

  @override
  State<PdfView> createState() => _PdfViewState();
}

class _PdfViewState extends State<PdfView> {
  final InitCon icon = Get.find();
  final PdfViewerController _con = PdfViewerController();
  var isloading = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: BaseAppBar(title: widget.title, backicon: true),
        body: Container(
            child: SfPdfViewer.network(
          widget.url,
          controller: _con,
          onDocumentLoaded: (o) {
            setState(() {
              // isloading = true;
              print(isloading.toString());
              _con.jumpToPage(int.parse(widget.pgNo.toString()));
            });
          },
          onPageChanged: (o) {
            print(o.newPageNumber);
            icon.savePage(widget.id, o.newPageNumber.toString());
          },
        )));
  }
}
