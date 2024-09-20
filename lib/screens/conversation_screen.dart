// lib/screens/conversation_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/message.model.dart';
import 'package:flutter_application_1/models/user.model.dart';
import 'package:uuid/uuid.dart';
import '../services/chat_service.dart';

class ConversationScreen extends StatefulWidget {
  final String conversationId;

  const ConversationScreen({super.key, required this.conversationId});

  @override
  _ConversationScreenState createState() => _ConversationScreenState();
}

class _ConversationScreenState extends State<ConversationScreen> {
  final ChatService _chatService = ChatService();
  final TextEditingController _messageController = TextEditingController();
  final Uuid _uuid = Uuid(); // Create an instance of Uuid

  List<Message> _messages = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchMessages();
  }

  Future<void> _fetchMessages() async {
    try {
      final messages = await _chatService.fetchMessages(widget.conversationId);
      setState(() {
        _messages = messages;
        _isLoading = false;
      });
    } catch (e) {
      // Handle error, e.g., show a snackbar
      print('Error fetching messages: $e');
      setState(() => _isLoading = false);
    }
  }

  void _sendMessage() {
    if (_messageController.text.trim().isEmpty) return;

    final newMessage = Message(
      id: _uuid.v4(), // Generate a unique ID using uuid
      sender: User(
        id: _uuid.toString(),
        firstName: 'Rowland',
        lastName: 'Ricketts',
      ), // Replace with the actual user
      text: _messageController.text.trim(),
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      isUser: true, // Assuming this is sent by the current user
    );

    setState(() {
      _messages.add(newMessage);
      _messageController.clear();
    });

    // Since there's no backend, you could store this in local storage or simply rely on the state
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 50),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
              'Chat with ${widget.conversationId}'), // Replace with actual conversation title
        ),
        body: Column(
        
          children: [
            Expanded(
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      itemCount: _messages.length,
                      itemBuilder: (context, index) {
                        final Message message = _messages[index];
                        final bool isUserMessage = message.isUser;

                        return Align(
                          alignment: isUserMessage
                              ? Alignment.centerRight
                              : Alignment.centerLeft,
                          child: Container(
                            margin: const EdgeInsets.symmetric(
                                vertical: 4.0, horizontal: 8.0),
                            padding: const EdgeInsets.all(12.0),
                            decoration: BoxDecoration(
                              color: isUserMessage
                                  ? Colors.blueAccent
                                  : Colors.grey[400],
                              borderRadius: BorderRadius.only(
                                topLeft: const Radius.circular(12.0),
                                topRight: const Radius.circular(12.0),
                                bottomLeft: isUserMessage
                                    ? const Radius.circular(12.0)
                                    : const Radius.circular(0),
                                bottomRight: isUserMessage
                                    ? const Radius.circular(0)
                                    : const Radius.circular(12.0),
                              ),
                            ),
                            child: Text(
                              message.text,
                              style: TextStyle(
                                color:
                                    isUserMessage ? Colors.white : Colors.black,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _messageController,
                      decoration: const InputDecoration(
                        hintText: 'Type a message...',
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15))),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.send,
                      size: 35,
                      color: Colors.blueAccent,
                    ),
                    onPressed: _sendMessage,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
