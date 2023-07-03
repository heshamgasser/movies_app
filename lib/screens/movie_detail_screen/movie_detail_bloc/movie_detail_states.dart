abstract class MovieDetailsStates {}

class MovieDetailInitState extends MovieDetailsStates{}
class MovieDetailLoadingState extends MovieDetailsStates{}
class MovieDetailLoadingSuccessState extends MovieDetailsStates{}



class MovieDetailErrorState extends MovieDetailsStates{
  String error;

  MovieDetailErrorState(this.error);
}