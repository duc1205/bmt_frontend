import 'package:injectable/injectable.dart';
import 'package:main_app/core/helpers/list_params.dart';
import 'package:main_app/modules/groups/data/repositories/club_repository.dart';
import 'package:main_app/modules/groups/domain/models/club.dart';
import 'package:suga_core/suga_core.dart';

@lazySingleton
class GetListClubsUsecase extends Usecase {
  final ClubRepository _clubRepository;

  const GetListClubsUsecase(this._clubRepository);

  Future<List<Club>> run({
    ListParams? listParams,
    String? search,
  }) =>
      _clubRepository.getListClubs(
        listParams: listParams,
      );
}
