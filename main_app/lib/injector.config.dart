// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:alice/alice.dart' as _i3;
import 'package:event_bus/event_bus.dart' as _i4;
import 'package:flutter/material.dart' as _i12;
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i5;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:logger/logger.dart' as _i7;
import 'package:main_app/core/helpers/loading_helper.dart' as _i6;
import 'package:main_app/injector.dart' as _i36;
import 'package:main_app/modules/auth/app/ui/login/login_page_view_model.dart'
    as _i32;
import 'package:main_app/modules/auth/app/ui/register/register_page_view_model.dart'
    as _i25;
import 'package:main_app/modules/auth/data/datasources/auth_datasource.dart'
    as _i15;
import 'package:main_app/modules/auth/data/repositories/auth_repositories.dart'
    as _i16;
import 'package:main_app/modules/auth/domain/usecases/check_logged_in_usecase.dart'
    as _i20;
import 'package:main_app/modules/auth/domain/usecases/login_usecase.dart'
    as _i21;
import 'package:main_app/modules/auth/domain/usecases/logout_usecase.dart'
    as _i22;
import 'package:main_app/modules/auth/domain/usecases/register_account_usecase.dart'
    as _i24;
import 'package:main_app/modules/boarding/app/ui/splash/splash_page_view_model.dart'
    as _i26;
import 'package:main_app/modules/boarding/data/datasources/boarding_local_datasource.dart'
    as _i17;
import 'package:main_app/modules/boarding/data/repositories/boarding_repository_impl.dart'
    as _i19;
import 'package:main_app/modules/boarding/domain/on_app_run_usecase.dart'
    as _i23;
import 'package:main_app/modules/boarding/domain/repositories/boarding_repository.dart'
    as _i18;
import 'package:main_app/modules/main/main_page_view_model.dart' as _i8;
import 'package:main_app/modules/people/app/ui/people_page_view_model.dart'
    as _i33;
import 'package:main_app/modules/user/app/ui/profile/profile_page_view_model.dart'
    as _i35;
import 'package:main_app/modules/user/data/datasources/services/me_service.dart'
    as _i9;
import 'package:main_app/modules/user/data/datasources/services/public_user_service.dart'
    as _i11;
import 'package:main_app/modules/user/data/datasources/services/user_service.dart'
    as _i14;
import 'package:main_app/modules/user/data/datasources/user_datasource.dart'
    as _i27;
import 'package:main_app/modules/user/data/repositories/user_repository.dart'
    as _i28;
import 'package:main_app/modules/user/domain/usecases/change_password_usecase.dart'
    as _i29;
import 'package:main_app/modules/user/domain/usecases/get_list_users_usecase.dart'
    as _i30;
import 'package:main_app/modules/user/domain/usecases/get_profile_usecase.dart'
    as _i31;
import 'package:main_app/modules/user/domain/usecases/update_profile_usecase.dart'
    as _i34;
