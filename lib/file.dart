import 'dart:convert';
import 'dart:io';

import 'package:moises_dart/api.dart';
import 'package:http/http.dart' as http;

extension FileMusicAi on MusicAiClient {
  /// Request an [uploadUrl] and an [downloadUrl] from our server.
  Future<(String uploadUrl, String downloadUrl)> requestSignedURLs() async {
    final url = Uri.parse('https://api.music.ai/api/upload');
    final response = await http.get(url, headers: {'Authorization': apiKey});

    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      return (result['uploadUrl'] as String, result['downloadUrl'] as String);
    } else {
      throw Exception('Failed to create job: ${response.body}');
    }
  }

  /// Upload your local file to the provided [uploadUrl].
  ///
  /// If [uploadUrl] is not provided, it will be requested from the server using
  /// [requestSignedURLs].
  ///
  /// ```dart
  /// final file = File('path/to/file.mp3');
  /// final bytes = await file.readAsBytes();
  /// final downloadUrl = await client.uploadFile(bytes);
  /// ```
  ///
  /// Returns the [downloadUrl] of the uploaded file.
  Future<String?> uploadFile(List<int> bytes, {String? uploadUrl}) async {
    String? downloadUrl;
    if (uploadUrl == null) {
      (uploadUrl, downloadUrl) = await requestSignedURLs();
    }

    final request = await HttpClient().putUrl(Uri.parse(uploadUrl));
    request.add(bytes);
    final response = await request.close();

    if (response.statusCode != 200) {
      throw Exception('Failed to upload file: ${response.statusCode}');
    }

    return downloadUrl;
  }
}
