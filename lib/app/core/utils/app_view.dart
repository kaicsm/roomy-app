import 'package:flutter/material.dart';
import 'package:roomy/app/config/di.dart';
import 'package:roomy/app/core/utils/app_controller.dart';

abstract class AppView<T extends AppController> extends StatefulWidget {
  const AppView({super.key});

  T getController(BuildContext context) {
    try {
      return getIt<T>();
    } catch (e) {
      throw Exception("Controller $T not found");
    }
  }

  Widget build(BuildContext context, T controller);

  @override
  State<AppView<T>> createState() => _AppViewState<T>();
}

class _AppViewState<T extends AppController> extends State<AppView<T>> {
  late T _controller;
  late Future<void> _initializationFuture;

  @override
  void initState() {
    super.initState();
    _controller = widget.getController(context);
    _initializationFuture = _controller.init();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initializationFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return Center(child: Text('Error loading: ${snapshot.error}'));
          }
          return widget.build(context, _controller);
        }

        return const Scaffold(body: Center(child: CircularProgressIndicator()));
      },
    );
  }
}
