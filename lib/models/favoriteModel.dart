// ignore_for_file: file_names

class FavoriteModel {
  late bool status;
  String message = '';
  FavoriteModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
  }
}

class FavoriteDataModel {
  late bool status;
  String message = '';
  FavoriteData? data;

  FavoriteDataModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'] ?? "No Message";
    data = json['data'] != null ? FavoriteData.fromJson(json['data']) : null;
  }
}

class FavoriteData {
  List<Data> data = [];

  FavoriteData.fromJson(Map<String, dynamic> json) {
    json['data'].forEach((element) {
      data.add(Data.fromJson(element));
    });
  }
}

class Data {
  late int id;
  Product? products;

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    products =
        json['product'] != null ? Product.fromJson(json['product']) : null;
  }
}

class Product {
  late int id;
  late dynamic price;
  late dynamic oldPrice;
  late String name;
  late dynamic discount;
  late String image;

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    name = json['name'];
    discount = json['discount'];
    image = json['image'];
  }
}
