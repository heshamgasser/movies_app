abstract class ComingSoonStates {}

class ComingSoonInitState extends ComingSoonStates {}

class ComingSoonLoadingState extends ComingSoonStates{}

class ComingSoonLoadingSuccessState extends ComingSoonStates{}

class ComingSoonChangedState extends ComingSoonStates{}

class ComingSoonLoadingErrorState extends ComingSoonStates{
  String error;
  ComingSoonLoadingErrorState(this.error);
}