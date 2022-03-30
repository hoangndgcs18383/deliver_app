import 'package:get/get.dart';

class Dimemsions {
  //screen height = 780
  static double screenHeight = Get.context!.height;
  static double screenWidth = Get.context!.width;

  static double pageView = screenHeight/2.44;
  static double pageViewContainer = screenHeight/3.55;
  static double pageViewTextContainer = screenHeight/6.5;
  //dynamic height padding and margin
  static double height10 = screenHeight/78;
  static double height15 = screenHeight/52;
  static double height20 = screenHeight/39;
  static double height30 = screenHeight/26;
  static double height45 = screenHeight/17.3;

  //dynamic wight padding and margin
  static double width10 = screenWidth/78;
  static double width15 = screenWidth/52;
  static double width20 = screenWidth/39;
  static double width30 = screenWidth/26;

  //font size
  static double font16 = screenHeight/50;
  static double font20 = screenHeight/39;
  static double font26 = screenHeight/32;

  //icon size
  static double iconSize24 = screenHeight/35;
  static double iconSize16 = screenHeight/50;

  static double radius15 = screenHeight/52;
  static double radius20 = screenHeight/39;
  static double radius30 = screenHeight/26;
  //list view size
  static double listViewImgSize = screenWidth/3.5;
  static double listViewTextContSize = screenWidth/4;

  //popular food
  static double popularFoodImgSize = screenHeight/2.3;

  //splash screen dimensions
  static double splashImg = screenHeight/3.38;

}