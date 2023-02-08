import 'package:chat_app/constants.dart';
import 'package:chat_app/models/messages.dart';
import 'package:chat_app/views/cubit/chat_cubit/chat_state.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widgets/chat_buble.dart';
import 'cubit/chat_cubit/chat_cubit.dart';

class ChatPage extends StatelessWidget {
  static String id = 'ChatPage';
  final _controller = ScrollController();
  TextEditingController controller = TextEditingController();
  List<Message> messagesList = [];
  ChatPage({super.key});
  @override
  Widget build(BuildContext context) {
    String email = ModalRoute.of(context)!.settings.arguments as String;
          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: kPrimaryColor,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    kLogo,
                    height: 50,
                  ),
                  const Text(
                    'Chat',
                  ),
                ],
              ),
            ),
            body: Column(
              children: [
                BlocConsumer<ChatCubit , ChatStates>(
                  listener: (context , state) {
                    if(state is ChatSuccess){
                      messagesList = state.messages;
                    }
                  },
                  builder: (context , state) {
                    return Expanded(
                      child: ListView.builder(
                        reverse: true,
                        controller: _controller,
                        itemCount: messagesList.length,
                        itemBuilder: (context, index) {
                          return messagesList[index].id == email ? ChatBubble(
                            message: messagesList[index],
                          ): ChatBubbleForFriend(message: messagesList[index]);
                        },
                      ),
                    );
                  }
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextField(
                      controller: controller,
                      onSubmitted: (data) {
                        BlocProvider.of<ChatCubit>(context).sendMessage(message: data, email: email);
                        controller.clear();
                        _controller.animateTo(
                            0,
                            duration: const Duration(seconds: 1),
                            curve: Curves.fastOutSlowIn);
                      },
                      decoration: InputDecoration(
                        hintText: 'Send Message',
                        suffixIcon: const Icon(
                          Icons.send,
                          color: kPrimaryColor,
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: const BorderSide(color: kPrimaryColor)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: const BorderSide(color: kPrimaryColor)),
                      )),
                )
              ],
            ),
          );
  }
}
