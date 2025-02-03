import 'package:dartz/dartz.dart';
import 'package:flutter_chat_seek/features/chat/data/request/chat_request.dart';
import 'package:flutter_chat_seek/features/chat/data/response/prompt_reponse.dart';

abstract class ChatRepository {
  Future<Either<dynamic, PromptResponse>> sendMessage(ChatRequest message);
}