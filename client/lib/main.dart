import 'package:app/screens/login.screen.dart';
import 'package:app/screens/registration.screen.dart';
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
      initialRoute: "/auth/v1/login",
      getPages: [
        GetPage(name: "/auth/v1/login", page: () => const Login()),
        GetPage(name: "/auth/v1/register", page: () => const Registration())
      ],
    );
  }
}
