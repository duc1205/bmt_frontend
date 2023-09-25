import 'package:injectable/injectable.dart';
import 'package:main_app/core/helpers/list_params.dart';
import 'package:main_app/modules/groups/data/datasources/club_datasource.dart';
import 'package:main_app/modules/groups/domain/models/club.dart';
import 'package:suga_core/suga_core.dart';

@lazySingleton
class ClubRepository extends Repository {
  final ClubDatasource _clubDatasource;

  const ClubRepository(this._clubDatasource);

  Future<Club> getDetailClub(String id) => _clubDatasource.getDetailClub(id);

  Future<Club> updateClub(
    String id, {
    required String name,
    String? avatarPath,
  }) =>
      _clubDatasource.updateClub(id, name: name);

  Future<bool> deleteClub(String id) => _clubDatasource.deleteClub(id);

  Future<Club> createClub(String name, String? avatarPath) => _clubDatasource.createClub(name, avatarPath);

  Future<List<Club>> getListClubs({
    ListParams? listParams,
  }) =>
      _clubDatasource.getListClubs(
        listParams: listParams,
      );
}
