import 'package:deliver_app/screens/address/add_address_page.dart';
import 'package:deliver_app/screens/address/pick_address_page.dart';
import 'package:deliver_app/screens/auth/sign_in_page.dart';
import 'package:deliver_app/screens/cart/cart_page.dart';
import 'package:deliver_app/screens/food/popular_food_detail.dart';
import 'package:deliver_app/screens/food/recommend_food_detail.dart';
import 'package:deliver_app/screens/home/home_page.dart';
import 'package:deliver_app/screens/home/main_food_page.dart';
import 'package:deliver_app/screens/splash/splash_page.dart';
import 'package:get/get.dart';

class RouteHelper {
  static const String splashPage = "/splash-page";
  static const String initial = "/";
  static const String popularFood = "/popular-food";
  static const String recommendedFood = "/recommended-food";
  static const String cartPage = "/cart-page";
  static const String signIn = "/sign-in";
  static const String addAddress = "/add-address";
  static const String pickAddress = "/pick-address";

  static String getSplashPage() => '$splashPage';
  static String getInitial() => '$initial';
  static String getPopularFood(int pageId, String page) => '$popularFood?pageId=$pageId&page=$page';
  static String getRecommendedFood(int pageId, String page) => '$recommendedFood?pageId=$pageId&page=$page';
  static String getCartPage() => '$cartPage';
  static String getSignInPage() => '$signIn';
  static String getAddAddressPage() => '$addAddress';
  static String getPickAddressPage() => '$pickAddress';

  static List<GetPage> routes = [
    //splash-page
    GetPage(name: splashPage, page: () => SplashScreen()),
    //initial-page/home page
    GetPage(name: initial, page: () => HomePage()),
    //popular-detail-page
    GetPage(name: popularFood, page: () {
      var pageId = Get.parameters['pageId'];
      var page = Get.parameters['page'];
      return PopularFoodDetail(pageId: int.parse(pageId!), page: page!);
    },
      transition: Transition.fadeIn
    ),
    //recommended-detail-page
    GetPage(name: recommendedFood, page: () {
      var pageId = Get.parameters['pageId'];
      var page = Get.parameters['page'];
      return RecommendFoodDetail(pageId: int.parse(pageId!), page: page!);
    },
        transition: Transition.fadeIn
    ),
    //cart-page
    GetPage(name: cartPage, page: () {
      return CartPage();
    },
        transition: Transition.fadeIn
    ),
    //sign-in-page
    GetPage(name: signIn, page: () {
      return SignInPage();
    },
        transition: Transition.fadeIn
    ),
    //add-address-page
    GetPage(name: addAddress, page: () {
      return AddAddressPage();
    },
        transition: Transition.fadeIn
    ),
    //pick-address-page
    GetPage(name: pickAddress, page: () {
      PickAddressPage _pickAddress = Get.arguments;
      return _pickAddress;
    },
        transition: Transition.fadeIn
    ),

  ];
}