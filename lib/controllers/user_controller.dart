import 'package:deliver_app/data/repository/user_repo.dart';
import 'package:deliver_app/models/response_model.dart';
import 'package:deliver_app/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserController extends GetxController implements GetxService {
  final UserRepo userRepo;

  UserController({
    required this.userRepo
  });

  bool _isLoading = false;
  UserModel? _userModel;

  bool get isLoading => _isLoading;
  UserModel? get userModel => _userModel;

  //call at repo
  Future<ResponseModel> getUserInfo() async {
    Response response = await userRepo.getUserInfo(); //send response
    late ResponseModel responseModel;
    print(response.body.toString());
    if (response.statusCode == 200) {
      _userModel = UserModel.fromJson(response.body);
      _isLoading = true;
      responseModel = ResponseModel(true, "successfully");
    } else {
      responseModel = ResponseModel(false, response.statusText!);
    }
    update();
    return responseModel;
  }
}