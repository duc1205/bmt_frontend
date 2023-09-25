// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:alice/alice.dart' as _i3;
import 'package:event_bus/event_bus.dart' as _i5;
import 'package:flutter/material.dart' as _i13;
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i6;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:logger/logger.dart' as _i8;
import 'package:main_app/core/helpers/loading_helper.dart' as _i7;
import 'package:main_app/injector.dart' as _i44;
import 'package:main_app/modules/auth/app/ui/login/login_page_view_model.dart'
    as _i40;
import 'package:main_app/modules/auth/app/ui/register/register_page_view_model.dart'
    as _i31;
import 'package:main_app/modules/auth/data/datasources/auth_datasource.dart'
    as _i16;
import 'package:main_app/modules/auth/data/repositories/auth_repositories.dart'
    as _i17;
import 'package:main_app/modules/auth/domain/usecases/check_logged_in_usecase.dart'
    as _i21;
import 'package:main_app/modules/auth/domain/usecases/login_usecase.dart'
    as _i27;
import 'package:main_app/modules/auth/domain/usecases/logout_usecase.dart'
    as _i28;
import 'package:main_app/modules/auth/domain/usecases/register_account_usecase.dart'
    as _i30;
import 'package:main_app/modules/boarding/app/ui/splash/splash_page_view_model.dart'
    as _i32;
import 'package:main_app/modules/boarding/data/datasources/boarding_local_datasource.dart'
    as _i18;
import 'package:main_app/modules/boarding/data/repositories/boarding_repository_impl.dart'
    as _i20;
import 'package:main_app/modules/boarding/domain/on_app_run_usecase.dart'
    as _i29;
import 'package:main_app/modules/boarding/domain/repositories/boarding_repository.dart'
    as _i19;
import 'package:main_app/modules/groups/app/ui/club_page_view_model.dart'
    as _i37;
import 'package:main_app/modules/groups/data/datasources/club_datasource.dart'
    as _i22;
import 'package:main_app/modules/groups/data/datasources/services/club_service.dart'
    as _i4;
import 'package:main_app/modules/groups/data/repositories/club_repository.dart'
    as _i23;
import 'package:main_app/modules/groups/domain/usecases/create_club_usecase.dart'
    as _i24;
import 'package:main_app/modules/groups/domain/usecases/delete_club_usecase.dart'
    as _i25;
import 'package:main_app/modules/groups/domain/usecases/get_list_clubs_usecase.dart'
    as _i26;
import 'package:main_app/modules/groups/domain/usecases/update_club_usecase.dart'
    as _i33;
import 'package:main_app/modules/main/main_page_view_model.dart' as _i9;
import 'package:main_app/modules/people/app/ui/people_page_view_model.dart'
    as _i41;
import 'package:main_app/modules/user/app/ui/profile/profile_page_view_model.dart'
    as _i43;
import 'package:main_app/modules/user/data/datasources/services/me_service.dart'
    as _i10;
import 'package:main_app/modules/user/data/datasources/services/public_user_service.dart'
    as _i12;
import 'package:main_app/modules/user/data/datasources/services/user_service.dart'
    as _i15;
import 'package:main_app/modules/user/data/datasources/user_datasource.dart'
    as _i34;
import 'package:main_app/modules/user/data/repositories/user_repository.dart'
    as _i35;
import 'package:main_app/modules/user/domain/usecases/change_password_usecase.dart'
    as _i36;
import 'package:main_app/modules/user/domain/usecases/get_list_users_usecase.dart'
    as _i38;
import 'package:main_app/modules/user/domain/usecases/get_profile_usecase.dart'
    as _i39;
import 'package:main_app/modules/user/domain/usecases/update_profile_usecase.dart'
    as _i42;
