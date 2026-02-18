class Property {
  final String id;
  final String userId;
  final String address;
  final String city;
  final String state;
  final String zipCode;
  final String country;
  final double latitude;
  final double longitude;
  final String propertyType;
  final double? totalArea;
  final int? bedrooms;
  final int? bathrooms;
  final DateTime? builtYear;
  final String status; // 'active', 'sold', 'archived'
  final List<String> floorPlanIds;
  final List<String> imageUrls;
  final DateTime createdAt;
  final DateTime updatedAt;
  final Map<String, dynamic> additionalInfo;

  Property({
    required this.id,
    required this.userId,
    required this.address,
    required this.city,
    required this.state,
    required this.zipCode,
    required this.country,
    required this.latitude,
    required this.longitude,
    required this.propertyType,
    this.totalArea,
    this.bedrooms,
    this.bathrooms,
    this.builtYear,
    required this.status,
    required this.floorPlanIds,
    required this.imageUrls,
    required this.createdAt,
    required this.updatedAt,
    required this.additionalInfo,
  });

  factory Property.fromJson(Map<String, dynamic> json) {
    return Property(
      id: json['id'] as String,
      userId: json['userId'] as String,
      address: json['address'] as String,
      city: json['city'] as String,
      state: json['state'] as String,
      zipCode: json['zipCode'] as String,
      country: json['country'] as String,
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      propertyType: json['propertyType'] as String,
      totalArea: (json['totalArea'] as num?)?.toDouble(),
      bedrooms: json['bedrooms'] as int?,
      bathrooms: json['bathrooms'] as int?,
      builtYear: json['builtYear'] != null ? DateTime.parse(json['builtYear'] as String) : null,
      status: json['status'] as String? ?? 'active',
      floorPlanIds: List<String>.from(json['floorPlanIds'] as List? ?? []),
      imageUrls: List<String>.from(json['imageUrls'] as List? ?? []),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      additionalInfo: json['additionalInfo'] as Map<String, dynamic>? ?? {},
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'address': address,
      'city': city,
      'state': state,
      'zipCode': zipCode,
      'country': country,
      'latitude': latitude,
      'longitude': longitude,
      'propertyType': propertyType,
      'totalArea': totalArea,
      'bedrooms': bedrooms,
      'bathrooms': bathrooms,
      'builtYear': builtYear?.toIso8601String(),
      'status': status,
      'floorPlanIds': floorPlanIds,
      'imageUrls': imageUrls,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'additionalInfo': additionalInfo,
    };
  }
}
