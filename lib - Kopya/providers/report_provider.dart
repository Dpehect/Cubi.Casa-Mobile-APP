import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/report_model.dart';
import '../network/api_service.dart';
import '../constants/app_constants.dart';

final reportsProvider = StateNotifierProvider<ReportsNotifier, AsyncValue<List<Report>>>((ref) {
  return ReportsNotifier(ApiService());
});

final reportDetailProvider = FutureProvider.family<Report?, String>((ref, id) async {
  final apiService = ApiService();
  try {
    final response = await apiService.get('${ApiEndpoints.reportDetail.replaceAll(':id', id)}');
    if (response != null && response['data'] != null) {
      return Report.fromJson(response['data']);
    }
    return null;
  } catch (e) {
    return null;
  }
});

class ReportsNotifier extends StateNotifier<AsyncValue<List<Report>>> {
  final ApiService _apiService;

  ReportsNotifier(this._apiService) : super(const AsyncValue.loading()) {
    _loadReports();
  }

  Future<void> _loadReports() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final response = await _apiService.get(ApiEndpoints.reports);
      if (response != null && response['data'] != null) {
        final list = (response['data'] as List)
            .map((item) => Report.fromJson(item as Map<String, dynamic>))
            .toList();
        return list;
      }
      return [];
    });
  }

  Future<void> createReport(Report report) async {
    try {
      await _apiService.post(
        ApiEndpoints.createReport,
        data: report.toJson(),
      );
      await _loadReports();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> generateReport(String floorPlanId) async {
    try {
      await _apiService.post(
        ApiEndpoints.generateReport.replaceAll(':id', floorPlanId),
      );
      await _loadReports();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteReport(String id) async {
    try {
      await _apiService.delete(
        ApiEndpoints.reportDetail.replaceAll(':id', id),
      );
      await _loadReports();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> refreshReports() async {
    await _loadReports();
  }
}
