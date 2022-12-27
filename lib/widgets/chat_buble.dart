import 'package:chat_app/models/messages.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class ChatBubble extends StatelessWidget {
   const ChatBubble({
    required this.message,
    Key? key,
  }) : super(key: key);

  final Message message;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16,vertical: 8),
        padding: const EdgeInsets.only(left: 16,top: 16,bottom: 16,right: 32),
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(32),
              topRight: Radius.circular(32),
              bottomRight: Radius.circular(32),
            ),
            color: kPrimaryColor
        ),
        child: Text(
          message.message,
          style: const TextStyle(
              color: Colors.white
          ),
        ),
      ),
    );
  }
}


class ChatBubbleForFriend extends StatelessWidget {
  const ChatBubbleForFriend({
    required this.message,
    Key? key,
  }) : super(key: key);

  final Message message;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16,vertical: 8),
        padding: const EdgeInsets.only(left: 16,top: 16,bottom: 16,right: 32),
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(32),
              topRight: Radius.circular(32),
              bottomLeft: Radius.circular(32),
            ),
            color: Color(0xff006D84)
        ),
        child: Text(
          message.message,
          style: const TextStyle(
              color: Colors.white
          ),
        ),
      ),
    );
  }
}