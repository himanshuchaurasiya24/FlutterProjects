import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future openFile({required String url, String? fileName}) async {
    final name = fileName ?? url.split('/').last;
    final file = await downloadFile(url, name);
    if (file != null) {
      debugPrint('Path: + ${file.path}');
      OpenFile.open(file.path);
    } else {
      return;
    }
  }

  Future<File?> downloadFile(String url, String name) async {
    try {
      final appStorage = await getApplicationDocumentsDirectory();
      debugPrint(appStorage.path);
      File file = File('${appStorage.path}/$name');
      final response = await Dio().get(url,
          options: Options(
            responseType: ResponseType.bytes,
            followRedirects: true,
            receiveTimeout: const Duration(seconds: 0),
          ));
      final raf = file.openSync(mode: FileMode.write);
      raf.writeFromSync(response.data);
      await raf.close();
      return file;
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () {
                  openFile(
                      url:
                          // 'https://github.com/himanshuchaurasiya24/TodoFlutterxDjango/archive/refs/heads/main.zip'
                      'https://sample-videos.com/video321/mp4/720/big_buck_bunny_720p_1mb.mp4',
                      // fileName: 'videos.mp4'
                      );
                },
                child: const Text('Download & Open File'))
          ],
        ),
      ),
    );
  }
}
