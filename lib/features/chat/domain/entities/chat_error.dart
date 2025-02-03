import 'package:flutter_chat_seek/features/chat/domain/entities/app_error.dart';

class ChatError {
  final String message;
  final String? code;

  ChatError({required this.message, this.code});

  factory ChatError.fromAppError(AppError error) {
    return ChatError(message: error.message, code: error.code);
  }
}