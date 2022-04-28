import 'package:deliver_app/utils/dimemsions.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback? onPress;
  final String buttonText;
  final bool transparent;
  final EdgeInsets? margin;
  final double? height;
  final double? width;
  final double? fontSize;
  final double radius;
  final IconData? icon;

  CustomButton({
    Key? key,
    required this.buttonText,
    this.onPress,
    this.transparent = false,
    this.margin,
    this.height,
    this.width,
    this.fontSize,
    this.radius = 5,
    this.icon
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ButtonStyle _flatButton = TextButton.styleFrom(
      backgroundColor: onPress == null ?
      Theme.of(context).disabledColor :
          transparent ?
          Colors.transparent :
              Theme.of(context).primaryColor,
      minimumSize: Size(
          width == null ? Dimemsions.screenWidth : width!,
          height != null ? height! : 50),
      padding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius)
      )
    );
    return Center(
      child: SizedBox(
        width: width ?? Dimemsions.screenWidth,
        height: height ?? 50,
        child: TextButton(
          onPressed: onPress,
          style: _flatButton,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            icon != null ?
            Padding(
                padding: EdgeInsets.only(
                    right: Dimemsions.width10/2),
                  child: Icon(icon,
                    color: transparent ?
                    Theme.of(context).primaryColor :
                    Theme.of(context).cardColor,),
            ) :
            SizedBox(),
              Text(buttonText ?? "", style: TextStyle(
                fontSize: fontSize != null ? fontSize : Dimemsions.font16,
                color: transparent ?
                Theme.of(context).primaryColor :
                Theme.of(context).cardColor),)
            ],
          ),
        ),
      ),
    );
  }
}
