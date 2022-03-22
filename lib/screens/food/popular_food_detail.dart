import 'package:deliver_app/controllers/popular_product_controller.dart';
import 'package:deliver_app/screens/home/main_food_page.dart';
import 'package:deliver_app/utils/app_constants.dart';
import 'package:deliver_app/utils/colors.dart';
import 'package:deliver_app/utils/dimemsions.dart';
import 'package:deliver_app/widgets/app_column.dart';
import 'package:deliver_app/widgets/app_icon.dart';
import 'package:deliver_app/widgets/big_text.dart';
import 'package:deliver_app/widgets/expandable_text_widget.dart';
import 'package:deliver_app/widgets/icon_and_text_widget.dart';
import 'package:deliver_app/widgets/small_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PopularFoodDetail extends StatelessWidget {
  int pageId;
  PopularFoodDetail({Key? key, required this.pageId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var product = Get.find<PopularProductController>().popularProductList[pageId];
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          //background img
          Positioned(
              left: 0,
              right: 0,
              child: Container(
                width: double.maxFinite,
                height: Dimemsions.popularFoodImgSize,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                          AppConstants.BASE_URL + AppConstants.UPLOAD_URL + product.img!
                        ))),
              )),
          // icon widgets
          Positioned(
              top: Dimemsions.height45,
              left: Dimemsions.width20,
              right: Dimemsions.width20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                      onTap: () {
                        Get.to(() => MainFoodPage());
                      },
                      child: AppIcon(icon: Icons.arrow_back_ios)),
                  AppIcon(icon: Icons.shopping_cart_outlined)
                ],
              )),
          //introduction
          Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              top: Dimemsions.popularFoodImgSize - 20,
              child: Container(
                  padding: EdgeInsets.only(
                      left: Dimemsions.width20,
                      right: Dimemsions.width20,
                      top: Dimemsions.height20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(Dimemsions.radius20),
                          bottomRight: Radius.circular(Dimemsions.radius20)),
                      color: Colors.white),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppColumn(text: product.name!),
                      SizedBox(height: Dimemsions.height20),
                      BigText(text: "Introduce"),
                      SizedBox(height: Dimemsions.height20),
                      // expandable text
                      Expanded(
                          child: ExpandableTextWidget(
                              text:  product.description!))
                    ],
                  )))
        ],
      ),
      bottomNavigationBar: Container(
        height: 120,
        padding: EdgeInsets.only(
            top: Dimemsions.height30,
            bottom: Dimemsions.height30,
            left: Dimemsions.width20,
            right: Dimemsions.width20),
        decoration: BoxDecoration(
            color: AppColors.buttonBackgroundColor,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(Dimemsions.radius20 * 2),
                topRight: Radius.circular(Dimemsions.radius20 * 2))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: EdgeInsets.only(
                  top: Dimemsions.height20,
                  bottom: Dimemsions.height20,
                  left: Dimemsions.width20,
                  right: Dimemsions.width20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimemsions.radius20),
                  color: Colors.white),
              child: Row(
                children: [
                  Icon(
                    Icons.remove,
                    color: AppColors.signColor,
                  ),
                  SizedBox(
                    width: Dimemsions.width10 / 2,
                  ),
                  BigText(text: "0"),
                  SizedBox(
                    width: Dimemsions.width10 / 2,
                  ),
                  Icon(
                    Icons.add,
                    color: AppColors.signColor,
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(
                  top: Dimemsions.height20,
                  bottom: Dimemsions.height20,
                  left: Dimemsions.width20,
                  right: Dimemsions.width20),
              child: BigText(
                text: "\$ ${product.price!} | Add to Cart",
                color: Colors.white,
              ),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimemsions.radius20),
                  color: AppColors.mainColor),
            )
          ],
        ),
      ),
    );
  }
}
