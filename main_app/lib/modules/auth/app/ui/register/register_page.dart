import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:main_app/injector.dart';
import 'package:main_app/modules/auth/app/ui/register/register_page_view_model.dart';
import 'package:suga_core/suga_core.dart';
import 'package:tap_debouncer/tap_debouncer.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends BaseViewState<RegisterPage, RegisterPageViewModel> {
  @override
  Widget build(BuildContext context) {
    OutlineInputBorder inputBorder() {
      return OutlineInputBorder(
        borderRadius: BorderRadius.circular(15.r),
        borderSide: BorderSide(color: Colors.black, width: 1.w),
      );
    }

    return Scaffold(
        backgroundColor: Colors.amber.withOpacity(0.15),
        appBar: AppBar(
          title: Text(
            "Đăng ký tài khoản",
            style: GoogleFonts.libreBaskerville(
              fontStyle: FontStyle.italic,
              fontSize: 24.sp,
              color: Colors.white,
              fontWeight: FontWeight.w400,
            ),
          ),
          backgroundColor: Colors.orange,
          automaticallyImplyLeading: false,
          centerTitle: true,
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: GestureDetector(
            onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 35.h),
                  Text(
                    'Số điện thoại (*)',
                    style: GoogleFonts.libreBaskerville(
                      fontStyle: FontStyle.italic,
                      fontSize: 16.sp,
                    ),
                  ),
                  SizedBox(height: 5.h),
                  SizedBox(
                    height: 50.h,
                    child: TextField(
                      scrollPadding: EdgeInsets.only(bottom: 120.h),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 16.w,
                          vertical: 13.h,
                        ),
                        isDense: true,
                        enabledBorder: inputBorder(),
                        focusedBorder: inputBorder(),
                      ),
                      textAlign: TextAlign.left,
                      keyboardType: TextInputType.phone,
                      controller: viewModel.phoneController,
                    ),
                  ),
                  SizedBox(height: 25.h),
                  Text(
                    'Tên (*)',
                    style: GoogleFonts.libreBaskerville(
                      fontStyle: FontStyle.italic,
                      fontSize: 16.sp,
                    ),
                  ),
                  SizedBox(height: 5.h),
                  SizedBox(
                    height: 50.h,
                    child: TextField(
                      scrollPadding: EdgeInsets.only(bottom: 120.h),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 16.w,
                          vertical: 13.h,
                        ),
                        isDense: true,
                        enabledBorder: inputBorder(),
                        focusedBorder: inputBorder(),
                      ),
                      textAlign: TextAlign.left,
                      keyboardType: TextInputType.text,
                      controller: viewModel.nameController,
                    ),
                  ),
                  SizedBox(height: 25.h),
                  Text(
                    'Mật khẩu (*)',
                    style: GoogleFonts.libreBaskerville(
                      fontStyle: FontStyle.italic,
                      fontSize: 16.sp,
                    ),
                  ),
                  SizedBox(height: 5.h),
                  SizedBox(
                    height: 50.h,
                    child: TextField(
                      scrollPadding: EdgeInsets.only(bottom: 120.h),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 16.w,
                          vertical: 13.h,
                        ),
                        isDense: true,
                        enabledBorder: inputBorder(),
                        focusedBorder: inputBorder(),
                      ),
                      textAlign: TextAlign.left,
                      keyboardType: TextInputType.text,
                      controller: viewModel.passwordController,
                    ),
                  ),
                  SizedBox(height: 25.h),
                  TapDebouncer(
                    onTap: () => viewModel.registerUser(),
                    builder: (context, onTap) => TextButton(
                      onPressed: onTap,
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                          vertical: 15.h,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.r),
                        ),
                        backgroundColor: Colors.blueAccent,
                        minimumSize: Size(double.infinity, 50.h),
                      ),
                      child: Text(
                        "Đăng ký",
                        style: GoogleFonts.libreBaskerville(
                          fontStyle: FontStyle.italic,
                          fontSize: 16.sp,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  @override
  RegisterPageViewModel createViewModel() => injector<RegisterPageViewModel>();
}
