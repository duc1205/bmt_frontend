import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:main_app/core/ui/load_more_widget.dart';
import 'package:main_app/injector.dart';
import 'package:main_app/modules/people/app/ui/people_page_view_model.dart';
import 'package:main_app/modules/people/app/widget/list_people_widget.dart';
import 'package:suga_core/suga_core.dart';

class PeoplePage extends StatefulWidget {
  const PeoplePage({super.key});

  @override
  State<PeoplePage> createState() => _PeoplePageState();
}

class _PeoplePageState extends BaseViewState<PeoplePage, PeoplePageViewModel> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber.withOpacity(0.15),
      appBar: AppBar(
        title: Text(
          "List People".toUpperCase(),
          style: GoogleFonts.libreBaskerville(
            fontStyle: FontStyle.italic,
            fontSize: 24.sp,
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: Colors.orange,
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.sp),
        child: RefreshIndicator(
          onRefresh: () => viewModel.onRefresh(),
          child: CustomScrollView(
            controller: viewModel.listPeopleController,
            physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics(),
            ),
            slivers: [
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    return Obx(
                      () => viewModel.listUser.isNotEmpty ? ListPeopleWidget(listUser: viewModel.listUser) : Container(),
                    );
                  },
                  childCount: 1,
                ),
              ),
              SliverToBoxAdapter(
                child: viewModel.isLoadingMore ? const LoadMoreWidget() : Container(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  PeoplePageViewModel createViewModel() => injector<PeoplePageViewModel>();
}
