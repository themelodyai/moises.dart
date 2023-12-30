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
  final String id;
  final String name;
  final JobStatus status;
  final (String? id, String? name, Map? params) workflow;

  const Job({
    required this.id,
    required this.name,
    required this.status,
    required this.workflow,
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
        other.workflow == workflow;
  }

  @override
  int get hashCode {
    return id.hashCode ^ name.hashCode ^ status.hashCode ^ workflow.hashCode;
  }
}
