
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';

class AddPage extends StatefulWidget {
  const AddPage({super.key});

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  final TextEditingController _controller = TextEditingController();
  File? _selectedImage;
  File? _selectedPdf;

  Future<void> pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  Future<void> pickPdf() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );
    if (result != null) {
      setState(() {
        _selectedPdf = File(result.files.single.path!);
      });
    }
  }

  void _saveAndNavigate() {
    if (_controller.text.isNotEmpty &&
        _selectedImage != null &&
        _selectedPdf != null) {
      Navigator.pop(
        context,
        {
          'name': _controller.text,
          'image': _selectedImage!.path,
          'pdf': _selectedPdf!.path,
        },
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "يرجى إدخال قيمة صحيحة واختيار صورة وملف PDF",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Color(0xFFA45963),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "إضافة عنصر",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFFA45963),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          child: ListView(
            children: [
              
              TextFormField(
                controller: _controller,
                decoration: InputDecoration(
                  labelText: 'أدخل الاسم',
                  labelStyle: const TextStyle(color: Color(0xFFA45963)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(color: Color(0xFFA45963)),
                  ),
                ),
              ),
              const SizedBox(height: 20),

            
              ElevatedButton.icon(
                onPressed: pickImage,
                icon: const Icon(Icons.image, color: Colors.white),
                label: const Text("اختر صورة"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFA45963),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
              const SizedBox(height: 20),

             
              _selectedImage != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.file(
                        _selectedImage!,
                        height: 200,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    )
                  : const Center(
                      child: Text(
                        "لم يتم اختيار صورة",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
              const SizedBox(height: 20),

              
              ElevatedButton.icon(
                onPressed: pickPdf,
                icon: const Icon(Icons.picture_as_pdf, color: Colors.white),
                label: const Text("اختر ملف PDF"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFA45963),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),

              
              if (_selectedPdf != null)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    "PDF مختار: ${_selectedPdf!.path.split('/').last}",
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
              const SizedBox(height: 20),

            
              ElevatedButton(
                onPressed: _saveAndNavigate,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFA45963),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 15),
                ),
                child: const Text(
                  "إضافة",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
