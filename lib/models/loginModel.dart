// ignore_for_file: file_names

class ShopLoginModel {
  bool status = false;
  String massage = '';
  UserData? data;
  ShopLoginModel({
    required this.status,
    required this.massage,
    required this.data,
  });

  ShopLoginModel.fromJson(Map<dynamic, dynamic> json) {
    status = json['status'];
    massage = json['message'] ?? 'No Message';
    data = json['data'] != null ? UserData.fromJson(json['data']) : null;
  }
}

class UserData {
  int id = 0;
  String name = '';
  String email = '';
  String phone = '';
  String image = '';
  int points = 0;
  int credit = 0;
  String token = '';

  //named Constructor

  UserData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    image = json['image'];
    points = json['points'];
    credit = json['credit'];
    token = json['token'];
  }
}
