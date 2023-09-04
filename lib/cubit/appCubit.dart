// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/layout/categaries.dart';
import 'package:shopapp/layout/favorites.dart';
import 'package:shopapp/layout/products.dart';
import 'package:shopapp/layout/settings.dart';
import 'package:shopapp/states/appStates.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppIntialState());
  static AppCubit get(context) => BlocProvider.of(context);
  int currentindex = 0;

  List<Widget> bottomScreens = const [
    ProductScreen(),
    CategoryScreen(),
    FavoriteScreen(),
    SettingScreen(),
  ];

  void changeBottomScreen(int index) {
    currentindex = index;
    emit(AppChangeBottomNavBarState());
  }
}
