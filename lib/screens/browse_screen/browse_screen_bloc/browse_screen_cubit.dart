import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/screens/browse_screen/browse_screen_bloc/browse_screen_state.dart';
import 'package:http/http.dart' as http;

import '../../../componant/constant.dart';
import '../../../models/browse_screen_model/CategoryModel.dart';

class BrowseScreenCubit extends Cubit<BrowseScreenStates>{

  BrowseScreenCubit() : super(BrowseScreenInitState());

  static BrowseScreenCubit get(context) => BlocProvider.of(context);


  List<Genres> genresList = [];

   Future<void> getMoviesCategory () async{
    Uri url = Uri.https(BASEURL, BASE_CATEGORY_ENDPOINT , {
      'api_key' : API_KEY,
    },);
    emit(BrowseScreenLoadingState());
    http.get(url).then((value){
      var json = jsonDecode(value.body);
      CategoryModel categoryModel = CategoryModel.fromJson(json);
     genresList = categoryModel.genres ?? [];
     emit(BrowseScreenLoadingSuccessState());
    }).catchError((onError){
      emit(BrowseScreenLoadingErrorState(onError));
    });

  }

}