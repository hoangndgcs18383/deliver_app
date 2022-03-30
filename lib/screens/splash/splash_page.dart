import 'dart:async';
import 'package:deliver_app/controllers/popular_product_controller.dart';
import 'package:deliver_app/controllers/recommended_product_controller.dart';
import 'package:deliver_app/routes/route_helper.dart';
import 'package:deliver_app/utils/dimemsions.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {

  late Animation<double> animation;
  late AnimationController controller;

  Future<void> _loadResource() async {
    await Get.find<PopularProductController>().getPopularProductList();
    await Get.find<RecommendedProductController>().getRecommendedProductList();
  }

  @override
  void initState() {

    _loadResource();

    super.initState();
    controller = new AnimationController(
        vsync: this,
        duration: Duration(seconds: 2)
    )..forward();

    animation = new CurvedAnimation(
        parent: controller,
        curve: Curves.linear);

    Timer(
      Duration(seconds: 3),
        () => Get.offNamed(RouteHelper.getInitial())
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ScaleTransition(
              scale: animation,
              child: Center(
                  child: Image.asset("assets/image/logo part 1.png", width: Dimemsions.splashImg,))),
          Center(child: Image.asset("assets/image/logo part 2.png", width:  Dimemsions.splashImg,))
        ],
      ),
    );
  }
}


