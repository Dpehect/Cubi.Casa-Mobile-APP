import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/user_model.dart';
import '../services/auth_service.dart';

final authServiceProvider = Provider<AuthService>((ref) {
  return AuthService();
});

final currentUserProvider = StateNotifierProvider<CurrentUserNotifier, AsyncValue<User?>>((ref) {
  return CurrentUserNotifier(ref.watch(authServiceProvider));
});

final isAuthenticatedProvider = Provider<bool>((ref) {
  final authService = ref.watch(authServiceProvider);
  return authService.isLoggedIn();
});

class CurrentUserNotifier extends StateNotifier<AsyncValue<User?>> {
  final AuthService _authService;

  CurrentUserNotifier(this._authService) : super(const AsyncValue.loading()) {
    _loadCurrentUser();
  }

  Future<void> _loadCurrentUser() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => _authService.getCurrentUser());
  }

  Future<void> signInWithEmail({required String email, required String password}) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(
      () => _authService.signInWithEmail(email: email, password: password),
    );
  }

  Future<void> signUpWithEmail({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    required String userType,
  }) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(
      () => _authService.signUpWithEmail(
        email: email,
        password: password,
        firstName: firstName,
        lastName: lastName,
        userType: userType,
      ),
    );
  }

  Future<void> signInWithGoogle() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => _authService.signInWithGoogle());
  }

  Future<void> signOut() async {
    await _authService.signOut();
    state = const AsyncValue.data(null);
  }

  Future<void> resetPassword(String email) async {
    await _authService.resetPassword(email);
  }
}
