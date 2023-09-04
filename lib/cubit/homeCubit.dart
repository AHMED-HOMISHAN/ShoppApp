// ignore_for_file: file_names, avoid_function_literals_in_foreach_calls

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/components/components.dart';
import 'package:shopapp/components/constants.dart';
import 'package:shopapp/models/categryModel.dart';
import 'package:shopapp/models/favoriteModel.dart';
import 'package:shopapp/models/homeModel.dart';
import 'package:shopapp/models/loginModel.dart';
import 'package:shopapp/network/API/endPoints.dart';
import 'package:shopapp/network/API/API.dart';
import 'package:shopapp/states/homeStates.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(HomeIntialState());
  static HomeCubit get(context) => BlocProvider.of(context);
  HomeModel? homeModel;
  CategoryModel? categoryModel;
  FavoriteModel? favoriteModel;
  ShopLoginModel? userModel;
  FavoriteDataModel? favoriteDataModel;

  Map<int, bool> favorites = {};

  void getHomeData() {
    emit(HomeLoadingState());
    DioHelper.getDate(url: HOME, token: token).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      homeModel?.data.products.forEach((element) {
        favorites.addAll({element.id: element.inFavorites});
      });
      emit(HomeSuccessState());
    }).catchError((error) {
      emit(HomeErrorState());
    });
  }

  void getCategoryData() {
    DioHelper.getDate(url: CATEGORIES, token: token).then((value) {
      categoryModel = CategoryModel.fromJson(value.data);

      emit(CategorySuccessState());
    }).catchError((error) {
      emit(CategoryErrorState());
    });
  }

  void changeFavorites(int productId, BuildContext context) {
    favorites[productId] = !favorites[productId]!;
    emit(ChangeFavoriteSuccessState());

    DioHelper.postData(
            url: FAVORITES, data: {'product_id': productId}, token: token)
        .then((value) {
      favoriteModel = FavoriteModel.fromJson(value.data);

      if (!favoriteModel!.status) {
        favorites[productId] = !favorites[productId]!;
      } else {
        emit(GetFavoriteLoadingState());
      }

      messanger(
          context: context,
          message: favoriteModel!.message,
          status: favoriteModel!.status);
      emit(ChangeFavoriteSuccessState());
    }).catchError((error) {
      favorites[productId] = !favorites[productId]!;

      emit(ChangeFavoriteErrorState());
    });
  }

  void getFavoriteData() {
    emit(GetFavoriteLoadingState());
    DioHelper.getDate(url: FAVORITES, token: token).then((value) {
      favoriteDataModel = FavoriteDataModel.fromJson(value.data);
      emit((GetFavoriteSuccessState()));
    }).catchError((error) {
      emit(GetFavoriteErrorState());
    });
  }

  void getUserData() {
    emit(GetUserDataLoadingState());
    DioHelper.getDate(url: PROFILE, token: token).then((value) {
      userModel = ShopLoginModel.fromJson(value.data);

      emit((GetUserDataSuccessState(userModel!)));
    }).catchError((error) {
      emit(GetUserDataErrorState());
    });
  }

  void updateProfile({
    required String name,
    required String email,
    required String phone,
    required dynamic context,
  }) {
    emit(UpdateProfileLoadingState());
    DioHelper.putData(url: UPDATE_PROFILE, token: token, data: {
      'name': name,
      'email': email,
      'phone': phone,
    }).then((value) {
      userModel = ShopLoginModel.fromJson(value.data);
      messanger(
          context: context,
          message: userModel!.massage,
          status: userModel!.status);
      emit((UpdateProfileSuccessState(userModel!)));
    }).catchError((error) {
     
      emit(UpdateProfileErrorState());
    });
  }
}
