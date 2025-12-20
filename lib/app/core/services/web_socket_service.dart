import 'dart:async';
import 'package:logger/logger.dart';
import 'package:roomy/app/config/api_config.dart';
import 'package:roomy/app/config/di.dart';
import 'package:roomy/app/core/services/api_service.dart';
import 'package:roomy/app/core/utils/result.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class WebSocketService {
  final _apiService = getIt<ApiService>();
  final _log = Logger();

  Future<Result<WebSocketChannel>> connect(String roomId) async {
    try {
      final authCookie = (await _apiService.cookieJar.loadForRequest(
        Uri.parse(ApiConfig.baseUrl),
      )).firstWhere((cookie) => cookie.name == 'authToken').value;

      final url = ApiConfig.baseUrl.startsWith('https')
          ? 'wss://${ApiConfig.baseUrl.replaceFirst('https://', '')}/rooms/$roomId/ws?authToken=$authCookie'
          : 'ws://${ApiConfig.baseUrl.replaceFirst('http://', '')}/rooms/$roomId/ws?authToken=$authCookie';

      _log.i(url);

      final channel = WebSocketChannel.connect(Uri.parse(url));
      await channel.ready;
      return Success(channel);
    } catch (e) {
      _log.e(e);
      return Failure(e.toString());
    }
  }
}
