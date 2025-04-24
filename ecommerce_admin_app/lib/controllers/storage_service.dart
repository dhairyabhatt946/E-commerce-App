import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class StorageService {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  // UPLOAD IMAGE TO FIREBASE STORAGE
  Future<String?> uploadImage(String path, BuildContext context) async {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Uploading image...")));
    print("Uploading image...");
    File file = File(path);
    try {
      // create a unique file based on the current time
      String fileName = DateTime.now().toString();

      // create a reference to Firebase Storage
      Reference ref = _storage.ref().child("shop_images/$fileName");

      // upload the file
      UploadTask uploadTask = ref.putFile(file);

      // wait for the upload to complete
      await uploadTask;

      // Get the download url
      String downloadURL = await ref.getDownloadURL();
      print("Download URL: $downloadURL");
      return downloadURL;
    } catch (e) {
      print("There was an error");
      print(e);
      return null;
    }
  }
}