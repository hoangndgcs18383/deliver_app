import 'package:deliver_app/base/custom_loader.dart';
import 'package:deliver_app/controllers/auth_controller.dart';
import 'package:deliver_app/controllers/cart_controller.dart';
import 'package:deliver_app/controllers/location_controller.dart';
import 'package:deliver_app/controllers/user_controller.dart';
import 'package:deliver_app/routes/route_helper.dart';
import 'package:deliver_app/utils/colors.dart';
import 'package:deliver_app/utils/dimemsions.dart';
import 'package:deliver_app/widgets/account_widget.dart';
import 'package:deliver_app/widgets/app_icon.dart';
import 'package:deliver_app/widgets/big_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class AccountPage extends StatelessWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool _userLoggedIn = Get.find<AuthController>().userLoggedIn();
    if(_userLoggedIn){
      Get.find<UserController>().getUserInfo();

    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        title: BigText(text: "Profile", size: 24, color: Colors.white,),
      ),
      body: GetBuilder<UserController>(builder: (controller){
        return _userLoggedIn ? (controller.isLoading
            ? Container(
          width: double.maxFinite,
          margin: EdgeInsets.only(top: Dimemsions.height20),
          child: Column(
            children: [
              AppIcon(icon: Icons.person,
                backgroundColor: AppColors.mainColor,
                iconColor: Colors.white,
                iconSize: Dimemsions.height45+Dimemsions.height30,
                size: Dimemsions.height30*5,
              ),
              SizedBox(height: Dimemsions.height30*2,),
              Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        //name
                        AccountWidget(
                            appIcon: AppIcon(icon: Icons.person,
                              backgroundColor: AppColors.mainColor,
                              iconColor: Colors.white,
                              iconSize: Dimemsions.height10*5/2,
                              size: Dimemsions.height10*5,
                            ),
                            bigText: BigText(text: controller.userModel!.name)),
                        SizedBox(height: Dimemsions.height20,),
                        //phone
                        AccountWidget(
                            appIcon: AppIcon(icon: Icons.phone,
                              backgroundColor: AppColors.yellowColor,
                              iconColor: Colors.white,
                              iconSize: Dimemsions.height10*5/2,
                              size: Dimemsions.height10*5,
                            ),
                            bigText: BigText(text: controller.userModel!.phone)),
                        SizedBox(height: Dimemsions.height20,),
                        //email
                        AccountWidget(
                            appIcon: AppIcon(icon: Icons.email,
                              backgroundColor: AppColors.yellowColor,
                              iconColor: Colors.white,
                              iconSize: Dimemsions.height10*5/2,
                              size: Dimemsions.height10*5,
                            ),
                            bigText: BigText(text: controller.userModel!.email)),
                        SizedBox(height: Dimemsions.height20,),
                        //address
                        GetBuilder<LocationController>(builder: (locationController){
                          if(_userLoggedIn && locationController.addressList.isEmpty){
                            return GestureDetector(
                              onTap: (){
                                Get.offNamed(RouteHelper.getAddAddressPage());
                              },
                              child: AccountWidget(
                                  appIcon: AppIcon(icon: Icons.location_on,
                                    backgroundColor: AppColors.yellowColor,
                                    iconColor: Colors.white,
                                    iconSize: Dimemsions.height10*5/2,
                                    size: Dimemsions.height10*5,
                                  ),
                                  bigText: BigText(text: "Fill in your address")),
                            );
                          } else {
                            return AccountWidget(
                                appIcon: AppIcon(icon: Icons.location_on,
                                  backgroundColor: AppColors.yellowColor,
                                  iconColor: Colors.white,
                                  iconSize: Dimemsions.height10*5/2,
                                  size: Dimemsions.height10*5,
                                ),
                                bigText: BigText(text: "Your address"));
                          }
                        }),
                        SizedBox(height: Dimemsions.height20,),
                        //message
                        AccountWidget(
                            appIcon: AppIcon(icon: Icons.message_outlined,
                              backgroundColor: Colors.red,
                              iconColor: Colors.white,
                              iconSize: Dimemsions.height10*5/2,
                              size: Dimemsions.height10*5,
                            ),
                            bigText: BigText(text: "Message")),
                        SizedBox(height: Dimemsions.height20,),
                        GestureDetector(
                          onTap: () {
                            if(Get.find<AuthController>().userLoggedIn()){
                              Get.find<AuthController>().clearSharedData();
                              Get.find<CartController>().clear();
                              Get.find<CartController>().clearCartHistory();
                              Get.find<LocationController>().clearAddressList();
                              Get.offNamed(RouteHelper.getSignInPage());
                            } else {
                              print('you logged out');
                            }
                          },
                          child: AccountWidget(
                              appIcon: AppIcon(icon: Icons.logout,
                                backgroundColor: Colors.green,
                                iconColor: Colors.white,
                                iconSize: Dimemsions.height10*5/2,
                                size: Dimemsions.height10*5,
                              ),
                              bigText: BigText(text: "Log out")),
                        ),
                        SizedBox(height: Dimemsions.height20,),
                      ],
                    ),
                  ))
            ],
          ),
        )
            : CustomLoader())
            : Container(
          child:
          Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: double.maxFinite,
                    height: Dimemsions.height20*8,
                    margin: EdgeInsets.only(left: Dimemsions.width20, right: Dimemsions.width20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimemsions.radius20),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage("assets/image/signintocontinue.png")
                      )
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      Get.toNamed(RouteHelper.getSignInPage());
                    },
                    child: Container(
                      width: double.maxFinite,
                      height: Dimemsions.height20*8,
                      margin: EdgeInsets.only(left: Dimemsions.width20, right: Dimemsions.width20),
                      decoration: BoxDecoration(
                          color: AppColors.mainColor,
                          borderRadius: BorderRadius.circular(Dimemsions.radius20)
                      ),
                      child: Center(child: BigText(text: "Sign in", color: Colors.white, size: Dimemsions.font20,)),
                    ),
                  ),
                ],
              )),
        );
      })
    );
  }
}

