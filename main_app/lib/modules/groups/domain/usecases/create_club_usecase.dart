import 'package:injectable/injectable.dart';
import 'package:main_app/modules/groups/data/repositories/club_repository.dart';
import 'package:main_app/modules/groups/domain/models/club.dart';
import 'package:suga_core/suga_core.dart';

@lazySingleton
class CreateClubUsecase extends Usecase {
  final ClubRepository _clubRepository;

  const CreateClubUsecase(this._clubRepository);

  Future<Club> run(String name, String avatarPath) async {
    final club = await _clubRepository.createClub(name, avatarPath);
    return club;
  }
}
