import 'package:injectable/injectable.dart';
import 'package:main_app/core/helpers/list_params.dart';
import 'package:main_app/modules/user/data/repositories/user_repository.dart';
import 'package:main_app/modules/user/domain/models/user.dart';
import 'package:suga_core/suga_core.dart';

@lazySingleton
class GetListUsersUsecase extends Usecase {
  final UserRepository _userRepository;

  const GetListUsersUsecase(this._userRepository);

  Future<List<User>> run({
    ListParams? listParams,
    String? search,
  }) =>
      _userRepository.getListUsers(
        listParams: listParams,
        search: search,
      );
}
