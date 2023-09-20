import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:injectable/injectable.dart';
import 'package:main_app/core/abstracts/app_view_model.dart';
import 'package:main_app/core/extensions/context_ext.dart';
import 'package:main_app/core/helpers/format_helper.dart';
import 'package:main_app/core/helpers/toast_helper.dart';
import 'package:main_app/modules/auth/app/ui/login/login_page.dart';
import 'package:main_app/modules/auth/domain/usecases/register_account_usecase.dart';
import 'package:suga_core/suga_core.dart';

@injectable
class RegisterPageViewModel extends AppViewModel {
  final RegisterAccountUsecase _registerAccountUsecase;

  RegisterPageViewModel(this._registerAccountUsecase);

  final phoneController = TextEditingController();
  final nameController = TextEditingController();
  final passwordController = TextEditingController();

  Future<Unit> registerUser() async {
    if (!validateForm()) {
      return unit;
    }

    Get.context?.hideKeyboard();
    await showLoading();
    final phoneWithCountryCode = FormatHelper.formatPhone(phoneController.text.trim());

    final success = await run(
      () async {
        await _registerAccountUsecase.run(
          phoneWithCountryCode,
          nameController.text,
          passwordController.text,
        );
      },
      shouldHandleError: true,
    );

    if (success) {
      await hideLoading();
      showToast("Successful account registration");
      Get.offAll(() => const LoginPage(), duration: const Duration(milliseconds: 2));
    }

    return unit;
  }

  bool validateForm() {
    if (phoneController.text.trim().isEmpty) {
      showToast("Vui lòng nhập số điện thoại");
      return false;
    }
    if (nameController.text.trim().isEmpty) {
      showToast("Vui lòng nhập tên");
      return false;
    }
    if (passwordController.text.isEmpty) {
      showToast("Vui lòng nhập mật khẩu");
      return false;
    }
    return true;
  }

  @override
  Future<Unit> handleError(dynamic error) async {
    if (error is HttpError) {
      // print("~~~~~~~~~~~ $error");
      final data = error.response?.data as Map<String, dynamic>;
      final errorCode = data["error_code"];
      switch (errorCode) {
        case 3:
        default:
          showToast(data["error_message"].toString());
          break;
      }
    }
    return unit;
  }
}
