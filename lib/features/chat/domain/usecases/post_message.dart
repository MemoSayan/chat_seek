import 'package:dartz/dartz.dart';
import 'package:flutter_chat_seek/core/constants/errors_types.dart';
import 'package:flutter_chat_seek/features/chat/data/request/chat_request.dart';
import 'package:flutter_chat_seek/features/chat/domain/entities/app_error.dart';
import 'package:flutter_chat_seek/features/chat/domain/entities/chat_message_entity.dart';
import 'package:flutter_chat_seek/features/chat/domain/repositories/chat_repository.dart';

class PostMessage {
  final ChatRepository _chatRepository;

  PostMessage(this._chatRepository);

  Future<Either<AppError, List<ChatMessage>>> call(ChatRequest request) async {
    final result = await _chatRepository.sendMessage(request);

    return result.fold(
      (failure) => Left(failure),
      (response) {
        final messages = response.choices.map((choice) {
          return ChatMessage(
            content: choice.message.content,
            role: choice.message.role,
            timestamp:
                DateTime.fromMillisecondsSinceEpoch(response.created * 1000),
          );
        }).toList();

        if (messages.isNotEmpty) {
          return Right(messages);
        } else {
          return Left(ValidationError(
              message: 'No messages returned from the response.'));
        }
      },
    );
  }
}
