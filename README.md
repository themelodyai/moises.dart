<div align='center'>

![](https://studio.moises.ai/assets/images/moises-primary-logo-white.svg)

<h1> moises.ai client for Dart </h1>

</div>

### Getting started

First, create a project on [music.ai](https://music.ai/dash) and create a workflow. These are straightforward steps, so we won't go into details here.

Then, add the dependency to your `pubspec.yaml` file:

```yaml
dependencies:
  moises_dart:
    git:
      url: https://github.com/melody-io/moises.dart
```

### Usage

Assuming your API key is stored in the `MOISES_API_KEY` environment variable, you can run the example. Do not commit your API key to your repository, keep it private.

```dart
import 'package:moises_dart/music.dart';

final apiKey = String.fromEnvironment('MOISES_API_KEY');
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

  // wait the estimated time for the job to finish
  await Future.delayed(Duration(seconds: 5));
  final job = await client.getJob(jobId);

  print('Job created: ${job.id}');
} else {
  print('Error uploading file');
}
```
