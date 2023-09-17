import 'package:app/const/colors.const.dart';
import 'package:app/controllers/classes/room.class.dart';
import 'package:app/controllers/room.controller.dart';
import 'package:app/screens/foods.screen.dart';
import 'package:app/utils/formatters.util.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';

class Snacks extends StatefulWidget {
  const Snacks({super.key});

  @override
  State<Snacks> createState() => _SnacksState();
}

class _SnacksState extends State<Snacks> {
  final RoomController _roomController = Get.put(RoomController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _roomController.orderedItems.clear();
      _roomController.orderTotal.value = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimary,
      appBar: AppBar(
        iconTheme: IconThemeData(color: kLight),
        title: Text("Snacks",
            style: TextStyle(
              color: kLight,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            )),
        backgroundColor: kSecondary,
        actions: [
          Obx(() => Badge(
                label: Text(_roomController.orderedItems.length.toString()),
                child: const Icon(
                  Icons.shopping_basket,
                  color: Colors.white,
                ),
              )),
          const SizedBox(width: 20),
        ],
      ),
      body: FutureBuilder<List<MenuItem>>(
        // Replace with your API endpoint
        future: _roomController.getFoods(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Text('No data available');
          } else {
            return CheckboxList(menuItems: snapshot.data!);
          }
        },
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          onPressed: () {
            _roomController.createOrder();
            MotionToast.info(
              title: const Text(
                "SUCCESS",
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              description: const Text(
                "Order placed and in the kitchen! We'll have it ready soon.",
                style: TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                ),
              ),
              displayBorder: false,
              displaySideBar: false,
              position: MotionToastPosition.top,
              barrierColor: Colors.transparent,
              animationType: AnimationType.fromTop,
              enableAnimation: true,
              iconSize: 0,
              toastDuration: const Duration(seconds: 3),
              borderRadius: 10,
            ).show(context);
          },
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            backgroundColor: Colors.deepPurple,
            padding: const EdgeInsets.symmetric(
              horizontal: 32.0,
              vertical: 12.0,
            ),
          ),
          child: Obx(() => Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Order now".toUpperCase(),
                    style: TextStyle(
                      color: kLight,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    formatCurrency(
                        _roomController.orderTotal.value.toDouble(), "PHP"),
                    style: TextStyle(
                      color: kLight,
                      fontSize: 11,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
