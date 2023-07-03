import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/home_layout/home_layout_bloc/home_layout_states.dart';
import 'package:movies_app/screens/home_screen/home_screen_bloc/home_screen_cubit.dart';
import 'package:movies_app/screens/home_screen/home_screen_bloc/home_screen_states.dart';
import 'package:movies_app/screens/home_screen/widgets/coming_soon_movies.dart';
import 'package:movies_app/screens/home_screen/widgets/popular_widget.dart';
import 'package:movies_app/screens/home_screen/widgets/top_rated_widget.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context) => HomeScreenCubit()..getPopularMovies()..getComingSoonMovies()..getTopRatedMovies(),
    child: BlocConsumer<HomeScreenCubit, HomeScreenStates>(
      listener: (context, state) {
        if (state is PopularLoadingState || state is ComingSoonLoadingState ||state is TopRatedLoadingState){
          showDialog(context: context, builder: (context) {
            return AlertDialog(
              title: Text('Loading'),
              content:  Center(child: CircularProgressIndicator(),),
            );
          },);
        }
      },
      builder: (context, state) {
        return ListView(
          children: [
            HomeScreenCubit.get(context).popularResults.isEmpty ? Center(child: CircularProgressIndicator(),) : PopularMoviesWidget(),
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
