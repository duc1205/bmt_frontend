import 'package:injectable/injectable.dart';
import 'package:main_app/core/helpers/list_params.dart';
import 'package:main_app/modules/groups/data/datasources/services/club_service.dart';
import 'package:main_app/modules/groups/domain/models/club.dart';

abstract class ClubDatasource {
  Future<Club> getDetailClub(String id);

  Future<Club> updateClub(String id, {required String name, String? avatarPath});

  Future<bool> deleteClub(String id);

  Future<Club> createClub(String name, String? avatarPath);

  Future<List<Club>> getListClubs({
    ListParams? listParams,
  });
}

@LazySingleton(as: ClubDatasource)
class ClubDataSourceImpl implements ClubDatasource {
  final ClubService _clubService;

  ClubDataSourceImpl(this._clubService);

  @override
  Future<Club> createClub(String name, String? avatarPath) {
    final map = {
      "name": name,
      "avatar_path": avatarPath,
    };
    return _clubService.createClub(map);
  }

  @override
  Future<bool> deleteClub(String id) => _clubService.delete(id);

  @override
  Future<Club> getDetailClub(String id) => _clubService.get(id);

  @override
  Future<List<Club>> getListClubs({ListParams? listParams}) {
    return _clubService.getListClubs(
      page: listParams?.paginationParams?.page,
      limit: listParams?.paginationParams?.limit,
      sort: listParams?.sortParams?.attribute,
      dir: listParams?.sortParams?.direction,
    );
  }

  @override
  Future<Club> updateClub(String id, {required String name, String? avatarPath}) {
    final map = {
      "name": name,
      "avatar_path": avatarPath,
    };
    return _clubService.update(id, map);
  }
}
