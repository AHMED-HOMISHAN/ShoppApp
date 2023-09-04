import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:shopapp/components/components.dart';
import 'package:shopapp/cubit/searchCubit.dart';
import 'package:shopapp/states/searchStates.dart';
import 'package:shopapp/style/colors.dart';
import 'package:shopapp/style/const.dart';

class SreachScreen extends StatelessWidget {
  const SreachScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    var searchController = TextEditingController();
    return BlocProvider(
        create: (context) => SearchCubit(),
        child: BlocConsumer<SearchCubit, AppSearchStates>(
          listener: (context, state) {},
          builder: (context, state) => Scaffold(
            appBar: AppBar(
              leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(IconlyBroken.closeSquare, size: 23)),
              title: const Text(
                'Search',
                style: TextStyle(color: primaryColor),
              ),
            ),
            body: Form(
              key: formKey,
              child: Column(children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  child: defaultForm(
                    controller: searchController,
                    type: TextInputType.text,
                    prefixIcon: IconlyBroken.search,
                    label: 'Search ..',
                    suffixIconPressed: () {},
                    onSubmit: () => SearchCubit.get(context)
                        .searchData(searchController.text),
                  ),
                ),
                verticalSpacing,
                ConditionalBuilder(
                    condition: state is! AppSearchLoadingState &&
                        SearchCubit.get(context).searchModel != null,
                    builder: (context) {
                      return Expanded(
                        child: ListView.separated(
                            itemBuilder: (context, index) => builderItem(
                                SearchCubit.get(context)
                                    .searchModel!
                                    .data!
                                    .data[index],
                                context,
                                isOldPrice: false),
                            separatorBuilder: (context, index) =>
                                verticalSpacing,
                            itemCount: SearchCubit.get(context)
                                .searchModel!
                                .data!
                                .data
                                .length),
                      );
                    },
                    fallback: (context) => const Center(
                          child: CircularProgressIndicator(
                            color: primaryColor,
                          ),
                        ))
              ]),
            ),
          ),
        ));
  }
}
