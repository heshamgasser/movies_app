import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../componant/constant.dart';
import '../../../../../models/home_screen_model/ComingSoonModel.dart';
import 'coming_soon_states.dart';
import 'package:http/http.dart' as http;


class ComingSoonCubit extends Cubit<ComingSoonStates>{
  ComingSoonCubit() : super(ComingSoonInitState());

  static ComingSoonCubit get(context)=> BlocProvider.of(context);


  List <Results> comingSoonResult = [];
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
}