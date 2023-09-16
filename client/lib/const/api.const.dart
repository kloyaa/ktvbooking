const String localIPA = "192.168.1.102"; //IPv4 Address
const String baseUrl = "http://$localIPA:3000/api";

class Api {
  // Authentication
  static const String login = "$baseUrl/auth/v1/login";
  static const String register = "$baseUrl/auth/v1/register";

  // Profile
  static const String createProfile = "$baseUrl/clients/v1/profile";
  static const String getAllProfile = "$baseUrl/clients/v1/profiles";
  static const String getMyProfile = "$baseUrl/clients/v1/me";
  static const String getProfileByLoginId = "$baseUrl/clients/v1/profile";

  // Rooms
  static const String getRooms = "$baseUrl/room/v1";
  static const String createBooking = "$baseUrl/booking/v1";
}

final headers = {
  'from': 'mobile',
};
