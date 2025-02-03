import 'package:dio/dio.dart';
import 'package:flutter_chat_seek/features/chat/data/request/chat_request.dart';
import 'package:flutter_chat_seek/features/chat/data/response/prompt_reponse.dart';
import 'package:retrofit/retrofit.dart';

part 'deep_seek_api.g.dart';

@RestApi()
abstract class DeepSeekApi {
  factory DeepSeekApi(Dio dio, {String baseUrl}) = _DeepSeekApi;

  @POST('/v1/chat/completions')
  Future<HttpResponse<PromptResponse>> sendMessage(@Body() ChatRequest message);
}
