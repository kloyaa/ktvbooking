class BookingItem {
  final String createdAt;
  final User user;
  final Room room;

  BookingItem({
    required this.createdAt,
    required this.user,
    required this.room,
  });

  factory BookingItem.fromJson(Map<String, dynamic> json) {
    return BookingItem(
      createdAt: json['createdAt'],
      user: User.fromJson(json['user']),
      room: Room.fromJson(json['room']),
    );
  }
}

class User {
  final String id;
  final String username;
  final String email;

  User({
    required this.id,
    required this.username,
    required this.email,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'],
      username: json['username'],
      email: json['email'],
    );
  }
}

class Room {
  final String id;
  final String number;

  Room({
    required this.id,
    required this.number,
  });

  factory Room.fromJson(Map<String, dynamic> json) {
    return Room(
      id: json['_id'],
      number: json['number'],
    );
  }
}
