import 'package:deliver_app/data/repository/cart_repo.dart';
import 'package:deliver_app/models/cart_model.dart';
import 'package:deliver_app/models/products_model.dart';
import 'package:deliver_app/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartController extends GetxController{
  final CartRepo cartRepo;
  CartController({required this.cartRepo});
  Map<int, CartModel> _items = {};

  Map<int, CartModel> get items => _items;

  List<CartModel> storageItems = [];

  void addItem(ProductModel product, int quantity){
    var totalQuantity = 0;
    if(_items.containsKey(product.id!)){
      _items.update(product.id!, (value) {
        totalQuantity = value.quantity! + quantity;
        return CartModel(
          id: product.id,
          name: product.name,
          price: product.price,
          img: product.img,
          quantity: value.quantity! + quantity,
          isExit: true,
          time: DateTime.now().toString(),
          product: product
        );
      });
      if(totalQuantity <= 0){
        _items.remove(product.id);
      }
    } else {
      if(quantity > 0) {
          _items.putIfAbsent(product.id!, ()
          {
            return CartModel(
              id: product.id,
              name: product.name,
              price: product.price,
              img: product.img,
              quantity: quantity,
              isExit: true,
              time: DateTime.now().toString(),
              product: product
            );
          }
        );
      }
      else {
        Get.snackbar("Item count", "You should at least add an item in the cart !",
            backgroundColor: AppColors.mainColor,
            colorText: Colors.white
        );
      }
    }
    addToCartList();
  }

  bool exitsInCart(ProductModel product){
    if(_items.containsKey(product.id)){
      return true;
    }
    return false;
  }

  getQuantity(ProductModel product){
    var quantity = 0;
    if(_items.containsKey(product.id)){
      _items.forEach((key, value) {
        if(key == product.id){
          quantity = value.quantity!;
        }
      });
    }
    return quantity;
  }

  int get totalItems {
    var totalQuantity = 0;
    _items.forEach((key, value) {
      totalQuantity += value.quantity!;
    });
    return totalQuantity;
  }

  int get totalAmounts {
    var total = 0;
      _items.forEach((key, value) {
        total += value.quantity! * value.price!;
      });
    return total;
  }

  List<CartModel> get getItems{
    return _items.entries.map((e) {
      return e.value;
    }).toList();
  }

  List<CartModel> getCartData(){
    setCart = cartRepo.getCartList();
    return storageItems;
  }
    set setCart(List<CartModel> items){
      storageItems = items;
      print("Length of cart item" + storageItems.length.toString());
      for(int i = 0; i < storageItems.length; i++){
        var id = storageItems[i].product!.id!;
        _items.putIfAbsent(id, () => storageItems[i]);
      }
    }


  void addToHistory(){
    cartRepo.addToCartHistoryList();
    clear();
  }

  void clear(){
    _items={};
    update();
  }

  List<CartModel> getCartHistoryList(){
    return cartRepo.getCartHistoryList();
  }
  set setItems(Map<int, CartModel> setItems){
    _items = {};
    _items = setItems;
  }

  void addToCartList(){
    cartRepo.addToCartList(getItems);
    update();
  }

  void clearCartHistory(){
    cartRepo.clearCartHistory();
    update();
  }
}
