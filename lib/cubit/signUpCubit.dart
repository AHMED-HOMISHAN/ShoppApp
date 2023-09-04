// ignore_for_file: file_names, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:shopapp/models/LoginModel.dart';
import 'package:shopapp/network/API/endPoints.dart';
import 'package:shopapp/network/API/API.dart';
import 'package:shopapp/states/signUpStates.dart';

class AppSignUpCubit extends Cubit<AppSignUpStates> {
  AppSignUpCubit() : super(AppSignUpIntialState());
  static AppSignUpCubit get(context) => BlocProvider.of(context);
  late ShopLoginModel SignUpModel;
  void userSignUp({
    required String name,
    required String phone,
    required String email,
    required String password,
  }) {
    emit(AppSignUpLoadingState());

    DioHelper.postData(url: SIGNUP, data: {
      'name': name,
      'email': email,
      'phone': phone,
      'password': password,
    }).then((value) {
      SignUpModel = ShopLoginModel.fromJson(value.data);

      emit(AppSignUpSuccessState(SignUpModel));
    }).catchError((error) {
      emit(AppSignUpErrorState(error.toString()));
    });
  }

  IconData suffixIcon = IconlyBroken.show;
  bool isPassword = false;

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffixIcon = isPassword ? IconlyBroken.show : IconlyBroken.hide;
    emit(AppChangePasswordVisbilityState());
  }
}
