import '../models/floorplan_model.dart';
import '../network/api_service.dart';
import '../constants/app_constants.dart';

abstract class FloorPlanRepository {
  Future<List<FloorPlan>> getFloorPlans();
  Future<FloorPlan?> getFloorPlan(String id);
  Future<FloorPlan> createFloorPlan(FloorPlan floorPlan);
  Future<FloorPlan> updateFloorPlan(FloorPlan floorPlan);
  Future<void> deleteFloorPlan(String id);
  Future<void> toggleFavorite(String id);
  Future<List<FloorPlan>> searchFloorPlans(String query);
}

class FloorPlanRepositoryImpl implements FloorPlanRepository {
  final ApiService _apiService;

  FloorPlanRepositoryImpl(this._apiService);

  @override
  Future<List<FloorPlan>> getFloorPlans() async {
    try {
      final response = await _apiService.get(ApiEndpoints.floorPlans);
      if (response != null && response['data'] != null) {
        return (response['data'] as List)
            .map((item) => FloorPlan.fromJson(item as Map<String, dynamic>))
            .toList();
      }
      return [];
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<FloorPlan?> getFloorPlan(String id) async {
    try {
      final response = await _apiService.get(
        ApiEndpoints.floorPlanDetail.replaceAll(':id', id),
      );
      if (response != null && response['data'] != null) {
        return FloorPlan.fromJson(response['data']);
      }
      return null;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<FloorPlan> createFloorPlan(FloorPlan floorPlan) async {
    try {
      final response = await _apiService.post(
        ApiEndpoints.createFloorPlan,
        data: floorPlan.toJson(),
      );
      return FloorPlan.fromJson(response['data']);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<FloorPlan> updateFloorPlan(FloorPlan floorPlan) async {
    try {
      final response = await _apiService.put(
        ApiEndpoints.updateFloorPlan.replaceAll(':id', floorPlan.id),
        data: floorPlan.toJson(),
      );
      return FloorPlan.fromJson(response['data']);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> deleteFloorPlan(String id) async {
    try {
      await _apiService.delete(
        ApiEndpoints.deleteFloorPlan.replaceAll(':id', id),
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> toggleFavorite(String id) async {
    try {
      await _apiService.post(
        ApiEndpoints.favoriteFloorPlan.replaceAll(':id', id),
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<FloorPlan>> searchFloorPlans(String query) async {
    try {
      final response = await _apiService.get(
        ApiEndpoints.search,
        queryParameters: {'q': query, 'type': 'floor_plan'},
      );
      if (response != null && response['data'] != null) {
        return (response['data'] as List)
            .map((item) => FloorPlan.fromJson(item as Map<String, dynamic>))
            .toList();
      }
      return [];
    } catch (e) {
      rethrow;
    }
  }
}
