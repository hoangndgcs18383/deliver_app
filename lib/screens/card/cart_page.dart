import 'package:deliver_app/controllers/cart_controller.dart';
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
          Positioned(
              top: Dimemsions.height20*3,
              left: Dimemsions.width20,
              right: Dimemsions.width20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppIcon(
                    icon: Icons.arrow_back_ios,
                    iconColor: Colors.white,
                    backgroundColor: AppColors.mainColor,
                    iconSize: Dimemsions.iconSize24,
                  ),
                  SizedBox(width: Dimemsions.width20*5,),
                  GestureDetector(
                    onTap: () {
                      Get.to(() => MainFoodPage());
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
          Positioned(
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
                    var item = context.getItems;

                    return ListView.builder(
                        itemCount: count,
                        itemBuilder: (_, index) {
                          return Container(
                            height: 100,
                            width: double.maxFinite,
                            child: Row(
                              children: [
                                Container(
                                  width: Dimemsions.height20*5,
                                  height: Dimemsions.height20*5,
                                  margin: EdgeInsets.only(bottom: Dimemsions.height10),
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(
                                              AppConstants.BASE_URL + AppConstants.UPLOAD_URL + item[index].img!
                                          )
                                      ),
                                      borderRadius: BorderRadius.circular(Dimemsions.radius20),
                                      color: Colors.white
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
                                          BigText(text: item[index].name!, color: Colors.black54,),
                                          SmallText(text: "Spicy"),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              BigText(text: "\$ ${item[index].price}", color: Colors.redAccent,),
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
                                                        //context.setQuantity(false);
                                                      },
                                                      child: Icon(
                                                        Icons.remove,
                                                        color: AppColors.signColor,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: Dimemsions.width10 / 2,
                                                    ),
                                                    BigText(text: "0"),//context.inCartItems.toString()),
                                                    SizedBox(
                                                      width: Dimemsions.width10 / 2,
                                                    ),
                                                    //Increment
                                                    GestureDetector(
                                                      onTap: () {
                                                        //context.setQuantity(true);
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
          ))
        ],
      ),
    );
  }
}
