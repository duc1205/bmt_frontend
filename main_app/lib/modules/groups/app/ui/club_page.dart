import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:main_app/injector.dart';
import 'package:main_app/modules/groups/app/create/create_team_dialog.dart';
import 'package:main_app/modules/groups/app/ui/club_page_view_model.dart';
import 'package:main_app/modules/groups/app/widget/list_club_widget.dart';
import 'package:suga_core/suga_core.dart';

class ClubPage extends StatefulWidget {
  const ClubPage({super.key});

  @override
  State<ClubPage> createState() => _ClubPageState();
}

class _ClubPageState extends BaseViewState<ClubPage, ClubPageViewModel> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber.withOpacity(0.15),
      appBar: AppBar(
        title: Text(
          "Club".toUpperCase(),
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
      body: Column(
        children: [
          Obx(
            () => SizedBox(
              height: (ScreenUtil.defaultSize.height - 64).h,
              child: ListClubWidget(
                onRefresh: viewModel.onRefresh,
                scrollController: viewModel.listClubsController,
                listClub: viewModel.listClub,
                isLoadingMore: viewModel.isLoadingMore,
                showScrollShadow: viewModel.reachStartSnap,
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: Padding(
        padding: EdgeInsets.all(15.sp),
        child: FloatingActionButton(
          backgroundColor: Colors.green.withOpacity(0.875),
          onPressed: () {},
          child: const Icon(
            Icons.add,
            size: 36,
          ),
        ),
      ),
    );
  }

  @override
  ClubPageViewModel createViewModel() => injector<ClubPageViewModel>();
}
