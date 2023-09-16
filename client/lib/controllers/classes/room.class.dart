class Room {
  final String id;
  final String number;
  final String createdAt;
  final List<Order> orders;
  final List<Booking> bookings;

  Room({
    required this.id,
    required this.number,
    required this.createdAt,
    required this.orders,
    required this.bookings,
  });
}

class Order {
  final String id;
  final String food;
  final String room;
  final int qty;
  final String message;
  final bool delivered;
  final String createdAt;
  final String updatedAt;
  final int v;

  Order({
    required this.id,
    required this.food,
    required this.room,
    required this.qty,
    required this.message,
    required this.delivered,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['_id'],
      food: json['food'],
      room: json['room'],
      qty: json['qty'],
      message: json['message'],
      delivered: json['delivered'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      v: json['__v'],
    );
  }
}

class Booking {
  final String id;
  final String user;
  final String room;
  final String start;
  final String end;
  final bool active;
  final String createdAt;
  final String updatedAt;
  final int v;

  Booking({
    required this.id,
    required this.user,
    required this.room,
    required this.start,
    required this.end,
    required this.active,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory Booking.fromJson(Map<String, dynamic> json) {
    return Booking(
      id: json['_id'],
      user: json['user'],
      room: json['room'],
      start: json['start'],
      end: json['end'],
      active: json['active'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      v: json['__v'],
    );
  }
}
