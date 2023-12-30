import 'package:moises_dart/music.dart';
import 'package:test/test.dart';

void main() {
  group('Job', () {
    test('Job parses correctly from the server', () {
      final json = {
        'id': 'job-id',
        'name': 'job-name',
        'status': 'succeeded',
        'workflow': {
          'id': 'workflow-id',
          'name': 'workflow-name',
        },
        'workflowParams': {'key': 'value'},
      };

      final job = Job.fromJson(json);

      expect(job.id, 'job-id');
      expect(job.name, 'job-name');
      expect(job.status, JobStatus.succeeded);
      expect(job.workflow.$1, 'workflow-id');
      expect(job.workflow.$2, 'workflow-name');
      expect(job.workflow.$3, {'key': 'value'});
    });
  });
}
