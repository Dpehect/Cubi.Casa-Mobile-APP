import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/index.dart';

class DatabaseService {
  static final DatabaseService _instance = DatabaseService._internal();
  static late Database _database;

  factory DatabaseService() {
    return _instance;
  }

  DatabaseService._internal();

  Future<Database> get database async {
    _database ??= await _initializeDatabase();
    return _database;
  }

  Future<Database> _initializeDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'cubicasa.db');

    return openDatabase(
      path,
      version: 1,
      onCreate: _createTables,
      onUpgrade: _upgradeTables,
    );
  }

  Future<void> _createTables(Database db, int version) async {
    await db.execute('''
      CREATE TABLE users (
        id TEXT PRIMARY KEY,
        email TEXT UNIQUE,
        firstName TEXT,
        lastName TEXT,
        profileImageUrl TEXT,
        userType TEXT,
        companyName TEXT,
        phoneNumber TEXT,
        createdAt TEXT,
        lastLogin TEXT,
        isEmailVerified INTEGER
      )
    ''');

    await db.execute('''
      CREATE TABLE properties (
        id TEXT PRIMARY KEY,
        userId TEXT,
        address TEXT,
        city TEXT,
        state TEXT,
        zipCode TEXT,
        country TEXT,
        latitude REAL,
        longitude REAL,
        propertyType TEXT,
        totalArea REAL,
        bedrooms INTEGER,
        bathrooms INTEGER,
        builtYear TEXT,
        status TEXT,
        createdAt TEXT,
        updatedAt TEXT,
        FOREIGN KEY(userId) REFERENCES users(id)
      )
    ''');

    await db.execute('''
      CREATE TABLE floor_plans (
        id TEXT PRIMARY KEY,
        userId TEXT,
        propertyId TEXT,
        name TEXT,
        description TEXT,
        planImageUrl TEXT,
        planPdfUrl TEXT,
        plan3dModelUrl TEXT,
        totalArea REAL,
        areaUnit TEXT,
        scanStatus TEXT,
        createdAt TEXT,
        updatedAt TEXT,
        completedAt TEXT,
        propertyType TEXT,
        address TEXT,
        latitude REAL,
        longitude REAL,
        isFavorite INTEGER,
        FOREIGN KEY(userId) REFERENCES users(id),
        FOREIGN KEY(propertyId) REFERENCES properties(id)
      )
    ''');

    await db.execute('''
      CREATE TABLE rooms (
        id TEXT PRIMARY KEY,
        name TEXT,
        roomType TEXT,
        width REAL,
        height REAL,
        area REAL,
        areaUnit TEXT,
        floorPlanId TEXT,
        FOREIGN KEY(floorPlanId) REFERENCES floor_plans(id)
      )
    ''');

    await db.execute('''
      CREATE TABLE scan_sessions (
        id TEXT PRIMARY KEY,
        userId TEXT,
        floorPlanId TEXT,
        status TEXT,
        totalFrames INTEGER,
        startedAt TEXT,
        endedAt TEXT,
        FOREIGN KEY(userId) REFERENCES users(id),
        FOREIGN KEY(floorPlanId) REFERENCES floor_plans(id)
      )
    ''');

    await db.execute('''
      CREATE TABLE reports (
        id TEXT PRIMARY KEY,
        floorPlanId TEXT,
        userId TEXT,
        reportType TEXT,
        status TEXT,
        createdAt TEXT,
        generatedAt TEXT,
        sentAt TEXT,
        FOREIGN KEY(floorPlanId) REFERENCES floor_plans(id),
        FOREIGN KEY(userId) REFERENCES users(id)
      )
    ''');
  }

  Future<void> _upgradeTables(Database db, int oldVersion, int newVersion) async {
  }

  Future<int> insertUser(User user) async {
    final db = await database;
    return await db.insert('users', user.toJson());
  }

  Future<User?> getUser(String userId) async {
    final db = await database;
    final result = await db.query('users', where: 'id = ?', whereArgs: [userId]);
    if (result.isNotEmpty) {
      return User.fromJson(result.first);
    }
    return null;
  }

  Future<int> updateUser(User user) async {
    final db = await database;
    return await db.update('users', user.toJson(), where: 'id = ?', whereArgs: [user.id]);
  }

  Future<int> insertFloorPlan(FloorPlan floorPlan) async {
    final db = await database;
    return await db.insert('floor_plans', floorPlan.toJson());
  }

  Future<List<FloorPlan>> getUserFloorPlans(String userId) async {
    final db = await database;
    final result = await db.query('floor_plans', where: 'userId = ?', whereArgs: [userId]);
    return result.map((map) => FloorPlan.fromJson(map)).toList();
  }

  Future<FloorPlan?> getFloorPlan(String floorPlanId) async {
    final db = await database;
    final result = await db.query('floor_plans', where: 'id = ?', whereArgs: [floorPlanId]);
    if (result.isNotEmpty) {
      return FloorPlan.fromJson(result.first);
    }
    return null;
  }

  Future<int> updateFloorPlan(FloorPlan floorPlan) async {
    final db = await database;
    return await db.update('floor_plans', floorPlan.toJson(), where: 'id = ?', whereArgs: [floorPlan.id]);
  }

  Future<int> deleteFloorPlan(String floorPlanId) async {
    final db = await database;
    return await db.delete('floor_plans', where: 'id = ?', whereArgs: [floorPlanId]);
  }

  Future<int> insertProperty(Property property) async {
    final db = await database;
    return await db.insert('properties', property.toJson());
  }

  Future<List<Property>> getUserProperties(String userId) async {
    final db = await database;
    final result = await db.query('properties', where: 'userId = ?', whereArgs: [userId]);
    return result.map((map) => Property.fromJson(map)).toList();
  }

  Future<int> updateProperty(Property property) async {
    final db = await database;
    return await db.update('properties', property.toJson(), where: 'id = ?', whereArgs: [property.id]);
  }

  Future<int> deleteProperty(String propertyId) async {
    final db = await database;
    return await db.delete('properties', where: 'id = ?', whereArgs: [propertyId]);
  }

  Future<int> insertScanSession(ScanSession session) async {
    final db = await database;
    return await db.insert('scan_sessions', {
      'id': session.id,
      'userId': session.userId,
      'floorPlanId': session.floorPlanId,
      'status': session.status,
      'totalFrames': session.totalFrames,
      'startedAt': session.startedAt.toIso8601String(),
      'endedAt': session.endedAt?.toIso8601String(),
    });
  }

  Future<ScanSession?> getScanSession(String sessionId) async {
    final db = await database;
    final result = await db.query('scan_sessions', where: 'id = ?', whereArgs: [sessionId]);
    if (result.isNotEmpty) {
      final row = result.first;
      return ScanSession(
        id: row['id'] as String,
        userId: row['userId'] as String,
        floorPlanId: row['floorPlanId'] as String?,
        status: row['status'] as String,
        capturedImageUrls: [],
        totalFrames: row['totalFrames'] as int? ?? 0,
        startedAt: DateTime.parse(row['startedAt'] as String),
        endedAt: row['endedAt'] != null ? DateTime.parse(row['endedAt'] as String) : null,
        scanMetadata: {},
        errorLogs: [],
      );
    }
    return null;
  }

  Future<void> clearAllData() async {
    final db = await database;
    await db.delete('floor_plans');
    await db.delete('properties');
    await db.delete('rooms');
    await db.delete('scan_sessions');
    await db.delete('reports');
    await db.delete('users');
  }

  Future<void> closeDatabase() async {
    final db = await database;
    await db.close();
  }
}
