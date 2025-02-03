import 'package:flutter_chat_seek/features/chat/data/request/message_model.dart';
import 'package:flutter_chat_seek/features/chat/data/response/prompt_reponse.dart';
import 'package:flutter_chat_seek/features/chat/domain/entities/chat_message_entity.dart';

class PromptResponseMapper {
  static List<ChatMessage> fromPromptResponse(PromptResponse response) {
    return response.choices.map((choice) {
      return ChatMessage(
        content: choice.message.content,
        role: choice.message.role,
        timestamp: DateTime.fromMillisecondsSinceEpoch(response.created * 1000),
      );
    }).toList();
  }
}

extension ChatMessageToMessage on ChatMessage {
  Message toApiMessage() => Message(
        role: role,
        content: content,
      );
}

extension MessageToChatMessage on Message {
  ChatMessage toUiModel() => ChatMessage(
        content: content,
        role: role,
        timestamp: DateTime.now(),
      );
}
