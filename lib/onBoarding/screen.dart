import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:shopapp/auth/login.dart';
import 'package:shopapp/components/components.dart';
import 'package:shopapp/network/local/cacheHelper.dart';
import 'package:shopapp/style/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BoardingModel {
  final String image;
  final String title;
  final String body;
  BoardingModel({
    required this.title,
    required this.body,
    required this.image,
  });
}

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  bool isLast = false;

  @override
  Widget build(BuildContext context) {
    var borderContorller = PageController();

    List<BoardingModel> boarding = [
      BoardingModel(
          title: 'title1', body: 'body1', image: 'assets/images/man.jpg'),
      BoardingModel(
          title: 'title2', body: 'body2', image: 'assets/images/woman.jpg'),
      BoardingModel(
          title: 'title3', body: 'body3', image: 'assets/images/items.jpg'),
    ];

    void submit() {
      CacheHelper.saveData(key: 'onBoarding', value: true).then((value) {
        if (value) {
          navigateAndfinished(context, const ShopLoginScreen());
        }
      });
    }

    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
              onPressed: () {
                submit();
              },
              child: const Text(
                'SKIP',
                style: TextStyle(
                  color: primaryColor,
                ),
              ))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(children: [
          Expanded(
            child: PageView.builder(
              onPageChanged: (int index) {
                if (index == boarding.length - 1) {
                  setState(() {
                    isLast = true;
                  });
                } else {
                  setState(() {
                    isLast = false;
                  });
                }
              },
              physics: const BouncingScrollPhysics(),
              controller: borderContorller,
              itemBuilder: (context, index) =>
                  buildBoardingItem(boarding[index]),
              itemCount: boarding.length,
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          Row(
            children: [
              SmoothPageIndicator(
                controller: borderContorller,
                count: boarding.length,
                effect: const ExpandingDotsEffect(
                    dotColor: Colors.grey,
                    activeDotColor: primaryColorAccent,
                    dotHeight: 10,
                    expansionFactor: 4,
                    dotWidth: 10,
                    spacing: 5),
              ),
              const Spacer(),
              FloatingActionButton(
                  backgroundColor: primaryColor,
                  onPressed: () {
                    if (isLast) {
                      submit();
                    } else {
                      borderContorller.nextPage(
                          duration: const Duration(milliseconds: 750),
                          curve: Curves.fastLinearToSlowEaseIn);
                    }
                  },
                  child: const Icon(IconlyBroken.arrowRight))
            ],
          )
        ]),
      ),
    );
  }

  Widget buildBoardingItem(BoardingModel boardingModel) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
              child: Image(
            image: AssetImage(
              boardingModel.image,
            ),
          )),
          const SizedBox(
            height: 30.0,
          ),
          Text(boardingModel.title,
              style:
                  const TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold)),
          const SizedBox(
            height: 30.0,
          ),
          Text(boardingModel.body,
              style:
                  const TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold)),
          const SizedBox(
            height: 30.0,
          ),
        ],
      );
}
