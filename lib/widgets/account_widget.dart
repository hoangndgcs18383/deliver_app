import 'package:deliver_app/utils/dimemsions.dart';
import 'package:deliver_app/widgets/app_icon.dart';
import 'package:deliver_app/widgets/big_text.dart';
import 'package:flutter/material.dart';

class AccountWidget extends StatelessWidget {
  AppIcon appIcon;
  BigText bigText;
  AccountWidget({Key? key,
    required this.appIcon,
    required this.bigText
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: Dimemsions.width20,
        top: Dimemsions.width10,
        bottom: Dimemsions.width10
      ),
      child: Row(
        children: [
          appIcon,
          SizedBox(width: Dimemsions.width20*2,),
          bigText
        ],
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: 1,
            offset: Offset(0, 2),
            color: Colors.grey.withOpacity(0.2)
          )
        ]
      ),
    );
  }
}
