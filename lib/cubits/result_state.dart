part of 'result_cubit.dart';

@immutable
abstract class ResultState {}

class ResultStateInitial extends ResultState {
  ResultStateInitial();
}

class ResultStateLoading extends ResultState {}

class ResultStateLoaded extends ResultState {
  ResultStateLoaded();
}

class ResultStateFailed extends ResultState {
  ResultStateFailed();
}
