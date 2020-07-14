import 'package:flutter/material.dart';
import 'package:flutter_orderonline/entity/cart_provider.dart';
import 'package:flutter_orderonline/entity/memu_provider.dart';
import 'package:flutter_orderonline/page/cart.dart';
import 'package:flutter_orderonline/page/product_detail.dart';
import 'package:provider/provider.dart';

class MyMenu extends StatelessWidget {
  final int seatId;
  MyMenu(this.seatId);
  @override
  Widget build(BuildContext context) {

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.black,
          onPressed: () => Navigator.push(
              context, MaterialPageRoute(builder: (context) => MyCart(seatId))),
          child: Icon(Icons.shopping_cart),
        ),
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                primary: true,
                expandedHeight: 200,
                pinned: true,
                floating: false,
                snap: false,
                title: Text("菜单"),
                backgroundColor: Colors.black,
                //FlexibleSpaceBar，包括title和background
                flexibleSpace: _getFlexBar(),
                //底部可以是个tab切换栏，与appbar相似
                bottom: _getTabAppBar(),
              )
            ];
          },
          body: _getTabBarView(),
        ),
      ),
    );
  }
}

TabBar _getTabAppBar() {
  return TabBar(
    tabs: [
      Tab(
        icon: Icon(Icons.star_border),
        text: "菜品",
      ),
      Tab(
        icon: Icon(Icons.restaurant),
        text: "主食",
      ),
      Tab(
        icon: Icon(Icons.local_drink),
        text: "饮品",
      ),
    ],
  );
}

_getTabBarView() {
  return TabBarView(
    children: [
      DishesList(),
      DrinksList(),
      FoodList(),
    ],
  );
}

_getFlexBar() {
  return FlexibleSpaceBar(
    background: Image.network(
      'https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=1693585905,1298251231&fm=26&gp=0.jpg',
      fit: BoxFit.fill,
    ),
  );
}

class DishesList extends StatefulWidget {
  @override
  _DishesListState createState() => _DishesListState();
}

class _DishesListState extends State<DishesList> {
  MemuModel menu;
  CartModel cart;

  @override
  void initState() {
    super.initState();
    _load();
  }

  _load() {
    // 必须异步执行
    Future.delayed(Duration.zero, () => menu.loadProduct());
  }

  @override
  Widget build(BuildContext context) {
    // 此组件，需要监听菜单变化渲染商品，因此需要监听菜单变化
    menu = Provider.of<MemuModel>(context);
    // 需要操作更新CartModel，但无需响应CartModel更新
    cart = Provider.of<CartModel>(context, listen: false);

    return menu.listDishes().length == 0
        ? Center(
            child: CircularProgressIndicator(),
          )
        : ListView.separated(
            padding: const EdgeInsets.all(10),
            itemCount: menu.listDishes().length,
            itemBuilder: (context, index) {
              return productItemView(menu.listDishes()[index],context);
            },
            separatorBuilder: (context, index) {
              return Divider();
            },
          );
  }
}

class DrinksList extends StatefulWidget {
  @override
  _DrinksListState createState() => _DrinksListState();
}

class _DrinksListState extends State<DrinksList> {
  MemuModel menu;
  CartModel cart;
  @override
  Widget build(BuildContext context) {
    // 此组件，需要监听菜单变化渲染商品，因此需要监听菜单变化
    menu = Provider.of<MemuModel>(context);
    // 需要操作更新CartModel，但无需响应CartModel更新
    cart = Provider.of<CartModel>(context, listen: false);

    return menu.listDrinks().length == 0
        ? Center(
            child: CircularProgressIndicator(),
          )
        : ListView.separated(
            padding: const EdgeInsets.all(10),
            itemCount: menu.listDrinks().length,
            itemBuilder: (context, index) {
              return productItemView(menu.listDrinks()[index],context);
            },
            separatorBuilder: (context, index) {
              return Divider();
            },
          );
  }
}

class FoodList extends StatefulWidget {
  @override
  _FoodListState createState() => _FoodListState();
}

class _FoodListState extends State<FoodList> {
  MemuModel menu;
  CartModel cart;

  @override
  Widget build(BuildContext context) {
    // 此组件，需要监听菜单变化渲染商品，因此需要监听菜单变化
    menu = Provider.of<MemuModel>(context);
    // 需要操作更新CartModel，但无需响应CartModel更新
    cart = Provider.of<CartModel>(context, listen: false);

    return menu.listFood().length == 0
        ? Center(
            child: CircularProgressIndicator(),
          )
        : ListView.separated(
            padding: const EdgeInsets.all(10),
            itemCount: menu.listFood().length,
            itemBuilder: (context, index) {
              return productItemView(menu.listFood()[index],context);
            },
            separatorBuilder: (context, index) {
              return Divider();
            },
          );
  }
}

Widget productItemView(Product product,BuildContext context) {
   CartModel cart = Provider.of<CartModel>(context);

  return Container(
    padding: EdgeInsets.only(left: 10, right: 10),
    child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[

          InkWell(
            onTap: () =>  Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Detail(product))),
            child:  Container(
              width: 140,
              padding: EdgeInsets.only(left: 10, right: 10),
              child: Image.network(product.image)),
          ),
          Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(child: Text(product.name)),
                Container(child: Text("价格：￥${product.price}"))
              ]),
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
                print(product.id);
                cart.addItem(product);
            },
          ),
          ItemCount(product),
          IconButton(
              icon: Icon(Icons.remove),
              onPressed: () {
                print(product.id);
                cart.removeItem(product);
              }),
        ]),
  );
}

class ItemCount extends StatelessWidget {
  final Product product;

  ItemCount(this.product);

  @override
  Widget build(BuildContext context) {
    return Consumer<CartModel>(
      builder: (context, cart, chlid) {
        return Text(
          '${cart.getItemCount(product)}',
          style: TextStyle(fontSize: 20),
        );
      },
    );
  }
}


