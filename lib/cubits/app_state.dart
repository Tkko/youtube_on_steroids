part of 'app_cubit.dart';

@immutable
abstract class AppState {}

class AppStateInitial extends AppState {}

class AppStateLoading extends AppState {}

class AppStateLoaded extends AppState {
  AppStateLoaded();
}

class AppStateFailed extends AppState {
  final String message;

  AppStateFailed(this.message);
}
