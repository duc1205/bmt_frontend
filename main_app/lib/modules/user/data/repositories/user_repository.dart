import 'package:injectable/injectable.dart';
import 'package:main_app/core/helpers/list_params.dart';
import 'package:main_app/modules/user/data/datasources/user_datasource.dart';
import 'package:main_app/modules/user/domain/models/user.dart';
import 'package:suga_core/suga_core.dart';

@lazySingleton
class UserRepository extends Repository {
  final UserDatasource _userDatasource;

  const UserRepository(this._userDatasource);

  Future<User> get() => _userDatasource.get();

  Future<User> update({
    String? fullName,
    String? avatarPath,
  }) =>
      _userDatasource.update(
        fullName: fullName,
        avatarPath: avatarPath,
      );

  Future<bool> deleteAccount() => _userDatasource.delete();

  Future<bool> changePassword({
    String? oldPassword,
    String? newPassword,
  }) =>
      _userDatasource.changePassword(
        oldPassword: oldPassword,
        newPassword: newPassword,
      );

  Future<List<User>> getListUsers({
    ListParams? listParams,
    String? search,
  }) =>
      _userDatasource.getListUsers(
        listParams: listParams,
        search: search,
      );
}
