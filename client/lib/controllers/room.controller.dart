import 'package:app/const/api.const.dart';
import 'package:app/controllers/auth.controller.dart';
import 'package:app/controllers/classes/room.class.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class RoomController extends GetxController {
  final Dio _dio = Dio();

  final isLoading = false.obs;
  final rooms = [].obs; // Use a typed list for rooms

  Future<void> getRooms() async {
    final Controller authController = Get.put(Controller());
    try {
      final response = await _dio.get(
        Api.getRooms,
        options: Options(headers: {
          ...headers,
          'Authorization': 'Bearer ${authController.accessToken}'
        }), // Pass the headers here
      );

      if (response.statusCode == 200) {
        rooms.value = response.data;
      }
    } on DioException catch (e) {
      if (kDebugMode) {
        print("@getRooms DioError $e");
      }
      // Handle Dio errors here, e.g., show an error message to the user
    } catch (e) {
      if (kDebugMode) {
        print("@getRooms error $e");
      }
      // Handle unexpected errors here
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> createBooking(String room) async {
    final Controller authController = Get.put(Controller());
    try {
      print('creating booking');
      final response = await _dio.post(
        Api.createBooking,
        data: {"room": room, "start": "2023-06-10", "end": "2023-06-11"},
        options: Options(headers: {
          ...headers,
          'Authorization': 'Bearer ${authController.accessToken}'
        }), // Pass the headers here
      );

      print('response?? $response');
      if (response.statusCode == 200) {
        await getRooms();
        rooms.refresh();
      }
    } on DioException catch (e) {
      if (kDebugMode) {
        print("@getRooms DioError $e");
      }
      // Handle Dio errors here, e.g., show an error message to the user
    } catch (e) {
      if (kDebugMode) {
        print("@getRooms error $e");
      }
      // Handle unexpected errors here
    } finally {
      isLoading.value = false;
    }
  }
}
