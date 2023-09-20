import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:main_app/core/extensions/context_ext.dart';
import 'package:main_app/core/ui/debounce_textfield.dart';
import 'package:main_app/injector.dart';
import 'package:main_app/modules/people/app/ui/people_page_view_model.dart';
import 'package:suga_core/suga_core.dart';
import 'package:tap_debouncer/tap_debouncer.dart';

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
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(15.sp),
          child: Column(
            children: [
              Obx(
                () => DebounceTextfield(
                  action: (text) => viewModel.onRefresh(),
                  controller: viewModel.searchTextController,
                  duration: const Duration(milliseconds: 1000),
                  onTextfieldEmpty: () => viewModel.onRefresh(),
                  textFieldStyle: GoogleFonts.libreBaskerville(
                    fontStyle: FontStyle.italic,
                    fontSize: 14.sp,
                    color: Colors.black,
                  ),
                  focusNode: viewModel.focusNode,
                  inputDecoration: InputDecoration(
                    hintText: "Searching for...",
                    hintStyle: GoogleFonts.libreBaskerville(
                      fontStyle: FontStyle.italic,
                      fontSize: 14.sp,
                      color: Colors.black,
                    ),
                    fillColor: Colors.white,
                    filled: true,
                    isDense: true,
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon: viewModel.isCanClearSearch
                        ? TapDebouncer(
                            onTap: () async {
                              Get.context?.hideKeyboard();
                              viewModel.onClearSearch();
                            },
                            builder: (BuildContext context, TapDebouncerFunc? onTap) => IconButton(
                              onPressed: onTap,
                              icon: Icon(
                                Icons.clear,
                                size: 20.sp,
                                color: Colors.black,
                              ),
                            ),
                          )
                        : const SizedBox(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: viewModel.focusNode.hasFocus
                          ? BorderSide(color: Colors.orange.withOpacity(0.5), width: 1.w)
                          : BorderSide(color: Colors.grey.withOpacity(0.5), width: 1.w),
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.r),
                      borderSide: BorderSide(color: Colors.grey.withOpacity(0.5), width: 1.w),
                    ),
                  ),
                ),
              ),
              Expanded(child: ListView()),
            ],
          ),
        ),
      ),
    );
  }

  @override
  PeoplePageViewModel createViewModel() => injector<PeoplePageViewModel>();
}
