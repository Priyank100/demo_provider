class FruitModel {
  FruitModel({
      int? id,
      String? image, 
      String? title, 
      String? price,
      int? qty=0}){
    _id = id;
    _image = image;
    _title = title;
    _price = price;
    _qty = qty;
}

  FruitModel.fromJson(dynamic json) {
    _id = json['id'];
    _image = json['image'];
    _title = json['title'];
    _price = json['price'];
  }
  int? _id;
  String? _image;
  String? _title;
  String? _price;
  int? _qty = 0;

  int? get id => _id;
  String? get image => _image;
  String? get title => _title;
  String? get price => _price;
  int? get qty => _qty;

  set quantity(int value) {
    _qty = value;
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['image'] = _image;
    map['title'] = _title;
    map['price'] = _price;
    map['qty'] = _qty;
    return map;
  }

}