import 'package:injectable/injectable.dart';
import 'package:main_app/modules/groups/data/repositories/club_repository.dart';
import 'package:suga_core/suga_core.dart';

@lazySingleton
class DeleteClubUsecase extends Usecase {
  final ClubRepository _clubRepository;

  const DeleteClubUsecase(this._clubRepository);

  Future<Unit> run(String id) async {
    await _clubRepository.deleteClub(id);
    return unit;
  }
}
