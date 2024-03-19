import 'dart:io';

// import 'package:open_file/open_file.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart';

class PdfApi {
  static Future<File> generateCenteredText(String text) async {
    final pdf = Document();
    pdf.addPage(
      Page(
        build: (context) {
          return Center(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 48,
              ),
            ),
          );
        },
      ),
    );
    return saveDocument(name: 'first_pdf.pdf', pdf: pdf);
  }

  static Future<File> saveDocument(
      {required String name, required Document pdf}) async {
    final bytes = await pdf.save();
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/$name');
    await file.writeAsBytes(bytes);
    return file;
  }

  static Future openFile({required File file}) async {
    final url = file.path;
    await OpenFilex.open(url);
  }
}
