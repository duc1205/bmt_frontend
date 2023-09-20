import 'package:event_bus/event_bus.dart';
import 'package:injectable/injectable.dart';
import 'package:main_app/modules/user/data/repositories/user_repository.dart';
import 'package:main_app/modules/user/domain/events/user_profile_changed_event.dart';
import 'package:main_app/modules/user/domain/models/user.dart';
import 'package:suga_core/suga_core.dart';

@lazySingleton
class UpdateProfileUsecase extends Usecase {
  final UserRepository _userRepository;
  final EventBus _eventBus;

  const UpdateProfileUsecase(this._userRepository, this._eventBus);

  Future<User> run({String? name, String? avatarPath}) async {
    final user = await _userRepository.update(fullName: name, avatarPath: avatarPath);
    _eventBus.fire(UserProfileChangedEvent(user));
    return user;
  }
}
