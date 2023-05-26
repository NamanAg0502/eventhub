import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageUploadScreen extends StatefulWidget {
  const ImageUploadScreen({super.key});

  @override
  _ImageUploadScreenState createState() => _ImageUploadScreenState();
}

class _ImageUploadScreenState extends State<ImageUploadScreen> {
  File? _image;

  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: source);

    setState(() {
      if (pickedImage != null) {
        _image = File(pickedImage.path);
      }
    });
  }

  void _showImageUploadOptions(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: const Color(0xff4A43EC),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24.0),
          topRight: Radius.circular(24.0),
        ),
      ),
      context: context,
      builder: (BuildContext ctx) {
        return Wrap(
          children: [
            ListTile(
              leading: const Icon(CupertinoIcons.photo_fill_on_rectangle_fill,
                  color: Colors.white70),
              title: const Text('Pick Image from Gallery',
                  style: TextStyle(color: Colors.white)),
              onTap: () {
                _pickImage(ImageSource.gallery);
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              leading:
                  const Icon(CupertinoIcons.camera_fill, color: Colors.white70),
              title: const Text('Take Image from Camera',
                  style: TextStyle(color: Colors.white)),
              onTap: () {
                _pickImage(ImageSource.camera);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: GestureDetector(
            onTap: () => _showImageUploadOptions(context),
            child: Stack(
              children: [
                Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.all(24.0),
                    padding: const EdgeInsets.all(10.0),
                    height: 150.0,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18.0),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xff505588).withOpacity(0.02),
                            spreadRadius: 0,
                            blurRadius: 30,
                            offset: const Offset(0, 8),
                          ),
                        ]),
                    child: _image != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(16.0),
                            child: Image.file(
                              _image!,
                              width: double.infinity,
                              height: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          )
                        : Container(
                            padding: const EdgeInsets.all(16.0),
                            child: const Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  CupertinoIcons.cloud_upload_fill,
                                  color: Color(0xff4A43EC),
                                  size: 64.0,
                                ),
                                Text(
                                  'Upload Image',
                                  style: TextStyle(
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          )),
                _image != null
                    ? Positioned(
                        top: 16.0,
                        right: 16.0,
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              _image = null; // Remove the image
                            });
                          },
                          child: Container(
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.grey,
                            ),
                            padding: const EdgeInsets.all(4.0),
                            child: const Icon(Icons.close, size: 16.0),
                          ),
                        ),
                      )
                    : const SizedBox.shrink(),
              ],
            )));
  }
}
