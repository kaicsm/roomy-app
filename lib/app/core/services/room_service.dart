import 'package:logger/logger.dart';
import 'package:roomy/app/config/api_config.dart';
import 'package:roomy/app/config/di.dart';
import 'package:roomy/app/core/models/room_model.dart';
import 'package:roomy/app/core/services/api_service.dart';
import 'package:roomy/app/core/utils/result.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class RoomService {
  final _log = Logger();

  final _apiService = getIt<ApiService>();

  Future<Result<List<RoomModel>>> getPublicRooms() async {
    try {
      final response = await _apiService.client.get(ApiConfig.roomEndpoint);

      final roomsList = (response.data as List)
          .map((room) => RoomModel.fromJson(room))
          .toList();

      _log.i(roomsList.toString());

      return Sucess(roomsList);
    } catch (e) {
      _log.e(e);
      return Failure(e.toString());
    }
  }

  Future<Result<RoomModel>> createRoom(
    String name, {
    int? maxParticipants,
    bool? isPublic,
  }) async {
    try {
      final roomData = {
        "name": name,
        "isPublic": isPublic ?? true,
        "maxParticipants": maxParticipants ?? 10,
      };

      final response = await _apiService.client.post(
        ApiConfig.roomEndpoint,
        data: roomData,
      );

      final room = RoomModel.fromJson(response.data);

      _log.i(room);

      return Sucess(room);
    } catch (e) {
      _log.e(e);
      return Failure(e.toString());
    }
  }

  Future<Result<WebSocketChannel>> getWebSocketChannel(String roomId) async {
    try {
      final authCookie = (await _apiService.cookieJar.loadForRequest(
        Uri.parse(ApiConfig.baseUrl),
      )).firstWhere((cookie) => cookie.name == 'authToken').value;

      final url =
          'ws://${ApiConfig.baseUrl.replaceFirst('http://', '').replaceFirst('https://', '')}/rooms/$roomId/ws?authToken=$authCookie';

      _log.i(url);

      final channel = WebSocketChannel.connect(Uri.parse(url));

      await channel.ready;

      _log.i(channel);
      return Sucess(channel);
    } catch (e) {
      _log.e(e);
      return Failure(e.toString());
    }
  }
}
