class ApiEndpoints {
  static const String baseUrl = "https://cosmatics.growfet.com";

  static const String register = "/api/Auth/register";
  static const String verifyOtp = "/api/Auth/verify-otp";
  static const String resendOtp = "/api/Auth/resend-otp";
  static const String login = "/api/Auth/login";
  static const String forgotPassword = "/api/Auth/forgot-password";
  static const String resetPassword = "/api/Auth/reset-password";
  static const String profile = "/api/Auth/profile";
  static const String logout = "/api/Auth/logout";
  static const String refreshToken = "/api/Auth/refresh-token";
  static const String countries = "/api/Countries";
  static const String products = "/api/Products";
  static const String categories = "/api/Categories";
  static const String sliders = "/api/Sliders";
  static const String cart = "/api/Cart";
  static const String cartAdd = "/api/Cart/add";
  static const String cartUpdate = "/api/Cart/update";
  static const String cartRemove = "/api/Cart/remove";
}
