import 'package:deliver_app/base/no_data_page.dart';
import 'package:deliver_app/controllers/auth_controller.dart';
import 'package:deliver_app/controllers/cart_controller.dart';
import 'package:deliver_app/controllers/location_controller.dart';
import 'package:deliver_app/controllers/popular_product_controller.dart';
import 'package:deliver_app/controllers/recommended_product_controller.dart';
import 'package:deliver_app/routes/route_helper.dart';
import 'package:deliver_app/screens/home/main_food_page.dart';
import 'package:deliver_app/utils/app_constants.dart';
import 'package:deliver_app/utils/colors.dart';
import 'package:deliver_app/utils/dimemsions.dart';
import 'package:deliver_app/widgets/app_icon.dart';
import 'package:deliver_app/widgets/big_text.dart';
import 'package:deliver_app/widgets/small_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          //header
          Positioned(
              top: Dimemsions.height20*3,
              left: Dimemsions.width20,
              right: Dimemsions.width20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: (){
                      Get.back();
                    },
                    child: AppIcon(
                      icon: Icons.arrow_back_ios,
                      iconColor: Colors.white,
                      backgroundColor: AppColors.mainColor,
                      iconSize: Dimemsions.iconSize24,
                    ),
                  ),
                  SizedBox(width: Dimemsions.width20*5,),
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(RouteHelper.getInitial());
                    },
                    child: AppIcon(
                      icon: Icons.home_outlined,
                      iconColor: Colors.white,
                      backgroundColor: AppColors.mainColor,
                      iconSize: Dimemsions.iconSize24,
                    ),
                  ),
                  AppIcon(
                    icon: Icons.shopping_cart,
                    iconColor: Colors.white,
                    backgroundColor: AppColors.mainColor,
                    iconSize: Dimemsions.iconSize24,
                  )
                ],
          )),
          //body
          GetBuilder<CartController>(builder: (_cartController){
            return _cartController.getItems.length > 0 ? Positioned(
                top: Dimemsions.height20*5,
                bottom: 0,
                left: Dimemsions.width20,
                right: Dimemsions.width20,
                child: Container(
                  margin: EdgeInsets.only(top: Dimemsions.height15),
                  child: MediaQuery.removePadding(
                      context: context,
                      removeTop: true,
                      child: GetBuilder<CartController>(builder: (context){
                        var count = context.getItems.length;
                        var items = context.getItems;

                        return ListView.builder(
                            itemCount: count,
                            itemBuilder: (_, index) {
                              return Container(
                                height: 100,
                                width: double.maxFinite,
                                child: Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        var popularIndex = Get.find<PopularProductController>()
                                            .popularProductList
                                            .indexOf(items[index].product!);

                                        var recommendedIndex = Get.find<RecommendedProductController>()
                                            .recommendedProductList
                                            .indexOf(items[index].product!);

                                        if(popularIndex >= 0){
                                          Get.toNamed(RouteHelper.getPopularFood(popularIndex, "cart_page"));
                                        } else {
                                          if(recommendedIndex < 0){
                                            Get.snackbar("History product", "Product review is not available for history product",
                                                backgroundColor: AppColors.mainColor,
                                                colorText: Colors.white
                                            );
                                          } else {
                                            Get.toNamed(RouteHelper.getRecommendedFood(recommendedIndex, "cart_page"));
                                          }
                                        }
                                      },
                                      child: Container(
                                        width: Dimemsions.height20*5,
                                        height: Dimemsions.height20*5,
                                        margin: EdgeInsets.only(bottom: Dimemsions.height10),
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image: NetworkImage(
                                                    AppConstants.BASE_URL + AppConstants.UPLOAD_URL + items[index].img!
                                                )
                                            ),
                                            borderRadius: BorderRadius.circular(Dimemsions.radius20),
                                            color: Colors.white
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: Dimemsions.width10,),
                                    Expanded(
                                        child: Container(
                                          height: Dimemsions.height20*5,
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: [
                                              BigText(text: items[index].name!, color: Colors.black54,),
                                              SmallText(text: "Spicy"),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  BigText(text: "\$ ${items[index].price!}", color: Colors.redAccent,),
                                                  Container(
                                                    padding: EdgeInsets.only(
                                                        top: Dimemsions.height10,
                                                        bottom: Dimemsions.height10,
                                                        left: Dimemsions.width10,
                                                        right: Dimemsions.width10),
                                                    decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(Dimemsions.radius20),
                                                        color: Colors.white),
                                                    child: Row(
                                                      children: [
                                                        //Decrement
                                                        GestureDetector(
                                                          onTap: () {
                                                            context.addItem(items[index].product!, -1);
                                                          },
                                                          child: Icon(
                                                            Icons.remove,
                                                            color: AppColors.signColor,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: Dimemsions.width10 / 2,
                                                        ),
                                                        BigText(text: "${items[index].quantity}"),
                                                        SizedBox(
                                                          width: Dimemsions.width10 / 2,
                                                        ),
                                                        //Increment
                                                        GestureDetector(
                                                          onTap: () {
                                                            context.addItem(items[index].product!, 1);
                                                          },
                                                          child: Icon(
                                                            Icons.add,
                                                            color: AppColors.signColor,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ))
                                  ],
                                ),
                              );
                            });
                      })
                  ),
                )) : NoDataPage(text: "Your cart is empty");
          })
        ],
      ),
      bottomNavigationBar: GetBuilder<CartController>(builder: (cartController){
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
          child:  cartController.getItems.length > 0 ? Row(
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
                    SizedBox(
                      width: Dimemsions.width10 / 2,
                    ),
                    BigText(text: "Total \$ ${cartController.totalAmounts}"),
                    SizedBox(
                      width: Dimemsions.width10 / 2,
                    ),
                    //Increment
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  if (Get.find<AuthController>().userLoggedIn()){
                    cartController.addToHistory();
                   /* if(Get.find<LocationController>().addressList.isEmpty){
                      Get.toNamed(RouteHelper.getAddAddressPage());
                    } else{
                      Get.offNamed(RouteHelper.getInitial());
                    }*/
                  } else {
                    Get.toNamed(RouteHelper.getSignInPage());
                  }
                },
                child: Container(
                  padding: EdgeInsets.only(
                      top: Dimemsions.height20,
                      bottom: Dimemsions.height20,
                      left: Dimemsions.width20,
                      right: Dimemsions.width20),
                  child: BigText(
                    text: "Check out",
                    color: Colors.white,
                  ),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimemsions.radius20),
                      color: AppColors.mainColor),
                ),
              )
            ],
          ) : Container(),
        );
      }),
    );
  }
}
