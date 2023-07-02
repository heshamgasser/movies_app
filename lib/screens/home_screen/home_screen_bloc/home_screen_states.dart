abstract class HomeScreenStates {}

class HomeScreenInitState extends HomeScreenStates {}

class HomeScreenPopularLoadingState extends HomeScreenStates{}

class HomeScreenPopularLoadingSuccessState extends HomeScreenStates{}

class HomeScreenPopularChangedState extends HomeScreenStates{}

class HomeScreenPopularLoadingErrorState extends HomeScreenStates{
  String error;
  HomeScreenPopularLoadingErrorState(this.error);
}