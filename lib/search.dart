import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter_application_100/information.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';

class ItemSearchDelegate extends SearchDelegate {
  final List element;

  ItemSearchDelegate(this.element);

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = ""; 
        },
        icon: const Icon(Icons.clear, color: Color(0xFFA45963)),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null); 
      },
      icon: const Icon(Icons.arrow_back, color: Color(0xFFA45963)),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final results = element.where((item) {
      final itemName = item['name'] ?? '';
      return itemName.toLowerCase().contains(query.toLowerCase());
    }).toList();

    if (results.isEmpty) {
      return const Center(
        child: Text(
          "لا توجد نتائج!",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFFA45963),
          ),
        ),
      );
    }

    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        final item = results[index];
        final imagePath = item['image'];

        return Card(
          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          elevation: 3,
          child: ListTile(
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: imagePath != null
                  ? (imagePath.startsWith('assets')
                      ? Image.asset(
                          imagePath,
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                        )
                      : Image.file(
                          File(imagePath),
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                        ))
                  : const Icon(Icons.image_not_supported, color: Color(0xFFA45963)),
            ),
            title: Text(
              item['name'] ?? '',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Color(0xFF333333),
              ),
            ),
            subtitle: const Text(
              "اضغط لعرض ملف PDF",
              style: TextStyle(fontSize: 14, color: Color(0xFF666666)),
            ),
            trailing: const Icon(Icons.chevron_right, color: Color(0xFFA45963)),
            onTap: () async {
              final pdfPath = item['pdf'];

              if (pdfPath != null && pdfPath.startsWith('assets/pdf/')) {
                final localPath = await copyAssetToLocal(pdfPath);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PdfViewerPage(pdfPath: localPath),
                  ),
                );
              } else if (pdfPath != null && pdfPath.isNotEmpty) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PdfViewerPage(pdfPath: pdfPath),
                  ),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("لا يوجد ملف PDF لهذا العنصر"),
                    backgroundColor: Color(0xFFA45963),
                  ),
                );
              }
            },
          ),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = element.where((item) {
      final itemName = item['name'] ?? '';
      return itemName.toLowerCase().startsWith(query.toLowerCase());
    }).toList();

    if (suggestions.isEmpty) {
      return const Center(
        child: Text(
          "لا توجد اقتراحات!",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFFA45963),
          ),
        ),
      );
    }

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        final item = suggestions[index];
        final imagePath = item['image'];

        return Card(
          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          elevation: 3,
          child: ListTile(
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: imagePath != null
                  ? (imagePath.startsWith('assets')
                      ? Image.asset(
                          imagePath,
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                        )
                      : Image.file(
                          File(imagePath),
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                        ))
                  : const Icon(Icons.image_not_supported, color: Color(0xFFA45963)),
            ),
            title: Text(
              item['name'] ?? '',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Color(0xFF333333),
              ),
            ),
            onTap: () {
              query = item['name'] ?? '';
              showResults(context);
            },
          ),
        );
      },
    );
  }
}

Future<String> copyAssetToLocal(String assetPath) async {
  final byteData = await rootBundle.load(assetPath);
  final tempDir = await getTemporaryDirectory();
  final file = File('${tempDir.path}/${assetPath.split('/').last}');
  await file.writeAsBytes(byteData.buffer.asUint8List());
  return file.path;
}
