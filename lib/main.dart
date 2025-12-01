import 'package:flutter/material.dart';
import 'package:roomy/app.dart';
import 'package:roomy/app/config/di.dart';

void main() {
  setupDependencies();

  runApp(const RoomyApp());
}
