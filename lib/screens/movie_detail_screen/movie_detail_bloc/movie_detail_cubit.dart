import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/screens/movie_detail_screen/movie_detail_bloc/movie_detail_states.dart';
import 'package:http/http.dart' as http;
import '../../../componant/constant.dart';
import '../../../models/movie_details_similar_withArguments/MovieDetailsModel.dart';

class MovieDetailsCubit extends Cubit<MovieDetailsStates>{

  MovieDetailsCubit() : super(MovieDetailInitState());

  static MovieDetailsCubit get(context) => BlocProvider.of(context);

MovieDetailsModel movieDetailsData = MovieDetailsModel();

   Future<void> getMovieDetails (int movieId) async{
    Uri url = Uri.https(BASEURL, '$BASE_DETAILS_ENDPOINT$movieId' , {
      'api_key' : API_KEY,
    },);
    emit(MovieDetailLoadingState());
    http.get(url).then((value){
      var json = jsonDecode(value.body);
      MovieDetailsModel movieDetailsModel = MovieDetailsModel.fromJson(json);
        movieDetailsData = movieDetailsModel;
        emit(MovieDetailLoadingSuccessState());
    }).catchError((onError){
      emit(MovieDetailErrorState(onError));
    });

  }
}