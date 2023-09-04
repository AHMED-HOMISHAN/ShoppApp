// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:shopapp/models/loginModel.dart';
import 'package:shopapp/network/API/endPoints.dart';
import 'package:shopapp/network/API/API.dart';
import 'package:shopapp/states/loginStates.dart';

class AppLoginCubit extends Cubit<AppLoginStates> {
  AppLoginCubit() : super(AppLoginIntialState());
  static AppLoginCubit get(context) => BlocProvider.of(context);
  late ShopLoginModel loginModel;
  void userLogin({
    required String email,
    required String password,
  }) {
    emit(AppLoginLoadingState());

    DioHelper.postData(url: LOGIN, data: {
      'email': email,
      'password': password,
    }).then((value) {
      loginModel = ShopLoginModel.fromJson(value.data);

      emit(AppLoginSuccessState(loginModel));
    }).catchError((error) {
      emit(AppLoginErrorState(error.toString()));
    });
  }

  IconData suffixIcon = IconlyBroken.show;
  bool isPassword = false;

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffixIcon = isPassword ? IconlyBroken.show : IconlyBroken.hide;
    isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(AppChangePasswordVisbilityState());
  }
}