import 'package:shared_preferences/shared_preferences.dart' as _i14;
import 'package:suga_core/suga_core.dart' as _i11;

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
    gh.lazySingleton<_i4.ClubService>(() => _i4.ClubService());
    gh.lazySingleton<_i5.EventBus>(() => mainModule.getEventBus());
    gh.lazySingleton<_i6.FlutterSecureStorage>(
        () => mainModule.secureStorage());
    gh.lazySingleton<_i7.LoadingHelper>(() => _i7.LoadingHelper());
    gh.lazySingleton<_i8.Logger>(() => mainModule.getLogger());
    gh.factory<_i9.MainPageViewModel>(() => _i9.MainPageViewModel());
    gh.lazySingleton<_i10.MeService>(() => _i10.MeService());
    gh.lazySingleton<_i11.Oauth2Manager>(
        () => mainModule.getOauth2Manager(gh<_i6.FlutterSecureStorage>()));
    gh.lazySingleton<_i12.PublicUserService>(() => _i12.PublicUserService());
    gh.lazySingleton<_i13.RouteObserver<_i13.Route<dynamic>>>(
        () => mainModule.getRouteObserver());
    await gh.lazySingletonAsync<_i14.SharedPreferences>(
      () => mainModule.getSharePreferences(),
      preResolve: true,
    );
    gh.lazySingleton<_i15.UserService>(() => _i15.UserService());
    gh.lazySingleton<_i16.AuthDatasource>(() => _i16.AuthDatasourceImpl(
          gh<_i11.Oauth2Manager>(),
          gh<_i10.MeService>(),
          gh<_i12.PublicUserService>(),
        ));
    gh.lazySingleton<_i17.AuthRepository>(
        () => _i17.AuthRepository(gh<_i16.AuthDatasource>()));
    gh.lazySingleton<_i18.BoardingLocalDatasource>(
        () => _i18.BoardingLocalDatasource(gh<_i14.SharedPreferences>()));
    gh.lazySingleton<_i19.BoardingRepository>(
        () => _i20.BoardingRepositoryImpl(gh<_i18.BoardingLocalDatasource>()));
    gh.lazySingleton<_i21.CheckLoggedInUsecase>(
        () => _i21.CheckLoggedInUsecase(gh<_i17.AuthRepository>()));
    gh.lazySingleton<_i22.ClubDatasource>(
        () => _i22.ClubDataSourceImpl(gh<_i4.ClubService>()));
    gh.lazySingleton<_i23.ClubRepository>(
        () => _i23.ClubRepository(gh<_i22.ClubDatasource>()));
    gh.lazySingleton<_i24.CreateClubUsecase>(
        () => _i24.CreateClubUsecase(gh<_i23.ClubRepository>()));
    gh.lazySingleton<_i25.DeleteClubUsecase>(
        () => _i25.DeleteClubUsecase(gh<_i23.ClubRepository>()));
    gh.lazySingleton<_i26.GetListClubsUsecase>(
        () => _i26.GetListClubsUsecase(gh<_i23.ClubRepository>()));
    gh.lazySingleton<_i11.HttpClientWrapper>(
        () => mainModule.getHttpClientWrapper(
              gh<_i11.Oauth2Manager>(),
              gh<_i6.FlutterSecureStorage>(),
              gh<_i3.Alice>(),
            ));
    gh.lazySingleton<_i27.LoginUsecase>(
        () => _i27.LoginUsecase(gh<_i17.AuthRepository>()));
    gh.lazySingleton<_i28.LogoutUsecase>(() => _i28.LogoutUsecase(
          gh<_i17.AuthRepository>(),
          gh<_i6.FlutterSecureStorage>(),
        ));
    gh.lazySingleton<_i29.OnAppRunUsecase>(() => _i29.OnAppRunUsecase(
          gh<_i19.BoardingRepository>(),
          gh<_i6.FlutterSecureStorage>(),
        ));
    gh.lazySingleton<_i30.RegisterAccountUsecase>(
        () => _i30.RegisterAccountUsecase(gh<_i17.AuthRepository>()));
    gh.factory<_i31.RegisterPageViewModel>(
        () => _i31.RegisterPageViewModel(gh<_i30.RegisterAccountUsecase>()));
    gh.factory<_i32.SplashPageViewModel>(
        () => _i32.SplashPageViewModel(gh<_i21.CheckLoggedInUsecase>()));
    gh.lazySingleton<_i33.UpdateProfileUsecase>(() => _i33.UpdateProfileUsecase(
          gh<_i23.ClubRepository>(),
          gh<_i5.EventBus>(),
        ));
    gh.lazySingleton<_i34.UserDatasource>(() => _i34.UserDataSourceImpl(
          gh<_i10.MeService>(),
          gh<_i15.UserService>(),
        ));
    gh.lazySingleton<_i35.UserRepository>(
        () => _i35.UserRepository(gh<_i34.UserDatasource>()));
    gh.lazySingleton<_i36.ChangePasswordUsecase>(
        () => _i36.ChangePasswordUsecase(gh<_i35.UserRepository>()));
    gh.factory<_i37.ClubPageViewModel>(() => _i37.ClubPageViewModel(
          gh<_i24.CreateClubUsecase>(),
          gh<_i26.GetListClubsUsecase>(),
        ));
    gh.lazySingleton<_i38.GetListUsersUsecase>(
        () => _i38.GetListUsersUsecase(gh<_i35.UserRepository>()));
    gh.lazySingleton<_i39.GetProfileUsecase>(
        () => _i39.GetProfileUsecase(gh<_i35.UserRepository>()));
    gh.factory<_i40.LoginPageViewModel>(
        () => _i40.LoginPageViewModel(gh<_i27.LoginUsecase>()));
    gh.factory<_i41.PeoplePageViewModel>(
        () => _i41.PeoplePageViewModel(gh<_i38.GetListUsersUsecase>()));
    gh.lazySingleton<_i42.UpdateProfileUsecase>(() => _i42.UpdateProfileUsecase(
          gh<_i35.UserRepository>(),
          gh<_i5.EventBus>(),
        ));
    gh.factory<_i43.ProfilePageViewModel>(() => _i43.ProfilePageViewModel(
          gh<_i39.GetProfileUsecase>(),
          gh<_i28.LogoutUsecase>(),
          gh<_i42.UpdateProfileUsecase>(),
        ));
    return this;
  }
}

class _$MainModule extends _i44.MainModule {}
