import 'package:app/const/colors.const.dart';
import 'package:app/controllers/room.controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showConfirmDeleteModal(BuildContext context, Map payload) {
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
          "Confirmation",
          style: TextStyle(
            color: kLight,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        content: SizedBox(
          width: 150,
          child: Text(
            payload["title"],
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
              roomController.deleteFood(payload["id"]);
              Navigator.of(context).pop();
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
