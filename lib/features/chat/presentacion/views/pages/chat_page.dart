// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat_seek/features/chat/presentacion/logic/helpers/messages_helper.dart';
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
  late MessageHelper _messageHandler;

  final _user = const types.User(
    id: '82091008-a484-4a89-ae75-a22bf8d6f3ac',
  );
  final _user2 = const types.User(
    id: '82091008-a484-4a89-ae75-a22bf8d6f3ad',
  );
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _messagesBloc = context.read<MessagesBloc>();
      _messageHandler = MessageHelper(_messagesBloc);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<MessagesBloc, MessagesState>(
        builder: (context, state) {
          // if (state.status == PromptStatus.loading) {
          //   return const Center(
          //     child: CircularProgressIndicator(),
          //   );
          // }

          if (state.status == PromptStatus.error) {
            _showErrorDialog(
                context, state.error?.message ?? "Error desconocido");
          }

          final messages =
              MessageHelper.mapStateToMessages(state, _user, _user2);

          return Chat(
            messages: messages,
            onSendPressed: (message) =>
                _messageHandler.handleSendPressed(message.text),
            user: _user,
            showUserAvatars: true,
          );
        },
      ),
    );
  }

  /// 🔹 Método para mostrar el BottomSheet con el error
  void _showErrorDialog(BuildContext context, String errorMessage) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16),
          child:  Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.error_outline, color: Colors.red, size: 48),
              const SizedBox(height: 12),
              const Text(
                "Error",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                errorMessage,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Cerrar"),
              ),
            ],
          ),
        );
      },
    );
  }
}
