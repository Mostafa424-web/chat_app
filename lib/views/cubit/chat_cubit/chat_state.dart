import '../../../models/messages.dart';

abstract class ChatStates {}

class ChatInitial extends ChatStates {}
class ChatSuccess extends ChatStates {
  List<Message> messages = [];
  ChatSuccess({required this.messages});
}