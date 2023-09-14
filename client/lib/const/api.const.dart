const String baseUrl = "http://localhost:3000/api";

class Api {
  static const String login = "/auth/v1/login";

  // Profile
  static const String createProfile = "/clients/v1/profile";
  static const String getAllProfile = "/clients/v1/profiles";
  static const String getMyProfile = "/clients/v1/me";
  static const String getProfileByLoginId = "/clients/v1/profile";
}
