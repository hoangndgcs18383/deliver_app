import 'package:deliver_app/utils/colors.dart';
import 'package:deliver_app/utils/dimemsions.dart';
import 'package:deliver_app/widgets/big_text.dart';
import 'package:deliver_app/widgets/icon_and_text_widget.dart';
import 'package:deliver_app/widgets/small_text.dart';
import 'package:flutter/material.dart';

class AppColumn extends StatelessWidget {
  final String text;
  final int star;
  AppColumn({
    Key? key,
    required this.text,
    this.star = 5,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BigText(text: text, size: Dimemsions.font26,),
        SizedBox(height: Dimemsions.height10),
        //comments section
        Row(
          children: [
            Wrap(
              children: List.generate(star, (index) => Icon(Icons.star, color: AppColors.mainColor, size: 14,)),
            ),
            SizedBox(width: 10,),
            SmallText(text: "${star}",),
            SizedBox(width: 10,),
            SmallText(text: "1287",),
            SizedBox(width: 5,),
            SmallText(text: "comments",),
          ],
        ),
        SizedBox(height: Dimemsions.height20,),
        //time and distances
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconAndTextWidget(icon: Icons.circle_sharp, text: "Normal", iconColor: AppColors.iconColor1),
              IconAndTextWidget(icon: Icons.location_on, text: "1.7km", iconColor: AppColors.mainColor),
              IconAndTextWidget(icon: Icons.access_time_rounded, text: "32min", iconColor: AppColors.iconColor2),
            ]
        )
      ],
    );
  }
}
