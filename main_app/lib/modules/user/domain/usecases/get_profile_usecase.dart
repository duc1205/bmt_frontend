import 'package:injectable/injectable.dart';
import 'package:main_app/modules/user/data/repositories/user_repository.dart';
import 'package:main_app/modules/user/domain/models/user.dart';
import 'package:suga_core/suga_core.dart';

@lazySingleton
class GetProfileUsecase extends Usecase {
  final UserRepository _userRepository;

  const GetProfileUsecase(this._userRepository);

  Future<User> run() => _userRepository.get();
}
