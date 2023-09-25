import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:main_app/gen/assets.gen.dart';
import 'package:main_app/modules/groups/app/detail/club_detail_page.dart';
import 'package:main_app/modules/groups/domain/models/club.dart';

class ItemClubWidget extends StatefulWidget {
  final double? customHeight;
  final bool? useBlueBackground;
  final Club club;

  const ItemClubWidget({
    required this.club,
    this.useBlueBackground,
    this.customHeight,
    Key? key,
  }) : super(key: key);

  @override
  State<ItemClubWidget> createState() => _ItemClubWidgetState();
}

class _ItemClubWidgetState extends State<ItemClubWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.to(
        () => ClubDetailPage(
          club: widget.club,
        ),
      ),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.all(
              Radius.circular(12.r),
            ),
            child: Container(
              width: 343.w,
              height: 175.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(12.r),
                ),
                border: Border.all(color: Colors.grey, width: 1.w),
                color: widget.useBlueBackground != null && widget.useBlueBackground! ? Colors.grey : Colors.white,
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12.r),
                topRight: Radius.circular(12.r),
              ),
            ),
            padding: const EdgeInsets.all(1),
            width: 343.w,
            height: 113.h,
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12.r),
                topRight: Radius.circular(12.r),
              ),
              child: SizedBox(
                child: widget.club.avatarUrl != null
                    ? Image.network(
                        widget.club.avatarUrl!,
                        fit: BoxFit.cover,
                      )
                    : Assets.resources.images.image.image(
                        fit: BoxFit.cover,
                      ),
              ),
            ),
          ),
          Positioned(
            top: 103.h,
            left: 13.w,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  padding: const EdgeInsets.all(2),
                  width: 64.w,
                  height: 64.h,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.greenAccent,
                        Colors.lightGreenAccent,
                      ],
                      stops: [0.1, 0.9],
                    ),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(width: 2.w, color: Colors.white),
                    ),
                    width: 56.w,
                    height: 56.h,
                    child: widget.club.avatarUrl != null
                        ? CircleAvatar(
                            backgroundImage: NetworkImage(
                              widget.club.avatarUrl!,
                            ),
                          )
                        : Assets.resources.images.image.image(),
                  ),
                ),
                SizedBox(width: 14.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 250.w,
                      child: Text(
                        widget.club.name,
                        style: GoogleFonts.libreBaskerville(
                          fontStyle: FontStyle.normal,
                          fontSize: 16.sp,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    RichText(
                      text: TextSpan(
                        children: <TextSpan>[
                          TextSpan(
                            text: "0",
                            style: GoogleFonts.libreBaskerville(
                              fontStyle: FontStyle.normal,
                              fontSize: 14.sp,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          TextSpan(
                            text: '/10',
                            style: GoogleFonts.libreBaskerville(
                              fontStyle: FontStyle.normal,
                              fontSize: 14.sp,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
