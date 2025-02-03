part of 'messages_bloc.dart';

enum PromptStatus { loading, sent, received, error, inital }

class MessagesState extends Equatable {
  const MessagesState(
      {this.status = PromptStatus.inital, this.outPut, this.error, this.message});

  final PromptStatus status;
  final List<ChatMessage>? outPut;
  final ChatError? error;
  final String? message;

  MessagesState copyWith({
    PromptStatus? status,
    List<ChatMessage>? outPut,
    ChatError? error,
    String? message,
  }) {
    return MessagesState(
      status: status ?? this.status,
      outPut: outPut ?? this.outPut,
      error: error ?? this.error,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [status, outPut, error, message];
}

final class MessagesInitial extends MessagesState {
  const MessagesInitial() : super(status: PromptStatus.inital);
}

 