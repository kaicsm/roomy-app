import 'package:signals/signals.dart';

class HomeController {
  final _counter = signal(0);
  Signal<int> get counter => _counter;

  void increment() {
    _counter.value++;
  }

  void decrement() {
    _counter.value--;
  }
}
