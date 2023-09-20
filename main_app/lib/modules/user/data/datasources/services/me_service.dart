import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:main_app/configs/backend_config.dart';
import 'package:main_app/injector.dart';
import 'package:main_app/modules/user/domain/models/user.dart';
import 'package:retrofit/retrofit.dart';
import 'package:suga_core/suga_core.dart';

part 'me_service.g.dart';

@lazySingleton
@RestApi(baseUrl: "${BackendConfig.baseUrl}/api/user/v1/me")
abstract class MeService {
  @factoryMethod
  factory MeService() => _MeService(injector<HttpClientWrapper>().dio);

  @GET("")
  Future<User> get();

  @PUT("")
  Future<User> update(@Body() Map<String, dynamic> body);

  @DELETE("")
  Future<bool> delete();

  @POST('/logout')
  Future logout();

  @PUT("/password/change")
  Future<bool> changePassword(@Body() Map<String, dynamic> body);
}
