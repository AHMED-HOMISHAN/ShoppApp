// ignore_for_file: file_names, non_constant_identifier_names

import 'package:shopapp/models/LoginModel.dart';

// ----------------- SignUp ---------------------//

abstract class AppSignUpStates {}

class AppSignUpIntialState extends AppSignUpStates {}

class AppSignUpLoadingState extends AppSignUpStates {}

class AppSignUpSuccessState extends AppSignUpStates {
  final ShopLoginModel SignUpModel;

  AppSignUpSuccessState(this.SignUpModel);
}

class AppSignUpErrorState extends AppSignUpStates {
  final String error;
  AppSignUpErrorState(this.error);
}

class AppChangePasswordVisbilityState extends AppSignUpStates {}
