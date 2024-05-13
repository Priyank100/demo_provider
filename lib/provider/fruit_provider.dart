import 'package:demo_provider/model/fruit_model.dart';
import 'package:demo_provider/model/fruit_quantity_model.dart';
import 'package:demo_provider/service/api.dart';
import 'package:demo_provider/service/api_service.dart';
import 'package:flutter/cupertino.dart';

class FruitProvider with ChangeNotifier {
  ApiService service = ApiService();

  bool _loading = false;
  bool get loading => _loading;

  List<FruitModel> _fruitList = [];
  List<FruitModel> get fruitList => _fruitList;

  double _total = 0.0;
  double get total => _total;

  Future<void> fetchFruitList() async {
    _cartList.clear();
    _loading = true;
    var response = await service.getApiResponse(API.fruitApi);
    _loading = false;
    if(response.statusCode == 200) {
      _fruitList = List<FruitModel>.from(response.data.map((x) => FruitModel.fromJson(x)));
    } else {
      print('Something went wrong');
    }
    notifyListeners();
  }

  List<FruitModel> _cartList = [];
  List<FruitModel> get cartList => _cartList;

  addProduct(FruitModel product) {
    product.quantity = 1;
    _cartList.add(product);
    totalAmount();
    notifyListeners();
  }

  removeProduct(FruitModel product) {
    product.quantity = 0;
    _cartList.remove(product);
    totalAmount();
    notifyListeners();
  }

  increaseQuantity(FruitModel product) {
    product.quantity = product.qty!.toInt() + 1;
    totalAmount();
    notifyListeners();
  }

  decreaseQuantity(FruitModel product) {
    product.quantity = product.qty!.toInt() - 1;
    totalAmount();
    notifyListeners();
  }

  totalAmount() {
    _total = 0.0;
    for(int i=0; i<_cartList.length; i++) {
      double qty = double.parse(_cartList[i].qty.toString());
      double price = double.parse(_cartList[i].price.toString().split('₹')[1].toString());
      double amount = qty * price;
      _total = _total + amount;
    }
    notifyListeners();
  }

}