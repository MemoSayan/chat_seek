// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat_seek/features/chat/presentacion/logic/messages_bloc/messages_bloc.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  late MessagesBloc _messagesBloc;

  final _user = const types.User(
    id: '82091008-a484-4a89-ae75-a22bf8d6f3ac',
  );
  final _user2 = const types.User(
    id: '82091008-a484-4a89-ae75-a22bf8d6f3ad',
  );

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _messagesBloc = context.read<MessagesBloc>();
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<MessagesBloc, MessagesState>(
        builder: (context, state) {
          // Mostrar un indicador de carga si el estado es "loading"
          if (state.status == PromptStatus.loading) {
            // return const Center(
            //   child: CircularProgressIndicator(), // Indicador de carga
            // );
          }

          // Convertir el estado del BLoC en una lista de mensajes para el chat
          final messages = _mapStateToMessages(state);

          return Chat(
            messages: messages,
            onSendPressed: _handleSendPressed,
            user: _user,
            showUserAvatars: true,
          );
        },
      ),
    );
  }

  List<types.Message> _mapStateToMessages(MessagesState state) {
    final messages = <types.Message>[];

    if (state.outPut != null) {
      for (final chatMessage in state.outPut!) {
        final isUser = chatMessage.role == 'user';

        messages.add(types.TextMessage(
          type: types.MessageType.text,
          status: state.status == PromptStatus.received
              ? types.Status.delivered
              : types.Status.sending,
          showStatus: true,
          author: isUser ? _user : _user2,
          createdAt: chatMessage.timestamp.millisecondsSinceEpoch,
          id: chatMessage.timestamp.millisecondsSinceEpoch.toString(),
          text: chatMessage.content,
        ));
      }
    }

    return messages;
  }

  void _handleSendPressed(types.PartialText message) {
    _messagesBloc.add(OnSendMessage(message.text)); // Enviar evento al BLoC
  }
}
