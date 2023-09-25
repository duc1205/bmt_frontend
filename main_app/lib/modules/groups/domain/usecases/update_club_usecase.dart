import 'package:event_bus/event_bus.dart';
import 'package:injectable/injectable.dart';
import 'package:main_app/modules/groups/data/repositories/club_repository.dart';
import 'package:main_app/modules/groups/domain/events/update_club_changed_event.dart';
import 'package:main_app/modules/groups/domain/models/club.dart';
import 'package:suga_core/suga_core.dart';

@lazySingleton
class UpdateProfileUsecase extends Usecase {
  final ClubRepository _clubRepository;
  final EventBus _eventBus;

  const UpdateProfileUsecase(this._clubRepository, this._eventBus);

  Future<Club> run(String id, {required String name, String? avatarPath}) async {
    final club = await _clubRepository.updateClub(id, name: name, avatarPath: avatarPath);
    _eventBus.fire(UpdateClubChangedEvent(club));
    return club;
  }
}
