import 'package:flutter/material.dart';
import 'package:food_delivery/app/colors.dart';
import 'package:food_delivery/controllers/cart_controller.dart';
import 'package:food_delivery/data/repository/popular_product_repo.dart';
import 'package:food_delivery/models/products_model.dart';
import 'package:get/get.dart';

class PopularProductController extends GetxController{
  final PopularProductRepo popularProductRepo;
  PopularProductController({required this.popularProductRepo});

  List<ProductModel> _popularProductList = [];
  List<ProductModel> get popularProductList => _popularProductList;
  late CartController _cart;
  
  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  int _quantity = 0;
  int get quantity => _quantity;
  int _inCartItems=0;
  int get inCartItems=>_inCartItems + _quantity;

  Future<void> getPopularProductList() async {
    Response response = await popularProductRepo.getPopularProductList();
    if(response.statusCode == 200){
      print("got products");
      _popularProductList = [];
      _popularProductList.addAll(Product.fromJson(response.body).products);
      _isLoaded = true;
      update(); 
    }else{
      
    }
  }
  // tang giam so luong dat hang
  
  void setQuantity(bool isIncrement){
    if(isIncrement){
      //print("tang so luong: " +  _quantity.toString());
      _quantity=checkQuantity(_quantity+1);
    }else{
      //print("giam so luong: " + _quantity.toString());
        _quantity=checkQuantity(_quantity-1);
      
    }
    update();
  }
  // thong bao vuot qua so luong dat hang
  int checkQuantity(int quantity){
    if(quantity < 0){
      Get.snackbar("Item count", "You ca't reduce more",
      backgroundColor: AppColors.mainColor,
      colorText: Colors.white,
      );
      return 0;
    }else if(quantity > 20){
      Get.snackbar("Item count", "You ca't reduce more",
      backgroundColor: AppColors.mainColor,
      colorText: Colors.white,
      );
      return 20;
    }else{
      return quantity;
    }
  }
  // khoi tao so luong dat hang la 0
  void initProduct(CartController cart){
    _quantity = 0;
    _inCartItems = 0;
    _cart = cart;
    // if exist in storage
    
    //get from storage _inCartItems = 0;
  }

  void addItem(ProductModel product){
    if(quantity>0){
      _cart.addItem(product, _quantity);
      _quantity = 0;
      _cart.items.forEach((key, value) {
        print("The id is "+ value.id.toString() +",the quantity: " + value.quantity.toString());
        
      });
    }else{
      Get.snackbar("Item count", "Please select item count",
      backgroundColor: AppColors.mainColor,
      colorText: Colors.white,
      );
    }
  }
}