import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';


class PdfViewerPage extends StatelessWidget {
  final String pdfPath;

  const PdfViewerPage({super.key, required this.pdfPath});

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PDF Viewer'),
        centerTitle: true,
      ),
      body: 
      PDFView(
        filePath: pdfPath,
        enableSwipe: true,
        swipeHorizontal: false,
        autoSpacing: true,
        pageFling: true,
        onError: (error) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("حدث خطأ: $error")),
          );

        // ignore: unused_label
        onPageError: (page, error) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("خطأ في الصفحة $page: $error")),
          );
        };
        },
      )
    );
  }
}