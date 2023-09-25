import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:main_app/core/ui/load_more_widget.dart';
import 'package:main_app/modules/groups/app/widget/item_club_widget.dart';
import 'package:main_app/modules/groups/domain/models/club.dart';

class ListClubWidget extends StatefulWidget {
  final List<Club> listClub;
  final Future<void> Function() onRefresh;
  final ScrollController? scrollController;
  final bool? isLoadingMore;
  final bool showScrollShadow;

  const ListClubWidget({
    super.key,
    required this.listClub,
    required this.onRefresh,
    this.scrollController,
    this.isLoadingMore,
    required this.showScrollShadow,
  });

  @override
  State<ListClubWidget> createState() => _ListClubWidgetState();
}

class _ListClubWidgetState extends State<ListClubWidget> {
  @override
  Widget build(BuildContext context) {
    if (widget.listClub.isEmpty) {
      return Container();
    } else {
      return Stack(
        children: [
          RefreshIndicator(
            onRefresh: () => widget.onRefresh(),
            child: Padding(
              padding: EdgeInsets.only(bottom: 20.h),
              child: CustomScrollView(
                controller: widget.scrollController,
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                slivers: <Widget>[
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        if (widget.listClub.isNotEmpty) {
                          final club = widget.listClub[index];
                          return Padding(
                            padding: EdgeInsets.only(top: 20.h),
                            child: ItemClubWidget(
                              club: club,
                            ),
                          );
                        }
                        return null;
                      },
                      childCount: widget.listClub.length,
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: widget.isLoadingMore != null && widget.isLoadingMore! ? const LoadMoreWidget() : Container(),
                  ),
                ],
              ),
            ),
          ),
          AnimatedOpacity(
            opacity: widget.showScrollShadow ? 0 : 1,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOutQuint,
            child: Container(
              height: 10.h,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  stops: const [0.0, 1.0],
                  colors: [
                    Colors.grey.withOpacity(0.0),
                    Colors.blueGrey,
                  ],
                ),
              ),
            ),
          ),
        ],
      );
    }
  }
}
