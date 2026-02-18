import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/property_model.dart';
import '../network/api_service.dart';
import '../constants/app_constants.dart';

final propertyRepositoryProvider = Provider<ApiService>((ref) {
  return ApiService();
});

final propertiesProvider = StateNotifierProvider<PropertiesNotifier, AsyncValue<List<Property>>>((ref) {
  return PropertiesNotifier(ref.watch(propertyRepositoryProvider));
});

final propertyDetailProvider = FutureProvider.family<Property?, String>((ref, id) async {
  final apiService = ref.watch(propertyRepositoryProvider);
  try {
    final response = await apiService.get('${ApiEndpoints.propertyDetail.replaceAll(':id', id)}');
    if (response != null && response['data'] != null) {
      return Property.fromJson(response['data']);
    }
    return null;
  } catch (e) {
    return null;
  }
});

class PropertiesNotifier extends StateNotifier<AsyncValue<List<Property>>> {
  final ApiService _apiService;

  PropertiesNotifier(this._apiService) : super(const AsyncValue.loading()) {
    _loadProperties();
  }

  Future<void> _loadProperties() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final response = await _apiService.get(ApiEndpoints.properties);
      if (response != null && response['data'] != null) {
        final list = (response['data'] as List)
            .map((item) => Property.fromJson(item as Map<String, dynamic>))
            .toList();
        return list;
      }
      return [];
    });
  }

  Future<void> createProperty(Property property) async {
    try {
      await _apiService.post(
        ApiEndpoints.createProperty,
        data: property.toJson(),
      );
      await _loadProperties();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateProperty(Property property) async {
    try {
      await _apiService.put(
        ApiEndpoints.updateProperty.replaceAll(':id', property.id),
        data: property.toJson(),
      );
      await _loadProperties();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteProperty(String id) async {
    try {
      await _apiService.delete(
        ApiEndpoints.deleteProperty.replaceAll(':id', id),
      );
      await _loadProperties();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> refreshProperties() async {
    await _loadProperties();
  }
}
