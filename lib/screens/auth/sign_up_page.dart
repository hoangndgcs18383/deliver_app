import 'package:deliver_app/base/custom_loader.dart';
import 'package:deliver_app/base/show_custom_snackbar.dart';
import 'package:deliver_app/controllers/auth_controller.dart';
import 'package:deliver_app/models/sign_up_body_model.dart';
import 'package:deliver_app/routes/route_helper.dart';
import 'package:deliver_app/utils/colors.dart';
import 'package:deliver_app/utils/dimemsions.dart';
import 'package:deliver_app/widgets/app_text_field.dart';
import 'package:deliver_app/widgets/big_text.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var nameController = TextEditingController();
    var phoneController = TextEditingController();

    var signUpImages = [
      "t.png",
      "f.png",
      "g.png"
    ];

    void _registration(AuthController authController){
      String email = emailController.text.trim();
      String name =  nameController.text.trim();
      String password = passwordController.text.trim();
      String phone = phoneController.text.trim();

      if(email.isEmpty){
        showCustomSnackBar("Type in your email", title: "Email");
      } else if(!GetUtils.isEmail(email)){
        showCustomSnackBar("Type in a valid email address", title: "Address");
      } else if(password.isEmpty){
        showCustomSnackBar("Type in your password", title: "Password");
      } else if(password.length < 6){
        showCustomSnackBar("Password can be at least more than six characters", title: "Password");
      } else if(name.isEmpty){
        showCustomSnackBar("Type in your name", title: "Name");
      } else if(phone.isEmpty){
        showCustomSnackBar("Type in your phone", title: "Phone");
      }
      else{
        SignUpBody signUpBody = SignUpBody(
            name: name,
            phone: phone,
            email: email,
            password: password);
        /*print(signUpBody.toString());*/
        authController.registration(signUpBody).then((status){
          if(status.isSuccess){
            Get.offNamed(RouteHelper.getInitial());
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
              //email
              AppTextField(
                  textEditingController: emailController,
                  hintText: "Email",
                  icon: Icons.email),
              SizedBox(height: Dimemsions.height20,),
              //password
              AppTextField(
                  isObscure: true,
                  textEditingController: passwordController,
                  hintText: "Password",
                  icon: Icons.password_outlined),
              SizedBox(height: Dimemsions.height20,),
              //name
              AppTextField(
                  textEditingController: nameController,
                  hintText: "Name",
                  icon: Icons.person),
              SizedBox(height: Dimemsions.height20,),
              //phone
              AppTextField(
                  textEditingController: phoneController,
                  hintText: "Phone",
                  icon: Icons.phone),
              SizedBox(height: Dimemsions.height20+Dimemsions.height20,),
              //sign up button
              GestureDetector(
                onTap: (){
                  _registration(controller);
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
              SizedBox(height: Dimemsions.height10,),
              //tag line
              RichText(
                  text: TextSpan(
                      recognizer: TapGestureRecognizer()..onTap = () => Get.back(),
                      text: "Have an account already?",
                      style: TextStyle(
                          color: Colors.grey[500],
                          fontSize: Dimemsions.font20
                      )
                  )),
              SizedBox(height: Dimemsions.screenHeight*0.02,),
              //sign up options
              RichText(
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
              )
            ],
          ),
        ) : CustomLoader();
      })
    );

  }
}
