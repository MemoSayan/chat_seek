import 'package:flutter_chat_seek/features/chat/presentacion/logic/messages_bloc/messages_bloc.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

class MessageHelper {
  final MessagesBloc messagesBloc;

  MessageHelper(this.messagesBloc);

  static List<types.Message> mapStateToMessages(
      MessagesState state, types.User user, types.User user2) {
    final messages = <types.Message>[];

    if (state.outPut != null) {
      for (final chatMessage in state.outPut!) {
        final isUser = chatMessage.role == 'user';

        messages.add(types.TextMessage(
          type: types.MessageType.text,
          status: state.status == PromptStatus.received
              ? types.Status.delivered
              : types.Status.sending,
          showStatus: true,
          author: isUser ? user : user2,
          createdAt: chatMessage.timestamp.millisecondsSinceEpoch,
          id: chatMessage.timestamp.millisecondsSinceEpoch.toString(),
          text: chatMessage.content,
        ));
      }
    }
    return messages;
  }

  void handleSendPressed(String text) {
    messagesBloc.add(OnSendMessage(text));
  }
}
