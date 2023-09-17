import 'package:app/const/colors.const.dart';
import 'package:app/const/route.const.dart';
import 'package:app/controllers/room.controller.dart';
import 'package:app/widgets/modal_booking.widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Rooms extends StatefulWidget {
  const Rooms({super.key});

  @override
  State<Rooms> createState() => _RoomsState();
}

class _RoomsState extends State<Rooms> {
  final RoomController _roomController = Get.put(RoomController());

  @override
  void initState() {
    super.initState();

    _roomController.getRooms(); // Fetch the data
    _roomController.getMyBookings();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimary,
      appBar: AppBar(
        leading: const SizedBox(),
        leadingWidth: 0,
        actionsIconTheme: IconThemeData(color: kLight),
        title: Text("Rooms",
            style: TextStyle(
              color: kLight,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            )),
        backgroundColor: kSecondary,
      ),
      endDrawer: Drawer(
        backgroundColor: kPrimary,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ListTile(
              leading: const Icon(
                Icons.logout_outlined,
                color: Colors.white, // Set the color to white
              ),
              title: Text(
                'Sign out',
                style: TextStyle(
                  color: kLight,
                ), // Set the text color to white
              ),
              onTap: () {
                Get.toNamed(MobileRoute.login);
              },
            ),
            const SizedBox(height: 20.0),
          ],
        ),
      ),
      body: WillPopScope(
        onWillPop: () async => false,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Obx(() => RefreshIndicator(
                onRefresh: () => _roomController.getRooms(),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 150.0,
                    mainAxisSpacing: 8.0,
                    crossAxisSpacing: 8.0,
                  ),
                  itemCount: _roomController.rooms.length,
                  itemBuilder: (context, index) {
                    final item = _roomController.rooms[index];
                    final number = item['number'];
                    final hasBooking = item['booking'] as List;

                    return IgnorePointer(
                      ignoring: _roomController.assignedRoom.value.isNotEmpty
                          ? true
                          : false,
                      child: Opacity(
                        opacity: hasBooking.isEmpty
                            ? 1
                            : _roomController.assignedRoom.value == item["_id"]
                                ? 1
                                : 0.1,
                        child: GestureDetector(
                          onTap: () {
                            if (hasBooking.isEmpty) {
                              showBookingModal(context, {
                                "room": item["_id"],
                                "message":
                                    "Do you want to book Room $number? Tap 'YES' to continue.",
                              });
                            }
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: _roomController.assignedRoom.value ==
                                      item["_id"]
                                  ? Colors.deepPurpleAccent
                                  : kSecondary,
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
                                    fontSize: 12,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                                Text(
                                  "$number",
                                  style: TextStyle(
                                    color: kLight,
                                    fontSize: 32,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              )),
        ),
      ),
      bottomNavigationBar: Obx(() => IgnorePointer(
            // ignore: unnecessary_null_comparison
            ignoring: _roomController.assignedRoom.value.isEmpty ? true : false,
            child: Opacity(
              opacity: _roomController.assignedRoom.value.isEmpty ? 0.2 : 1,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () => Get.toNamed(MobileRoute.snacks),
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
                        Icons.shopping_basket,
                        color: Colors.white,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        "ORDER A SNACKS".toUpperCase(),
                        style: TextStyle(color: kLight),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )),
    );
  }
}
