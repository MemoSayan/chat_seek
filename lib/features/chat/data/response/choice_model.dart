
// ignore_for_file: invalid_annotation_target

import 'package:flutter_chat_seek/features/chat/data/request/message_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'choice_model.freezed.dart';
part 'choice_model.g.dart';

@freezed
class Choice with _$Choice {
  const factory Choice({
    required int index,
    required String? logprobs,
    @JsonKey(name: 'finish_reason') required String finishReason,
    required Message message,
  }) = _Choice;

  factory Choice.fromJson(Map<String, dynamic> json) => _$ChoiceFromJson(json);
}