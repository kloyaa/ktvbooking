import 'package:app/config.dart';

const String baseUrl = "http://$localNetworkIPA:3000/api";

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
  static const String getFoods = "$baseUrl/food/v1";
  static const String getMyBookings = "$baseUrl/booking/v1/me";
  static const String getBookings = "$baseUrl/booking/v1";
  static const String createFood = "$baseUrl/food/v1";
  static const String deleteFood = "$baseUrl/food/v1";
  static const String createBooking = "$baseUrl/booking/v1";
  static const String createRoom = "$baseUrl/room/v1";
  static const String createBulkOrder = "$baseUrl/order/v1/place-many";
  static const String acceotBooking = "$baseUrl/booking/v1";
}

final headers = {
  'from': 'mobile',
};
