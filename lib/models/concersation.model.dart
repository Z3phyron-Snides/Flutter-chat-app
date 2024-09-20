import 'package:flutter_application_1/models/user.model.dart';

class Conversation {
  final String id;
  final User user;
  final String lastMessage;
  final DateTime createdAt;
  final DateTime updatedAt;

  Conversation({
    required this.id,
    required this.user,
    required this.lastMessage,
    required this.createdAt,
    required this.updatedAt,
  });

    factory Conversation.fromJson(Map<String, dynamic> json) {
    return Conversation(
      id: json['id'] as String,
      user: User.fromJson(json['user']),
      lastMessage: json['last_message'] as String,
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']) ,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user': user.toJson(),
      'last_message': lastMessage,
      'created_at': createdAt.toIso8601String(),
      'updated_at': createdAt.toIso8601String(),
    };
  }
}
