import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:media_kit/media_kit.dart';
import 'package:roomy/app.dart';
import 'package:roomy/app/config/di.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MediaKit.ensureInitialized();

  await dotenv.load();
  await setupDependencies();

  runApp(const RoomyApp());
}
