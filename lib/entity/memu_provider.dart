import 'package:flutter/material.dart';

class Product {
  int id;
  String name;
  String image;
  double price;
  Product(this.id, this.image, this.name, this.price);
}

class MemuModel with ChangeNotifier {
  List<Product> _dishes = [];
  List<Product> _drink = [];
  List<Product> _food = [];
  // 也可以声明为listProducts()方法，但是调用时不同
  List<Product> listDishes() {
    return _dishes;
  }

  List<Product> listDrinks() {
    return _drink;
  }

  List<Product> listFood() {
    return _food;
  }

  // 方法名称可以像业务方法一样命名
  loadProduct() async {
    _dishes = await Future.delayed(Duration(seconds: 1), () {
      return [
        Product(
            1,
            "https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=2267244499,786629221&fm=26&gp=0.jpg",
            "佛跳墙",
            500),
        Product(
            2,
            "https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=3008278616,839714892&fm=26&gp=0.jpg",
            "红烧肉",
            80),
        Product(
            3,
            "https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=3209462229,3979021569&fm=26&gp=0.jpg",
            "国家保护动物",
            2800),
        Product(
            4,
            "https://ss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=3287016545,325934971&fm=26&gp=0.jpg",
            "淡水虾",
            70),
        Product(
            5,
            "https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=38723855,675208170&fm=26&gp=0.jpg",
            "智商检测汤",
            50),
        Product(
            6,
            "https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=1229560723,2931222765&fm=26&gp=0.jpg",
            "蟹",
            300)
      ];
    });
    _drink = await Future.delayed(Duration(seconds: 1), () {
      return [
        Product(
            7,
            "https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=3476613669,2398074586&fm=26&gp=0.jpg",
            "米饭",
            2)
      ];
    });
    _food = await Future.delayed(Duration(seconds: 1), () {
      return [
        Product(
            8,
            "https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=2753113174,1926823468&fm=26&gp=0.jpg",
            "五彩缤纷汁",
            10)
      ];
    });
    notifyListeners();
  }
}
