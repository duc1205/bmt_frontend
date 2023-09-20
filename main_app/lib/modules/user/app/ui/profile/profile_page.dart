import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
// import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:main_app/gen/assets.gen.dart';
import 'package:main_app/injector.dart';
import 'package:main_app/modules/user/app/ui/profile/profile_page_view_model.dart';
import 'package:main_app/modules/user/app/ui/widget/user_info_widget.dart';
import 'package:suga_core/suga_core.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends BaseViewState<ProfilePage, ProfilePageViewModel> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange.withOpacity(0.15),
      appBar: AppBar(
        title: Text(
          "Profile".toUpperCase(),
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
          Container(
            color: Colors.orange.withOpacity(0.15),
            padding: EdgeInsets.symmetric(vertical: 45.h),
            child: Center(
              child: Assets.resources.images.avatarImage.image(
                width: 120.h,
                height: 120.h,
                fit: BoxFit.contain,
              ),
            ),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.r),
                  topRight: Radius.circular(20.r),
                ),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: 20.h, left: 15.w, top: 15.h),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Information",
                        style: GoogleFonts.libreBaskerville(
                          fontStyle: FontStyle.italic,
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  Obx(
                    () => GestureDetector(
                      onTap: () => viewModel.onChangeNameClick(),
                      behavior: HitTestBehavior.translucent,
                      child: UserInfoWidget(
                        title: "${viewModel.user?.name}",
                        value: Container(),
                        icon: Assets.resources.icons.iconProfile.image(),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: 27.w,
                      right: 27.w,
                      bottom: 20.h,
                    ),
                    child: Divider(
                      color: Colors.grey,
                      height: 1.h,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    behavior: HitTestBehavior.translucent,
                    child: UserInfoWidget(
                      title: "Language",
                      value: const Text("viewModel.language.getName()"),
                      icon: Assets.resources.icons.icLanguage.image(),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: 27.w,
                      right: 27.w,
                      bottom: 20.h,
                    ),
                    child: Divider(
                      color: Colors.grey,
                      height: 1.h,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => viewModel.onlogoutClick(),
                    behavior: HitTestBehavior.translucent,
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 27.w),
                      child: Row(
                        children: [
                          Assets.resources.icons.icLogOut.image(),
                          SizedBox(width: 14.w),
                          Text(
                            "Logout",
                            style: GoogleFonts.libreBaskerville(
                              fontStyle: FontStyle.italic,
                              fontSize: 16.sp,
                              color: Colors.red,
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(top: 10.h),
                            ),
                          ),
                          const Icon(
                            Icons.arrow_forward_ios_rounded,
                            color: Colors.grey,
                            size: 12,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: 27.w,
                      right: 27.w,
                    ),
                    child: Divider(
                      color: Colors.grey,
                      height: 1.h,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  ProfilePageViewModel createViewModel() => injector<ProfilePageViewModel>();
}
