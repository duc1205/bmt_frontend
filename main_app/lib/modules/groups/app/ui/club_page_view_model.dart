import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:injectable/injectable.dart';
import 'package:main_app/core/abstracts/app_view_model.dart';
import 'package:main_app/core/helpers/list_params.dart';
import 'package:main_app/core/helpers/pagination_params.dart';
import 'package:main_app/core/helpers/sort_params.dart';
import 'package:main_app/modules/groups/domain/models/club.dart';
import 'package:main_app/modules/groups/domain/usecases/create_club_usecase.dart';
import 'package:main_app/modules/groups/domain/usecases/get_list_clubs_usecase.dart';
import 'package:suga_core/suga_core.dart';

@injectable
class ClubPageViewModel extends AppViewModel {
  final CreateClubUsecase _createClubUsecase;
  final GetListClubsUsecase _getListClubsUsecase;

  ClubPageViewModel(this._createClubUsecase, this._getListClubsUsecase);

  final _listClub = RxList<Club>([]);
  List<Club> get listClub => _listClub.toList();

  final _canLoadMore = Rx<bool>(false);
  bool get canLoadMore => _canLoadMore.value;

  final _isLoadingMore = false.obs;
  bool get isLoadingMore => _isLoadingMore.value;

  final _reachStartSnap = Rx<bool>(true);
  bool get reachStartSnap => _reachStartSnap.value;

  int _page = 1;
  bool _reachedStart = true;
  static const endReachedThreshold = 60;
  ScrollController listClubsController = ScrollController();

  @override
  void initState() {
    getListClub();
    listClubsController.addListener(() {
      _onGridViewScroll();
    });
    super.initState();
  }

  Future<Unit> getListClub() async {
    await run(() async {
      final listClub = await _getListClubsUsecase.run(
        listParams: ListParams(
          paginationParams: PaginationParams(
            page: _page,
            limit: 10,
          ),
          sortParams: SortParams(),
        ),
      );
      fetchedListClub(listClub);
    });
    return unit;
  }

  void fetchedListClub(List<Club> fetchedListClub) {
    if (_page == 1) {
      _listClub.assignAll(fetchedListClub);
    } else {
      _listClub.addAll(fetchedListClub);
    }
    if (fetchedListClub.isNotEmpty) {
      _page++;
    }
    _canLoadMore.value = fetchedListClub.isNotEmpty;
  }

  Future<Unit> onRefresh() async {
    _canLoadMore.value = false;
    _page = 1;
    await getListClub();
    return unit;
  }

  Future<Unit> _onGridViewScroll() async {
    if (!listClubsController.hasClients || !_canLoadMore.value || isLoadingMore) {
      return unit;
    }
    if (listClubsController.position.extentBefore > listClubsController.position.maxScrollExtent + endReachedThreshold) {
      return _onLoadMore();
    }
    _reachedStart = listClubsController.position.extentBefore == 0;
    if (_reachedStart != reachStartSnap) {
      _reachStartSnap.value = _reachedStart;
    }
    return unit;
  }

  Future<Unit> _onLoadMore() async {
    _isLoadingMore.value = true;
    if (_canLoadMore.value = true) {
      await getListClub();
    }
    _isLoadingMore.value = false;
    return unit;
  }
}
