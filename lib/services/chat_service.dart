import 'dart:async';

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_application_1/services/auth_service.dart';
import 'package:flutter_application_1/models/concersation.model.dart';
import 'package:flutter_application_1/models/message.model.dart';
import 'package:flutter_application_1/models/user.model.dart'; 

class ChatService {
  final AuthService _authService = AuthService();
  final String baseUrl = 'http://localhost:3000/api'; // Update with your server URL

  Future<List<Conversation>> fetchConversations() async {
    final token = await _authService.getToken();
    final response = await http.get(
      Uri.parse('$baseUrl/chat/conversations'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => Conversation.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load conversations');
    }
  }

  Future<List<Message>> fetchMessages(String conversationId) async {
    final token = await _authService.getToken();
    final response = await http.get(
      Uri.parse('$baseUrl/chat/conversations/$conversationId/messages'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => Message.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load messages');
    }
  }

  Future<void> sendMessage(String conversationId, String text) async {
    final token = await _authService.getToken();
    final response = await http.post(
      Uri.parse('$baseUrl/chat/message'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: json.encode({
        'conversationId': conversationId,
        'text': text,
      }),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to send message');
    }
  }
}



// class ChatService {
//   // Sample data for mock conversations
//   final List<Conversation> _mockConversations = [
//     Conversation(
//       id: '1',
//       user: User(id: '2', firstName: 'Alice', lastName: 'Johnson'),
//       lastMessage: 'Hey, how are you?',
//       createdAt: DateTime.now().subtract(const Duration(days: 1)),
//       updatedAt: DateTime.now(),
//     ),
//     Conversation(
//       id: '2',
//       user: User(id: '3', firstName: 'Bob', lastName: 'Smith'),
//       lastMessage: 'Are you coming to the party?',
//       createdAt: DateTime.now().subtract(const Duration(days: 2)),
//       updatedAt: DateTime.now(),
//     ),
//     Conversation(
//       id: '3',
//       user: User(id: '4', firstName: 'Charlie', lastName: 'Brown'),
//       lastMessage: 'Don’t forget our meeting tomorrow.',
//       createdAt: DateTime.now().subtract(const Duration(days: 3)),
//       updatedAt: DateTime.now(),
//     ),
//   ];



//   // Sample data for mock messages
//   final Map<String, List<Message>> _mockMessages = {
//     '1': [
//       Message(
//         id: '1',
//         sender: User(id: '2', firstName: 'Alice', lastName: 'Johnson'),
//         text: 'Hello!',
//         createdAt: DateTime.now().subtract(const Duration(minutes: 10)),
//         updatedAt: DateTime.now().subtract(const Duration(minutes: 10)),
//         isUser: false,
//       ),
//       Message(
//         id: '2',
//         sender: User(id: '1', firstName: 'Rowland', lastName: 'Ricketts'),
//         text: 'How are you?',
//         createdAt: DateTime.now().subtract(const Duration(minutes: 5)),
//         updatedAt: DateTime.now().subtract(const Duration(minutes: 5)),
//         isUser: true,
//       ),
//       Message(
//         id: '3',
//         sender: User(id: '2', firstName: 'Alice', lastName: 'Johnson'),
//         text: 'I am fine, thank you!',
//         createdAt: DateTime.now().subtract(const Duration(minutes: 1)),
//         updatedAt: DateTime.now().subtract(const Duration(minutes: 1)),
//         isUser: false,
//       ),
//     ],
//     // More mock messages for other conversations...
//   };

//   Future<List<Conversation>> fetchConversations() async {
//     // await Future.delayed(const Duration(seconds: 2)); // Simulate a delay
//     return _mockConversations;
//   }

//   Future<List<Message>> fetchMessages(String conversationId) async {
//     await Future.delayed(const Duration(seconds: 2)); // Simulate a delay
//     return _mockMessages[conversationId] ?? [];
//   }
// }
