import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/cubit/homeCubit.dart';
import 'package:shopapp/models/categryModel.dart';
import 'package:shopapp/models/homeModel.dart';
import 'package:shopapp/states/homeStates.dart';
import 'package:shopapp/style/colors.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:shopapp/style/const.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return ConditionalBuilder(
              condition: HomeCubit.get(context).homeModel != null &&
                  HomeCubit.get(context).categoryModel != null,
              builder: (context) {
                return productGetDate(HomeCubit.get(context).homeModel,
                    HomeCubit.get(context).categoryModel, context);
              },
              fallback: (context) => const Center(
                    child: CircularProgressIndicator(
                      color: primaryColor,
                    ),
                  ));
        });
  }

  Widget productGetDate(HomeModel? model, CategoryModel? categoryModel,
          BuildContext context) =>
      SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CarouselSlider(
              items: model?.data.banners
                  .map(
                    (e) => Image(
                      image: NetworkImage(e.image),
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  )
                  .toList(),
              options: CarouselOptions(
                  height: 250.0,
                  initialPage: 0,
                  viewportFraction: 1.0,
                  enableInfiniteScroll: true,
                  reverse: false,
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 3),
                  autoPlayAnimationDuration: const Duration(seconds: 1),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  scrollDirection: Axis.horizontal),
            ),
            verticalSpacing,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Categories',
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                        color: primaryColor),
                  ),
                  SizedBox(
                    height: 100.0,
                    child: ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) =>
                            buildCategoryItems(categoryModel.data!.data[index]),
                        separatorBuilder: (context, index) => horizantelSpacing,
                        itemCount: categoryModel!.data!.data.length),
                  ),
                  verticalSpacing,
                  const Text(
                    'New Products',
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                        color: primaryColor),
                  ),
                ],
              ),
            ),
            verticalSpacing,
            Container(
              color: Colors.grey[300],
              child: GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                mainAxisSpacing: 1.0,
                crossAxisSpacing: 1.0,
                childAspectRatio: 1 / 1.58,
                children: List.generate(
                    model!.data.products.length,
                    (index) =>
                        buildGridProduct(model.data.products[index], context)),
              ),
            )
          ],
        ),
      );

  Widget buildGridProduct(ProductModel model, BuildContext context) =>
      Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Image(
                  image: NetworkImage(model.image),
                  width: double.infinity,
                  height: 200,
                ),
                if (model.discount != 0)
                  Container(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      decoration: const BoxDecoration(
                        color: Colors.red,
                      ),
                      child: const Text(
                        'Discount',
                        style: TextStyle(fontSize: 12.0, color: Colors.white),
                      ))
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(model.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 14.0, height: 1.3)),
               
                  Row(
                    children: [
                      Text('${model.price.round()} \$',
                          style: const TextStyle(
                              fontSize: 12.0, color: primaryColor)),
                      horizantelSpacing,
                      if (model.oldPrice != 0 && model.discount != 0)
                        Text('${model.oldPrice.round()} \$',
                            style: const TextStyle(
                                fontSize: 10.0,
                                color: Colors.grey,
                                decoration: TextDecoration.lineThrough)),
                      const Spacer(),
                      IconButton(
                          onPressed: () {
                            HomeCubit.get(context)
                                .changeFavorites(model.id, context);
                          },
                          icon: Icon(
                              HomeCubit.get(context).favorites[model.id] == true
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              size: 25.0,
                              color:
                                  HomeCubit.get(context).favorites[model.id] ==
                                          true
                                      ? Colors.red
                                      : Colors.black))
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      );

  Widget buildCategoryItems(DataModel model) => Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          Image(
            image: NetworkImage(model.image),
            height: 100.0,
            width: 100.0,
            fit: BoxFit.cover,
          ),
          Container(
              padding: const EdgeInsets.all(6),
              width: 100.0,
              color: Colors.black.withOpacity(0.8),
              child: Text(
                model.name,
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(color: Colors.white),
              )),
        ],
      );
}
