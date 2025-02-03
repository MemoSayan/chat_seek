part of 'messages_bloc.dart';

sealed class MessagesEvent extends Equatable {
  const MessagesEvent();
}

final class OnSendMessage extends MessagesEvent {
  final String message;

  const OnSendMessage(this.message);

  @override
  List<Object> get props => [message];
}


