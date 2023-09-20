import 'package:main_app/core/helpers/pagination_params.dart';
import 'package:main_app/core/helpers/sort_params.dart';

class ListParams {
  final PaginationParams? paginationParams;
  final SortParams? sortParams;

  ListParams({
    this.paginationParams,
    this.sortParams,
  });
}
