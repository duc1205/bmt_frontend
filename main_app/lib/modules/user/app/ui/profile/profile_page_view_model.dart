import 'dart:async';

import 'package:event_bus/event_bus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:injectable/injectable.dart';
import 'package:main_app/core/abstracts/app_view_model.dart';
import 'package:main_app/core/helpers/toast_helper.dart';
import 'package:main_app/core/ui/alert_dialog_widget.dart';
import 'package:main_app/injector.dart';
import 'package:main_app/modules/auth/app/ui/login/login_page.dart';
import 'package:main_app/modules/auth/domain/usecases/logout_usecase.dart';
import 'package:main_app/modules/user/domain/events/user_profile_changed_event.dart';
import 'package:main_app/modules/user/domain/models/user.dart';
import 'package:main_app/modules/user/domain/usecases/get_profile_usecase.dart';
import 'package:main_app/modules/user/domain/usecases/update_profile_usecase.dart';
import 'package:suga_core/suga_core.dart';

@injectable
class ProfilePageViewModel extends AppViewModel {
  final GetProfileUsecase _getProfileUsecase;
  final UpdateProfileUsecase _updateProfileUsecase;
  final LogoutUsecase _logoutUsecase;

  ProfilePageViewModel(
    this._getProfileUsecase,
    this._logoutUsecase,
    this._updateProfileUsecase,
  );

  final _user = Rx<User?>(null);
  User? get user => _user.value;

  String newName = '';
  final TextEditingController _controller = TextEditingController();

  StreamSubscription? _userProfileChanged;

  @override
  void initState() {
    getProfile();
    registerEvent();
    super.initState();
  }

  @override
  void disposeState() {
    _userProfileChanged?.cancel();
    super.disposeState();
  }

  Future<void> onUserInfoChanged(User user) async {
    _user.value = null;
    _user.value = user;
  }

  Future<void> registerEvent() async {
    _userProfileChanged = injector<EventBus>().on<UserProfileChangedEvent>().listen((event) async {
      await onUserInfoChanged(event.user);
    });
  }

  Future<Unit> getProfile() async {
    late User userData;
    final success = await run(() async {
      userData = await _getProfileUsecase.run();
    });

    if (success) {
      _user.value = null;
      _user.value = userData;
    }
    return unit;
  }

  Future<Unit> logout() async {
    final sucess = await run(
      () async => await _logoutUsecase.run(),
    );
    if (sucess) {
      Get.offAll(() => const LoginPage());
    }
    return unit;
  }

  bool checkNameValid(String name) {
    return name.trim().isNotEmpty;
  }

  Future<Unit> changeUserName() async {
    User? userLoaded;
    if (!checkNameValid(newName)) {
      showToast("Vui lòng nhập tên");
      return unit;
    } else {
      await showLoading();
      final isSuccess = await run(
        () async => userLoaded = await _updateProfileUsecase.run(name: newName),
      );
      await hideLoading();
      if (isSuccess) {
        _user.value = userLoaded;
        return unit;
      }
    }
    return unit;
  }

  String getUserName() => user?.name ?? "";

  void onChangeNameClick() {
    _controller.text = getUserName();
    Get.dialog(
      AlertDialogWidget(
        title: "Change name",
        bodyViewDistance: 25.h,
        bodyView: TextField(
          autofocus: true,
          controller: _controller,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
              horizontal: 16.w,
              vertical: 10.h,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                8.r,
              ),
              borderSide: BorderSide(
                color: Colors.black12,
                width: 1.w,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                8.r,
              ),
              borderSide: BorderSide(
                color: Colors.black12,
                width: 1.w,
              ),
            ),
          ),
          textAlign: TextAlign.left,
          style: GoogleFonts.libreBaskerville(
            fontStyle: FontStyle.normal,
            fontSize: 16.sp,
            color: Colors.black,
          ),
        ),
        confirmButton: TextButton(
          style: TextButton.styleFrom(
            padding: EdgeInsets.symmetric(
              vertical: 15.h,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.r),
            ),
            backgroundColor: Colors.yellow,
          ),
          onPressed: () {
            newName = _controller.text;
            changeUserName();
            Get.back();
          },
          child: Text(
            "Save",
            style: GoogleFonts.libreBaskerville(
              fontStyle: FontStyle.normal,
              fontSize: 16.sp,
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        cancelButton: TextButton(
          style: TextButton.styleFrom(
            padding: EdgeInsets.symmetric(
              vertical: 15.h,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.r),
            ),
            backgroundColor: Colors.grey,
          ),
          onPressed: () => Get.back(),
          child: Text(
            "Cancel",
            style: GoogleFonts.libreBaskerville(
              fontStyle: FontStyle.normal,
              fontSize: 16.sp,
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }

  void onlogoutClick() {
    Get.dialog(
      AlertDialogWidget(
        title: "Logout",
        bodyViewDistance: 25.h,
        // bodyView: TextField(
        //   autofocus: true,
        //   controller: _controller,
        //   decoration: InputDecoration(
        //     contentPadding: EdgeInsets.symmetric(
        //       horizontal: 16.w,
        //       vertical: 10.h,
        //     ),
        //     border: OutlineInputBorder(
        //       borderRadius: BorderRadius.circular(
        //         8.r,
        //       ),
        //       borderSide: BorderSide(
        //         color: Colors.black12,
        //         width: 1.w,
        //       ),
        //     ),
        //     focusedBorder: OutlineInputBorder(
        //       borderRadius: BorderRadius.circular(
        //         8.r,
        //       ),
        //       borderSide: BorderSide(
        //         color: Colors.black12,
        //         width: 1.w,
        //       ),
        //     ),
        //   ),
        //   textAlign: TextAlign.left,
        //   style: GoogleFonts.libreBaskerville(
        //     fontStyle: FontStyle.normal,
        //     fontSize: 16.sp,
        //     color: Colors.black,
        //   ),
        // ),
        confirmButton: TextButton(
          style: TextButton.styleFrom(
            padding: EdgeInsets.symmetric(
              vertical: 15.h,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.r),
            ),
            backgroundColor: Colors.yellow,
          ),
          onPressed: () {
            newName = _controller.text;
            logout();
            Get.back();
          },
          child: Text(
            "Yes",
            style: GoogleFonts.libreBaskerville(
              fontStyle: FontStyle.normal,
              fontSize: 16.sp,
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        cancelButton: TextButton(
          style: TextButton.styleFrom(
            padding: EdgeInsets.symmetric(
              vertical: 15.h,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.r),
            ),
            backgroundColor: Colors.grey,
          ),
          onPressed: () => Get.back(),
          child: Text(
            "Cancel",
            style: GoogleFonts.libreBaskerville(
              fontStyle: FontStyle.normal,
              fontSize: 16.sp,
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }
}
