// ignore_for_file: invalid_annotation_target

import 'package:flutter_chat_seek/features/chat/data/request/message_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';


part 'chat_request.freezed.dart';
part 'chat_request.g.dart';

@freezed
class ChatRequest with _$ChatRequest {
   factory ChatRequest({
    required String model,
    required List<Message> messages,
    required double temperature,
    @JsonKey(name: 'max_tokens') required int maxTokens,
    required bool stream,
  }) = _ChatRequest;

  factory ChatRequest.fromJson(Map<String, dynamic> json) =>
      _$ChatRequestFromJson(json);
}
