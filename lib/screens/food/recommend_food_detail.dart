import 'package:deliver_app/routes/route_helper.dart';
import 'package:deliver_app/utils/colors.dart';
import 'package:deliver_app/utils/dimemsions.dart';
import 'package:deliver_app/widgets/app_icon.dart';
import 'package:deliver_app/widgets/big_text.dart';
import 'package:deliver_app/widgets/expandable_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RecommendFoodDetail extends StatelessWidget {
  const RecommendFoodDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                      Get.toNamed(RouteHelper.getInitial());
                    },
                    child: AppIcon(icon: Icons.clear)),
                AppIcon(icon: Icons.shopping_cart_outlined)
              ],
            ),
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(20),
              child: Container(
                child: Center(child: BigText(text: "Chinese Side", size: Dimemsions.font26,)),
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
              background: Image.asset(
                "assets/image/food0.png",
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
                  child: ExpandableTextWidget(text: "Khi thế giới của hai người dần trở nên khác nhau, không còn điểm nào giao nhau nữa, mỗi khi gặp nhau cũng chỉ có thể nói đi nói lại những kỷ niệm đã qua làm đề tài chung.",),
                )
              ],
            )
          )
        ],
      ),
      bottomNavigationBar: Column(
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppIcon(
                  icon: Icons.remove,
                  backgroundColor: AppColors.mainColor,
                  iconColor: Colors.white,
                  iconSize: Dimemsions.iconSize24,
                ),
                BigText(text: "\$12.88" + " X" + " 0", color: AppColors.mainBlackColor, size: Dimemsions.font26,),
                AppIcon(icon: Icons.add,
                  backgroundColor: AppColors.mainColor,
                  iconColor: Colors.white,
                  iconSize: Dimemsions.iconSize24,
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
                Container(
                  padding: EdgeInsets.only(
                      top: Dimemsions.height20,
                      bottom: Dimemsions.height20,
                      left: Dimemsions.width20,
                      right: Dimemsions.width20),
                  child: BigText(
                    text: "\$10 | Add to Cart",
                    color: Colors.white,
                  ),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimemsions.radius20),
                      color: AppColors.mainColor),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
