import 'package:shared_preferences/shared_preferences.dart';

class AppConfig {
  static late SharedPreferences _prefs;

  static Future<void> initialize() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static const String appName = 'CubiCasa';
  static const String appVersion = '1.0.0';
  static const String bundleId = 'com.cubicasa.app';

  static const String baseUrl = 'https://api.cubicasa.com/v1';
  static const String wsUrl = 'wss://ws.cubicasa.com';
  static const String apiKey = 'your-api-key-here';
  static const int apiTimeout = 30; // seconds

  static const bool enableAnalytics = true;
  static const bool enableCrashReporting = true;
  static const bool enableOfflineMode = true;

  static const String appDocumentsPath = '/cubicasa';
  static const String cacheExpiry = '24h';

  static const int minScanFrames = 50;
  static const int maxScanFrames = 5000;
  static const double minRoomArea = 0.5; // m²
  static const double maxRoomArea = 1000; // m²

  static const List<String> supportedImageFormats = ['jpg', 'jpeg', 'png'];
  static const int maxImageUploadSize = 50 * 1024 * 1024; // 50MB
  static const List<String> supportedReportFormats = ['pdf', 'xlsx', 'csv'];

  static const List<String> supportedLanguages = ['en', 'tr', 'de', 'es', 'fr'];
  static const String defaultLanguage = 'en';

  static bool get isDarkMode {
    return _prefs.getBool('isDarkMode') ?? false;
  }

  static String get lastLanguage {
    return _prefs.getString('lastLanguage') ?? defaultLanguage;
  }

  static String? get authToken {
    return _prefs.getString('authToken');
  }

  static String? get userEmail {
    return _prefs.getString('userEmail');
  }

  static Future<bool> setDarkMode(bool value) => _prefs.setBool('isDarkMode', value);
  static Future<bool> setLastLanguage(String lang) => _prefs.setString('lastLanguage', lang);
  static Future<bool> setAuthToken(String token) => _prefs.setString('authToken', token);
  static Future<bool> setUserEmail(String email) => _prefs.setString('userEmail', email);

  static Future<bool> clearAllPreferences() => _prefs.clear();
}
