import 'package:deliver_app/controllers/cart_controller.dart';
import 'package:deliver_app/data/repository/popular_product_repo.dart';
import 'package:deliver_app/models/cart_model.dart';
import 'package:deliver_app/models/products_%20model.dart';
import 'package:deliver_app/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PopularProductController extends GetxController {
  final PopularProductRepo popularProductRepo;
  PopularProductController({required this.popularProductRepo});
  List<dynamic> _popularProductList = [];
  List<dynamic> get popularProductList => _popularProductList;
  late CartController _cart;

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  int _quantity = 0;
  int get quantity => _quantity;

  int _inCartItems = 0;
  int get inCartItems => _inCartItems + _quantity;

  void initProduct(ProductModel product ,CartController cart){
    _quantity = 0;
    _inCartItems= 0;
    _cart = cart;
    var exist = false;
    exist = _cart.exitsInCart(product);
    print("exist or not " + exist.toString());
    if(exist){
      _inCartItems = _cart.getQuantity(product);
    }
    // print("the quanlity in the cart is " + _inCartItems.toString());
    //get from storage
  }

  Future<void> getPopularProductList() async {
    Response response = await popularProductRepo.getPopularProductList();
    if(response.statusCode == 200){
      _popularProductList = [];
      _popularProductList.addAll(Product.fromJson(response.body).products!);
      print(_popularProductList);
      _isLoaded = true;
      update();
    } else {

    }
  }

  void setQuantity(bool isIncrement){
    if(isIncrement){
      _quantity = checkQuantity(_quantity + 1);
    } else {
      _quantity = checkQuantity(_quantity - 1);
    }
    update();
  }
  //logic check quantity
  int checkQuantity(int quantity) {
    var cal = _inCartItems + quantity;
    if(cal < 0){
      Get.snackbar("Item count", "You can't reduce more !",
          backgroundColor: AppColors.mainColor,
          colorText: Colors.white
      );
      if(_inCartItems > 0) {
        _quantity = -inCartItems;
        return _quantity;
      }
      return 0;
    }
    else if (cal > 20){
      Get.snackbar("Item count", "You can't add more !",
          backgroundColor: AppColors.mainColor,
          colorText: Colors.white
      );
      return 20;
    } else {
      return quantity;
    }
  }

  void addItem(ProductModel product){
    _cart.addItem(product, _quantity);
    _quantity = 0;
    _inCartItems = _cart.getQuantity(product);
    _cart.items.forEach((key, value) {
      // print("The id is " + value.id.toString() + "The quantity is " + value.quantity.toString());
    });
    update();
  }

  int get totalItems {
    return _cart.totalItems;
  }

  List<CartModel> get getItems {
    return _cart.getItems;
  }
}