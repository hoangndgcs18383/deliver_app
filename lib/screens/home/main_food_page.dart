import 'package:deliver_app/screens/home/body_food_page.dart';
import 'package:deliver_app/utils/colors.dart';
import 'package:deliver_app/utils/dimemsions.dart';
import 'package:deliver_app/widgets/big_text.dart';
import 'package:deliver_app/widgets/small_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/auth_controller.dart';
import '../../controllers/user_controller.dart';

class MainFoodPage extends StatefulWidget {
  const MainFoodPage({Key? key}) : super(key: key);

  @override
  State<MainFoodPage> createState() => _MainFoodPageState();
}



class _MainFoodPageState extends State<MainFoodPage> {



  @override
  Widget build(BuildContext context) {

    bool _userLoggedIn = Get.find<AuthController>().userLoggedIn();
    if(_userLoggedIn){
      Get.find<UserController>().getUserInfo();
    }

    return Scaffold(
      body: GetBuilder<UserController>(builder: (controller){
        return Column(
          children: [
            Container(
              child: Container(
                margin: EdgeInsets.only(top: Dimemsions.height45, bottom: Dimemsions.height45),
                padding: EdgeInsets.only(left: Dimemsions.width20, right: Dimemsions.width20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        controller.userModel?.name == null ?
                        BigText(text: 'Welcome to GreenFood', color: AppColors.mainColor) :
                        BigText(text: 'Hi! ${controller.userModel?.name}', color: AppColors.mainColor),
                        Row(
                          children: [
                            controller.userModel?.name == null ?
                            SmallText(text: 'You need to sign in', color: Colors.black54,) :
                            SmallText(text: '${controller.userModel!.phone}', color: Colors.black54,),
                          ],
                        )
                      ],
                    ),
                    Center(
                      child: Container(
                        width: Dimemsions.height45,
                        height: Dimemsions.height45,
                        child: Icon(Icons.search, color: Colors.white, size: 24,),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(Dimemsions.radius15),
                            color: AppColors.mainColor
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Expanded(child: SingleChildScrollView(
              child: BodyFoodPage(),
            )),
          ],
        );
      })
    );
  }
}
