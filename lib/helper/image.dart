// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'dart:io';
import 'package:chat_app/utils/style.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

Future<File?> pickImage(ImageSource source) async {
  PickedFile? selectedImage =
      await ImagePicker.platform.pickImage(source: source);
  if (selectedImage != null) {
    return File(selectedImage.path);
  }
  return null;
}

pickImageDialog(BuildContext context, Function(File) onImageSelected) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      actionsPadding: const EdgeInsets.only(right: 10, bottom: 10),
      shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius)),
      title: const Text('Select Image',
          style: TextStyle(fontSize: 20, fontWeight: fontWeightBold)),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            contentPadding: EdgeInsets.zero,
            visualDensity: const VisualDensity(horizontal: 2, vertical: -3),
            leading: const Icon(Icons.camera_alt),
            title: const Text('Camera'),
            onTap: () async {
              Navigator.pop(context);
              File? image = await pickImage(ImageSource.camera);
              if (image != null) {
                onImageSelected(image);
              }
            },
          ),
          ListTile(
            contentPadding: EdgeInsets.zero,
            visualDensity: const VisualDensity(horizontal: 2, vertical: -3),
            leading: const Icon(Icons.image),
            title: const Text('Gallery'),
            onTap: () async {
              Navigator.pop(context);
              File? image = await pickImage(ImageSource.gallery);
              if (image != null) {
                onImageSelected(image);
              }
            },
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
      ],
    ),
  );
}
