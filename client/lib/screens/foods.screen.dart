import 'package:app/const/colors.const.dart';
import 'package:app/controllers/classes/room.class.dart';
import 'package:app/controllers/room.controller.dart';
import 'package:app/utils/formatters.util.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CheckboxList extends StatefulWidget {
  final List<MenuItem> menuItems;

  const CheckboxList({super.key, required this.menuItems});

  @override
  State<CheckboxList> createState() => _CheckboxListState();
}

class _CheckboxListState extends State<CheckboxList> {
  final RoomController _roomController = Get.put(RoomController());
  final List _selectedOrdrItemIds = [];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.menuItems.length,
      itemBuilder: (context, index) {
        final item = widget.menuItems[index];
        return CheckboxListTile(
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
          value: _selectedOrdrItemIds.contains(item.id),
          onChanged: (bool? value) {
            if (!_selectedOrdrItemIds.contains(item.id)) {
              setState(() {
                _selectedOrdrItemIds.add(item.id);
              });
              if (!_roomController.alreadyInOrderedItems(item.id)) {
                _roomController.addToOrderedItems(item);
              }
              return;
            }
          },
        );
      },
    );
  }
}
