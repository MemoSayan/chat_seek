import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_chat_seek/core/constants/message_utils.dart';
import 'package:flutter_chat_seek/features/chat/domain/entities/chat_error.dart';
import 'package:flutter_chat_seek/features/chat/domain/entities/chat_message_entity.dart';
import 'package:flutter_chat_seek/features/chat/domain/usecases/post_message.dart';

part 'messages_event.dart';
part 'messages_state.dart';

class MessagesBloc extends Bloc<MessagesEvent, MessagesState> {
  MessagesBloc(this._postMessage) : super(const MessagesInitial()) {
    on<OnSendMessage>(_onSendMessage);
  }

  final PostMessage _postMessage;

  FutureOr<void> _onSendMessage(
      OnSendMessage event, Emitter<MessagesState> emit) async {
    emit(state.copyWith(status: PromptStatus.loading));

    final ChatMessage inputMessage = ChatMessage(
      content: event.message,
      role: 'user',
      timestamp: DateTime.now(),
    );

    final List<ChatMessage> promptMessages = [
      inputMessage,
      ...(state.outPut ?? [])
    ];

    emit(state.copyWith(outPut: promptMessages));

    final request = MessageUtils.buildChatRequest(event.message);

    final result = await _postMessage(request);

    result.fold(
      (error) {
        final chatError = ChatError.fromAppError(error);
        emit(state.copyWith(status: PromptStatus.error, error: chatError));
      },
      (message) {
        final List<ChatMessage> updatedMessages = [
          ...message,
          ...(state.outPut ?? [])
        ];
        emit(state.copyWith(
            outPut: updatedMessages, status: PromptStatus.received));
      },
    );
  }
}
