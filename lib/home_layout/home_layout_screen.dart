import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/home_layout/home_layout_bloc/home_layout_cubit.dart';
import 'package:movies_app/home_layout/home_layout_bloc/home_layout_states.dart';
import 'package:movies_app/provider/home_provider.dart';
import 'package:movies_app/styles/app_color.dart';
import 'package:provider/provider.dart';

class HomeLayout extends StatelessWidget {
  static const String routeName = 'Home Layout';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeLayoutCubit(),
      child: BlocConsumer<HomeLayoutCubit, HomeLayoutStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            backgroundColor: backgroundColor,
            bottomNavigationBar: BottomNavigationBar(
              backgroundColor: backgroundColor,
              showUnselectedLabels: true,
              iconSize: 30,
              unselectedItemColor: Colors.grey,
              selectedItemColor: Color(0xFFFFBB3B),
              type: BottomNavigationBarType.shifting,
              currentIndex: HomeLayoutCubit.get(context).selectedIndex,
              onTap: (value) {
                HomeLayoutCubit.get(context).changeSelectedIndex(value);
              },
              items: HomeLayoutCubit.get(context).bottomItems,
            ),
            body: HomeLayoutCubit.get(context)
                .screensWidget[HomeLayoutCubit.get(context).selectedIndex],
          );
        },
      ),
    );

    //   ChangeNotifierProvider(
    //   create: (context) => HomeProvider(),
    //   builder: (context, child) {
    //     var homeProvider = Provider.of<HomeProvider>(context);
    //     return SafeArea(
    //       child: Scaffold(
    //         backgroundColor: backgroundColor,
    //         bottomNavigationBar: BottomNavigationBar(
    //           backgroundColor: backgroundColor,
    //           showUnselectedLabels: true,
    //           iconSize: 30,
    //           unselectedItemColor: Colors.grey,
    //           selectedItemColor: Color(0xFFFFBB3B),
    //           type: BottomNavigationBarType.shifting,
    //             currentIndex: homeProvider.selectedIndex,
    //             onTap: (value) {
    //               homeProvider.changeSelectedIndex(value);
    //             },
    //           items: homeProvider.bottomItems,
    //         ),
    //
    //         body: homeProvider.screensWidget[homeProvider.selectedIndex],
    //       ),
    //     );
    //   },
    //
    // );
  }
}
