import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_orderonline/entity/acount_provider.dart';
import 'package:flutter_orderonline/entity/cart_provider.dart';
import 'package:flutter_orderonline/entity/memu_provider.dart';
import 'package:flutter_orderonline/entity/seat_provider.dart';
import 'package:flutter_orderonline/page/index.dart';
import 'package:provider/provider.dart';

main() {
  runApp(MyApp());
  final SystemUiOverlayStyle _style =
      SystemUiOverlayStyle(statusBarColor: Colors.transparent);
  SystemChrome.setSystemUIOverlayStyle(_style);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => MyAcount(),
        ),
        ChangeNotifierProvider(
          create: (context) => MemuModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => CartModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => SeatModel(),
        )
      ],
      child: MaterialApp(debugShowCheckedModeBanner: false, home: LoginPage()),
    );
  }
}

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _phoneNumberController;

  TextEditingController _passwordController;
  //账号
  String number = "";
  //密码
  String password = "";
  @override
  Widget build(BuildContext context) {
    @override
    // ignore: unused_element
    void initState() {
      _phoneNumberController = TextEditingController();
      _passwordController = TextEditingController();
      super.initState();
    }

    return Scaffold(
        appBar: buildAppBar(),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(left: 40, right: 40),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  buildIcon(),
                  Container(
                    child: Text('欢迎使用', style: TextStyle(fontSize: 28)),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 40),
                    child: Text('账号', style: TextStyle(fontSize: 14)),
                  ),
                  buildNumber(),
                  Container(
                    padding: EdgeInsets.only(top: 10),
                    child: Text('密码', style: TextStyle(fontSize: 14)),
                  ),
                  buildPassWord(),
                  buildLoginButton(),
                  GestureDetector(
                    child: Text('忘记密码',
                        style: TextStyle(fontSize: 14, color: Colors.grey)),
                    onTap: () {
                      print('忘记密码');
//                   Navigator.push(context, MaterialPageRoute(builder: (context) =>Agreement()));
                    },
                  ),
                  buildRegisterButton()
                ]),
          ),
        ));
  }

  Container buildRegisterButton() {
    return Container(
      alignment: Alignment(0.0, -1.0),
      padding: EdgeInsets.only(top: 50),
      child: GestureDetector(
        child: Text('注册账号',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18, color: Colors.grey)),
        onTap: () {
          print('注册账号');
//                   Navigator.push(context, MaterialPageRoute(builder: (context) =>Agreement()));
        },
      ),
    );
  }

  Container buildIcon() {
    return Container(
      padding: EdgeInsets.only(bottom: 20),
      child: CircleAvatar(
          backgroundImage: NetworkImage(
              'https://t8.baidu.com/it/u=3571592872,3353494284&fm=79&app=86&size=h300&n=0&g=4n&f=jpeg?sec=1589212401&t=35519f0def1b6d8e99be80a142dea0f3')),
    );
  }

  Container buildNumber() {
    return Container(
        decoration: BoxDecoration(
            border: Border(bottom: BorderSide(width: 0.4, color: Colors.grey))),
        child: TextFormField(
          onChanged: (val) {
            setState(() {
              print(number);
              number = val;
            });
          },
          keyboardType: TextInputType.number,
          controller: _phoneNumberController,
          decoration: InputDecoration(
            hintText: "请输入手机号码",
            border: InputBorder.none,
          ),
        ));
  }

  Container buildPassWord() {
    return Container(
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(width: 0.4, color: Colors.grey))),
      child: TextFormField(
        obscureText:true,
        onChanged: (val) {
          print('$password');
          setState(() {
            password = val;
          });
        },
        
        keyboardType: TextInputType.text,
        controller: _passwordController,
        decoration: InputDecoration(
          hintText: "请输入密码",
          border: InputBorder.none,
        ),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      brightness: Brightness.light,
      elevation: 0,
      iconTheme: IconThemeData(color: Colors.black),
      backgroundColor: Colors.transparent,
    );
  }

  login() async {
    await Future.delayed(Duration(seconds: 1), () {
      print("登录");
      Navigator.of(context).pushAndRemoveUntil(
          new MaterialPageRoute(builder: (context) => new IndexPage()),
          (route) => route == null);
    });
  }

  checkInput() {
    //  账号密码检测
    if (number == null || number == "") {
      openDialog("登录失败", "账号不能为空");
    }
    if (password == null || password == "") {
      openDialog("登录失败", "密码不能为空");
    }
    if (number == "1234" && password == "1234") {
      final acount = Provider.of<MyAcount>(context, listen: false);

      acount.number = "1234";
      acount.name = "王三多";
      acount.avatar =
          "https://t8.baidu.com/it/u=3571592872,3353494284&fm=79&app=86&size=h300&n=0&g=4n&f=jpeg?sec=1589212401&t=35519f0def1b6d8e99be80a142dea0f3";

      showDialog(
          context: context,
          child: SimpleDialog(
              title: Container(
                  padding: EdgeInsets.all(10),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("加载中"),
                        CircularProgressIndicator(),
                      ]))));
      login();

      // Navigator.push(
      //     context, MaterialPageRoute(builder: (context) => IndexPage()));
    } else {
      openDialog("登陆失败", "账号或密码错误");
    }
  }

  //按钮是否禁用，返回为函数，null
  openDialog(String title, String msg) {
//    print(_phoneNumberController.text);
//    print(_passwordController.text);
//    print(context);
    showDialog(
        context: context,
        child: AlertDialog(
          title: Text(title),
          content: Text(msg),
        ));
  }

  Container buildLoginButton() => Container(
      width: double.infinity,
      margin: EdgeInsets.all(15),
      child: FlatButton(
        disabledColor: Colors.lightBlueAccent,
        disabledTextColor: Colors.white,
        onPressed: checkInput,
        child: Container(
            padding: EdgeInsets.all(15),
            child:
                Text("登录", style: TextStyle(fontSize: 18, letterSpacing: 2))),
        color: Colors.blue,
        textColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
      ));
}
