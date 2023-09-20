import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:injectable/injectable.dart';
import 'package:main_app/core/abstracts/app_view_model.dart';
import 'package:main_app/core/helpers/list_params.dart';
import 'package:main_app/core/helpers/pagination_params.dart';
import 'package:main_app/core/helpers/sort_params.dart';
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

  final _isLoadingMore = false.obs;
  bool get isLoadingMore => _isLoadingMore.value;

  int _page = 1;
  static const endReachedThreshold = 60;
  ScrollController listPeopleController = ScrollController();

  final FocusNode focusNode = FocusNode();

  @override
  void initState() {
    getListUser();
    listPeopleController.addListener(() {
      _onGridViewScroll();
    });
    super.initState();
  }

  @override
  void disposeState() {
    listPeopleController.dispose();
    super.disposeState();
  }

  Future<Unit> getListUser() async {
    await run(() async {
      final listUser = await _getListUsersUsecase.run(
        listParams: ListParams(
          paginationParams: PaginationParams(
            page: _page,
            limit: 10,
          ),
          sortParams: SortParams(),
        ),
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

  Future<Unit> onRefresh() async {
    _canLoadMore.value = false;
    _page = 1;
    await getListUser();
    return unit;
  }

  Future<Unit> _onGridViewScroll() async {
    if (!listPeopleController.hasClients || !_canLoadMore.value || isLoadingMore) {
      return unit;
    }
    if (listPeopleController.position.extentBefore > listPeopleController.position.maxScrollExtent + endReachedThreshold) {
      return _onLoadMore();
    }
    return unit;
  }

  Future<Unit> _onLoadMore() async {
    _isLoadingMore.value = true;
    if (_canLoadMore.value = true) {
      await getListUser();
    }
    _isLoadingMore.value = false;
    return unit;
  }
}
