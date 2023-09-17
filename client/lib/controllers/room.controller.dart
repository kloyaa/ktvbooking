import 'dart:convert';
import 'package:app/const/api.const.dart';
import 'package:app/controllers/auth.controller.dart';
import 'package:app/controllers/classes/booking.class.dart';
import 'package:app/controllers/classes/room.class.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class RoomController extends GetxController {
  final Dio _dio = Dio();

  final isLoading = false.obs;
  final rooms = [].obs; // Use a typed list for rooms
  final foods = [].obs; // Use a typed list for rooms
  List<dynamic> orderedItems = [].obs;
  final RxInt orderTotal = 0.obs;
  final RxString assignedRoom = "".obs;

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

  Future<void> getMyBookings() async {
    final Controller authController = Get.put(Controller());
    try {
      final response = await _dio.get(
        Api.getMyBookings,
        options: Options(headers: {
          ...headers,
          'Authorization': 'Bearer ${authController.accessToken}'
        }), // Pass the headers here
      );

      if (response.statusCode == 200) {
        assignedRoom.value = response.data["room"];
      }

      print(assignedRoom);
    } on DioException catch (e) {
      if (kDebugMode) {
        print("@getMyBookings DioError $e");
      }
      // Handle Dio errors here, e.g., show an error message to the user
    } catch (e) {
      if (kDebugMode) {
        print("@getMyBookings error $e");
      }
      // Handle unexpected errors here
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> acceptBookings(String user, String room) async {
    final Controller authController = Get.put(Controller());
    try {
      isLoading.value = true;
      final response = await _dio.put(
        Api.acceotBooking,
        data: {"user": user, "room": room, "active": true},
        options: Options(headers: {
          ...headers,
          'Authorization': 'Bearer ${authController.accessToken}'
        }), // Pass the headers here
      );

      if (response.statusCode == 200) {
        print(response.data);
      }
    } on DioException catch (e) {
      if (kDebugMode) {
        print("@getMyBookings DioError $e");
      }
      // Handle Dio errors here, e.g., show an error message to the user
    } catch (e) {
      if (kDebugMode) {
        print("@getMyBookings error $e");
      }
      // Handle unexpected errors here
    } finally {
      isLoading.value = false;
    }
  }

  Future<List<MenuItem>> getFoods() async {
    final Controller authController = Get.put(Controller());
    try {
      isLoading.value = true;
      final response = await _dio.get(
        Api.getFoods,
        options: Options(headers: {
          ...headers,
          'Authorization': 'Bearer ${authController.accessToken}'
        }), // Pass the headers here
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        final List<MenuItem> items = data
            .map((item) => MenuItem(
                  id: item['_id'],
                  name: item['name'],
                  price: item["price"],
                  createdAt: item["createdAt"],
                  updatedAt: item["updatedAt"],
                  isSelected: false,
                ))
            .toList();
        foods.value = items;
        return items;
      } else {
        // Return an empty list wrapped in a Future for non-200 status codes
        return Future.value([]);
      }
    } on DioException catch (e) {
      if (kDebugMode) {
        print("@getFoods DioError $e");
      }
      // Handle Dio errors here, e.g., show an error message to the user

      // Return an empty list wrapped in a Future for Dio errors
      return Future.value([]);
    } catch (e) {
      if (kDebugMode) {
        print("@getFoods error $e");
      }
      // Handle unexpected errors here

      // Return an empty list wrapped in a Future for unexpected errors
      return Future.value([]);
    } finally {
      isLoading.value = false;
    }
  }

  Future<List<BookingItem>> getBookings() async {
    final Controller authController = Get.put(Controller());
    try {
      final response = await _dio.get(
        Api.getBookings,
        options: Options(headers: {
          ...headers,
          'Authorization': 'Bearer ${authController.accessToken}'
        }), // Pass the headers here
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        print(data);
        final List<BookingItem> items = data
            .map((item) => BookingItem(
                  createdAt: item["createdAt"],
                  room: Room.fromJson(item["room"]),
                  user: User.fromJson(item["user"]),
                ))
            .toList();
        return items;
      } else {
        // Return an empty list wrapped in a Future for non-200 status codes
        return Future.value([]);
      }
    } on DioException catch (e) {
      if (kDebugMode) {
        print("@getBookings DioError $e");
      }
      // Handle Dio errors here, e.g., show an error message to the user

      // Return an empty list wrapped in a Future for Dio errors
      return Future.value([]);
    } catch (e) {
      if (kDebugMode) {
        print("@getBookings error $e");
      }
      // Handle unexpected errors here

      // Return an empty list wrapped in a Future for unexpected errors
      return Future.value([]);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> createBooking(String room) async {
    final Controller authController = Get.put(Controller());
    try {
      final response = await _dio.post(
        Api.createBooking,
        data: {"room": room, "start": "2023-06-10", "end": "2023-06-11"},
        options: Options(headers: {
          ...headers,
          'Authorization': 'Bearer ${authController.accessToken}'
        }), // Pass the headers here
      );

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

  Future<void> createRoom(String number) async {
    final Controller authController = Get.put(Controller());
    try {
      isLoading.value = true;
      final response = await _dio.post(
        Api.createRoom,
        data: {"number": "$number", "capacity": 5},
        options: Options(headers: {
          ...headers,
          'Authorization': 'Bearer ${authController.accessToken}'
        }), // Pass the headers here
      );

      if (response.statusCode == 201) {
        await getRooms();
        rooms.refresh();
      }
    } on DioException catch (e) {
      if (kDebugMode) {
        print("@createRoom DioError $e");
      }
      // Handle Dio errors here, e.g., show an error message to the user
    } catch (e) {
      if (kDebugMode) {
        print("@createRoom error $e");
      }
      // Handle unexpected errors here
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> createFood(String name, int price) async {
    final Controller authController = Get.put(Controller());
    try {
      final response = await _dio.post(
        Api.createFood,
        data: {"name": name, "price": price},
        options: Options(headers: {
          ...headers,
          'Authorization': 'Bearer ${authController.accessToken}'
        }),
      );
      if (response.statusCode == 201) {
        print(response.data);
      }
    } on DioException catch (e) {
      if (kDebugMode) {
        print("@creatFood DioError $e");
      }
    } catch (e) {
      if (kDebugMode) {
        print("@creatFood error $e");
      }
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> deleteFood(String id) async {
    final Controller authController = Get.put(Controller());
    try {
      isLoading.value = true;

      final response = await _dio.delete(
        "${Api.deleteFood}/$id",
        options: Options(headers: {
          ...headers,
          'Authorization': 'Bearer ${authController.accessToken}'
        }),
      );
      if (response.statusCode == 200) {
        getFoods();
      }
    } on DioException catch (e) {
      if (kDebugMode) {
        print("@deleteFood DioError $e");
      }
    } catch (e) {
      if (kDebugMode) {
        print("@deleteFood error $e");
      }
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> createOrder() async {
    final Controller authController = Get.put(Controller());
    try {
      final items = orderedItems.map((item) {
        return {
          "room": assignedRoom.value,
          "food": item.id,
          "qty": 1,
          "message": "N/A",
        };
      }).toList();
      final response = await _dio.post(
        Api.createBulkOrder,
        data: jsonEncode(items),
        options: Options(headers: {
          ...headers,
          'Authorization': 'Bearer ${authController.accessToken}'
        }),
      );
      if (response.statusCode == 201) {
        print("Orders placed successfully!");
        print(response.data);
      } else {
        print("Failed to place orders. Status code: ${response.statusCode}");
      }
    } on DioException catch (e) {
      if (kDebugMode) {
        print("@createOrder DioError $e");
      }
      // Handle Dio errors here, e.g., show an error message to the user
    } catch (e) {
      if (kDebugMode) {
        print("@createOrder error $e");
      }
      // Handle unexpected errors here
    } finally {
      isLoading.value = false;
    }
  }

  void addToOrderedItems(MenuItem item) {
    orderedItems.add(item);
    calculateTotal();
  }

  bool alreadyInOrderedItems(String id) {
    final existingIndex = orderedItems.indexWhere(
      (item) => item.id == id,
    );

    return existingIndex != -1; // Return true if found, false otherwise
  }

  void calculateTotal() {
    orderTotal.value = 0;
    for (var item in orderedItems) {
      orderTotal.value += (item.price as int);
    }
  }
}
