import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/cubit/homeCubit.dart';
import 'package:shopapp/models/categryModel.dart';
import 'package:shopapp/states/homeStates.dart';
import 'package:shopapp/style/colors.dart';
import 'package:shopapp/style/const.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
        builder: (context, state) {
          return ConditionalBuilder(
              condition:
                  HomeCubit.get(context).categoryModel?.data?.data != null,
              builder: (context) => ListView.separated(
                  itemBuilder: (context, index) => buildGetIrem(
                      HomeCubit.get(context).categoryModel!.data!.data[index]),
                  separatorBuilder: (context, index) => verticalSpacing,
                  itemCount:
                      HomeCubit.get(context).categoryModel!.data!.data.length),
              fallback: (BuildContext context) => const Center(
                    child: CircularProgressIndicator(
                      color: primaryColor,
                    ),
                  ));
        },
        listener: (context, state) {});
  }

  Widget buildGetIrem(DataModel model) => Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Image(
              image: NetworkImage(model.image),
              width: 120,
              height: 120,
              fit: BoxFit.cover,
            ),
            horizantelSpacing,
            Text(model.name,
                style: const TextStyle(
                    fontSize: 20.0, fontWeight: FontWeight.bold)),
            const Spacer(),
            const Icon(Icons.arrow_forward_ios_outlined)
          ],
        ),
      );
}
