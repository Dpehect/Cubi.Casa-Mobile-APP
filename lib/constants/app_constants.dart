class ApiEndpoints {
  static const String login = '/auth/login';
  static const String register = '/auth/register';
  static const String logout = '/auth/logout';
  static const String refreshToken = '/auth/refresh-token';
  static const String forgotPassword = '/auth/forgot-password';
  static const String resetPassword = '/auth/reset-password';

  static const String userProfile = '/user/profile';
  static const String updateProfile = '/user/profile/update';
  static const String deleteAccount = '/user/profile/delete';

  static const String floorPlans = '/floor-plans';
  static const String createFloorPlan = '/floor-plans/create';
  static const String floorPlanDetail = '/floor-plans/:id';
  static const String updateFloorPlan = '/floor-plans/:id/update';
  static const String deleteFloorPlan = '/floor-plans/:id/delete';
  static const String favoriteFloorPlan = '/floor-plans/:id/favorite';
  static const String shareFloorPlan = '/floor-plans/:id/share';
  static const String exportFloorPlan = '/floor-plans/:id/export';

  static const String initiateScan = '/scan/initiate';
  static const String uploadScanFrames = '/scan/upload-frames';
  static const String createFloorPlanFromScan = '/scan/create-floor-plan';
  static const String getScanSession = '/scan/session/:id';

  static const String properties = '/properties';
  static const String createProperty = '/properties/create';
  static const String propertyDetail = '/properties/:id';
  static const String updateProperty = '/properties/:id/update';
  static const String deleteProperty = '/properties/:id/delete';
  static const String propertyFloorPlans = '/properties/:id/floor-plans';

  static const String reports = '/reports';
  static const String createReport = '/reports/create';
  static const String reportDetail = '/reports/:id';
  static const String generateReport = '/reports/:id/generate';
  static const String downloadReport = '/reports/:id/download';
  static const String shareReport = '/reports/:id/share';

  static const String search = '/search';
  static const String filter = '/filter';

  static const String statistics = '/statistics';
  static const String userStatistics = '/statistics/user';
}

class AppStrings {
  static const String appName = 'CubiCasa';
  static const String loading = 'Loading...';
  static const String error = 'Error';
  static const String success = 'Success';
  static const String cancel = 'Cancel';
  static const String save = 'Save';
  static const String delete = 'Delete';
  static const String edit = 'Edit';
  static const String back = 'Back';
  static const String next = 'Next';
  static const String finish = 'Finish';

  static const String login = 'Login';
  static const String register = 'Register';
  static const String logout = 'Logout';
  static const String forgotPassword = 'Forgot Password';
  static const String resetPassword = 'Reset Password';

  static const String errorNetwork = 'Network error. Please check your connection.';
  static const String errorServer = 'Server error. Please try again later.';
  static const String errorUnknown = 'An unknown error occurred.';
}

class AppDurations {
  static const Duration snackbar = Duration(seconds: 3);
  static const Duration animation = Duration(milliseconds: 300);
  static const Duration debounce = Duration(milliseconds: 500);
  static const Duration apiTimeout = Duration(seconds: 30);
}
