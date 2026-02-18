import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/floorplan_model.dart';
import '../network/api_service.dart';
import '../constants/app_constants.dart';

final apiServiceProvider = Provider<ApiService>((ref) {
  return ApiService();
});

final floorPlansProvider = StateNotifierProvider<FloorPlansNotifier, AsyncValue<List<FloorPlan>>>((ref) {
  return FloorPlansNotifier(ref.watch(apiServiceProvider));
});

final floorPlanDetailProvider = FutureProvider.family<FloorPlan?, String>((ref, id) async {
  final apiService = ref.watch(apiServiceProvider);
  try {
    final response = await apiService.get('${ApiEndpoints.floorPlanDetail.replaceAll(':id', id)}');
    if (response != null && response['data'] != null) {
      return FloorPlan.fromJson(response['data']);
    }
    return null;
  } catch (e) {
    return null;
  }
});

class FloorPlansNotifier extends StateNotifier<AsyncValue<List<FloorPlan>>> {
  final ApiService _apiService;

  FloorPlansNotifier(this._apiService) : super(const AsyncValue.loading()) {
    _loadFloorPlans();
  }

  Future<void> _loadFloorPlans() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final response = await _apiService.get(ApiEndpoints.floorPlans);
      if (response != null && response['data'] != null) {
        final list = (response['data'] as List)
            .map((item) => FloorPlan.fromJson(item as Map<String, dynamic>))
            .toList();
        return list;
      }
      return [];
    });
  }

  Future<void> createFloorPlan(FloorPlan floorPlan) async {
    try {
      await _apiService.post(
        ApiEndpoints.createFloorPlan,
        data: floorPlan.toJson(),
      );
      await _loadFloorPlans();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateFloorPlan(FloorPlan floorPlan) async {
    try {
      await _apiService.put(
        ApiEndpoints.updateFloorPlan.replaceAll(':id', floorPlan.id),
        data: floorPlan.toJson(),
      );
      await _loadFloorPlans();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteFloorPlan(String id) async {
    try {
      await _apiService.delete(
        ApiEndpoints.deleteFloorPlan.replaceAll(':id', id),
      );
      await _loadFloorPlans();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> toggleFavorite(String id) async {
    try {
      await _apiService.post(
        ApiEndpoints.favoriteFloorPlan.replaceAll(':id', id),
      );
      await _loadFloorPlans();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> refreshFloorPlans() async {
    await _loadFloorPlans();
  }
}
