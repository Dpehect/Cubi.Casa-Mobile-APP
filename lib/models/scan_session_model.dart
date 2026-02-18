class ScanSession {
  final String id;
  final String userId;
  final String? floorPlanId;
  final String status; // 'in_progress', 'completed', 'failed', 'paused'
  final List<String> capturedImageUrls;
  final int totalFrames;
  final DateTime startedAt;
  final DateTime? endedAt;
  final Duration? duration;
  final Map<String, dynamic> scanMetadata;
  final List<String> errorLogs;

  ScanSession({
    required this.id,
    required this.userId,
    this.floorPlanId,
    required this.status,
    required this.capturedImageUrls,
    required this.totalFrames,
    required this.startedAt,
    this.endedAt,
    this.duration,
    required this.scanMetadata,
    required this.errorLogs,
  });

  factory ScanSession.fromJson(Map<String, dynamic> json) {
    return ScanSession(
      id: json['id'] as String,
      userId: json['userId'] as String,
      floorPlanId: json['floorPlanId'] as String?,
      status: json['status'] as String,
      capturedImageUrls: List<String>.from(json['capturedImageUrls'] as List? ?? []),
      totalFrames: json['totalFrames'] as int? ?? 0,
      startedAt: DateTime.parse(json['startedAt'] as String),
      endedAt: json['endedAt'] != null ? DateTime.parse(json['endedAt'] as String) : null,
      duration: json['duration'] != null ? Duration(milliseconds: json['duration'] as int) : null,
      scanMetadata: json['scanMetadata'] as Map<String, dynamic>? ?? {},
      errorLogs: List<String>.from(json['errorLogs'] as List? ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'floorPlanId': floorPlanId,
      'status': status,
      'capturedImageUrls': capturedImageUrls,
      'totalFrames': totalFrames,
      'startedAt': startedAt.toIso8601String(),
      'endedAt': endedAt?.toIso8601String(),
      'duration': duration?.inMilliseconds,
      'scanMetadata': scanMetadata,
      'errorLogs': errorLogs,
    };
  }
}
