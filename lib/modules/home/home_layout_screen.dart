import 'package:evently_app/core/constant/app_strings.dart';
import 'package:evently_app/core/gen/assets.gen.dart';
import 'package:evently_app/core/l10n/app_localizations.dart';
import 'package:evently_app/modules/home/favourite/favourite_screen.dart';
import 'package:evently_app/modules/home/home_screen/home_screen.dart';
import 'package:evently_app/modules/home/profile/profile_screen.dart';
import 'package:flutter/material.dart';

class HomeLayoutScreen extends StatefulWidget {
  const HomeLayoutScreen({super.key});

  @override
  State<HomeLayoutScreen> createState() => _HomeLayoutScreenState();
}

class _HomeLayoutScreenState extends State<HomeLayoutScreen> {
  int selectedIndex = 0;
  List<Widget> screenList = [HomeScreen(), FavouriteScreen(), ProfileScreen()];

  @override
  Widget build(BuildContext context) {
    final appLocalizations =AppLocalizations.of(context)!;
    return Scaffold(
      body: screenList[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index){
          selectedIndex = index;
          setState(() {

          });
        },
        currentIndex: selectedIndex,
        items: [
          BottomNavigationBarItem(
            label: appLocalizations.home,
            activeIcon: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Assets.icons.homeActiveIcn.svg(width: 24, height: 24),
            ),
            icon: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Assets.icons.homeInActiveIcn.svg(width: 24, height: 24),
            ),
          ),
          BottomNavigationBarItem(
            label: appLocalizations.favourite,
            activeIcon: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Assets.icons.heartActiveIcn.svg(width: 24, height: 24),
            ),
            icon: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Assets.icons.heartInActiveIcn.svg(width: 24, height: 24),
            ),
          ),
          BottomNavigationBarItem(
            label: appLocalizations.profile,
            activeIcon: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Assets.icons.userActiveIcn.svg(width: 24, height: 24),
            ),
            icon: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Assets.icons.userIcn.svg(width: 24, height: 24),
            ),
          ),
        ],
      ),
    );
  }
}
