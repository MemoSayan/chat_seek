// 2. Crea una clase para constantes del sistema
import 'package:flutter_chat_seek/features/chat/data/request/message_model.dart';

abstract class SystemPrompts {
  static final defaultSystemMessage = Message(
    role: 'system',
    content: 'You are a helpful and friendly assistant.',
  );

  static const defaultModel = 'deepseek-r1-distill-qwen-7b';

}

