import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:movies_app/screens/home_screen/home_screen_bloc/home_screen_states.dart';

import '../../../../../componant/constant.dart';
import '../../../../../models/home_screen_model/PopularMoviesModel.dart';

class PopularCubit extends Cubit<HomeScreenStates>{

  PopularCubit() : super(HomeScreenInitState());

static  PopularCubit get(context) => BlocProvider.of(context);

  int selectedMovie = 0;
  void changeSelectedMovie (int index){
    selectedMovie = index;
    emit(HomeScreenPopularChangedState());
  }



  List<Results> popularResults = [];

  Future<void> getPopularMovies () async{
    Uri url = Uri.https(BASEURL, BASE_POPULAR_ENDPOINT, {
      'api_key' : API_KEY,
    },);
    emit(HomeScreenPopularLoadingState());
    await http.get(url). then((value){
      var json =  jsonDecode(value.body);
      PopularMoviesResponse popularMoviesResponse =  PopularMoviesResponse.fromJson(json);
      popularResults = popularMoviesResponse.results ?? [];
      emit(HomeScreenPopularLoadingSuccessState());
    }).catchError((onError){
      emit(HomeScreenPopularLoadingErrorState(onError));
    });

  }

}