import 'package:roomy/app/core/utils/app_controller.dart';
import 'package:signals/signals_flutter.dart';

class SelectPlatformController extends AppController {
  final selectedPlatform = signal('');
  final isLoading = signal(false);

  @override
  void dispose() {
    selectedPlatform.dispose();
    isLoading.dispose();
  }
}
