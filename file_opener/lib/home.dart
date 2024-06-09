import 'dart:io';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              openFile(
                url:
                    'https://sample-videos.com/video321/mp4/720/big_buck_bunny_720p_1mb.mp4',
              );
            },
            child: const Text('Download & Open'),
          ),
        ],
      ),
    );
  }

  Future openFile({required String url, String? fileName}) async {
    // download from url;
    // final fileName2 = fileName ?? url.split('/').last;
    // final file = await downloadFile(url, fileName2);
    // from local storage
    final file = await pickFile();
    if (file == null) {
      return;
    } else {
      debugPrint(file.path);
      OpenFilex.open(file.path);
    }
  }

  Future<File?> pickFile() async {
    final result = await FilePicker.platform.pickFiles();
    if (result == null) return null;
    return File(result.files.first.path!);
  }

  Future<File?> downloadFile(String url, String name) async {
    try {
      final appStorage = await getApplicationDocumentsDirectory();
      final file = File('${appStorage.path}\\$name');
      final response = await Dio().get(
        url,
        options: Options(
            responseType: ResponseType.bytes,
            followRedirects: false,
            receiveTimeout: const Duration(seconds: 0)),
      );
      final ref = file.openSync(mode: FileMode.write);
      ref.writeFromSync(response.data);
      await ref.close();
      return file;
    } catch (e) {
      return null;
    }
  }
}
