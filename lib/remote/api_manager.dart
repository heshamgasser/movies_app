import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movies_app/componant/constant.dart';
import 'package:movies_app/models/ComingSoonModel.dart';
import 'package:movies_app/models/MovieDetailsModel.dart';
import 'package:movies_app/models/NewReleaseMovies.dart';

import 'package:movies_app/models/PopularMoviesModel.dart';
import 'package:movies_app/models/SimilarMoviesModel.dart';
import 'package:movies_app/models/TopRatedMoviesModel.dart';



class ApiManager {

static Future<PopularMoviesModel> getPopularMovies () async{
  Uri url = Uri.https(BASEURL, BASE_POPULAR_ENDPOINT, {
    'api_key' : API_KEY,
  },);
  http.Response popularResponse = await http.get(url);
 var json =  jsonDecode(popularResponse.body);
 PopularMoviesModel popularMoviesModel =  PopularMoviesModel.fromJson(json);
 return popularMoviesModel;
}

static Future<NewReleaseMovies> getNewReleaseMovies () async{
  Uri url = Uri.https(BASEURL, BASE_LATEST_ENDPOINT, {
    'api_key' : API_KEY,
  },);

  http.Response releaseResponse = await http.get(url);

  var json = jsonDecode(releaseResponse.body);
  NewReleaseMovies newReleaseMovies = NewReleaseMovies.fromJson(json);
  return newReleaseMovies;
}


static Future<TopRatedMoviesModel> getTopRatedMovies () async{
  Uri url = Uri.https(BASEURL,BASE_TOPRATED_ENDPOINT, {
    'api_key' : API_KEY,
  },);
  http.Response response = await http.get(url);
  var json = jsonDecode(response.body);
  TopRatedMoviesModel topRatedMoviesModel = TopRatedMoviesModel.fromJson(json);
  return topRatedMoviesModel;
}


static Future<ComingSoonModel> getComingSoonMovies () async{
  Uri url = Uri.https(BASEURL, BASE_COMINGSOON_ENDPOINT, {
    'api_key' : API_KEY,
  },);

  http.Response response = await http.get(url);

  var json = jsonDecode(response.body);

  ComingSoonModel comingSoonModel = ComingSoonModel.fromJson(json);

  return comingSoonModel;
}

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
}