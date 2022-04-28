import 'package:deliver_app/controllers/cart_controller.dart';
import 'package:deliver_app/controllers/popular_product_controller.dart';
import 'package:deliver_app/routes/route_helper.dart';
import 'package:deliver_app/screens/cart/cart_page.dart';
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
  final int pageId;
  final String page;
  const PopularFoodDetail({Key? key, required this.pageId, required this.page}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var product = Get.find<PopularProductController>().popularProductList[pageId];
    Get.find<PopularProductController>().initProduct(
      product ,Get.find<CartController>()
    );

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
                        if(page == "cart_page"){
                          Get.toNamed(RouteHelper.getCartPage());
                        } else {
                          Get.toNamed(RouteHelper.getInitial());
                        }
                      },
                      child: AppIcon(icon: Icons.arrow_back_ios)),
                    GetBuilder<PopularProductController>(builder: (context){
                      var totalItems = context.totalItems;
                      return GestureDetector(
                        onTap: () {
                          Get.toNamed(RouteHelper.getCartPage());
                        },
                        child: Stack(
                          children: [
                            AppIcon(icon: Icons.shopping_cart_outlined),
                            totalItems >= 1 ?
                              Positioned(
                                right: 4,
                                top: 4,
                                child: AppIcon(icon: Icons.circle,
                                  size: 16,
                                  iconColor: Colors.transparent,
                                  backgroundColor: AppColors.mainColor,),
                              ) :
                                  Container(),
                            totalItems >= 1 ?
                            Positioned(
                              right: 8,
                              top: 5,
                              child: BigText(text: totalItems.toString(), size: 12, color: Colors.white,),
                            ) :
                            Container()
                          ],
                        ),
                      );
                    })
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
                      Container(
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.only(right: Dimemsions.width20, bottom: Dimemsions.height20+Dimemsions.height30),
                        height: Dimemsions.height20*8,
                        child: Column(
                          children: [
                            Expanded(
                                child: SingleChildScrollView(
                                  child: ExpandableTextWidget(
                                      text:  product.description!),
                                )),
                          ],
                        ),
                      )
                    ],
                  )))
        ],
      ),
      bottomNavigationBar: GetBuilder<PopularProductController>(builder: (context){
        return Container(
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
                    //Decrement
                    GestureDetector(
                      onTap: () {
                        context.setQuantity(false);
                      },
                      child: Icon(
                        Icons.remove,
                        color: AppColors.signColor,
                      ),
                    ),
                    SizedBox(
                      width: Dimemsions.width10 / 2,
                    ),
                    BigText(text: context.inCartItems.toString()),
                    SizedBox(
                      width: Dimemsions.width10 / 2,
                    ),
                    //Increment
                    GestureDetector(
                      onTap: () {
                        context.setQuantity(true);
                      },
                      child: Icon(
                        Icons.add,
                        color: AppColors.signColor,
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  context.addItem(product);
                },
                child: Container(
                  padding: EdgeInsets.only(
                      top: Dimemsions.height20,
                      bottom: Dimemsions.height20,
                      left: Dimemsions.width20,
                      right: Dimemsions.width20),
                  child: BigText(
                    text: "\$ ${ product.price! * context.inCartItems} | Add to Cart",
                    color: Colors.white,
                  ),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimemsions.radius20),
                      color: AppColors.mainColor),
                ),
              )
            ],
          ),
        );
      }),
    );
  }
}
