import 'package:injectable/injectable.dart';
import 'package:main_app/modules/user/data/datasources/services/me_service.dart';
import 'package:main_app/modules/user/data/datasources/services/public_user_service.dart';
import 'package:oauth2/oauth2.dart';
import 'package:suga_core/suga_core.dart';

abstract class AuthDatasource {
  Future<Credentials> login(String username, String password);

  Future<bool> isLoggedIn();

  Future<Unit> logOut();

  Future<Unit> registerAccount(String sdt, String name, String password);
}

@LazySingleton(as: AuthDatasource)
class AuthDatasourceImpl extends AuthDatasource {
  final Oauth2Manager _oauth2manager;
  final MeService _meService;
  final PublicUserService _publicUserService;

  AuthDatasourceImpl(
    this._oauth2manager,
    this._meService,
    this._publicUserService,
  );

  @override
  Future<bool> isLoggedIn() => _oauth2manager.isLoggedIn();

  @override
  Future<Credentials> login(String username, String password) => _oauth2manager.login(username: username, password: password);

  @override
  Future<Unit> logOut() async {
    await _meService.logout();
    return unit;
  }

  @override
  Future<Unit> registerAccount(
    String sdt,
    String name,
    String password,
  ) async {
    final Map<String, dynamic> data = {
      "phone_number": sdt,
      "password": password,
      "name": name,
    };
    await _publicUserService.registerAccount(data);
    return unit;
  }
}
