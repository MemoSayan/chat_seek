import 'package:flutter/material.dart';
import 'package:flutter_chat_seek/app/app.dart';
import 'package:flutter_chat_seek/bootstrap.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  bootstrap(() async => const MyApp());
}
