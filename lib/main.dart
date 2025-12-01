import 'package:flutter/material.dart';
import 'package:roomy/app.dart';
import 'package:roomy/app/config/di.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await setupDependencies();

  runApp(const RoomyApp());
}
