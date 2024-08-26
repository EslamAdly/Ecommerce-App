import 'package:dio/dio.dart';
import 'package:ecommerce/models/Product.dart';

class ProductsService {
  Dio dio = Dio();

  Future<List<Product>> getProducts({required String path}) async {
    Response res = await dio.get(path);
    Map<String, dynamic> jsonData = res.data;
    List<dynamic> products = jsonData["products"];
    List<Product> productList = [];

    for (var product in products) {
      productList.add(Product.fromJson(product));
    }

    return productList;
  }
}
