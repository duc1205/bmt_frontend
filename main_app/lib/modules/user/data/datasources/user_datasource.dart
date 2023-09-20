import 'package:injectable/injectable.dart';
import 'package:main_app/core/helpers/list_params.dart';
import 'package:main_app/modules/user/data/datasources/services/me_service.dart';
import 'package:main_app/modules/user/data/datasources/services/user_service.dart';
import 'package:main_app/modules/user/domain/models/user.dart';

abstract class UserDatasource {
  Future<User> get();

  Future<User> update({
    String? fullName,
    String? avatarPath,
  });

  Future<bool> changePassword({
    String? oldPassword,
    String? newPassword,
  });

  Future<bool> delete();

  Future<List<User>> getListUsers({
    ListParams? listParams,
    String? search,
  });
}

@LazySingleton(as: UserDatasource)
class UserDataSourceImpl implements UserDatasource {
  final MeService _meService;
  final UserService _userService;

  UserDataSourceImpl(
    this._meService,
    this._userService,
  );

  @override
  Future<User> get() => _meService.get();

  @override
  Future<User> update({
    String? fullName,
    String? avatarPath,
  }) async {
    return _meService.update({
      'name': fullName,
      'avatar_path': avatarPath,
    });
  }

  @override
  Future<bool> delete() => _meService.delete();

  @override
  Future<bool> changePassword({
    String? oldPassword,
    String? newPassword,
  }) async {
    return _meService.changePassword({
      "old_password": oldPassword,
      "new_password": newPassword,
    });
  }

  @override
  Future<List<User>> getListUsers({
    ListParams? listParams,
    String? search,
  }) {
    return _userService.getListUsers(
      page: listParams?.paginationParams?.page,
      limit: listParams?.paginationParams?.limit,
      sort: listParams?.sortParams?.attribute,
      dir: listParams?.sortParams?.direction,
      search: search,
    );
  }
}
