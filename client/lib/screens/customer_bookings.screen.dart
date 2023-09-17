import 'package:app/const/colors.const.dart';
import 'package:app/const/route.const.dart';
import 'package:app/controllers/classes/booking.class.dart';
import 'package:app/controllers/room.controller.dart';
import 'package:app/screens/foods.screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomerBookings extends StatefulWidget {
  const CustomerBookings({super.key});

  @override
  State<CustomerBookings> createState() => _CustomerBookingsState();
}

class _CustomerBookingsState extends State<CustomerBookings> {
  final RoomController _roomController = Get.put(RoomController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kPrimary,
        appBar: AppBar(
          leading: const SizedBox(),
          leadingWidth: 0,
          actionsIconTheme: IconThemeData(color: kLight),
          title: Text("Bookings",
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
              const Spacer(),
              ListTile(
                leading: const Icon(
                  Icons.room_service_outlined,
                  color: Colors.white, // Set the color to white
                ),
                title: Text(
                  'Room Management',
                  style: TextStyle(
                    color: kLight,
                    fontSize: 12,
                    fontWeight: FontWeight.w300,
                  ), // Set the text color to white
                ),
                onTap: () {
                  Get.toNamed(MobileRoute.roomManagement);
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.food_bank_outlined,
                  color: Colors.white, // Set the color to white
                ),
                title: Text(
                  'Food Management',
                  style: TextStyle(
                    color: kLight,
                    fontSize: 12,
                    fontWeight: FontWeight.w300,
                  ), // Set the text color to white
                ),
                onTap: () {
                  Get.toNamed(MobileRoute.foodManagement);
                },
              ),
              const Spacer(flex: 10),
              ListTile(
                leading: const Icon(
                  Icons.logout_outlined,
                  color: Colors.white, // Set the color to white
                ),
                title: Text(
                  'Sign out',
                  style: TextStyle(
                    color: kLight,
                    fontSize: 12,
                    fontWeight: FontWeight.w300,
                  ), // Set the text color to white
                ),
                onTap: () {
                  Get.toNamed(MobileRoute.login);
                },
              ),
              const Spacer(),
            ],
          ),
        ),
        body: WillPopScope(
          onWillPop: () async => false,
          child: FutureBuilder<List<BookingItem>>(
            // Replace with your API endpoint
            future: _roomController.getBookings(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Center(
                  child: Text(
                    'No data available',
                    style: TextStyle(color: kLight, fontSize: 12),
                  ),
                );
              } else {
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    final bookingItem = snapshot.data![index];
                    return Container(
                      margin: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: kSecondary,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: ListTile(
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              bookingItem.user.username,
                              style: TextStyle(
                                color: kLight,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              "ROOM ${bookingItem.room.number}",
                              style: TextStyle(
                                color: kLight,
                                fontWeight: FontWeight.w300,
                                fontSize: 10,
                              ),
                            ),
                            const SizedBox(height: 10.0),
                            Row(
                              children: [
                                OutlinedButton(
                                  onPressed: () async {},
                                  style: OutlinedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                  ),
                                  child: Text(
                                    "Decline".toUpperCase(),
                                    style: const TextStyle(
                                      color: Colors.red,
                                      fontSize: 10,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10.0),
                                ElevatedButton(
                                  onPressed: () async {
                                    await _roomController.acceptBookings(
                                      bookingItem.user.id,
                                      bookingItem.room.id,
                                    );
                                    Get.toNamed(MobileRoute.success);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                    backgroundColor: Colors.deepPurple,
                                  ),
                                  child: Text(
                                    "Accept".toUpperCase(),
                                    style:
                                        TextStyle(color: kLight, fontSize: 10),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                        // Add more ListTile customization as needed
                      ),
                    );
                  },
                );
              }
            },
          ),
        ),
        bottomNavigationBar: Padding(
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
                  "ORDERS".toUpperCase(),
                  style: TextStyle(color: kLight),
                ),
              ],
            ),
          ),
        ));
  }
}
