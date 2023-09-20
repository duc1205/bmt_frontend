import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:main_app/modules/people/app/widget/people_item_widget.dart';
import 'package:main_app/modules/user/domain/models/user.dart';

class ListPeopleWidget extends StatefulWidget {
  final List<User> listUser;

  const ListPeopleWidget({
    super.key,
    required this.listUser,
  });

  @override
  State<ListPeopleWidget> createState() => _ListPeopleWidgetState();
}

class _ListPeopleWidgetState extends State<ListPeopleWidget> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      primary: false,
      itemCount: widget.listUser.length,
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 17.h),
      itemBuilder: (BuildContext context, int index) {
        return Container(
          margin: EdgeInsets.only(bottom: 16.h),
          child: PeopleItemWidget(
            user: widget.listUser[index],
          ),
        );
      },
    );
  }
}
