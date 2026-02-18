import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_model.dart';
import '../network/api_service.dart';
import '../constants/app_constants.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final ApiService _apiService = ApiService();
  late SharedPreferences _prefs;

  Future<void> initialize() async {
    _prefs = await SharedPreferences.getInstance();
  }

  Future<User?> signUpWithEmail({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    required String userType,
  }) async {
    try {
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final firebaseUser = userCredential.user;
      if (firebaseUser == null) return null;

      await firebaseUser.updateDisplayName('$firstName $lastName');

      final response = await _apiService.post(
        ApiEndpoints.register,
        data: {
          'firebaseUid': firebaseUser.uid,
          'email': email,
          'firstName': firstName,
          'lastName': lastName,
          'userType': userType,
        },
      );

      final user = User.fromJson(response['user']);
      await _saveUserLocally(user);
      await _saveAuthToken(response['token']);

      return user;
    } catch (e) {
      rethrow;
    }
  }

  Future<User?> signInWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final firebaseUser = userCredential.user;
      if (firebaseUser == null) return null;

      final response = await _apiService.post(
        ApiEndpoints.login,
        data: {
          'firebaseUid': firebaseUser.uid,
          'email': email,
        },
      );

      final user = User.fromJson(response['user']);
      await _saveUserLocally(user);
      await _saveAuthToken(response['token']);

      return user;
    } catch (e) {
      rethrow;
    }
  }

  Future<User?> signInWithGoogle() async {
    try {
      final googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return null;

      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential = await _firebaseAuth.signInWithCredential(credential);
      final firebaseUser = userCredential.user;
      if (firebaseUser == null) return null;

      final response = await _apiService.post(
        ApiEndpoints.login,
        data: {
          'firebaseUid': firebaseUser.uid,
          'email': firebaseUser.email,
        },
      );

      final user = User.fromJson(response['user']);
      await _saveUserLocally(user);
      await _saveAuthToken(response['token']);

      return user;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
      await _googleSignIn.signOut();
      await _prefs.clear();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> resetPassword(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } catch (e) {
      rethrow;
    }
  }

  Future<User?> getCurrentUser() async {
    try {
      final firebaseUser = _firebaseAuth.currentUser;
      if (firebaseUser == null) return null;

      final userJson = _prefs.getString('user');
      if (userJson != null) {
        return User.fromJson(Map<String, dynamic>.from(
          (await _apiService.get(ApiEndpoints.userProfile)) ?? {},
        ));
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  bool isLoggedIn() {
    return _firebaseAuth.currentUser != null;
  }

  Future<void> _saveUserLocally(User user) async {
    await _prefs.setString('user', _jsonEncode(user.toJson()));
  }

  Future<void> _saveAuthToken(String token) async {
    await _prefs.setString('authToken', token);
  }

  String _jsonEncode(Map<String, dynamic> data) {
    return data.toString();
  }
}
