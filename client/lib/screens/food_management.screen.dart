import 'package:app/const/colors.const.dart';
import 'package:app/const/route.const.dart';
import 'package:app/controllers/room.controller.dart';
import 'package:app/utils/formatters.util.dart';
import 'package:app/widgets/modal_confirm_delete.widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FoodManagement extends StatefulWidget {
  const FoodManagement({super.key});

  @override
  State<FoodManagement> createState() => _FoodManagementState();
}

class _FoodManagementState extends State<FoodManagement> {
  final RoomController _roomController = Get.put(RoomController());

  @override
  void initState() {
    // TODO: implement initState

    _roomController.getFoods();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimary,
      appBar: AppBar(
        iconTheme: IconThemeData(color: kLight),
        title: Text("Food Management",
            style: TextStyle(
              color: kLight,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            )),
        backgroundColor: kSecondary,
        actions: [
          IconButton(
            onPressed: () => Get.toNamed(MobileRoute.createFood),
            icon: const Icon(Icons.food_bank_outlined),
          )
        ],
      ),
      body: Obx(() => ListView.builder(
            itemCount: _roomController.foods.length,
            itemBuilder: (context, index) {
              final item = _roomController.foods[index];
              return ListTile(
                onTap: () {
                  showConfirmDeleteModal(context, {
                    "title": "Do you want to remove ${item.name}?",
                    "id": item.id
                  });
                },
                tileColor: kPrimary,
                title: Text(
                  item.name,
                  style: TextStyle(
                    color: kLight,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                subtitle: Text(
                  formatCurrency(item.price.toDouble(), "PHP"),
                  style: TextStyle(
                    color: kLight,
                    fontWeight: FontWeight.w300,
                    fontSize: 14,
                  ),
                ),
              );
            },
          )),
    );
  }
}
