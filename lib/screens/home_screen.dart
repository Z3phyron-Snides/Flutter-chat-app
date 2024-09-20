import 'package:date_time_format/date_time_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/concersation.model.dart';
import 'package:flutter_application_1/services/chat_service.dart';
import 'package:flutter_application_1/widgets/my_drawer.dart';
// lib/screens/home_screen.dart
import 'package:flutter/material.dart';
import 'package:truncate/truncate.dart';
import '../services/chat_service.dart';
import 'conversation_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ChatService _chatService = ChatService();
  List<Conversation> _conversations = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchConversations();
  }

  Future<void> _fetchConversations() async {
    try {
      final List<Conversation> conversations =
          await _chatService.fetchConversations();

      print(_conversations);
      setState(() {
        _conversations = conversations;
        _isLoading = false;
      });
    } catch (e) {
      // Handle error, e.g., show a snackbar
      print('Error fetching conversations: $e');
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 55),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Conversations'),
        ),
        drawer: const Drawer(),
        body: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: _conversations.length,
                itemBuilder: (context, index) {
                  final conversation = _conversations[index];
                  return ChatTile(
                    id: conversation.id,
                    title:
                        "${conversation.user.firstName} ${conversation.user.lastName}",
                    lastMessage: conversation.lastMessage,
                    updatedAt: conversation.updatedAt
                        .relative(appendIfAfter: 'ago', abbr: true),
                  );
                },
              ),
      ),
    );
  }
}

class ChatTile extends StatelessWidget {
  final String id;
  final String title;
  final String lastMessage;
  final String updatedAt;
  const ChatTile({
    super.key,
    required this.id,
    required this.title,
    required this.lastMessage,
    required this.updatedAt,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ConversationScreen(conversationId: id),
          ),
        );
      },
      child: Container(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const CircleAvatar(
                    radius: 30,
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        truncate(lastMessage, 20,
                            omission: '...', position: TruncatePosition.end),
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w300,
                        ),
                      )
                    ],
                  ),
                ],
              ),
              Text(
                updatedAt,
                style: TextStyle(color: Colors.grey.shade500),
              )
            ],
          ),
        ),
      ),
    );
  }
}
