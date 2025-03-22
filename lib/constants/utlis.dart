import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
    GlobalKey<ScaffoldMessengerState>();

void showSnackBar(BuildContext context, String text) {
  scaffoldMessengerKey.currentState?.showSnackBar(
    SnackBar(
      content: Text(text),
      behavior: SnackBarBehavior.floating, // Optional: Floating style
      duration: const Duration(seconds: 2), // Customize duration
    ),
  );
}


Future<List<File>> pickImages() async {
  List<File> images = [];
  try {
    var files = await FilePicker.platform.pickFiles(
      type: FileType.any,
      allowMultiple: true,
    );
    if (files != null && files.files.isNotEmpty) {
      for (int i = 0; i < files.files.length; i++) {
        images.add(File(files.files[i].path!));
      }
    }
  } catch (e) {
    debugPrint(e.toString());
  }
  return images;
}
