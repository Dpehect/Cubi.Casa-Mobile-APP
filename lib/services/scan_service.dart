import 'package:camera/camera.dart';
import 'package:uuid/uuid.dart';
import '../models/scan_session_model.dart';
import 'database_service.dart';

class ScanService {
  static final ScanService _instance = ScanService._internal();
  final DatabaseService _db = DatabaseService();
  late CameraController? _cameraController;

  factory ScanService() {
    return _instance;
  }

  ScanService._internal();

  Future<List<CameraDescription>> getAvailableCameras() async {
    return await availableCameras();
  }

  Future<bool> initializeCamera(CameraDescription description) async {
    try {
      _cameraController = CameraController(
        description,
        ResolutionPreset.high,
      );
      await _cameraController!.initialize();
      return true;
    } catch (e) {
      return false;
    }
  }

  CameraController? get cameraController => _cameraController;

  Future<void> disposeCamera() async {
    _cameraController?.dispose();
    _cameraController = null;
  }

  Future<String> startScanSession(String userId) async {
    final sessionId = const Uuid().v4();
    final session = ScanSession(
      id: sessionId,
      userId: userId,
      status: 'in_progress',
      capturedImageUrls: [],
      totalFrames: 0,
      startedAt: DateTime.now(),
      scanMetadata: {
        'device': 'mobile',
        'app_version': '1.0.0',
      },
      errorLogs: [],
    );

    await _db.insertScanSession(session);
    return sessionId;
  }

  Future<void> endScanSession(String sessionId) async {
  }

  Future<void> addCapturedFrame(String sessionId, String imagePath) async {
    return null;
  }
}
