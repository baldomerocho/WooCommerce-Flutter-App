import 'dart:convert';

import 'package:http/http.dart' as http;
final dominio = "https://supperya.com/wp-json/wc/v3/";
final products = "products";
final ck = "consumer_key=ck_7933aac74fb5ff13369c8e541f312bae71163913";
final cs = "consumer_secret=cs_4219eb309dd3ecbee3a1985e16055682a40d82b1";

final listaProductos = "$dominio$products?$ck&$cs";

Future<List> productos() async{
  final url= listaProductos;

  final response = await http.get(url, headers: {"Accept":"application/json"});
  var jsonConvert = jsonDecode(response.body);
  return jsonConvert;
}


