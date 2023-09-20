import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:main_app/injector.dart';
import 'package:main_app/modules/groups/app/ui/club_page.dart';
import 'package:main_app/modules/main/app/ui/home/home_page.dart';
import 'package:main_app/modules/main/app/ui/widget/tab_item_widget.dart';
import 'package:main_app/modules/main/main_page_view_model.dart';
import 'package:main_app/modules/people/app/ui/pepple_page.dart';
import 'package:main_app/modules/user/app/ui/profile/profile_page.dart';
import 'package:suga_core/suga_core.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends BaseViewState<MainPage, MainPageViewModel> with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    viewModel.initTabController(this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: viewModel.pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: const [
          HomePage(),
          PeoplePage(),
          ClubPage(),
          ProfilePage(),
        ],
      ),
      bottomNavigationBar: Material(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Obx(
            () => TabBar(
              labelPadding: EdgeInsets.zero,
              controller: viewModel.tabController,
              labelColor: Colors.orange,
              unselectedLabelColor: Colors.grey,
              indicatorColor: Colors.white,
              physics: const NeverScrollableScrollPhysics(),
              tabs: [
                TabItemWidget(
                  icon: const Icon(Icons.home),
                  selectedIcon: const Icon(
                    Icons.home,
                    color: Colors.orange,
                  ),
                  name: "Home",
                  isSelected: viewModel.isHomeTabSelected,
                ),
                TabItemWidget(
                  icon: const Icon(Icons.diversity_3),
                  selectedIcon: const Icon(
                    Icons.diversity_3,
                    color: Colors.orange,
                  ),
                  name: "List People",
                  isSelected: viewModel.peopleTabIndexSelected,
                ),
                TabItemWidget(
                  icon: const Icon(Icons.person),
                  selectedIcon: const Icon(
                    Icons.person,
                    color: Colors.orange,
                  ),
                  name: "Club",
                  isSelected: viewModel.isClubTabSelected,
                ),
                TabItemWidget(
                  icon: const Icon(Icons.person),
                  selectedIcon: const Icon(
                    Icons.person,
                    color: Colors.orange,
                  ),
                  name: "Profile",
                  isSelected: viewModel.isProfileTabSelected,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  MainPageViewModel createViewModel() => injector<MainPageViewModel>();
}
