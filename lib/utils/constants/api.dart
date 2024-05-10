class Api {
  static const baseUrl = "http://192.168.100.156:8080/api";

  static const loginUrl = "$baseUrl/auth/login";
  static const signUpUrl = "$baseUrl/auth/register";
  static const createPetProfileUrl = "$baseUrl/create-pet-profile";
  static const sendOTPUrl = "$baseUrl/auth/send-verification-code";
  static const verifyOTPUrl = "$baseUrl/auth/otp-verify";
  static const forgotPasswordUrl = "$baseUrl/auth/forgot-password";
  static const changePasswordUrl = "$baseUrl/auth/change-password";
  static const updateOwnerProfile = "$baseUrl/update-profile";
}
