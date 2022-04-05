import 'package:deliver_app/utils/colors.dart';
import 'package:deliver_app/utils/dimemsions.dart';
import 'package:deliver_app/widgets/account_widget.dart';
import 'package:deliver_app/widgets/app_icon.dart';
import 'package:deliver_app/widgets/big_text.dart';
import 'package:flutter/material.dart';


class AccountPage extends StatelessWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        title: BigText(text: "Profile", size: 24, color: Colors.white,),
      ),
      body: Container(
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
                      bigText: BigText(text: "HoangNguyen")),
                  SizedBox(height: Dimemsions.height20,),
                  //phone
                  AccountWidget(
                      appIcon: AppIcon(icon: Icons.phone,
                        backgroundColor: AppColors.yellowColor,
                        iconColor: Colors.white,
                        iconSize: Dimemsions.height10*5/2,
                        size: Dimemsions.height10*5,
                      ),
                      bigText: BigText(text: "0965280940")),
                  SizedBox(height: Dimemsions.height20,),
                  //email
                  AccountWidget(
                      appIcon: AppIcon(icon: Icons.email,
                        backgroundColor: AppColors.yellowColor,
                        iconColor: Colors.white,
                        iconSize: Dimemsions.height10*5/2,
                        size: Dimemsions.height10*5,
                      ),
                      bigText: BigText(text: "hoangndgcs18383@gmail.com")),
                  SizedBox(height: Dimemsions.height20,),
                  //address
                  AccountWidget(
                      appIcon: AppIcon(icon: Icons.location_on,
                        backgroundColor: AppColors.yellowColor,
                        iconColor: Colors.white,
                        iconSize: Dimemsions.height10*5/2,
                        size: Dimemsions.height10*5,
                      ),
                      bigText: BigText(text: "Fill your address")),
                  SizedBox(height: Dimemsions.height20,),
                  //message
                  AccountWidget(
                      appIcon: AppIcon(icon: Icons.message_outlined,
                        backgroundColor: Colors.red,
                        iconColor: Colors.white,
                        iconSize: Dimemsions.height10*5/2,
                        size: Dimemsions.height10*5,
                      ),
                      bigText: BigText(text: "HoangNguyen")),
                  SizedBox(height: Dimemsions.height20,),
                  AccountWidget(
                      appIcon: AppIcon(icon: Icons.message_outlined,
                        backgroundColor: Colors.red,
                        iconColor: Colors.white,
                        iconSize: Dimemsions.height10*5/2,
                        size: Dimemsions.height10*5,
                      ),
                      bigText: BigText(text: "HoangNguyen")),
                  SizedBox(height: Dimemsions.height20,),
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
}

