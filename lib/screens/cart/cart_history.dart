import 'dart:convert';

import 'package:deliver_app/base/no_data_page.dart';
import 'package:deliver_app/controllers/cart_controller.dart';
import 'package:deliver_app/models/cart_model.dart';
import 'package:deliver_app/routes/route_helper.dart';
import 'package:deliver_app/utils/app_constants.dart';
import 'package:deliver_app/utils/colors.dart';
import 'package:deliver_app/utils/dimemsions.dart';
import 'package:deliver_app/widgets/app_icon.dart';
import 'package:deliver_app/widgets/big_text.dart';
import 'package:deliver_app/widgets/small_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';


class CartHistory extends StatelessWidget {
  const CartHistory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var getCartHistoryList = Get.find<CartController>()
        .getCartHistoryList().reversed.toList();

    Map<String, int> cartItemsPerOrder = Map();

    for(int i = 0; i < getCartHistoryList.length; i++){
      var time = getCartHistoryList[i].time;
      if(cartItemsPerOrder.containsKey(time)){
        cartItemsPerOrder.update(time!, (value) => ++value);
      }
      else{
        cartItemsPerOrder.putIfAbsent(time!, () => 1);
      }
    }

    List<int> cartItemsPerOrderToList(){
      return cartItemsPerOrder.entries.map((e) => e.value).toList();
    }

    List<String> cartOderTimeToList(){
      return cartItemsPerOrder.entries.map((e) => e.key).toList();
    }

    List<int> itemsPerOrder = cartItemsPerOrderToList();

    var listCounter = 0;

    Widget timeWidget(int index){
      var date = DateTime.now().toString();
      if(index < getCartHistoryList.length){
        var time = getCartHistoryList[listCounter].time!;
        DateTime parseDate = DateFormat("yyyy-MM-dd HH:mm:ss").parse(time);
        var inputDate = DateTime.parse(parseDate.toString());
        var dateFormat = DateFormat("MM/dd/yyyy hh:mm a");
        date = dateFormat.format(inputDate);
      }
      return BigText(text: date,);
    }

    return Scaffold(
      body: Column(
        children: [
          Container(
            color: AppColors.mainColor,
            width: double.maxFinite,
            height: Dimemsions.height10*10,
            padding: EdgeInsets.only(top: Dimemsions.height45),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                BigText(text: "Cart History", color: Colors.white,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: (){
                        Get.toNamed(RouteHelper.getCartPage());
                      },
                      child: AppIcon(icon: Icons.shopping_cart_outlined,
                        iconColor: AppColors.mainColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          GetBuilder<CartController>(builder: (cartController){
            return cartController.getCartHistoryList().length > 0
                ? Expanded(
              child: Container(
                  margin: EdgeInsets.only(
                      top: Dimemsions.height10,
                      left: Dimemsions.width20,
                      right: Dimemsions.width20
                  ),
                  child: MediaQuery.removePadding(context: context,
                    removeTop: true,
                    child: ListView(
                      children: [
                        for(int i = 0; i < itemsPerOrder.length; i++)
                          Container(
                            height: Dimemsions.height30*4,
                            margin: EdgeInsets.only(bottom: Dimemsions.height20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                timeWidget(listCounter),
                                SizedBox(height: Dimemsions.height10,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Wrap(
                                      direction: Axis.horizontal,
                                      children:
                                      List.generate(itemsPerOrder[i], (index) {
                                        if(listCounter < getCartHistoryList.length){
                                          listCounter++;
                                        }
                                        return index <= 2 ? Container(
                                          height: Dimemsions.height20*4,
                                          width: Dimemsions.height20*4,
                                          margin: EdgeInsets.only(right: Dimemsions.width10),
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(Dimemsions.radius15/2),
                                              image: DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: NetworkImage(
                                                      AppConstants.BASE_URL + AppConstants.UPLOAD_URL + getCartHistoryList[listCounter-1].img!
                                                  )
                                              )
                                          ),
                                        ) : Container();
                                      }),
                                    ),
                                    Container(
                                      height: Dimemsions.height20*4,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          SmallText(text: "Total", color: AppColors.titleColor,),
                                          BigText(text:  "${itemsPerOrder[i]} Items", color: AppColors.titleColor,),
                                          GestureDetector(
                                            onTap: () {
                                              var orderTime = cartOderTimeToList();
                                              Map<int, CartModel> modelOrder = {};
                                              for(int j = 0; j < getCartHistoryList.length; j++){
                                                if(getCartHistoryList[i].time == orderTime[i]){
                                                  modelOrder.putIfAbsent(getCartHistoryList[j].id!, () =>
                                                      CartModel.fromJson(jsonDecode(jsonEncode(getCartHistoryList[j])))
                                                  );
                                                }
                                              }
                                              Get.find<CartController>().setItems = modelOrder;
                                              Get.find<CartController>().addToCartList();
                                              Get.toNamed(RouteHelper.getCartPage());
                                            },
                                            child: Container(
                                              padding: EdgeInsets.symmetric(horizontal: Dimemsions.width10, vertical: Dimemsions.height10/2),
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(Dimemsions.radius20/4),
                                                border: Border.all(width: 1, color: AppColors.mainColor),
                                              ),
                                              child: SmallText(text: "one more", color: AppColors.mainColor,),
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          )
                      ],
                    ),)
              ),
            )
                : SizedBox(
                height: MediaQuery.of(context).size.height/1.5,
                child: Center(
                    child: NoDataPage(text: "You didn't buy anything so far !", imgPath: "assets/image/empty_box.png",)));
          })
        ],
      ),
    );
  }
}
