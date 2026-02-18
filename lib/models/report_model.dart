class Report {
  final String id;
  final String floorPlanId;
  final String userId;
  final String reportType; // 'home_report', 'appraisal_report', 'insurance_report'
  final String status; // 'draft', 'completed', 'sent'
  final Map<String, dynamic> content;
  final List<String> attachmentUrls;
  final DateTime createdAt;
  final DateTime? generatedAt;
  final DateTime? sentAt;
  final List<String> recipientEmails;

  Report({
    required this.id,
    required this.floorPlanId,
    required this.userId,
    required this.reportType,
    required this.status,
    required this.content,
    required this.attachmentUrls,
    required this.createdAt,
    this.generatedAt,
    this.sentAt,
    required this.recipientEmails,
  });

  factory Report.fromJson(Map<String, dynamic> json) {
    return Report(
      id: json['id'] as String,
      floorPlanId: json['floorPlanId'] as String,
      userId: json['userId'] as String,
      reportType: json['reportType'] as String,
      status: json['status'] as String,
      content: json['content'] as Map<String, dynamic>? ?? {},
      attachmentUrls: List<String>.from(json['attachmentUrls'] as List? ?? []),
      createdAt: DateTime.parse(json['createdAt'] as String),
      generatedAt: json['generatedAt'] != null ? DateTime.parse(json['generatedAt'] as String) : null,
      sentAt: json['sentAt'] != null ? DateTime.parse(json['sentAt'] as String) : null,
      recipientEmails: List<String>.from(json['recipientEmails'] as List? ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'floorPlanId': floorPlanId,
      'userId': userId,
      'reportType': reportType,
      'status': status,
      'content': content,
      'attachmentUrls': attachmentUrls,
      'createdAt': createdAt.toIso8601String(),
      'generatedAt': generatedAt?.toIso8601String(),
      'sentAt': sentAt?.toIso8601String(),
      'recipientEmails': recipientEmails,
    };
  }
}
