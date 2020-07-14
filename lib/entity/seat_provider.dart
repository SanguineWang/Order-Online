import 'package:flutter/cupertino.dart';
import 'package:flutter_orderonline/entity/cart_provider.dart';

class Seat {
  int id;
  // 订单
  List<Item> order;
  // 服务员
  String waiter;
  Seat(this.id, this.waiter, this.order);
}

class SeatModel with ChangeNotifier {
  List<Seat> _seatList = [
    Seat(1, "赵河", null),
    Seat(2, "安丽", null),
    Seat(3, null, null),
    Seat(4, null, null),
    Seat(5, null, null),
    Seat(6, null, null),
    Seat(7, null, null),
    Seat(8, null, null),
    Seat(9, null, null),
  ];

  @override
  void dispose() {
    super.dispose();
    // _items=null;
    //  notifyListeners();
  }

  void open(int sid, String waiter) {
    Seat seat = _seatList.firstWhere((element) => element.id == sid,
        orElse: () => null);
    if (seat == null) {
      print("没有这个座位");
      return;
    } else {
      seat.waiter = waiter;
      print("$waiter 开启 id 为$sid的座位");
      notifyListeners();
    }
  }

  void close(int sid) {
    Seat seat = _seatList.firstWhere((element) => element.id == sid,
        orElse: () => null);
     if (seat == null) {
      print("没有这个座位");
      return;
    } else {
      print("$seat.waiter 关闭了 id 为$sid的座位");
      seat.waiter = null;
      seat.order = null;
      notifyListeners();
    }    
  }

  // 获取购物车中商品列表
  List<Seat> get seatList => _seatList;
}
