class Api {
  static const baseUrl = "http://192.168.100.156:8080/api";

  static const loginUrl = "$baseUrl/auth/login";
  static const signUpUrl = "$baseUrl/auth/register";
  static const createPetProfileUrl = "$baseUrl/create-pet-profile";
  static const sendOTPUrl = "$baseUrl/auth/send-verification-code";
  static const verifyOTPUrl = "$baseUrl/auth/otp-verify";
  static const forgotPasswordUrl = "$baseUrl/auth/forgot-password";
  static const changePasswordUrl = "$baseUrl/auth/change-password";
  static const updateOwnerProfile = "$baseUrl/auth/update-profile";
  static const getSitters = "$baseUrl/pet-sitters";
  static const getSitterDetail = "$baseUrl/pet-sitter/show/#id#";
  static const reviewSitter = "$baseUrl/review";
  static const addAppointment = "$baseUrl/appointment/store";
  static const getFeaturedSitters = "$baseUrl/featured-pet-sitters";
  static const updatePetProfile = "$baseUrl/update-pet-profile/#id#";
  static const deletePetProfile = "$baseUrl/delete-pet-profile/#id#";
  static const deleteAccount = "$baseUrl/auth/delete-account";
  static const getAppointments = "$baseUrl/appointments?filter[month]=#id#";
}
