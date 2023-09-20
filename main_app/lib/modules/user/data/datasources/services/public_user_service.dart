import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:main_app/configs/backend_config.dart';
import 'package:main_app/injector.dart';
import 'package:main_app/modules/user/domain/models/user.dart';
import 'package:retrofit/retrofit.dart';
import 'package:suga_core/suga_core.dart';

part 'public_user_service.g.dart';

@lazySingleton
@RestApi(baseUrl: "${BackendConfig.baseUrl}/api/public/v1/user")
abstract class PublicUserService {
  @factoryMethod
  factory PublicUserService() => _PublicUserService(injector<HttpClientWrapper>().dio);

  @POST("")
  Future<User> registerAccount(@Body() Map<String, dynamic> body);
}
