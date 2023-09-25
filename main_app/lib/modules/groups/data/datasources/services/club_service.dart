import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:main_app/configs/backend_config.dart';
import 'package:main_app/injector.dart';
import 'package:main_app/modules/groups/domain/models/club.dart';
import 'package:retrofit/retrofit.dart';
import 'package:suga_core/suga_core.dart';

part 'club_service.g.dart';

@lazySingleton
@RestApi(baseUrl: "${BackendConfig.baseUrl}/api/user/v1/group")
abstract class ClubService {
  @factoryMethod
  factory ClubService() => _ClubService(injector<HttpClientWrapper>().dio);

  @GET("id/{id}")
  Future<Club> get(@Path("id") String id);

  @PUT("id/{id}")
  Future<Club> update(@Path("id") String id, @Body() Map<String, dynamic> body);

  @DELETE("id/{id}")
  Future<bool> delete(@Path("id") String id);

  @POST('')
  Future<Club> createClub(@Body() Map<String, dynamic> body);

  @GET("")
  Future<List<Club>> getListClubs({
    @Query("page") int? page,
    @Query("limit") int? limit,
    @Query("need_total_count") bool? needTotalCount,
    @Query("sort") String? sort,
    @Query("dir") String? dir,
  });
}
