import 'package:flutter/material.dart';
import 'package:main_app/injector.dart';
import 'package:main_app/modules/groups/app/create/create_team_view_model.dart';
import 'package:suga_core/suga_core.dart';

class CreateTeamDialog extends StatefulWidget {
  final String? description;
  final String? title;

  const CreateTeamDialog({
    Key? key,
    this.description,
    this.title,
  }) : super(key: key);

  @override
  State<CreateTeamDialog> createState() => _CreateTeamDialogState();
}

class _CreateTeamDialogState extends BaseViewState<CreateTeamDialog, CreateClubViewModel> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }

  @override
  CreateClubViewModel createViewModel() => injector<CreateClubViewModel>();
}
