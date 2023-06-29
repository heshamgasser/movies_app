import 'package:flutter/material.dart';
import 'package:movies_app/provider/home_provider.dart';
import 'package:movies_app/styles/app_color.dart';
import 'package:provider/provider.dart';

class HomeLayout extends StatelessWidget {
  static const String routeName = 'Home Layout';



  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HomeProvider(),
      builder: (context, child) {
        var homeProvider = Provider.of<HomeProvider>(context);
        return SafeArea(
          child: Scaffold(
            backgroundColor: backgroundColor,
            bottomNavigationBar: BottomNavigationBar(
              showUnselectedLabels: true,
              iconSize: 30,
              unselectedItemColor: Colors.grey,
              selectedItemColor: Color(0xFFFFBB3B),
              type: BottomNavigationBarType.shifting,
                currentIndex: homeProvider.selectedIndex,
                onTap: (value) {
                  homeProvider.changeSelectedIndex(value);
                },
              items: homeProvider.bottomItems,
            ),

            body: homeProvider.screensWidget[homeProvider.selectedIndex],
          ),
        );
      },

    );
  }
}
