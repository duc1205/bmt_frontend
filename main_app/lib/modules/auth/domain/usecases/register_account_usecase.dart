import 'package:injectable/injectable.dart';
import 'package:main_app/modules/auth/data/repositories/auth_repositories.dart';
import 'package:suga_core/suga_core.dart';

@lazySingleton
class RegisterAccountUsecase extends Usecase {
  final AuthRepository _authRepository;

  const RegisterAccountUsecase(this._authRepository);

  Future<Unit> run(String sdt, String name, String password) async {
    await _authRepository.register(sdt, name, password);
    return unit;
  }
}
