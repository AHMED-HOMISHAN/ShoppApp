// ignore_for_file: file_names

abstract class AppSearchStates {}

class AppSearchIntialState extends AppSearchStates {}

class AppSearchLoadingState extends AppSearchStates {}

class AppSearchSuccessState extends AppSearchStates {}

class AppSearchErrorState extends AppSearchStates {
  final String error;
  AppSearchErrorState(this.error);
}
