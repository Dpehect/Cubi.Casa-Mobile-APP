class FloorPlan {
  final String id;
  final String userId;
  final String? propertyId;
  final String name;
  final String? description;
  final List<String> imageUrls;
  final String? planImageUrl;
  final String? planPdfUrl;
  final String? plan3dModelUrl;
  final List<Room> rooms;
  final double totalArea;
  final String areaUnit; // 'm2' or 'sqft'
  final String scanStatus; // 'pending', 'processing', 'completed', 'failed'
  final Map<String, dynamic> scanMetadata;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? completedAt;
  final String propertyType; // 'residential', 'commercial', 'office', 'retail'
  final String? address;
  final double? latitude;
  final double? longitude;
  final bool isFavorite;
  final List<String> tags;

  FloorPlan({
    required this.id,
    required this.userId,
    this.propertyId,
    required this.name,
    this.description,
    required this.imageUrls,
    this.planImageUrl,
    this.planPdfUrl,
    this.plan3dModelUrl,
    required this.rooms,
    required this.totalArea,
    required this.areaUnit,
    required this.scanStatus,
    required this.scanMetadata,
    required this.createdAt,
    required this.updatedAt,
    this.completedAt,
    required this.propertyType,
    this.address,
    this.latitude,
    this.longitude,
    required this.isFavorite,
    required this.tags,
  });

  FloorPlan copyWith({
    String? id,
    String? userId,
    String? propertyId,
    String? name,
    String? description,
    List<String>? imageUrls,
    String? planImageUrl,
    String? planPdfUrl,
    String? plan3dModelUrl,
    List<Room>? rooms,
    double? totalArea,
    String? areaUnit,
    String? scanStatus,
    Map<String, dynamic>? scanMetadata,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? completedAt,
    String? propertyType,
    String? address,
    double? latitude,
    double? longitude,
    bool? isFavorite,
    List<String>? tags,
  }) {
    return FloorPlan(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      propertyId: propertyId ?? this.propertyId,
      name: name ?? this.name,
      description: description ?? this.description,
      imageUrls: imageUrls ?? this.imageUrls,
      planImageUrl: planImageUrl ?? this.planImageUrl,
      planPdfUrl: planPdfUrl ?? this.planPdfUrl,
      plan3dModelUrl: plan3dModelUrl ?? this.plan3dModelUrl,
      rooms: rooms ?? this.rooms,
      totalArea: totalArea ?? this.totalArea,
      areaUnit: areaUnit ?? this.areaUnit,
      scanStatus: scanStatus ?? this.scanStatus,
      scanMetadata: scanMetadata ?? this.scanMetadata,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      completedAt: completedAt ?? this.completedAt,
      propertyType: propertyType ?? this.propertyType,
      address: address ?? this.address,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      isFavorite: isFavorite ?? this.isFavorite,
      tags: tags ?? this.tags,
    );
  }

  factory FloorPlan.fromJson(Map<String, dynamic> json) {
    return FloorPlan(
      id: json['id'] as String,
      userId: json['userId'] as String,
      propertyId: json['propertyId'] as String?,
      name: json['name'] as String,
      description: json['description'] as String?,
      imageUrls: List<String>.from(json['imageUrls'] as List? ?? []),
      planImageUrl: json['planImageUrl'] as String?,
      planPdfUrl: json['planPdfUrl'] as String?,
      plan3dModelUrl: json['plan3dModelUrl'] as String?,
      rooms: (json['rooms'] as List?)?.map((r) => Room.fromJson(r as Map<String, dynamic>)).toList() ?? [],
      totalArea: (json['totalArea'] as num?)?.toDouble() ?? 0.0,
      areaUnit: json['areaUnit'] as String? ?? 'm2',
      scanStatus: json['scanStatus'] as String? ?? 'pending',
      scanMetadata: json['scanMetadata'] as Map<String, dynamic>? ?? {},
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      completedAt: json['completedAt'] != null ? DateTime.parse(json['completedAt'] as String) : null,
      propertyType: json['propertyType'] as String? ?? 'residential',
      address: json['address'] as String?,
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
      isFavorite: json['isFavorite'] as bool? ?? false,
      tags: List<String>.from(json['tags'] as List? ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'propertyId': propertyId,
      'name': name,
      'description': description,
      'imageUrls': imageUrls,
      'planImageUrl': planImageUrl,
      'planPdfUrl': planPdfUrl,
      'plan3dModelUrl': plan3dModelUrl,
      'rooms': rooms.map((r) => r.toJson()).toList(),
      'totalArea': totalArea,
      'areaUnit': areaUnit,
      'scanStatus': scanStatus,
      'scanMetadata': scanMetadata,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'completedAt': completedAt?.toIso8601String(),
      'propertyType': propertyType,
      'address': address,
      'latitude': latitude,
      'longitude': longitude,
      'isFavorite': isFavorite,
      'tags': tags,
    };
  }
}

class Room {
  final String id;
  final String name;
  final String roomType; // 'bedroom', 'bathroom', 'kitchen', 'living room', etc.
  final double width;
  final double height;
  final double area;
  final String areaUnit;
  final Map<String, dynamic> coordinates;
  final List<String> featureIds;

  Room({
    required this.id,
    required this.name,
    required this.roomType,
    required this.width,
    required this.height,
    required this.area,
    required this.areaUnit,
    required this.coordinates,
    required this.featureIds,
  });

  Room copyWith({
    String? id,
    String? name,
    String? roomType,
    double? width,
    double? height,
    double? area,
    String? areaUnit,
    Map<String, dynamic>? coordinates,
    List<String>? featureIds,
  }) {
    return Room(
      id: id ?? this.id,
      name: name ?? this.name,
      roomType: roomType ?? this.roomType,
      width: width ?? this.width,
      height: height ?? this.height,
      area: area ?? this.area,
      areaUnit: areaUnit ?? this.areaUnit,
      coordinates: coordinates ?? this.coordinates,
      featureIds: featureIds ?? this.featureIds,
    );
  }

  factory Room.fromJson(Map<String, dynamic> json) {
    return Room(
      id: json['id'] as String,
      name: json['name'] as String,
      roomType: json['roomType'] as String,
      width: (json['width'] as num?)?.toDouble() ?? 0.0,
      height: (json['height'] as num?)?.toDouble() ?? 0.0,
      area: (json['area'] as num?)?.toDouble() ?? 0.0,
      areaUnit: json['areaUnit'] as String? ?? 'm2',
      coordinates: json['coordinates'] as Map<String, dynamic>? ?? {},
      featureIds: List<String>.from(json['featureIds'] as List? ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'roomType': roomType,
      'width': width,
      'height': height,
      'area': area,
      'areaUnit': areaUnit,
      'coordinates': coordinates,
      'featureIds': featureIds,
    };
  }
}
