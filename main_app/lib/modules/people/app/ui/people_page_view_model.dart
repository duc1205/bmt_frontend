import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:injectable/injectable.dart';
import 'package:main_app/core/abstracts/app_view_model.dart';
import 'package:main_app/core/helpers/list_params.dart';
import 'package:main_app/modules/user/domain/models/user.dart';
import 'package:main_app/modules/user/domain/usecases/get_list_users_usecase.dart';
import 'package:suga_core/suga_core.dart';

@injectable
class PeoplePageViewModel extends AppViewModel {
  final GetListUsersUsecase _getListUsersUsecase;

  PeoplePageViewModel(this._getListUsersUsecase);

  final _listUser = RxList<User>([]);
  List<User> get listUser => _listUser.toList();

  final _canLoadMore = Rx<bool>(false);
  bool get canLoadMore => _canLoadMore.value;

  final _isCanClearSearch = false.obs;
  bool get isCanClearSearch => _isCanClearSearch.value;

  int _page = 1;

  final searchTextController = TextEditingController();
  final FocusNode focusNode = FocusNode();

  @override
  void initState() {
    getListUser();
    searchTextController.addListener(() => _isCanClearSearch.value = searchTextController.text.trim().isNotEmpty);
    super.initState();
  }

  @override
  void disposeState() {
    searchTextController.dispose();
    super.disposeState();
  }

  Future<Unit> getListUser() async {
    final query = searchTextController.text.isNotEmpty ? searchTextController.text : null;
    await run(() async {
      final listUser = await _getListUsersUsecase.run(
        listParams: ListParams(),
        search: query,
      );
      fetchedListUser(listUser);
    });
    return unit;
  }

  void fetchedListUser(List<User> fetchedListUser) {
    if (_page == 1) {
      _listUser.assignAll(fetchedListUser);
    } else {
      _listUser.addAll(fetchedListUser);
    }
    if (fetchedListUser.isNotEmpty) {
      _page++;
    }
    _canLoadMore.value = fetchedListUser.isNotEmpty;
  }

  void onRefresh() {
    _canLoadMore.value = false;
    _page = 1;
    getListUser();
  }

  void onClearSearch() {
    searchTextController.clear();
    onRefresh();
  }
}
