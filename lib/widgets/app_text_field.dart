import 'package:deliver_app/utils/colors.dart';
import 'package:deliver_app/utils/dimemsions.dart';
import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  final TextEditingController textEditingController;
  final String hintText;
  final IconData icon;
  bool isObscure;
  AppTextField({
    Key? key,
    required this.textEditingController,
    required this.hintText,
    required this.icon,
    this.isObscure = false
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: Dimemsions.height20, right: Dimemsions.height20),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(Dimemsions.radius15),
          boxShadow: [
            BoxShadow(
                blurRadius: 5,
                spreadRadius: 3,
                offset: Offset(1, 5),
                color: Colors.grey.withOpacity(0.2)
            )
          ]
      ),
      child: TextField(
        obscureText: isObscure ? true : false,
        controller: textEditingController,
        decoration: InputDecoration(
            hintText: hintText,
            prefixIcon: Icon(icon, color: AppColors.yellowColor,),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(Dimemsions.radius15),
                borderSide: BorderSide(
                  width: 1.0,
                  color: Colors.white,
                )
            ),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(Dimemsions.radius15),
                borderSide: BorderSide(
                  width: 1.0,
                  color: Colors.white,
                )
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(Dimemsions.radius15),
            )
        ),
      ),
    );
  }
}
