import 'package:deliver_app/utils/colors.dart';
import 'package:deliver_app/utils/dimemsions.dart';
import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  final TextEditingController textEditingController;
  final String hintText;
  final IconData icon;
  const AppTextField({
    Key? key,
    required this.textEditingController,
    required this.hintText,
    required this.icon
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: Dimemsions.height20, right: Dimemsions.height20),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(Dimemsions.radius30),
          boxShadow: [
            BoxShadow(
                blurRadius: 10,
                spreadRadius: 7,
                offset: Offset(1, 10),
                color: Colors.grey.withOpacity(0.2)
            )
          ]
      ),
      child: TextField(
        controller: textEditingController,
        decoration: InputDecoration(
            hintText: hintText,
            prefixIcon: Icon(icon, color: AppColors.yellowColor,),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(Dimemsions.radius20),
                borderSide: BorderSide(
                  width: 1.0,
                  color: Colors.white,
                )
            ),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(Dimemsions.radius20),
                borderSide: BorderSide(
                  width: 1.0,
                  color: Colors.white,
                )
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(Dimemsions.radius20),
            )
        ),
      ),
    );
  }
}
