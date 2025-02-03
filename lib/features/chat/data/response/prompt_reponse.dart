// ignore_for_file: invalid_annotation_target

import 'package:flutter_chat_seek/features/chat/data/response/choice_model.dart';
import 'package:flutter_chat_seek/features/chat/data/response/usage_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'prompt_reponse.freezed.dart';
part 'prompt_reponse.g.dart';

@freezed
class PromptResponse with _$PromptResponse {
  const factory PromptResponse({
    required String id,
    required String object,
    required int created,
    required String model,
    required List<Choice> choices,
    required Usage usage,
    @JsonKey(name: 'system_fingerprint') required String systemFingerprint,
  }) = _PromptResponse;

  factory PromptResponse.fromJson(Map<String, dynamic> json) => _$PromptResponseFromJson(json);
}



