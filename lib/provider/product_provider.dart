import 'package:demo_provider/model/product_model.dart';
import 'package:flutter/cupertino.dart';

class ProductProvider with ChangeNotifier {

  List<ProductModel> _cartList = [];
  List<ProductModel> get cartList => _cartList;

  addProduct(ProductModel product) {
    _cartList.add(product);
    notifyListeners();
  }

  removeProduct(ProductModel product) {
    _cartList.remove(product);
    notifyListeners();
  }
}