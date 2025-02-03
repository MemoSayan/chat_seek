part of 'messages_bloc.dart';

sealed class MessagesState extends Equatable {
  const MessagesState();
}

final class MessagesInitial extends MessagesState {
  @override
  List<Object> get props => [];
}
