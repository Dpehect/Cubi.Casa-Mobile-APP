import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import '../../theme/app_theme.dart';
import '../../services/scan_service.dart';
import '../../widgets/index.dart';

class ScanCameraScreen extends ConsumerStatefulWidget {
  const ScanCameraScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ScanCameraScreen> createState() => _ScanCameraScreenState();
}

class _ScanCameraScreenState extends ConsumerState<ScanCameraScreen> {
  late CameraController _cameraController;
  bool _isInitialized = false;
  int _frameCount = 0;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    try {
      final scanService = ScanService();
      final cameras = await scanService.getAvailableCameras();
      if (cameras.isNotEmpty) {
        final initialized = await scanService.initializeCamera(cameras[0]);
        if (initialized) {
          _cameraController = scanService.cameraController!;
          setState(() => _isInitialized = true);
        }
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Camera initialization failed: $e')),
      );
    }
  }

  @override
  void dispose() {
    ScanService().disposeCamera();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_isInitialized) {
      return Scaffold(
        appBar: AppBar(title: const Text('Scan Floor Plan')),
        body: const LoadingWidget(message: 'Initializing camera...'),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Scan Floor Plan'),
        actions: [
          IconButton(icon: const Icon(Icons.info_outline), onPressed: () {}),
        ],
      ),
      body: Stack(
        children: [
          CameraPreview(_cameraController),
          Positioned(
            bottom: AppSpacing.xl,
            left: 0,
            right: 0,
            child: Center(
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.lg,
                      vertical: AppSpacing.md,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.6),
                      borderRadius: BorderRadius.circular(AppRadius.md),
                    ),
                    child: Text(
                      'Frames: $_frameCount',
                      style: const TextStyle(
                        color: AppColors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      FloatingActionButton(
                        backgroundColor: AppColors.error,
                        heroTag: 'cancel',
                        onPressed: () => Navigator.pop(context),
                        child: const Icon(Icons.close),
                      ),
                      FloatingActionButton(
                        backgroundColor: AppColors.primary,
                        heroTag: 'capture',
                        onPressed: () {
                          setState(() => _frameCount++);
                        },
                        child: const Icon(Icons.camera_alt),
                      ),
                      FloatingActionButton(
                        backgroundColor: AppColors.success,
                        heroTag: 'finish',
                        onPressed: () {
                          Navigator.pop(context, _frameCount);
                        },
                        child: const Icon(Icons.check),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
