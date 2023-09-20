import 'dart:async';

import 'package:get/get.dart';
import 'package:injectable/injectable.dart';
import 'package:main_app/core/abstracts/app_view_model.dart';
import 'package:main_app/modules/auth/app/ui/login/login_page.dart';
import 'package:main_app/modules/auth/domain/usecases/check_logged_in_usecase.dart';
// import 'package:main_app/modules/boarding/domain/on_app_run_usecase.dart';
import 'package:main_app/modules/main/main_page.dart';
import 'package:suga_core/suga_core.dart';

@injectable
class SplashPageViewModel extends AppViewModel {
  final CheckLoggedInUsecase _checkLoggedInUsecase;
  // final OnAppRunUsecase _onAppRunUsecase;

  SplashPageViewModel(
    this._checkLoggedInUsecase,
    // this._onAppRunUsecase,
  );

  final loadingValue = Rx<double>(0);

  @override
  void initState() {
    _loadingProgress();
    _loadData();
    super.initState();
  }

  Future<Unit> _loadData() async {
    await Future.delayed(const Duration(seconds: 2));
    Get.to(() => const LoginPage());
    // await _onAppRun();
    await _checkAuth();
    return unit;
  }

  // Future<Unit> _onAppRun() async {
  //   await run(
  //     () => _onAppRunUsecase.run(),
  //   );
  //   return unit;
  // }

  Future<Unit> _checkAuth() async {
    late bool isLoggedIn;
    final success = await run(
      () async {
        isLoggedIn = await _checkLoggedInUsecase.run();
      },
    );
    if (success) {
      if (isLoggedIn) {
        await Get.offAll(() => const MainPage(), duration: Duration.zero);
      } else {
        await Get.offAll(() => const LoginPage());
      }
    }

    return unit;
  }

  void _loadingProgress() {
    Timer.periodic(const Duration(milliseconds: 500), (timer) {
      loadingValue.value += 0.25;
      if (loadingValue.value == 1) {
        timer.cancel();
      }
    });
  }
}
