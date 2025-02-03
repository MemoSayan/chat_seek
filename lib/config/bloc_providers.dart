import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat_seek/config/dependencies_container.dart';
import 'package:flutter_chat_seek/features/chat/presentacion/logic/messages_bloc/messages_bloc.dart';

final blocProviders = [
  BlocProvider<MessagesBloc>(
    create: (context) => sl<MessagesBloc>(),
  ),
];
