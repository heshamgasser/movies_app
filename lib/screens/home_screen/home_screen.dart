import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/screens/home_screen/home_screen_bloc/home_screen_states.dart';
import 'package:movies_app/screens/home_screen/widgets/coming_soon_widget/coming_soon_movies.dart';
import 'package:movies_app/screens/home_screen/widgets/popular_widget/popular_widget.dart';
import 'package:movies_app/screens/home_screen/widgets/top_rated_widget.dart';

import 'home_screen_bloc/home_screen_cubit.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return



      // ListView(
      //             children: [
      //              PopularMoviesWidget(),
      //               SizedBox(height: 80.h),
      //               ComingSoonMovies(),
      //               SizedBox(height: 20.h),
      //               TopRatedWidget(),
      //               // SizedBox(height: 5.h)
      //             ],
      //           );




      BlocProvider(
      create: (context) => HomeScreenCubit()..getPopularMovies(),
      child: BlocConsumer<HomeScreenCubit, HomeScreenStates>(
        listener: (context, state) {
          if (state is HomeScreenPopularLoadingState) {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                content: Center(child: CircularProgressIndicator()),
              ),
            );
          } else if (state is HomeScreenPopularLoadingSuccessState) {
          } else if (state is HomeScreenPopularChangedState) {
          } else if (state is HomeScreenPopularLoadingErrorState) {
            showDialog(
              context: context,
              builder: (context) =>
                  AlertDialog(title: Text('Error'), content: Text(state.error)),
            );
          }
        },
        builder: (context, state) {
          return ListView(
            children: [
              PopularMoviesWidget(),
              SizedBox(height: 80.h),
              ComingSoonMovies(),
              SizedBox(height: 20.h),
              TopRatedWidget(),
              // SizedBox(height: 5.h)
            ],
          );
        },
      ),
    );





    // ChangeNotifierProvider(
    //   create: (context) => HomeProvider(),
    //   builder: (context, child) {
    //     var homeProvider = Provider.of<HomeProvider>(context);
    //     return FutureBuilder(
    //       future: ApiManager.getPopularMovies(),
    //       builder: (context, snapshot) {
    //         if (snapshot.connectionState == ConnectionState.waiting) {
    //           return Center(
    //             child: CircularProgressIndicator(),
    //           );
    //         }
    //
    //         if (snapshot.hasError) {
    //           return Column(
    //             children: [
    //               Text('Error'),
    //             ],
    //           );
    //         }
    //           List<Results> result = snapshot.data?.results ?? [];
    //         return ListView(
    //           children: [
    //             PopularMoviesWidget(
    //               popular: result,
    //             ),
    //             SizedBox(height: 80.h),
    //             ComingSoonMovies(),
    //             SizedBox(height: 20.h),
    //             TopRatedWidget(),
    //             // SizedBox(height: 5.h)
    //           ],
    //         );
    //       },
    //     );
    //   },
    // );
  }
}
