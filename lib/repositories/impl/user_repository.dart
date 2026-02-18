import '../models/user_model.dart';
import '../network/api_service.dart';
import '../constants/app_constants.dart';

abstract class UserRepository {
  Future<User?> getUserProfile();
  Future<User> updateUserProfile(User user);
  Future<void> deleteUserAccount();
  Future<void> changePassword(String currentPassword, String newPassword);
}

class UserRepositoryImpl implements UserRepository {
  final ApiService _apiService;

  UserRepositoryImpl(this._apiService);

  @override
  Future<User?> getUserProfile() async {
    try {
      final response = await _apiService.get(ApiEndpoints.userProfile);
      if (response != null && response['data'] != null) {
        return User.fromJson(response['data']);
      }
      return null;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<User> updateUserProfile(User user) async {
    try {
      final response = await _apiService.put(
        ApiEndpoints.updateProfile,
        data: user.toJson(),
      );
      return User.fromJson(response['data']);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> deleteUserAccount() async {
    try {
      await _apiService.post(ApiEndpoints.deleteAccount);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> changePassword(String currentPassword, String newPassword) async {
    try {
      await _apiService.post(
        '/user/change-password',
        data: {
          'currentPassword': currentPassword,
          'newPassword': newPassword,
        },
      );
    } catch (e) {
      rethrow;
    }
  }
}
