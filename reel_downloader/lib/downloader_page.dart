import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:reel_downloader/model_class.dart';
import 'package:http/http.dart' as http;

class DownloaderPage extends StatefulWidget {
  const DownloaderPage({super.key});

  @override
  State<DownloaderPage> createState() => _DownloaderPageState();
}

class _DownloaderPageState extends State<DownloaderPage> {
  final urlController = TextEditingController();
  double percent = 0.0;
  bool isLoading = false;
  Future<void> downloadFile({required String url}) async {
    final reelUrl = url;
    final regex = RegExp(r'/reel/([A-Za-z0-9_-]+)');
    final match = regex.firstMatch(reelUrl);
    if (match != null) {
      final identifier = match.group(1);
      debugPrint('Extracted identifier: $identifier');
      var endpointUrl = 'https://www.instagram.com/graphql/query/';
      Map<String, String> headers = {
        'user-agent':
            'Mozilla/5.0 (Windows NT 6.3; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.193 Safari/537.36'
      };
      Map<String, dynamic> params = {
        'hl': 'en',
        'query_hash': 'b3055c01b4b222b8a47dc12b090e4e64',
        'variables':
            '{"child_comment_count":3,"fetch_comment_count":40,"has_threaded_comments":true,"parent_comment_count":24,"shortcode":"$identifier"}'
      };
      Uri uri = Uri.parse(endpointUrl);
      final finalUri = uri.replace(queryParameters: params);
      final response = await http.get(finalUri, headers: headers);
      if (response.statusCode == 200) {
        ModelClass data = ModelClass.fromJson(jsonDecode(response.body));
        String videoUrl = data.data.shortcodeMedia.videoUrl;
        debugPrint(videoUrl);
        try {
          Dio dio = Dio();
          await dio.download(videoUrl,
              "${'/storage/emulated/0/ReelsByHimanshu/'}/$identifier.mp4",
              onReceiveProgress: (rec, total) {
            setState(() {
              percent = (rec / total) * 100;
              if (percent > 0) {
                isLoading = false;
              }
            });
            debugPrint("Rec: $rec , Total: $total, Percent: $percent");
          });
        } catch (e) {
          debugPrint(e.toString());
        }
      } else {
        throw Exception('Failed to load!');
      }

      if (kDebugMode) {
        print("Download completed");
      }
    } else {
      debugPrint(
          'Oops! Something went wrong. Could not extract the identifier.');
    }
  }

  Future<void> reelDownload() async {
    var status = await Permission.manageExternalStorage.request();
    if (status.isGranted) {
      downloadFile(url: urlController.text);
    } else if (status.isPermanentlyDenied) {
      openAppSettings();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reel Downloader Test'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: urlController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(30)),
                    filled: true,
                    hintText: 'Enter reel link',
                    fillColor: Colors.grey[300]),
                onFieldSubmitted: (value) {
                  setState(() {
                    isLoading = true;
                    percent = 0.0;
                  });
                  reelDownload();
                },
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton.icon(
                icon: const Icon(
                  Icons.download_for_offline,
                ),
                onPressed: () {
                  setState(() {
                    isLoading = true;
                    percent = 0.0;
                  });
                  reelDownload();
                },
                label: const Text('Download Reel'),
              ),
              Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  isLoading
                      ? CircularProgressIndicator(
                          color: Colors.green[400],
                        )
                      : Visibility(
                        visible: percent>0,
                        child: LinearPercentIndicator(
                            width: MediaQuery.of(context).size.width - 16,
                            lineHeight: 50.0,
                            fillColor: Colors.green[400]!,
                            progressColor: Colors.green[400],
                            percent: percent / 100,
                          ),
                      )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
