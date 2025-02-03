import 'package:dio/dio.dart';
import 'package:flutter_chat_seek/config/dio_factory.dart';
import 'package:flutter_chat_seek/features/chat/data/data_source/deep_seek_api.dart';
import 'package:flutter_chat_seek/features/chat/data/repositories_impl/chat_repository_impl.dart';
import 'package:flutter_chat_seek/features/chat/domain/repositories/chat_repository.dart';
import 'package:flutter_chat_seek/features/chat/domain/usecases/post_message.dart';
import 'package:flutter_chat_seek/features/chat/presentacion/logic/messages_bloc/messages_bloc.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> initializeDependecies() async {

  sl.registerSingleton<Dio>(DioFactory(
    baseUrl: 'http://10.0.2.2:1234',
  ).getDio());

//DATA LAYER
  sl.registerSingleton<DeepSeekApi>(DeepSeekApi(sl()));

//REPOSITORIES
  sl.registerSingleton<ChatRepository>(ChatRepositoryImpl(sl()));

  //USECASES

  sl.registerLazySingleton(() => PostMessage(sl()));

  // State Management
  sl.registerFactory(() => MessagesBloc(sl()));
}
