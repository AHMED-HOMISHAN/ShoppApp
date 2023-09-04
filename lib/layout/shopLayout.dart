// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:shopapp/components/components.dart';
import 'package:shopapp/cubit/appCubit.dart';
import 'package:shopapp/layout/search.dart';
import 'package:shopapp/states/appStates.dart';
import 'package:shopapp/style/colors.dart';
import 'package:shopapp/style/const.dart';

class ShopLayout extends StatelessWidget {
  const ShopLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Row(
              children: [
                Container(
                  height: 35,
                  width: 35,
                  decoration: BoxDecoration(
                      color: primaryColorAccent,
                      borderRadius: BorderRadius.circular(50)),
                  child: const Icon(
                    IconlyBroken.profile,
                    color: Colors.white,
                  ),
                ),
                horizantelSpacing,
                const Text(
                  'Shopping App',
                  style: TextStyle(
                      color: primaryColorAccent,
                      fontSize: 18,
                      fontWeight: FontWeight.w400),
                ),
              ],
            ),
            actions: [
              IconButton(
                icon:
                    const Icon(IconlyBroken.search, color: primaryColorAccent),
                onPressed: () {
                  navigateTo(context, const SreachScreen());
                },
              )
            ],
          ),
          body: cubit.bottomScreens[cubit.currentindex],
          bottomNavigationBar: BottomNavigationBar(
            onTap: (index) {
              cubit.changeBottomScreen(index);
            },
            currentIndex: cubit.currentindex,
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(IconlyBroken.home), label: 'Home'),
              BottomNavigationBarItem(
                  icon: Icon(IconlyBroken.category), label: 'Category'),
              BottomNavigationBarItem(
                  icon: Icon(IconlyBroken.heart), label: 'Favorite'),
              BottomNavigationBarItem(
                  icon: Icon(IconlyBroken.setting), label: 'Setting'),
            ],
          ),
        );
      },
    );
  }
}
