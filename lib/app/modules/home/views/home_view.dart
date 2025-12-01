import 'package:flutter/material.dart';
import 'package:roomy/app/config/di.dart';
import 'package:roomy/app/modules/home/controllers/home_controller.dart';
import 'package:signals/signals_flutter.dart';

class HomeView extends StatelessWidget {
  HomeView({super.key});

  final _controller = getIt<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: .center,
          children: [
            Watch((context) => Text("${_controller.counter}")),
            ElevatedButton(
              onPressed: () => _controller.increment(),
              child: Text("+"),
            ),
          ],
        ),
      ),
    );
  }
}
