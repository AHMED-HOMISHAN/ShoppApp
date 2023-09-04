import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/components/components.dart';
import 'package:shopapp/cubit/homeCubit.dart';
import 'package:shopapp/states/homeStates.dart';
import 'package:shopapp/style/colors.dart';
import 'package:shopapp/style/const.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
        builder: (context, state) {
          return ConditionalBuilder(
              condition: state is! GetFavoriteLoadingState,
              builder: (BuildContext context) => ConditionalBuilder(
                    condition: HomeCubit.get(context).favoriteDataModel != null,
                    builder: (BuildContext context) => ListView.separated(
                        itemBuilder: (context, index) => builderItem(
                            HomeCubit.get(context)
                                .favoriteDataModel!
                                .data!
                                .data[index]
                                .products,
                            context),
                        separatorBuilder: (context, index) => verticalSpacing,
                        itemCount: HomeCubit.get(context)
                            .favoriteDataModel!
                            .data!
                            .data
                            .length),
                    fallback: (BuildContext context) => const Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: SizedBox(
                            width: 150,
                            height: 150,
                            child: CircleAvatar(
                              backgroundColor:
                                  Color.fromARGB(255, 230, 165, 145),
                              child: Icon(IconlyBroken.heart,
                                  size: 50, color: Colors.white),
                            ),
                          ),
                        ),
                        verticalSpacing,
                        Center(
                          child: Text(
                            'EMPTY',
                            style: TextStyle(
                                color: Color.fromARGB(255, 230, 165, 145),
                                fontSize: 20,
                                fontWeight: FontWeight.w700),
                          ),
                        )
                      ],
                    ),
                  ),
              fallback: (context) => const Center(
                    child: CircularProgressIndicator(
                      color: primaryColor,
                    ),
                  ));
        },
        listener: (context, state) {});
  }
}
