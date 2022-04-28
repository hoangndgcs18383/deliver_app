
import 'package:deliver_app/controllers/popular_product_controller.dart';
import 'package:deliver_app/controllers/recommended_product_controller.dart';
import 'package:deliver_app/models/products_model.dart';
import 'package:deliver_app/routes/route_helper.dart';
import 'package:deliver_app/utils/app_constants.dart';
import 'package:deliver_app/utils/colors.dart';
import 'package:deliver_app/utils/dimemsions.dart';
import 'package:deliver_app/widgets/app_column.dart';
import 'package:deliver_app/widgets/big_text.dart';
import 'package:deliver_app/widgets/icon_and_text_widget.dart';
import 'package:deliver_app/widgets/small_text.dart';
import 'package:flutter/material.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:get/get.dart';

class BodyFoodPage extends StatefulWidget {
  const BodyFoodPage({Key? key}) : super(key: key);

  @override
  State<BodyFoodPage> createState() => _BodyFoodPageState();
}

class _BodyFoodPageState extends State<BodyFoodPage> {
  PageController pageController = PageController(viewportFraction: 0.85);
  var _currPageValue = 0.0;
  double _scaleFactor = 0.8;
  double _height = Dimemsions.pageViewContainer;

  @override
  void initState(){
    super.initState();

    pageController.addListener(() {
      setState(() {
        _currPageValue = pageController.page!;
      });
    });
  }
  @override
  void dispose(){
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //slide section
        GetBuilder<PopularProductController>(builder: (context){
          var count = context.popularProductList.length;
          var itemList = context.popularProductList;

          return context.isLoaded ? Container(
            height: Dimemsions.pageView,
            child: PageView.builder(
                controller: pageController,
                itemCount: count,
                itemBuilder: (context, index){
                  return _buildPageItem(index, itemList[index]);
                }),
          ) : CircularProgressIndicator(
            color: AppColors.mainColor,
          );
        }),
        //dots
        GetBuilder<PopularProductController>(builder: (context){
          var countIsEmpty = context.popularProductList.isEmpty;
          var count = context.popularProductList.length;
          return new DotsIndicator(
            dotsCount: countIsEmpty ? 1 : count,
            position: _currPageValue,
            decorator: DotsDecorator(
              activeColor: AppColors.mainColor,
              size: const Size.square(9.0),
              activeSize: const Size(18.0, 9.0),
              activeShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
            ),
          );
        }),
        //recommend text
        SizedBox(height: Dimemsions.height30,),
        Container(
          margin: EdgeInsets.only(left: Dimemsions.width30),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              BigText(text: "Recommend"),
              SizedBox(width: Dimemsions.width10,),
              Container(
                margin: const EdgeInsets.only(bottom: 3),
                child: BigText(text: ".", color: Colors.black26,),
              ),
              SizedBox(width: Dimemsions.width10,),
              Container(
                margin: const EdgeInsets.only(bottom: 2),
                child: SmallText(text: "Food pairing"),
              )
            ],
          ),
        ),
        //list of food and image
        GetBuilder<RecommendedProductController>(builder: (context){
          var count = context.recommendedProductList.length;
          var item = context.recommendedProductList;
          return context.isLoaded ? ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: count,
              itemBuilder: (context, index){
                return GestureDetector(
                  onTap: () {
                    Get.toNamed(RouteHelper.getRecommendedFood(index, "recommended"));
                  },
                  child: Container(
                    margin: EdgeInsets.only(left: Dimemsions.width20, right: Dimemsions.width20, bottom: Dimemsions.height10),
                    child: Row(
                      children: [
                        //image
                        Container(
                          width: Dimemsions.listViewImgSize,
                          height: Dimemsions.listViewImgSize,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(Dimemsions.radius20),
                              color: Colors.white38,
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(
                                      AppConstants.BASE_URL + AppConstants.UPLOAD_URL + item[index].img!
                                  )
                              )
                          ),
                        ),
                        //text
                        Expanded(
                          child: Container(
                            height: Dimemsions.listViewTextContSize,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(Dimemsions.radius20),
                                  bottomRight: Radius.circular(Dimemsions.radius20)
                              ),
                              color: Colors.white,
                            ),
                            child: Padding(
                              padding: EdgeInsets.only(left: Dimemsions.width10, right: Dimemsions.width10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  BigText(text: item[index].name!),
                                  SizedBox(height: Dimemsions.height10,),
                                  Expanded(child: SmallText(text: item[index].description!)),
                                  SizedBox(height: Dimemsions.height10,),
                                  Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        IconAndTextWidget(icon: Icons.circle_sharp, text: "Normal", iconColor: AppColors.iconColor1),
                                        IconAndTextWidget(icon: Icons.location_on, text: "1.7km", iconColor: AppColors.mainColor),
                                        IconAndTextWidget(icon: Icons.access_time_rounded, text: "32min", iconColor: AppColors.iconColor2),
                                      ]
                                  )
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              }) : CircularProgressIndicator(
            color: AppColors.mainColor,
          );
        }),
      ],
    );
  }

  Widget _buildPageItem(int index, ProductModel item){
    Matrix4 matrix4 = new Matrix4.identity();
    if(index == _currPageValue.floor()){
      var currScale = 1 - (_currPageValue - index) * (1 - _scaleFactor);
      var currTrans = _height*(1 - currScale)/2;
      matrix4 = Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0, currTrans, 0);
    } else if (index == _currPageValue.floor() + 1){
      var currScale = _scaleFactor + (_currPageValue - index + 1) * (1 - _scaleFactor);
      var currTrans = _height*(1 - currScale)/2;
      matrix4 = Matrix4.diagonal3Values(1, currScale, 1);
      matrix4 = Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0, currTrans, 0);
    } else if (index == _currPageValue.floor() - 1){
      var currScale = 1 - (_currPageValue - index) * (1 - _scaleFactor);
      var currTrans = _height*(1 - currScale)/2;
      matrix4 = Matrix4.diagonal3Values(1, currScale, 1);
      matrix4 = Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0, currTrans, 0);
    } else {
      var currScale = 0.8;
      var currTrans = _height*(1 - currScale)/2;
      matrix4 = Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0, currTrans, 0);
    }

    return Transform(
      transform: matrix4,
      child: Stack(
        children: [
            GestureDetector(
              onTap: () {
                Get.toNamed(RouteHelper.getPopularFood(index, "popular_page"));
              },
              child: Container(
              height: Dimemsions.pageViewContainer,
              margin: EdgeInsets.only(left: Dimemsions.width10, right: Dimemsions.width10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimemsions.radius30),
                  color: index.isEven ? Color(0xFF69c5df) : Color(0xFF9294cc),
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                          AppConstants.BASE_URL + AppConstants.UPLOAD_URL + item.img!
                      )
                  )
              ),
          ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
              height: Dimemsions.pageViewTextContainer,
              margin: EdgeInsets.only(left: Dimemsions.width30, right: Dimemsions.width30, bottom: Dimemsions.height30),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimemsions.radius20),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xFFe8e8e8),
                      blurRadius: 5.0,
                      offset: Offset(0, 5)
                    ),
                    BoxShadow(
                      color: Colors.white,
                      offset: Offset(-5, 0)
                    ),
                    BoxShadow(
                        color: Colors.white,
                        offset: Offset(5, 0)
                    )
                  ]
                ),
                child: Container(
                  padding: EdgeInsets.only(top: Dimemsions.height15, left: 15, right: 15),
                  child: AppColumn(text: item.name!, star: item.stars!,)
                ),
              ),
            )
        ],
      ),
    );
  }
}
