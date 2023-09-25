import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:injectable/injectable.dart';
import 'package:main_app/core/abstracts/app_view_model.dart';
import 'package:main_app/core/helpers/toast_helper.dart';
import 'package:main_app/modules/groups/domain/usecases/create_club_usecase.dart';
import 'package:suga_core/suga_core.dart';

@injectable
class CreateClubViewModel extends AppViewModel {
  final CreateClubUsecase _createClubUsecase;

  CreateClubViewModel(
    this._createClubUsecase,
  );

  final nameController = TextEditingController();
  final descriptionController = TextEditingController();

  Future<Unit> onSaveTeamButton() async {
    final String? errorValidate = isTeamInfoValid(nameController.text, descriptionController.text);
    if (errorValidate != null) {
      showToast(errorValidate);
      return unit;
    }

    await showLoading();
    final result = await run(
      () => _createClubUsecase.run(
        nameController.text,
        descriptionController.text,
      ),
      shouldHandleError: false,
    );
    await hideLoading();
    if (result) {
      Get.back();
      showToast("Create club success");
    } else {
      showToast("Create club fail");
    }

    return unit;
  }
}

String? isTeamInfoValid(String name, String description) {
  String? errorMessage;
  if (name.isBlank == true) {
    errorMessage = "LocaleKeys.please_input_team_name_isblank.trans()";
  } else if (name.isBlank == false && name.length > 50) {
    errorMessage = "LocaleKeys.please_input_team_name__not_isblank.trans()";
  }
  if (description.isBlank == true) {
    errorMessage = "LocaleKeys.please_input_team_description_isblank.trans()";
  }
  return errorMessage;
}
