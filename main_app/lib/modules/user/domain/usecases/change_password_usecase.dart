import 'package:injectable/injectable.dart';
import 'package:main_app/modules/user/data/repositories/user_repository.dart';
import 'package:suga_core/suga_core.dart';

@lazySingleton
class ChangePasswordUsecase extends Usecase {
  final UserRepository _userRepository;

  const ChangePasswordUsecase(this._userRepository);

  Future<bool> run({
    String? oldPassword,
    String? newPassword,
  }) =>
      _userRepository.changePassword(
        newPassword: newPassword,
        oldPassword: oldPassword,
      );
}
