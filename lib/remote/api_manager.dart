import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movies_app/componant/constant.dart';
import 'package:movies_app/models/browse_screen_model/CategoryModel.dart';
import 'package:movies_app/models/home_screen_model/ComingSoonModel.dart';
import 'package:movies_app/models/home_screen_model/PopularMoviesModel.dart';
import 'package:movies_app/models/SearchByCategoryModel.dart';
import 'package:movies_app/models/SimilarMoviesModel.dart';
import 'package:movies_app/models/home_screen_model/TopRatedMoviesModel.dart';
import '../models/movie_details_similar_withArguments/MovieDetailsModel.dart';



class ApiManager {

// static Future<PopularMoviesResponse> getPopularMovies () async{
//   Uri url = Uri.https(BASEURL, BASE_POPULAR_ENDPOINT, {
//     'api_key' : API_KEY,
//   },);
//   http.Response popularResponse = await http.get(url);
//  var json =  jsonDecode(popularResponse.body);
//  PopularMoviesResponse popularMoviesModel =  PopularMoviesResponse.fromJson(json);
//  return popularMoviesModel;
// }



// static Future<TopRatedMoviesModel> getTopRatedMovies () async{
//   Uri url = Uri.https(BASEURL,BASE_TOPRATED_ENDPOINT, {
//     'api_key' : API_KEY,
//   },);
//   http.Response response = await http.get(url);
//   var json = jsonDecode(response.body);
//   TopRatedMoviesModel topRatedMoviesModel = TopRatedMoviesModel.fromJson(json);
//   return topRatedMoviesModel;
// }


// static Future<ComingSoonResponse> getComingSoonMovies () async{
//   Uri url = Uri.https(BASEURL, BASE_COMINGSOON_ENDPOINT, {
//     'api_key' : API_KEY,
//   },);
//
//   http.Response response = await http.get(url);
//
//   var json = jsonDecode(response.body);
//
//   ComingSoonResponse comingSoonModel = ComingSoonResponse.fromJson(json);
//
//   return comingSoonModel;
// }

static Future<MovieDetailsModel> getMovieDetails (int movieId) async{
  Uri url = Uri.https(BASEURL, '$BASE_DETAILS_ENDPOINT$movieId' , {
    'api_key' : API_KEY,
  },);
  http.Response response = await http.get(url);
  var json = jsonDecode(response.body);
  MovieDetailsModel movieDetailsModel = MovieDetailsModel.fromJson(json);
  return movieDetailsModel;
}

static Future<SimilarMoviesModel> getSimilarMovies (int movieId) async{
  Uri url = Uri.https(BASEURL, '$BASE_DETAILS_ENDPOINT$movieId$SIMILAR' , {
    'api_key' : API_KEY,
  },);

  http.Response response = await http.get(url);
  var json = jsonDecode(response.body);

  SimilarMoviesModel similarMoviesModel = SimilarMoviesModel.fromJson(json);
  return similarMoviesModel;
}

static Future<CategoryModel> getMoviesCategory () async{
  Uri url = Uri.https(BASEURL, BASE_CATEGORY_ENDPOINT , {
    'api_key' : API_KEY,
  },);

  http.Response response = await http.get(url);
  var json = jsonDecode(response.body);

  CategoryModel categoryModel = CategoryModel.fromJson(json);
  return categoryModel;
}

static Future<SearchByCategoryModel> getMoviesSearchByCategory (String query) async{
  Uri url = Uri.https(BASEURL, BASE_SEARCH_ENDPOINT , {
    'api_key' : API_KEY,
    'query' : query
  },);

  http.Response response = await http.get(url);
  var json = jsonDecode(response.body);

  SearchByCategoryModel searchByCategoryModel = SearchByCategoryModel.fromJson(json);
  return searchByCategoryModel;
}


}