import 'dart:convert';

import 'package:http/http.dart' as http;

import 'src/job.dart';

class MusicAiClient {
  /// Every request to the API must be authenticated with an API Key.
  ///
  /// You can generate an API Key in your dashboard.
  ///
  /// See also:
  ///
  ///   * <https://music.ai/docs/api/authentication/>
  final String apiKey;

  /// Creates a music.ai client.
  const MusicAiClient({required this.apiKey});

  /// Returns a single job.
  Future<Job> getJob(String id) async {
    final url = Uri.parse('https://api.music.ai/api/job/$id');
    final response = await http.get(url, headers: {'Authorization': apiKey});

    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      return Job.fromJson(result);
    } else {
      throw Exception('Failed to load job');
    }
  }

  /// Returns a list of all jobs.
  Future getJobs() async {
    final url = Uri.parse('https://api.music.ai/api/job');
    final response = await http.get(url, headers: {'Authorization': apiKey});

    if (response.statusCode == 200) {
      final result = (jsonDecode(response.body) as List).cast<Map>();
      return result
          .map((job) => Job.fromJson(job.cast<String, dynamic>()))
          .toList();
    } else {
      throw Exception('Failed to load jobs: ${response.body}');
    }
  }

  /// Creates a job and returns its id.
  Future<String> createJob(
    String name,
    String workflowId,
    Map<String, String> params,
  ) async {
    final url = Uri.parse('https://api.music.ai/api/job');
    final response = await http.post(
      url,
      body: jsonEncode({
        'name': name,
        'workflow': workflowId,
        'params': params,
      }),
      headers: {'Authorization': apiKey},
    );

    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      return result['id'] as String;
    } else {
      throw Exception(
          'Failed to create job $name/$workflowId: ${response.body}');
    }
  }

  /// Deletes a job and returns its id.
  Future<String> deleteJob(String id) async {
    final url = Uri.parse('https://api.music.ai/api/job');
    final response = await http.delete(url, headers: {'Authorization': apiKey});

    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      return result['id'] as String;
    } else {
      throw Exception('Failed to create job $id: ${response.body}');
    }
  }
}
