import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:main_app/configs/backend_config.dart';
import 'package:main_app/injector.dart';
import 'package:main_app/modules/user/domain/models/user.dart';
import 'package:retrofit/retrofit.dart';
import 'package:suga_core/suga_core.dart';

part 'user_service.g.dart';

@lazySingleton
@RestApi(baseUrl: "${BackendConfig.baseUrl}/api/user/v1/users")
abstract class UserService {
  @factoryMethod
  factory UserService() => _UserService(injector<HttpClientWrapper>().dio);

  @GET("")
  Future<List<User>> getListUsers({
    @Query("page") int? page,
    @Query("limit") int? limit,
    @Query("need_total_count") bool? needTotalCount,
    @Query("search") String? search,
    @Query("sort") String? sort,
    @Query("dir") String? dir,
  });
}
