import 'package:app/const/colors.const.dart';
import 'package:app/const/route.const.dart';
import 'package:app/controllers/room.controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateFood extends StatefulWidget {
  const CreateFood({super.key});

  @override
  State<CreateFood> createState() => _CreateFoodState();
}

class _CreateFoodState extends State<CreateFood> {
  final RoomController _roomController = Get.put(RoomController());

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  late final FocusNode _nameFocus;
  late final FocusNode _priceFocus;

  @override
  void initState() {
    _nameFocus = FocusNode();
    _priceFocus = FocusNode();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: kSecondary,
        appBar: AppBar(
          iconTheme: IconThemeData(color: kLight),
          title: Text("Create",
              style: TextStyle(
                color: kLight,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              )),
          backgroundColor: kSecondary,
          actions: [
            IconButton(
              onPressed: () => Get.toNamed(MobileRoute.foodManagement),
              icon: const Icon(Icons.food_bank_outlined),
            )
          ],
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: kPrimary,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: TextFormField(
                  controller: _nameController,
                  focusNode: _nameFocus,
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    labelText: "Name",
                    labelStyle: TextStyle(color: kLight),
                    prefixIcon: const Icon(Icons.edit_note),
                    prefixIconColor: Colors.white,
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                  ),
                  style: TextStyle(color: kLight),
                ),
              ),
              const SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                  color: kPrimary,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: TextFormField(
                  controller: _priceController,
                  focusNode: _priceFocus,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    labelText: "Price",
                    labelStyle: TextStyle(color: kLight),
                    prefixIcon: const Icon(Icons.edit_note),
                    prefixIconColor: Colors.white,
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                  ),
                  style: TextStyle(color: kLight),
                ),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () async {
                    final name = _nameController.text.trim();
                    final price = _priceController.text.trim();

                    if (name.isNotEmpty && price.isNotEmpty) {
                      await _roomController.createFood(name, int.parse(price));
                      Get.toNamed(MobileRoute.foodManagement);
                    }
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.arrow_circle_right_outlined,
                        color: Colors.white,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        _roomController.isLoading.value
                            ? "Submitting..."
                            : "Submit".toUpperCase(),
                        style: TextStyle(color: kLight),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
