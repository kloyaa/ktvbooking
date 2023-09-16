import 'package:app/const/colors.const.dart';
import 'package:app/controllers/room.controller.dart';
import 'package:app/widgets/modal_booking.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:motion_toast/motion_toast.dart';

class Rooms extends StatefulWidget {
  const Rooms({super.key});

  @override
  State<Rooms> createState() => _RoomsState();
}

class _RoomsState extends State<Rooms> {
  final RoomController _roomController = Get.put(RoomController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _roomController.getRooms(); // Fetch the data
  }

  @override
  Widget build(BuildContext context) {
    print(_roomController.rooms);

    return Scaffold(
      backgroundColor: kPrimary,
      appBar: AppBar(
        leading: const SizedBox(),
        leadingWidth: 0,
        title: Text("Rooms",
            style: TextStyle(
              color: kLight,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            )),
        backgroundColor: kSecondary,
      ),
      body: WillPopScope(
        onWillPop: () async => true,
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

                    return Opacity(
                      opacity: hasBooking.isEmpty ? 1 : 0.1,
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
                    );
                  },
                ),
              )),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          onPressed: () async {},
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
    );
  }
}
