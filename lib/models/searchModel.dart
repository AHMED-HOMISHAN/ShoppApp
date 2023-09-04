// ignore_for_file: file_names

class SearchDataModel {
  late bool status;
  String? message;
  SearchData? data;

  SearchDataModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? SearchData.fromJson(json['data']) : null;
  }
}

class SearchData {
  List<Product> data = [];

  SearchData.fromJson(Map<String, dynamic> json) {
    json['data'].forEach((element) {
      data.add(Product.fromJson(element));
    });
  }
}

class Product {
  late int id;
  late dynamic price;
  dynamic oldPrice;
  late String name;
  late dynamic discount;
  late String image;
  late bool inSearchs;
  late bool inCart;
  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    name = json['name'];
    discount = json['discount'];
    image = json['image'];
    inSearchs = json['in_Searchs'] ?? false;
    inCart = json['in_cart'] ?? false;
  }
}
