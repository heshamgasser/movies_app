import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/screens/home_screen/home_screen_bloc/home_screen_states.dart';
import 'package:http/http.dart' as http;
import '../../../componant/constant.dart';
import '../../../models/home_screen_model/ComingSoonModel.dart';
import '../../../models/home_screen_model/PopularMoviesModel.dart';
import '../../../models/home_screen_model/TopRatedMoviesModel.dart';

class HomeScreenCubit extends Cubit<HomeScreenStates>{

  HomeScreenCubit(): super(HomeScreenInitState());

  static HomeScreenCubit get(context) => BlocProvider.of(context);

  int selectedMovie = 0;

  void changeSelectedMovie(int index) {
    selectedMovie = index;
    emit(PopularChangedState());
  }

  List popularResults = [];

  Future<void> getPopularMovies() async {
    Uri url = Uri.https(
      BASEURL,
      BASE_POPULAR_ENDPOINT,
      {
        'api_key': API_KEY,
      },
    );
    emit(PopularLoadingState());
    http.get(url).then((value) {
      var json = jsonDecode(value.body);
      PopularMoviesResponse popularMoviesResponse =
      PopularMoviesResponse.fromJson(json);
      popularResults = popularMoviesResponse.results ?? [];
      emit(PopularLoadingSuccessState());
    }).catchError((onError) {
      emit(PopularLoadingErrorState(onError));
    });
  }

  List comingSoonResult = [];

  Future<void> getComingSoonMovies () async{
    Uri url = Uri.https(BASEURL, BASE_COMINGSOON_ENDPOINT, {
      'api_key' : API_KEY,
    },);
    emit(ComingSoonLoadingState());
    http.get(url).then((value){
      var json = jsonDecode(value.body);
      ComingSoonResponse comingSoonResponse = ComingSoonResponse.fromJson(json);
      comingSoonResult = comingSoonResponse.results ?? [];
      emit(ComingSoonLoadingSuccessState());
    }).catchError((onError){
      emit(ComingSoonLoadingErrorState(onError));
    });


  }

  List topRatedResult = [];

  Future<void> getTopRatedMovies () async{
    Uri url = Uri.https(BASEURL,BASE_TOPRATED_ENDPOINT, {
      'api_key' : API_KEY,
    },);
    emit(TopRatedLoadingState());
    http.get(url).then((value) {
      var json = jsonDecode(value.body);
      TopRatedMoviesModel topRatedMoviesModel = TopRatedMoviesModel.fromJson(json);
      topRatedResult = topRatedMoviesModel.results ?? [];
      emit(TopRatedLoadingSuccessState());
    }).catchError((onError){
      emit(TopRatedLoadingErrorState(onError));
    });

  }


}