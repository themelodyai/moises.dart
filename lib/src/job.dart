enum JobStatus {
  /// Awaiting to start
  queued,

  /// Processing has started
  started,

  /// Everything has completed and the results are ready
  succeeded,

  /// There was an error processing your media
  failed;
}

class Job {
  /// The unique identifier for this job.
  final String id;

  /// The name of this job.
  final String name;

  /// The current status of this job.
  ///
  /// The status may take time to update.
  final JobStatus status;

  /// The workflow that this job is running.
  ///
  /// The workflow may be null if the job has not started yet or if it has
  /// failed.
  ///
  /// The workflow is a tuple of the workflow id, name, and parameters. The
  /// parameters has not a defined structure and may be null.
  final (String? id, String? name, Map? params) workflow;

  final Map<String, dynamic> result;

  /// Creates a new job.
  const Job({
    required this.id,
    required this.name,
    required this.status,
    required this.workflow,
    required this.result,
  });

  factory Job.fromJson(Map<String, dynamic> json) {
    print(json);
    return Job(
      id: json['id'] as String,
      name: json['name'] as String,
      status: JobStatus.values.firstWhere(
        (e) => e.name.toLowerCase() == (json['status'] as String).toLowerCase(),
        orElse: () => JobStatus.failed,
      ),
      workflow: () {
        final workflow = json['workflow'] is Map ? json['workflow'] : null;
        return (
          workflow?['id'] as String?,
          workflow?['name'] as String?,
          json['workflowParams'] as Map?,
        );
      }(),
      result: json['result'] as Map<String, dynamic>,
    );
  }

  @override
  String toString() {
    return 'Job(id: $id, name: $name, status: $status, workflow: $workflow)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Job &&
        other.id == id &&
        other.name == name &&
        other.status == status &&
        other.workflow == workflow &&
        other.result == result;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        status.hashCode ^
        workflow.hashCode ^
        result.hashCode;
  }
}
