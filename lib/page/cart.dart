import 'package:flutter/material.dart';
import 'package:flutter_orderonline/entity/cart_provider.dart';
import 'package:flutter_orderonline/entity/seat_provider.dart';
import 'package:provider/provider.dart';

import 'index.dart';

class MyCart extends StatelessWidget {
  final int seatId;
  MyCart(this.seatId);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        brightness: Brightness.light,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: buildColumn(context),
    );
  }

  Column buildColumn(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: buildConsumer(),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Price(),
            FlatButton(
              color: Colors.black,
              onPressed: () =>
                  {showDialog(context: context, child: buildSimpleDialog())},
              child: Text("付款",
                  style: TextStyle(color: Colors.white, fontSize: 20)),
            )
          ],
        ),
      ],
    );
  }

  SimpleDialog buildSimpleDialog() {
    return SimpleDialog(
        title: Column(
      children: <Widget>[
        Container(
            padding: EdgeInsets.all(10),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text("请使用微信扫描付款码"),
                  Image.asset("images/code.png"),
                ])),
        Consumer<SeatModel>(builder: (context, seatList, child) {
          return FlatButton(
            color: Colors.black,
            onPressed: () {
              seatList.close(seatId);
              Navigator.of(context).pushAndRemoveUntil(
                  new MaterialPageRoute(builder: (context) => new IndexPage()),
                  (route) => route == null);
            },
            child:
                Text("退房", style: TextStyle(color: Colors.white, fontSize: 20)),
          );
        }),
      ],
    ));
  }

  Consumer<CartModel> buildConsumer() {
    return Consumer<CartModel>(
      builder: (context, cart, child) {
        return ListView.separated(
            itemBuilder: (context, index) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text(
                    '${cart.items[index].product.name}',
                    style: TextStyle(fontSize: 25),
                  ),
                  Text(
                    '${cart.items[index].product.price} × ${cart.items[index].count}',
                    style: TextStyle(fontSize: 25),
                  )
                ],
              );
            },
            separatorBuilder: (context, index) => Divider(),
            itemCount: cart.items.length);
      },
    );
  }
}

class Price extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<CartModel>(
      builder: (context, cart, chlid) {
        return Text(
          '总价：${cart.getTotalPrices()}',
          style: TextStyle(fontSize: 30),
        );
      },
    );
  }
}
