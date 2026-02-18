class AnalyticsService {
  static final AnalyticsService _instance = AnalyticsService._internal();

  factory AnalyticsService() {
    return _instance;
  }

  AnalyticsService._internal();

  Future<void> logEvent(String eventName, {Map<String, dynamic>? parameters}) async {
  }

  Future<void> logScreenView(String screenName) async {
  }

  Future<void> logError(String errorCode, String? errorDescription) async {
  }

  Future<void> setUserId(String userId) async {
  }

  Future<void> setUserProperty(String name, String value) async {
  }

  Future<void> logPurchase({
    required double value,
    required String currency,
    String? itemId,
  }) async {
  }

  Future<void> logSignUp(String signUpMethod) async {
  }

  Future<void> logLogin(String loginMethod) async {
  }
}
