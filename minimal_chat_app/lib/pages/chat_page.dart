import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:minimal_chat_app/components/my_textfield.dart';
import 'package:minimal_chat_app/services/auth/auth_service.dart';
import 'package:minimal_chat_app/services/chat/chat_services.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({
    super.key,
    required this.receiverEmail,
    required this.receiverId,
  });
  final String receiverEmail;
  final String receiverId;

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  TextEditingController messageController = TextEditingController();

  ChatServices chatServices = ChatServices();

  AuthService authService = AuthService();
  void sendMessage() async {
    if (messageController.text.isNotEmpty) {
      await chatServices.sendMessage(
          receiverId: widget.receiverId, message: messageController.text);
      messageController.clear();
    }
  }

  Widget buildMessageItem(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Text(data['message']);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.receiverEmail),
      ),
      body: Column(
        children: [
          Expanded(
            child: buildMessageList(),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 15),
            child: buildUserInput(),
          ),
        ],
      ),
    );
  }

  Widget buildUserInput() {
    return Row(
      children: [
        Expanded(
          child: MyTextfield(
            hintText: 'Type here...',
            controller: messageController,
            isObscure: false,
          ),
        ),
        IconButton(
          onPressed: sendMessage,
          icon: const Icon(
            Icons.arrow_circle_right_rounded,
            size: 64,
          ),
        )
      ],
    );
  }

  Widget buildMessageList() {
    String senderId = FirebaseAuth.instance.currentUser!.uid;
    return StreamBuilder(
      stream: chatServices.getMessages(
          userId: senderId, otherId: widget.receiverId),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Center(
            child: Text('Some error occurred'),
          );
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        return ListView(
          children: snapshot.data!.docs
              .map(
                (doc) => buildMessageItem(doc),
              )
              .toList(),
        );
      },
    );
  }
}
