import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_chat_seek/core/constants/errors_types.dart';
import 'package:flutter_chat_seek/features/chat/data/data_source/deep_seek_api.dart';
import 'package:flutter_chat_seek/features/chat/data/request/chat_request.dart';
import 'package:flutter_chat_seek/features/chat/data/response/prompt_reponse.dart';
import 'package:flutter_chat_seek/features/chat/domain/entities/app_error.dart';
import 'package:flutter_chat_seek/features/chat/domain/repositories/chat_repository.dart';

class ChatRepositoryImpl implements ChatRepository {
  final DeepSeekApi _deepSeekApi;

  ChatRepositoryImpl(this._deepSeekApi);

  @override
  Future<Either<AppError, PromptResponse>> sendMessage(
      ChatRequest message) async {
    try {
      final response = await _deepSeekApi.sendMessage(message);
      return Right(response.data);
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionError) {
        return Left(NetworkError(message: e.message));
      } else if (e.response != null) {
        return Left(ServerError(
            statusCode: e.response!.statusCode!, message: e.message));
      } else {
        return Left(UnknownError(message: e.message));
      }
    } catch (e) {
      return Left(UnknownError(message: e.toString()));
    }
  }
}
