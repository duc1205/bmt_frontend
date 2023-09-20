import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:main_app/core/extensions/string_ext.dart';
import 'package:main_app/modules/user/domain/models/user.dart';

class PeopleItemWidget extends StatelessWidget {
  final User user;
  const PeopleItemWidget({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          width: 50.h,
          height: 50.h,
          decoration: BoxDecoration(
            border: Border.all(width: 1.w, color: Colors.black),
            borderRadius: const BorderRadius.all(Radius.circular(50)),
            // color: Colors.white,
          ),
          child: Center(
            child: user.avatarUrl != null
                ? CircleAvatar(
                    child: Text(
                      user.name.initials(),
                      style: GoogleFonts.libreBaskerville(
                        fontStyle: FontStyle.normal,
                        fontSize: 24.sp,
                        color: Colors.black,
                      ),
                    ),
                  )
                : CircleAvatar(
                    backgroundImage: NetworkImage(user.name.shortNameAvatar()),
                  ),
          ),
        ),
        SizedBox(width: 10.w),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              user.name,
              style: GoogleFonts.libreBaskerville(
                fontStyle: FontStyle.normal,
                fontSize: 20.sp,
                color: Colors.black,
              ),
            ),
            Text(
              user.phoneNumber,
              style: GoogleFonts.libreBaskerville(
                fontStyle: FontStyle.normal,
                fontSize: 16.sp,
                color: Colors.black,
              ),
            ),
          ],
        )
      ],
    );
  }
}
