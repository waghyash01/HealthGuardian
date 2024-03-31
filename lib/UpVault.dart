import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UploadImageAndMore extends StatefulWidget {
  const UploadImageAndMore({Key? key}) : super(key: key);

  @override
  State<UploadImageAndMore> createState() => _UploadImageAndMoreState();
}

class _UploadImageAndMoreState extends State<UploadImageAndMore> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _numberController = TextEditingController();
  List<String> imageUrls = [];

  @override
  void initState() {
    super.initState();
    // Load image URLs from SharedPreferences when the widget initializes
    loadImages();
  }

  Future<void> loadImages() async {
    final prefs = await SharedPreferences.getInstance();
    final storedImages = prefs.getStringList('imageUrls');
    if (storedImages != null) {
      setState(() {
        imageUrls = storedImages;
      });
    }
  }

  Future<void> _create(BuildContext context) async {
    await showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext ctx) {
        return Padding(
          padding: EdgeInsets.only(
            top: 20,
            right: 20,
            left: 20,
            bottom: MediaQuery.of(ctx).viewInsets.bottom + 20,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(
                child: Text("Create your Items"),
              ),
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Name',
                  hintText: 'eg Elon',
                ),
              ),
              TextField(
                controller: _numberController,
                decoration: const InputDecoration(
                  labelText: 'Number',
                  hintText: 'eg 10',
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Center(
                child: IconButton(
                  onPressed: () async {
                    final file =
                    await ImagePicker().pickImage(source: ImageSource.gallery);
                    if (file == null) return;

                    String fileName =
                    DateTime.now().microsecondsSinceEpoch.toString();

                    Reference referenceRoot = FirebaseStorage.instance.ref();

                    // Get the number entered by the user
                    String number = _numberController.text;

                    Reference referenceImageToUpload =
                    referenceRoot.child('$number/$fileName');

                    try {
                      await referenceImageToUpload.putFile(File(file.path));

                      String imageUrl =
                      await referenceImageToUpload.getDownloadURL();

                      // Add the image URL to the list
                      setState(() {
                        imageUrls.add(imageUrl);
                      });

                      // Save updated image URLs to SharedPreferences
                      saveImages();

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Image uploaded successfully'),
                        ),
                      );
                    } catch (error) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Error uploading image: $error'),
                        ),
                      );
                      // Handle error
                      print('Error uploading image: $error');
                    }
                  },
                  icon: const Icon(Icons.camera_alt),
                ),
              ),
              Center(
                child: ElevatedButton(
                  onPressed: () async {
                    if (imageUrls.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Please select and upload image"),
                        ),
                      );
                      return;
                    }
                    final String name = _nameController.text;
                    final int? number = int.tryParse(_numberController.text);
                    if (number != null) {
                      // You can perform any additional actions here
                      _nameController.text = '';
                      _numberController.text = '';
                      Navigator.of(context).pop();
                    }
                  },
                  child: const Text('Create'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> saveImages() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList('imageUrls', imageUrls);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Upload and display Items"),
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () => _create(context),
            child: const Text('Create'),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
              ),
              itemCount: imageUrls.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    // Show the image in a larger size
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Image.network(imageUrls[index]),
                              SizedBox(height: 10),
                              Text(
                                'Name: ${_nameController.text}',
                                style: TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text('Close'),
                            ),
                            TextButton(
                              onPressed: () {
                                _deletePhoto(index);
                                Navigator.of(context).pop();
                              },
                              child: Text('Delete'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: Card(
                    child: Image.network(imageUrls[index]),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _deletePhoto(int index) {
    setState(() {
      imageUrls.removeAt(index);
      saveImages(); // Update SharedPreferences after deleting the photo
    });
  }
}

