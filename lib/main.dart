import 'package:deliver_app/controllers/cart_controller.dart';
import 'package:deliver_app/controllers/popular_product_controller.dart';
import 'package:deliver_app/controllers/recommended_product_controller.dart';
import 'package:deliver_app/routes/route_helper.dart';
import 'package:deliver_app/screens/auth/sign_in_page.dart';
import 'package:deliver_app/screens/auth/sign_up_page.dart';
import 'package:deliver_app/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'helper/dependencies.dart' as depend;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await depend.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Get.find<CartController>().getCartData();
    return GetBuilder<PopularProductController>(builder: (_){
      return GetBuilder<RecommendedProductController>(builder: (_){
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
           /*home: SignInPage(),*/
          initialRoute: RouteHelper.getSplashPage(),
          getPages: RouteHelper.routes,
          theme: ThemeData(
            primaryColor: AppColors.mainColor,
          ),
        );
      });
    });
  }
}