import 'package:shared_preferences/shared_preferences.dart' as _i13;
import 'package:suga_core/suga_core.dart' as _i10;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  Future<_i1.GetIt> init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final mainModule = _$MainModule();
    gh.lazySingleton<_i3.Alice>(() => mainModule.getAlice());
    gh.lazySingleton<_i4.EventBus>(() => mainModule.getEventBus());
    gh.lazySingleton<_i5.FlutterSecureStorage>(
        () => mainModule.secureStorage());
    gh.lazySingleton<_i6.LoadingHelper>(() => _i6.LoadingHelper());
    gh.lazySingleton<_i7.Logger>(() => mainModule.getLogger());
    gh.factory<_i8.MainPageViewModel>(() => _i8.MainPageViewModel());
    gh.lazySingleton<_i9.MeService>(() => _i9.MeService());
    gh.lazySingleton<_i10.Oauth2Manager>(
        () => mainModule.getOauth2Manager(gh<_i5.FlutterSecureStorage>()));
    gh.lazySingleton<_i11.PublicUserService>(() => _i11.PublicUserService());
    gh.lazySingleton<_i12.RouteObserver<_i12.Route<dynamic>>>(
        () => mainModule.getRouteObserver());
    await gh.lazySingletonAsync<_i13.SharedPreferences>(
      () => mainModule.getSharePreferences(),
      preResolve: true,
    );
    gh.lazySingleton<_i14.UserService>(() => _i14.UserService());
    gh.lazySingleton<_i15.AuthDatasource>(() => _i15.AuthDatasourceImpl(
          gh<_i10.Oauth2Manager>(),
          gh<_i9.MeService>(),
          gh<_i11.PublicUserService>(),
        ));
    gh.lazySingleton<_i16.AuthRepository>(
        () => _i16.AuthRepository(gh<_i15.AuthDatasource>()));
    gh.lazySingleton<_i17.BoardingLocalDatasource>(
        () => _i17.BoardingLocalDatasource(gh<_i13.SharedPreferences>()));
    gh.lazySingleton<_i18.BoardingRepository>(
        () => _i19.BoardingRepositoryImpl(gh<_i17.BoardingLocalDatasource>()));
    gh.lazySingleton<_i20.CheckLoggedInUsecase>(
        () => _i20.CheckLoggedInUsecase(gh<_i16.AuthRepository>()));
    gh.lazySingleton<_i10.HttpClientWrapper>(
        () => mainModule.getHttpClientWrapper(
              gh<_i10.Oauth2Manager>(),
              gh<_i5.FlutterSecureStorage>(),
              gh<_i3.Alice>(),
            ));
    gh.lazySingleton<_i21.LoginUsecase>(
        () => _i21.LoginUsecase(gh<_i16.AuthRepository>()));
    gh.lazySingleton<_i22.LogoutUsecase>(() => _i22.LogoutUsecase(
          gh<_i16.AuthRepository>(),
          gh<_i5.FlutterSecureStorage>(),
        ));
    gh.lazySingleton<_i23.OnAppRunUsecase>(() => _i23.OnAppRunUsecase(
          gh<_i18.BoardingRepository>(),
          gh<_i5.FlutterSecureStorage>(),
        ));
    gh.lazySingleton<_i24.RegisterAccountUsecase>(
        () => _i24.RegisterAccountUsecase(gh<_i16.AuthRepository>()));
    gh.factory<_i25.RegisterPageViewModel>(
        () => _i25.RegisterPageViewModel(gh<_i24.RegisterAccountUsecase>()));
    gh.factory<_i26.SplashPageViewModel>(
        () => _i26.SplashPageViewModel(gh<_i20.CheckLoggedInUsecase>()));
    gh.lazySingleton<_i27.UserDatasource>(() => _i27.UserDataSourceImpl(
          gh<_i9.MeService>(),
          gh<_i14.UserService>(),
        ));
    gh.lazySingleton<_i28.UserRepository>(
        () => _i28.UserRepository(gh<_i27.UserDatasource>()));
    gh.lazySingleton<_i29.ChangePasswordUsecase>(
        () => _i29.ChangePasswordUsecase(gh<_i28.UserRepository>()));
    gh.lazySingleton<_i30.GetListUsersUsecase>(
        () => _i30.GetListUsersUsecase(gh<_i28.UserRepository>()));
    gh.lazySingleton<_i31.GetProfileUsecase>(
        () => _i31.GetProfileUsecase(gh<_i28.UserRepository>()));
    gh.factory<_i32.LoginPageViewModel>(
        () => _i32.LoginPageViewModel(gh<_i21.LoginUsecase>()));
    gh.factory<_i33.PeoplePageViewModel>(
        () => _i33.PeoplePageViewModel(gh<_i30.GetListUsersUsecase>()));
    gh.lazySingleton<_i34.UpdateProfileUsecase>(() => _i34.UpdateProfileUsecase(
          gh<_i28.UserRepository>(),
          gh<_i4.EventBus>(),
        ));
    gh.factory<_i35.ProfilePageViewModel>(() => _i35.ProfilePageViewModel(
          gh<_i31.GetProfileUsecase>(),
          gh<_i22.LogoutUsecase>(),
          gh<_i34.UpdateProfileUsecase>(),
        ));
    return this;
  }
}

class _$MainModule extends _i36.MainModule {}
