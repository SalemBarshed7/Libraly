import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';

class EditPage extends StatefulWidget {
  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  late TextEditingController _nameController;
  File? _imageFile;
  File? _pdfFile;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    
    final currentValue =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    _nameController = TextEditingController(text: currentValue['name']);
    if (currentValue['image'] != null) {
      _imageFile = File(currentValue['image']);
    }
    if (currentValue['pdf'] != null) {
      _pdfFile = File(currentValue['pdf']);
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  Future<void> _pickPdf() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      setState(() {
        _pdfFile = File(result.files.single.path!);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Edit Page",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFFA45963),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            // حقل تعديل الاسم
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: "Edit Name",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
            const SizedBox(height: 20),

      
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                side: const BorderSide(color: Color(0xFFA45963)),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: _pickPdf,
              icon: const Icon(Icons.picture_as_pdf, color: Color(0xFFA45963)),
              label: const Text(
                "Choose PDF",
                style: TextStyle(color: Color(0xFFA45963)),
              ),
            ),
            const SizedBox(height: 10),

           
            _pdfFile != null
                ? Text(
                    "PDF Selected: ${_pdfFile!.path.split('/').last}",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                : const Text("No PDF selected"),
            const SizedBox(height: 20),

          
            _imageFile != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.file(
                      _imageFile!,
                      height: 150,
                      width: 150,
                      fit: BoxFit.cover,
                    ),
                  )
                : const Text("No image selected"),
            const SizedBox(height: 20),

         
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                side: const BorderSide(color: Color(0xFFA45963)),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: _pickImage,
              child: const Text(
                "Change Image",
                style: TextStyle(color: Color(0xFFA45963)),
              ),
            ),
            const SizedBox(height: 20),

        
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFA45963),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {
               
                Navigator.pop(context, {
                  'name': _nameController.text,
                  'pdf': _pdfFile?.path,
                  'image': _imageFile?.path,
                });
              },
              child: const Text(
                "Save",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
