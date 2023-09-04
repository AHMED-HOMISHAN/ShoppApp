import 'package:flutter/material.dart';
import 'package:shopapp/auth/login.dart';
import 'package:shopapp/components/components.dart';
import 'package:shopapp/network/local/cacheHelper.dart';

var token = '';
void signOut(BuildContext context) {
  CacheHelper.clearData(key: 'token').then((value) {
    if (value) {
      navigateAndfinished(context, const ShopLoginScreen());
    }
  }).catchError((error) {
    messanger(context: context, message: error.toString());
  });
}
