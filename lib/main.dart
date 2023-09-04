// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/auth/login.dart';
import 'package:shopapp/components/constants.dart';
import 'package:shopapp/cubit/appCubit.dart';
import 'package:shopapp/cubit/homeCubit.dart';
import 'package:shopapp/layout/shopLayout.dart';
import 'package:shopapp/network/local/cacheHelper.dart';
import 'package:shopapp/network/API/API.dart';
import 'package:shopapp/onBoarding/screen.dart';
import 'package:shopapp/states/appStates.dart';
import 'package:shopapp/style/colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await CacheHelper.init();
  Widget widget;
  bool onBoarding = CacheHelper.getData(key: 'onBoarding');
  token = CacheHelper.getData(key: 'token');

  if (onBoarding != null) {
    if (token != null) {
      widget = const ShopLayout();
    } else {
      widget = const ShopLoginScreen();
    }
  } else {
    widget = const OnBoardingScreen();
  }

  runApp(MyApp(
    startWidget: widget,
  ));
}

class MyApp extends StatelessWidget {
  final Widget startWidget;
  const MyApp({super.key, required this.startWidget});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => AppCubit(),
        ),
        BlocProvider(
          create: (BuildContext context) => HomeCubit()
            ..getHomeData()
            ..getCategoryData()
            ..getFavoriteData()
            ..getUserData(),
        ),
      ],
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (BuildContext context, AppStates state) {},
        builder: (BuildContext context, AppStates state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
                primaryColor: primaryColor,
                colorScheme: ColorScheme.fromSwatch()
                    .copyWith(secondary: primaryColorAccent),
                scaffoldBackgroundColor: Colors.white,
                appBarTheme: const AppBarTheme(
                    foregroundColor: primaryColorAccent,
                    systemOverlayStyle: SystemUiOverlayStyle(
                        statusBarIconBrightness: Brightness.dark,
                        statusBarColor: Colors.white),
                    color: Colors.white,
                    elevation: 0.0,
                    titleTextStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    )),
                bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                    type: BottomNavigationBarType.fixed,
                    selectedItemColor: primaryColor,
                    elevation: 20.0)),
            home: startWidget,
          );
        },
      ),
    );
  }
}
