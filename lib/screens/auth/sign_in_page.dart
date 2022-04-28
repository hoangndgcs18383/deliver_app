import 'package:deliver_app/base/custom_loader.dart';
import 'package:deliver_app/base/show_custom_snackbar.dart';
import 'package:deliver_app/controllers/auth_controller.dart';
import 'package:deliver_app/models/sign_up_body_model.dart';
import 'package:deliver_app/routes/route_helper.dart';
import 'package:deliver_app/screens/auth/sign_up_page.dart';
import 'package:deliver_app/utils/colors.dart';
import 'package:deliver_app/utils/dimemsions.dart';
import 'package:deliver_app/widgets/app_text_field.dart';
import 'package:deliver_app/widgets/big_text.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var passwordController = TextEditingController();
    var nameController = TextEditingController();
    var phoneController = TextEditingController();

    var signUpImages = [
      "t.png",
      "f.png",
      "g.png"
    ];

      void _login(AuthController authController){
        String phone = phoneController.text.trim();
        String password = passwordController.text.trim();

        if(phone.isEmpty){
          showCustomSnackBar("Type in your phone", title: "Phone");
        } else if(password.isEmpty){
          showCustomSnackBar("Type in your password", title: "Password");
        } else if(password.length < 6) {
          showCustomSnackBar("Password can be at least more than six characters",
              title: "Password");
        }
        else{
          /*print(signUpBody.toString());*/
          authController.login(phone, password).then((status){
            if(status.isSuccess){
             Get.toNamed(RouteHelper.getInitial());
            } else {
              showCustomSnackBar(status.message);
            }
          });
        }
      }

    return Scaffold(
      backgroundColor: Colors.white,
      body: GetBuilder<AuthController>(builder: (controller){
        return !controller.isLoading ? SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              SizedBox(height: Dimemsions.screenHeight*0.05,),
              //logo
              Container(
                height: Dimemsions.screenHeight*0.25,
                child: Center(
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 80,
                    backgroundImage: AssetImage(
                        "assets/image/logo part 1 edit .png"
                    ),
                  ),
                ),
              ),
              //welcome
              Container(
                margin: EdgeInsets.only(left: Dimemsions.width20*2),
                width: double.maxFinite,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Hello",
                      style: TextStyle(
                          fontSize: Dimemsions.font20*3+Dimemsions.font20/2,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    Text("Sign into your account",
                      style: TextStyle(
                          fontSize: Dimemsions.font20,
                          color: Colors.grey[500]
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: Dimemsions.height20,),
              //email
              AppTextField(
                  textEditingController: phoneController,
                  hintText: "Your Phone...",
                  icon: Icons.email),
              SizedBox(height: Dimemsions.height20,),
              //password
              AppTextField(
                  isObscure: true,
                  textEditingController: passwordController,
                  hintText: "Your Password...",
                  icon: Icons.password_outlined),
              SizedBox(height: Dimemsions.height20,),
              //tag line
              Row(
                children: [
                  Expanded(child: Container()),
                  RichText(
                      text: TextSpan(
                          text: "Sign into your account",
                          style: TextStyle(
                              color: Colors.grey[500],
                              fontSize: Dimemsions.font20
                          )
                      )),
                  SizedBox(width: Dimemsions.width20*2,),
                ],
              ),
              SizedBox(height: Dimemsions.screenHeight*0.05,),
              //sign up button
              GestureDetector(
                onTap: () {
                  _login(controller);
                },
                child: Container(
                  width: Dimemsions.screenWidth/2,
                  height: Dimemsions.screenHeight/13,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimemsions.radius30),
                      color: AppColors.mainColor
                  ),
                  child: Center(
                    child: BigText(
                      text: "Sign Up",
                      size: Dimemsions.font20+Dimemsions.font20/2,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(height: Dimemsions.screenHeight*0.05,),
              //tag line
              RichText(
                  text: TextSpan(
                      text: "Don\'t have an account?",
                      style: TextStyle(
                          color: Colors.grey[500],
                          fontSize: Dimemsions.font16
                      ),
                      children: [
                        TextSpan(
                            recognizer: TapGestureRecognizer()..onTap =
                                () => Get.to(() => SignUpPage(), transition: Transition.fade),
                            text: " Create",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: AppColors.mainBlackColor,
                                fontSize: Dimemsions.font20)
                        )
                      ]
                  )),
              //sign up options
              /*RichText(
                text: TextSpan(
                    text: "Sign up using one of the following methods",
                    style: TextStyle(
                        color: Colors.grey[500],
                        fontSize: Dimemsions.font16
                    )
                )
            ),
            Wrap(
              children:
              List.generate(3, (index) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                  radius: Dimemsions.radius30,
                  backgroundImage: AssetImage(
                      "assets/image/" + signUpImages[index]
                  ),
                ),
              )),
            )*/
            ],
          ),
        ) : CustomLoader();
      })
    );
  }
}
