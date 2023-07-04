abstract class HomeScreenStates {}

class HomeScreenInitState extends HomeScreenStates{}

class PopularInitState extends HomeScreenStates {}

class PopularLoadingState extends HomeScreenStates{}

class PopularLoadingSuccessState extends HomeScreenStates{}

class PopularChangedState extends HomeScreenStates{}

class PopularWatchlistChangedState extends HomeScreenStates{}

class PopularLoadingErrorState extends HomeScreenStates{
  String error;
  PopularLoadingErrorState(this.error);
}

class ComingSoonInitState extends HomeScreenStates {}

class ComingSoonLoadingState extends HomeScreenStates{}

class ComingSoonLoadingSuccessState extends HomeScreenStates{}

class ComingSoonChangedState extends HomeScreenStates{}

class ComingSoonLoadingErrorState extends HomeScreenStates{
  String error;
  ComingSoonLoadingErrorState(this.error);
}

class TopRatedInitState extends HomeScreenStates {}

class TopRatedLoadingState extends HomeScreenStates{}

class TopRatedLoadingSuccessState extends HomeScreenStates{}

class TopRatedChangedState extends HomeScreenStates{}

class TopRatedLoadingErrorState extends HomeScreenStates{
  String error;
  TopRatedLoadingErrorState(this.error);
}