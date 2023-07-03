abstract class BrowseScreenStates {}

class BrowseScreenInitState extends BrowseScreenStates {}

class BrowseScreenLoadingState extends BrowseScreenStates {}

class BrowseScreenLoadingSuccessState extends BrowseScreenStates {}

class BrowseScreenLoadingErrorState extends BrowseScreenStates {
  String error;
  BrowseScreenLoadingErrorState(this.error);
}