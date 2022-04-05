import 'package:deliver_app/screens/home/body_food_page.dart';
import 'package:deliver_app/utils/colors.dart';
import 'package:deliver_app/utils/dimemsions.dart';
import 'package:deliver_app/widgets/big_text.dart';
import 'package:deliver_app/widgets/small_text.dart';
import 'package:flutter/material.dart';

class MainFoodPage extends StatefulWidget {
  const MainFoodPage({Key? key}) : super(key: key);

  @override
  State<MainFoodPage> createState() => _MainFoodPageState();
}

class _MainFoodPageState extends State<MainFoodPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
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
                      BigText(text: "HoangNguyen", color: AppColors.mainColor),
                      Row(
                        children: [
                          SmallText(text: "TPHCM", color: Colors.black54,),
                          Icon(Icons.arrow_drop_down_rounded)
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
      )
    );
  }
}
