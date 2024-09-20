import 'package:flutter_application_1/models/user.model.dart';

class Message {
  final String id;
  final User sender;
  final String text;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool isUser;

  Message({
    required this.id,
    required this.sender,
    required this.text,
    required this.createdAt,
    required this.updatedAt,
    required this.isUser
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      id: json['id'] as String,
      sender: User.fromJson(json['sender']),
      text: json['last_message'] as String,
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      isUser: json['is_user']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'sender': sender.toJson(),
      'last_message': text,
      'created_at': createdAt.toIso8601String(),
      'updated_at': createdAt.toIso8601String(),
      'is_user': isUser
    };
  }
}
