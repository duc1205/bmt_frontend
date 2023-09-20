import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class AlertDialogWidget extends StatelessWidget {
  final String? title;
  final VoidCallback? onConfirmButtonClicked;
  final VoidCallback? onCancelButtonClicked;
  final Widget? bodyView;
  final Widget? confirmButton;
  final Widget? cancelButton;
  bool _isHideTitle = false;
  final double bodyViewDistance;

  AlertDialogWidget({
    Key? key,
    this.title,
    this.confirmButton,
    this.cancelButton,
    this.onConfirmButtonClicked,
    this.onCancelButtonClicked,
    this.bodyView,
    this.bodyViewDistance = 48,
  }) : super(key: key);

  void hideTitle() => _isHideTitle = true;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20.r)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 16.h,
            ),
            Padding(
              padding: EdgeInsets.all(16.w),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  if (!_isHideTitle)
                    Column(
                      children: <Widget>[
                        Center(
                          child: Text(
                            title ?? "",
                            style: GoogleFonts.libreBaskerville(
                              fontStyle: FontStyle.normal,
                              fontSize: 20.sp,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 32.h,
                        ),
                      ],
                    )
                  else
                    Container(),
                  bodyView ?? Container(),
                  SizedBox(
                    height: bodyViewDistance,
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: cancelButton ??
                        SizedBox(
                          height: 50.h,
                          child: ElevatedButton(
                            onPressed: () {
                              Get.back();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              elevation: 5,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(20.r),
                                ),
                              ),
                            ),
                            child: Text(
                              "Cancel",
                              style: GoogleFonts.libreBaskerville(
                                fontStyle: FontStyle.normal,
                                fontSize: 14.sp,
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                  ),
                  SizedBox(
                    width: 12.w,
                  ),
                  Expanded(
                    child: confirmButton ??
                        SizedBox(
                          height: 50.h,
                          child: ElevatedButton(
                            onPressed: () {
                              onConfirmButtonClicked?.call();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              elevation: 5,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(20.r),
                                ),
                              ),
                            ),
                            child: Text(
                              "Save",
                              style: GoogleFonts.libreBaskerville(
                                fontStyle: FontStyle.normal,
                                fontSize: 14.sp,
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
