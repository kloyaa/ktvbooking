import 'package:app/const/route.const.dart';
import 'package:app/screens/common/success.screen.dart';
import 'package:app/screens/create_food.screen.dart';
import 'package:app/screens/customer_bookings.screen.dart';
import 'package:app/screens/food_management.screen.dart';
import 'package:app/screens/login.screen.dart';
import 'package:app/screens/registration.screen.dart';
import 'package:app/screens/room_management.screen.dart';
import 'package:app/screens/rooms.screen.dart';
import 'package:app/screens/snacks.screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'KTV Booking',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: MobileRoute.login,
      getPages: [
        GetPage(name: MobileRoute.login, page: () => const Login()),
        GetPage(name: MobileRoute.register, page: () => const Registration()),
        GetPage(name: MobileRoute.rooms, page: () => const Rooms()),
        GetPage(name: MobileRoute.snacks, page: () => const Snacks()),
        GetPage(
          name: MobileRoute.customerBookings,
          page: () => const CustomerBookings(),
        ),
        GetPage(
          name: MobileRoute.success,
          page: () => SuccessScreen(),
        ),
        GetPage(
          name: MobileRoute.roomManagement,
          page: () => const RoomManagement(),
        ),
        GetPage(
          name: MobileRoute.foodManagement,
          page: () => const FoodManagement(),
        ),
        GetPage(
          name: MobileRoute.createFood,
          page: () => const CreateFood(),
        ),
      ],
    );
  }
}
