import 'package:flutter/material.dart';
import 'package:flutter_orderonline/entity/memu_provider.dart';

class Detail extends StatelessWidget {
  final Product product;
  Detail(this.product);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return <Widget>[
          SliverAppBar(
            primary: true,
            expandedHeight: 250,
            pinned: true,
            floating: false,
            snap: false,
            title: Text(product.name),
            backgroundColor: Colors.black,
            //FlexibleSpaceBar，包括title和background
            flexibleSpace: _getFlexBar(),
          )
        ];
      },
      body: ListView(
        children: <Widget>[
          buildRow(),
       
          buildText()
        ],
      ),
    ));
  }

  _getFlexBar() {
    return FlexibleSpaceBar(
      background: Image.network(
        product.image,
        fit: BoxFit.fill,
      ),
    );
  }

  Container buildText() {
    return Container(
      padding: EdgeInsets.all(32),
      child: Text(
          'Lake Oeschinen lies at the foot of the Blüemlisalp in the Bernese '
          'Alps. Situated 1,578 meters above sea level, it is one of the '
          'larger Alpine Lakes. A gondola ride from Kandersteg, followed by a '
          'half-hour walk through pastures and pine forest, leads you to the '
          'lake, which warms to 20 degrees Celsius in the summer. Activities '
          'enjoyed here include rowing, and riding the summer toboggan run.',
          softWrap: true),
    );
  }



  Container buildRow() {
    return Container(
        padding: EdgeInsets.all(32),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    product.name,
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                  Text(
                    "${product.price}" ,
                    style: TextStyle(color: Colors.grey),
                  )
                ],
              ),
            ),
            Icon(
              Icons.star_border,
              color: Colors.red,
            ),
            Text('40')
          ],
        ));
  }

  Image buildImage() {
    return Image.network(
        'http://i0.hdslb.com/bfs/article/d22bbcc815668a3244e4237c1731b98d8ee370a3.jpg',
        fit: BoxFit.cover);
  }

  Column buildColumn(icon, text) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(
          icon,
          color: Colors.blue,
        ),
        Text(
          text,
          style: TextStyle(color: Colors.blue),
        )
      ],
    );
  }
}
