import 'package:flutter/material.dart';
import 'package:gnosis/models/book_model.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class BookReader extends StatelessWidget {
  final BookModel book;
  BookReader({super.key, required this.book});
  final PdfViewerController _pdfViewerController = PdfViewerController();

  @override
  Widget build(BuildContext context) {
    print(book.bookFile);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          book.title,
          overflow: TextOverflow.fade,
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromARGB(255, 0, 40, 73),
              Color.fromARGB(255, 0, 20, 39),
            ],
          ),
        ),
        child: SfPdfViewer.network(
          book.bookFile ?? "https://cdn.syncfusion.com/content/PDFViewer/flutter-succinctly.pdf",
          controller: _pdfViewerController,
          scrollDirection: PdfScrollDirection.horizontal,
          pageLayoutMode: PdfPageLayoutMode.single,
          interactionMode: PdfInteractionMode.selection,
        ),
      ),
    );
  }
}
