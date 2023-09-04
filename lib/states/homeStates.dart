// ignore_for_file: file_names

import 'package:shopapp/models/loginModel.dart';

abstract class HomeStates {}

class HomeIntialState extends HomeStates {}

class HomeLoadingState extends HomeStates {}

class HomeSuccessState extends HomeStates {}

class HomeErrorState extends HomeStates {}

// ----------      -------------------
class CategorySuccessState extends HomeStates {}

class CategoryErrorState extends HomeStates {}

// ----------      -------------------
class ChangeFavoriteSuccessState extends HomeStates {}

class ChangeFavoriteErrorState extends HomeStates {}

class GetFavoriteSuccessState extends HomeStates {}

class GetFavoriteLoadingState extends HomeStates {}

class GetFavoriteErrorState extends HomeStates {}

// ----------      -------------------

class GetUserDataLoadingState extends HomeStates {}

class GetUserDataSuccessState extends HomeStates {
  final ShopLoginModel loginModel;
  GetUserDataSuccessState(this.loginModel);
}

class GetUserDataErrorState extends HomeStates {}

// ----------      -------------------

class UpdateProfileLoadingState extends HomeStates {}

class UpdateProfileSuccessState extends HomeStates {
  final ShopLoginModel loginModel;
  UpdateProfileSuccessState(this.loginModel);
}

class UpdateProfileErrorState extends HomeStates {}
