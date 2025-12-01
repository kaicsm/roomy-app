import 'package:flutter/material.dart';
import 'package:signals/signals.dart';

class SignalNotifier extends ChangeNotifier {
  late final Function() _dispose;

  SignalNotifier(ReadonlySignal signal) {
    _dispose = effect(() {
      signal.value;
      notifyListeners();
    });
  }

  @override
  void dispose() {
    _dispose();
    super.dispose();
  }
}
