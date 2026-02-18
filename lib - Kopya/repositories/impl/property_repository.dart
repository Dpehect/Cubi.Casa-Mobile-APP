import '../models/property_model.dart';
import '../network/api_service.dart';
import '../constants/app_constants.dart';

abstract class PropertyRepository {
  Future<List<Property>> getProperties();
  Future<Property?> getProperty(String id);
  Future<Property> createProperty(Property property);
  Future<Property> updateProperty(Property property);
  Future<void> deleteProperty(String id);
  Future<List<Property>> searchProperties(String query);
}

class PropertyRepositoryImpl implements PropertyRepository {
  final ApiService _apiService;

  PropertyRepositoryImpl(this._apiService);

  @override
  Future<List<Property>> getProperties() async {
    try {
      final response = await _apiService.get(ApiEndpoints.properties);
      if (response != null && response['data'] != null) {
        return (response['data'] as List)
            .map((item) => Property.fromJson(item as Map<String, dynamic>))
            .toList();
      }
      return [];
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Property?> getProperty(String id) async {
    try {
      final response = await _apiService.get(
        ApiEndpoints.propertyDetail.replaceAll(':id', id),
      );
      if (response != null && response['data'] != null) {
        return Property.fromJson(response['data']);
      }
      return null;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Property> createProperty(Property property) async {
    try {
      final response = await _apiService.post(
        ApiEndpoints.createProperty,
        data: property.toJson(),
      );
      return Property.fromJson(response['data']);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Property> updateProperty(Property property) async {
    try {
      final response = await _apiService.put(
        ApiEndpoints.updateProperty.replaceAll(':id', property.id),
        data: property.toJson(),
      );
      return Property.fromJson(response['data']);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> deleteProperty(String id) async {
    try {
      await _apiService.delete(
        ApiEndpoints.deleteProperty.replaceAll(':id', id),
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<Property>> searchProperties(String query) async {
    try {
      final response = await _apiService.get(
        ApiEndpoints.search,
        queryParameters: {'q': query, 'type': 'property'},
      );
      if (response != null && response['data'] != null) {
        return (response['data'] as List)
            .map((item) => Property.fromJson(item as Map<String, dynamic>))
            .toList();
      }
      return [];
    } catch (e) {
      rethrow;
    }
  }
}
