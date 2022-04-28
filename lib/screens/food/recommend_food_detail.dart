import 'package:deliver_app/controllers/cart_controller.dart';
import 'package:deliver_app/controllers/popular_product_controller.dart';
import 'package:deliver_app/controllers/recommended_product_controller.dart';
import 'package:deliver_app/routes/route_helper.dart';
import 'package:deliver_app/screens/cart/cart_page.dart';
import 'package:deliver_app/utils/app_constants.dart';
import 'package:deliver_app/utils/colors.dart';
import 'package:deliver_app/utils/dimemsions.dart';
import 'package:deliver_app/widgets/app_icon.dart';
import 'package:deliver_app/widgets/big_text.dart';
import 'package:deliver_app/widgets/expandable_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RecommendFoodDetail extends StatelessWidget {
  final int pageId;
  final String page;
  RecommendFoodDetail({Key? key, required this.pageId, required this.page}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var product = Get.find<RecommendedProductController>().recommendedProductList[pageId];
    Get.find<PopularProductController>().initProduct(
        product ,Get.find<CartController>()
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            toolbarHeight: 70,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                    onTap: (){
                      if(page == "recommended"){
                        Get.toNamed(RouteHelper.getInitial());
                       /* Get.toNamed(RouteHelper.getCartPage());*/
                      } else {
                        Get.toNamed(RouteHelper.getCartPage());
                      }
                    },
                    child: AppIcon(icon: Icons.clear)),
                GetBuilder<PopularProductController>(builder: (context){
                  var totalItems = Get.find<PopularProductController>().totalItems;
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
            ),
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(20),
              child: Container(
                child: Center(child: BigText(text: product.name!, size: Dimemsions.font26,)),
                width: double.maxFinite,
                padding: EdgeInsets.only(top: 5, bottom: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(Dimemsions.radius20),
                    topRight: Radius.circular(Dimemsions.radius20)
                  )
                ),
              ),
            ),
            pinned: true,
            backgroundColor: AppColors.yellowColor,
            expandedHeight: 300,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                AppConstants.BASE_URL + AppConstants.UPLOAD_URL + product.img!,
                width: double.maxFinite,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(left: Dimemsions.width20, right: Dimemsions.width20),
                  child: ExpandableTextWidget(text: product.description!),
                )
              ],
            )
          )
        ],
      ),
      bottomNavigationBar: GetBuilder<PopularProductController>(builder: (context){
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.only(
                  left: Dimemsions.width20*2.5,
                  right: Dimemsions.width20*2.5,
                  top: Dimemsions.height10,
                  bottom: Dimemsions.height10
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      context.setQuantity(false);
                    },
                    child: AppIcon(icon: Icons.remove,
                      backgroundColor: AppColors.mainColor,
                      iconColor: Colors.white,
                      iconSize: Dimemsions.iconSize24,
                    ),
                  ),
                  BigText(text: "\$ ${product.price!} X ${context.inCartItems}", color: AppColors.mainBlackColor, size: Dimemsions.font26,),
                  GestureDetector(
                    onTap: () {
                      context.setQuantity(true);
                    },
                    child: AppIcon(icon: Icons.add,
                      backgroundColor: AppColors.mainColor,
                      iconColor: Colors.white,
                      iconSize: Dimemsions.iconSize24,
                    ),
                  )
                ],
              ),
            ),
            Container(
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
                        left: Dimemsions.height20,
                        right: Dimemsions.height20),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Dimemsions.radius20),
                        color: Colors.white),
                    child: Icon(
                      Icons.favorite,
                      color: AppColors.mainColor,
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
                        text: "\$ ${product.price!*context.inCartItems} | Add to Cart",
                        color: Colors.white,
                      ),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(Dimemsions.radius20),
                          color: AppColors.mainColor),
                    ),
                  )
                ],
              ),
            ),
          ],
        );
      })
    );
  }
}
