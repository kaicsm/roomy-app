import 'package:logger/logger.dart';
import 'package:roomy/app/config/api_config.dart';
import 'package:roomy/app/config/di.dart';
import 'package:roomy/app/core/models/user_model.dart';
import 'package:roomy/app/core/services/api_service.dart';
import 'package:roomy/app/core/utils/result.dart';

class UserService {
  final _log = Logger();

  final _apiService = getIt<ApiService>();

  Future<Result<UserModel>> getUser(String id) async {
    try {
      final response = await _apiService.client.get(
        '${ApiConfig.userEndpoint}/$id',
      );

      final user = UserModel.fromJson(response.data);

      _log.i(user);

      return Success(user);
    } catch (e) {
      _log.e(e);
      return Failure(e.toString());
    }
  }

  Future<Result<UserModel>> me() async {
    final response = await _apiService.client.get(
      '${ApiConfig.userEndpoint}/me',
    );
    final user = UserModel.fromJson(response.data);
    return Success(user);
  }
}
