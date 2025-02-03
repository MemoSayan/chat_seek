import 'package:flutter_chat_seek/config/model_config.dart';
import 'package:flutter_chat_seek/features/chat/data/request/chat_request.dart';
import 'package:flutter_chat_seek/features/chat/data/request/message_model.dart';

class MessageUtils {
  static const String model = 'deepseek-r1-distill-qwen-7b';

  static List<Message> buildPrompt(String userMessage) {
    return [
      SystemPrompts.defaultSystemMessage,
      Message(content: userMessage, role: 'user')
    ];
  }

  static ChatRequest buildChatRequest(String userMessage) {
    return ChatRequest(
      model: SystemPrompts.defaultModel,
      messages: buildPrompt(userMessage),
      temperature: 0.7,
      maxTokens: -1,
      stream: false,
    );
  }
}
