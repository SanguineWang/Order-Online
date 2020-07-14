import 'package:flutter/material.dart';
import 'package:flutter_orderonline/entity/acount_provider.dart';
import 'package:flutter_orderonline/entity/seat_provider.dart';
import 'package:flutter_orderonline/page/login.dart';
import 'package:flutter_orderonline/page/menu.dart';
import 'package:provider/provider.dart';

main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: IndexPage());
  }
}

class IndexPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    MyAcount acount = Provider.of<MyAcount>(context);
    SeatModel seatModel = Provider.of<SeatModel>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        brightness: Brightness.light,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        leading: Container(
          child: CircleAvatar(
              backgroundImage: NetworkImage(acount.avatar), radius: 10),
        ),
        title: Text(
          acount.name,
          style: TextStyle(color: Colors.black),
        ),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.phonelink_off),
              // 下线操作
              onPressed: () => Navigator.of(context).pushAndRemoveUntil(
                  new MaterialPageRoute(builder: (context) => new LoginPage()),
                  (route) => route == null)),
        ],
      ),
      body: ListView.builder(
          itemCount: seatModel.seatList.length,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                leading: Text("房号：${seatModel.seatList[index].id}"),
                title: seatModel.seatList[index].waiter != null
                    ? Text("服务员：${seatModel.seatList[index].waiter}")
                    : Text("空闲"),
                trailing: seatModel.seatList[index].waiter == null
                    ? IconButton(
                        icon: Icon(Icons.chevron_right),
                        onPressed: () {
                          // 开台
                          seatModel.open(
                              seatModel.seatList[index].id, acount.name);
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (context) =>
                                      MyMenu(seatModel.seatList[index].id)),
                              (route) => route == null);
                        },
                      )
                    : Text("已占"),
              ),
            );
          }),
    );
  }
}
