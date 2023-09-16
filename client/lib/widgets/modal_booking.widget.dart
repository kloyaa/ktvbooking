import 'package:app/const/colors.const.dart';
import 'package:app/controllers/room.controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';

void showBookingModal(BuildContext context, Map payload) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        backgroundColor: kPrimary,
        titlePadding: const EdgeInsets.only(left: 30, right: 30, top: 30),
        contentPadding: const EdgeInsets.only(
          left: 30,
          right: 30,
          top: 10,
          bottom: 10,
        ),
        actionsAlignment: MainAxisAlignment.end,
        title: Text(
          "Confirm",
          style: TextStyle(
            color: kLight,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        content: SizedBox(
          width: 150,
          child: Text(
            payload["message"],
            style: const TextStyle(
              fontWeight: FontWeight.w300,
              fontSize: 14,
              color: Colors.white,
            ),
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text("NO",
                style: TextStyle(
                  color: kLight.withOpacity(0.2),
                  fontWeight: FontWeight.w300,
                )),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.deepPurpleAccent,
            ),
            child: Text("YES",
                style: TextStyle(
                  color: kLight,
                  fontWeight: FontWeight.bold,
                )),
            onPressed: () async {
              final RoomController roomController = Get.put(RoomController());
              await roomController
                  .createBooking(payload["room"])
                  .then((value) => Navigator.of(context).pop())
                  .catchError((err) => Navigator.of(context).pop());

              // ignore: use_build_context_synchronously
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
                  "Your booking request will be reviewed by our staff",
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
          ),
        ],
      );
    },
    barrierColor: Colors.black.withOpacity(0.9),
    barrierDismissible: false,
    barrierLabel: "Confirm Modal",
  );
}
