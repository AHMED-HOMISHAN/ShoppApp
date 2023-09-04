// ignore_for_file: file_names

import 'package:shopapp/models/loginModel.dart';

// ----------------- Login ---------------------//

abstract class AppLoginStates {}

class AppLoginIntialState extends AppLoginStates {}

class AppLoginLoadingState extends AppLoginStates {}

class AppLoginSuccessState extends AppLoginStates {
  final ShopLoginModel loginModel;

  AppLoginSuccessState(this.loginModel);
}

class AppLoginErrorState extends AppLoginStates {
  final String error;
  AppLoginErrorState(this.error);
}

class AppChangePasswordVisbilityState extends AppLoginStates {}
