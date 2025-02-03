import 'package:flutter_chat_seek/features/chat/domain/entities/app_error.dart';

class NetworkError extends AppError {
  NetworkError({String? message})
      : super(message: message ?? 'Network error occurred');
}

class ServerError extends AppError {
  final int statusCode;

  ServerError({required this.statusCode, String? message})
      : super(message: message ?? 'Server error occurred', code: statusCode.toString());
}

class ValidationError extends AppError {
  ValidationError({String? message})
      : super(message: message ?? 'Validation error occurred');
}

class UnknownError extends AppError {
  UnknownError({String? message})
      : super(message: message ?? 'Unknown error occurred');
}