import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:mamanotes/app/data/common/style.dart';
import 'package:mamanotes/app/modules/home/views/home_view.dart';
import 'package:mamanotes/app/modules/kenangan/views/kenangan_view.dart';
import 'package:mamanotes/app/modules/profile/views/profile_view.dart';

import '../../../data/common/custom_bottom_navigation.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  int _currentIndex = 0;

  final _inactiveColor = Colors.grey;
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: getBody(), bottomNavigationBar: buildBottomBar());
  }

  Widget buildBottomBar() {
    return CustomAnimatedBottomBar(
      containerHeight: 70.h,
      backgroundColor: Colors.white,
      selectedIndex: _currentIndex,
      showElevation: true,
      itemCornerRadius: 24.r,
      curve: Curves.easeIn,
      onItemSelected: (index) => setState(() => _currentIndex = index),
      items: <BottomNavyBarItem>[
        BottomNavyBarItem(
            icon: const FaIcon(FontAwesomeIcons.houseChimney),
            title: const Text('Home'),
            activeColor: red,
            inactiveColor: _inactiveColor,
            textAlign: TextAlign.center,
            style: redTextStyle.copyWith(fontWeight: normal)),
        BottomNavyBarItem(
          icon: const FaIcon(FontAwesomeIcons.chartArea),
          title: const Text('Kenanganku'),
          activeColor: red,
          inactiveColor: _inactiveColor,
          textAlign: TextAlign.center,
        ),
        BottomNavyBarItem(
          icon: const FaIcon(FontAwesomeIcons.user),
          title: const Text(
            'Profil ',
          ),
          activeColor: red,
          inactiveColor: _inactiveColor,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget getBody() {
    List<Widget> pages = [
      HomeView(),
      KenanganView(),
      ProfileView(),
    ];
    return IndexedStack(
      index: _currentIndex,
      children: pages,
    );
  }
}
