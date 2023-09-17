import 'package:app/const/colors.const.dart';
import 'package:app/controllers/room.controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class RoomManagement extends StatefulWidget {
  const RoomManagement({super.key});

  @override
  State<RoomManagement> createState() => _RoomManagementState();
}

class _RoomManagementState extends State<RoomManagement> {
  final RoomController _roomController = Get.put(RoomController());

  final TextEditingController _roomNumberController = TextEditingController();
  late final FocusNode _roomNumberFocus;

  @override
  void initState() {
    _roomNumberFocus = FocusNode();
    _roomController.getRooms(); // Fetch the data
    _roomController.getMyBookings();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: kPrimary,
        appBar: AppBar(
          iconTheme: IconThemeData(color: kLight),
          title: Text("Room Management",
              style: TextStyle(
                color: kLight,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              )),
          backgroundColor: kSecondary,
          actions: [],
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: kSecondary,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: TextFormField(
                  controller: _roomNumberController,
                  focusNode: _roomNumberFocus,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    labelText: "Room Number",
                    labelStyle: TextStyle(color: kLight),
                    prefixIcon: const Icon(Icons.room_service_outlined),
                    prefixIconColor: Colors.white,
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                  ),
                  style: TextStyle(color: kLight),
                ),
              ),
              const SizedBox(height: 10),
              Obx(() => SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () async {
                        if (_roomNumberController.text.trim().length == 3) {
                          await _roomController.createRoom(
                            _roomNumberController.text.trim(),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        backgroundColor: Colors.deepPurple,
                      ),
                      child: _roomController.isLoading.value
                          ? LoadingAnimationWidget.prograssiveDots(
                              color: kLight,
                              size: 24,
                            )
                          : Text(
                              "Create".toUpperCase(),
                              style: TextStyle(color: kLight),
                            ),
                    ),
                  )),
              const SizedBox(height: 10),
              Obx(() => RefreshIndicator(
                    onRefresh: () => _roomController.getRooms(),
                    child: GridView.builder(
                      physics: const BouncingScrollPhysics(
                        parent: AlwaysScrollableScrollPhysics(),
                      ),
                      shrinkWrap: true,
                      gridDelegate:
                          const SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 50.0,
                        mainAxisSpacing: 8.0,
                        crossAxisSpacing: 8.0,
                      ),
                      itemCount: _roomController.rooms.length,
                      itemBuilder: (context, index) {
                        final item = _roomController.rooms[index];
                        final number = item['number'];
                        return GestureDetector(
                          onTap: () {},
                          child: Container(
                            decoration: BoxDecoration(
                              color: kSecondary,
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            alignment: Alignment.center,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "ROOM",
                                  style: TextStyle(
                                    color: kLight,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                Text(
                                  "$number",
                                  style: TextStyle(
                                    color: kLight,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
