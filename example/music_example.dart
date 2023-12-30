import 'dart:io';

import 'package:moises_dart/api.dart';
import 'package:moises_dart/file.dart';

void main() async {
  final apiKey = Platform.environment['moises_api_key'] ??
      String.fromEnvironment('moises_api_key');
  final client = MusicAiClient(apiKey: apiKey);

  final file = File('path/to/file.mp3');
  final bytes = await file.readAsBytes();
  final downloadUrl = await client.uploadFile(bytes);

  if (downloadUrl != null) {
    final jobId = await client.createJob(
      'Generate lyrics', // any name
      'generate-lyrics', // the workflow name you created
      {'inputUrl': downloadUrl},
    );

    await Future.delayed(Duration(seconds: 5));

    final job = await client.getJob(jobId);

    print('Job created: ${job.id}');
  }
}
