import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:injectable/injectable.dart';
import 'package:main_app/core/abstracts/app_view_model.dart';
import 'package:main_app/core/extensions/context_ext.dart';
import 'package:main_app/core/helpers/format_helper.dart';
import 'package:main_app/core/helpers/toast_helper.dart';
import 'package:main_app/modules/auth/app/ui/register/register_page.dart';
import 'package:main_app/modules/auth/domain/usecases/login_usecase.dart';
import 'package:main_app/modules/main/main_page.dart';
import 'package:oauth2/oauth2.dart';
import 'package:suga_core/suga_core.dart';

@injectable
class LoginPageViewModel extends AppViewModel {
  final LoginUsecase _loginUsecase;

  LoginPageViewModel(this._loginUsecase);

  final phoneController = TextEditingController();
  final passwordController = TextEditingController();

  final RxString _isMessage = "Error! Username or password are incorrect.".obs;
  String get isMessage => _isMessage.value;

  Future<Unit> onClickLogin() async {
    if (!validateForm()) {
      return unit;
    }

    Get.context?.hideKeyboard();
    await showLoading();

    final phoneWithCountryCode = FormatHelper.formatPhone(phoneController.text.trim());
    final success = await run(
      () async {
        await _loginUsecase.run(phoneWithCountryCode, passwordController.text);
      },
      shouldHandleError: true,
    );

    if (success) {
      await hideLoading();
      phoneController.clear();
      passwordController.clear();
      await Get.offAll(() => const MainPage(), duration: const Duration(seconds: 1));
    }
    return unit;
  }

  bool validateForm() {
    if (phoneController.text.trim().isEmpty) {
      showToast("Vui lòng nhập số điện thoại");
      return false;
    }
    if (passwordController.text.isEmpty) {
      showToast("Vui lòng nhập mật khẩu");
      return false;
    }
    return true;
  }

  void navigatorToRegisterPage() {
    phoneController.clear();
    passwordController.clear();
    Get.to(() => const RegisterPage());
  }

  @override
  Future<Unit> handleError(dynamic error) async {
    if (error is AuthorizationException) {
      print("~~~~~~~~~~~1 $error");
    }
    return unit;
  }
}
