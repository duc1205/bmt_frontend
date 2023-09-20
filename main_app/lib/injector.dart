import 'package:alice/alice.dart';
import 'package:dio/dio.dart';
import 'package:event_bus/event_bus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:main_app/configs/app_config.dart';
import 'package:main_app/configs/backend_config.dart';
import 'package:main_app/injector.config.dart';
import 'package:main_app/modules/auth/app/ui/login/login_page.dart';
import 'package:oauth2/oauth2.dart' as auth;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:suga_core/suga_core.dart';

final injector = GetIt.instance;

@injectableInit
Future<Unit> setupInjector() async {
  await injector.init(environment: Environment.dev);
  return unit;
}

@module
abstract class MainModule {
  @lazySingleton
  @preResolve
  Future<SharedPreferences> getSharePreferences() async => SharedPreferences.getInstance();

  @lazySingleton
  FlutterSecureStorage secureStorage() => const FlutterSecureStorage();

  @lazySingleton
  Logger getLogger() => Logger();

  @lazySingleton
  RouteObserver<Route> getRouteObserver() => RouteObserver();

  @lazySingleton
  EventBus getEventBus() => EventBus();

  @lazySingleton
  Oauth2Manager getOauth2Manager(
    FlutterSecureStorage secureStorage,
  ) =>
      Oauth2Manager(
        endpoint: Uri.parse("${BackendConfig.baseUrl}/auth/login"),
        credentialsStorage: Oauth2CredentialsSecureStorage(secureStorage, 'oauth2_credentials'),
        secret: BackendConfig.oauth2ClientSecret,
        identifier: BackendConfig.oauth2ClientId,
        grantOwnerPassword: (
          Uri endpoint,
          String identifier,
          String secret,
          bool basicAuth,
          String username,
          String password,
          Iterable<String>? scopes,
        ) =>
            auth.resourceOwnerPasswordGrant(
          endpoint,
          username,
          password,
          identifier: identifier,
          secret: secret,
          basicAuth: basicAuth,
        ),
      );

  @lazySingleton
  HttpClientWrapper getHttpClientWrapper(
    Oauth2Manager oauth2Manager,
    FlutterSecureStorage secureStorage,
    Alice alice,
  ) =>
      HttpClientWrapper(
        options: BaseOptions(
          baseUrl: BackendConfig.baseUrl,
          connectTimeout: BackendConfig.connectTimeout,
          receiveTimeout: BackendConfig.receiveTimeout,
        ),
        oauth2Manager: oauth2Manager,
        verbose: AppConfig.logLevel == Level.verbose,
        unauthorizedResponseHandler: ({HttpError? httpError}) async {
          if (Get.isDialogOpen == true) {
            Get.back();
          }
          await secureStorage.deleteAll();
          await Get.offAll(() => const LoginPage());
        },
        extraInterceptors: [
          if (AppConfig.aliceEnabled) alice.getDioInterceptor(),
        ],
      );

  @lazySingleton
  Alice getAlice() => Alice(
        showNotification: false,
        showInspectorOnShake: true,
        navigatorKey: Get.key,
      );
}
