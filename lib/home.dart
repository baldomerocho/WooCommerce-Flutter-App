import 'package:flutter/material.dart';
import 'package:flutter_multi_carousel/carousel.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

import 'api/woo.dart';

class HomePageProducts extends StatelessWidget {
  const HomePageProducts({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Productos recientes"),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text("Productos en promocion"),
          ),
          FutureBuilder(
            future: productos(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              final wpp = snapshot.data;
              return Column(
                children: [
                  ...wpp.map((producto){
                    return GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return buildDetallesDelProducto(producto);
                          },
                        ));
                      },
                      child: Card(
                        child: Container(
                          width: double.infinity,
                          child: Column(
                            children: [
                              Image.network(producto["images"][0]["src"]),
                              Text(producto["name"]),
                              Text(producto["price"]),
                            ],
                          ),
                        ),
                      ),
                    );
                  })
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  buildDetallesDelProducto(producto) {
    return Scaffold(
      appBar: AppBar(
        title: Text(producto["name"]),
      ),
      body: ListView(
        children: [
          
          
          Carousel(
            height: 350.0,
            width: 350,
            initialPage: 1,
            allowWrap: false,
            type: Types.slideSwiper,
            indicatorType: IndicatorTypes.bar,
            arrowColor: Colors.black,
            axis: Axis.horizontal,
            showArrow: true,
            children: [
              ...producto["images"].map(
                          (img){
                            return Image.network(img["src"]);
                          }
                        ).toList(),
            ],
          ),


          Padding(
            padding: const EdgeInsets.symmetric(vertical:30.0),
            child: Center(child: Text("Precio: \$ ${producto["price"]}",  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),)),
          ),
          Container(
            padding: EdgeInsets.all(20),
            child: HtmlWidget(producto["description"]),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.shopping_cart), onPressed: (){}
      )
    );
  }
}