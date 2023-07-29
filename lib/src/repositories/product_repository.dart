

import 'package:fakestore_dhyonemolina/src/commons/const.dart';
import 'package:fakestore_dhyonemolina/src/data/exceptions.dart';
import 'package:fakestore_dhyonemolina/src/models/product_model.dart';

import '../data/dio_cliente.dart';

abstract class IProductRepository {
  Future<List<ProductModel>> getProducts();
  Future<List<ProductModel>> searchProducts();
}

class ProductRepository implements IProductRepository {
  final IDioClient dio;

  ProductRepository({required this.dio});

  @override
  Future<List<ProductModel>> getProducts() async {
    final response = await dio.get(url: '$baseUri/products');
    if (response.statusCode == 200) {
      final List<ProductModel> products = [];

      final data = response.data;

      data.map((item) {
        final ProductModel product = ProductModel.fromMap(item);
        products.add(product);
      }).toList();

      return products;
    } else if (response.statusCode == 404) {
      throw NotfoundException(msgErrorUrl);
    } else {
      throw Exception(msgErrorCarregarProduct);
    }
  }

  @override
  Future<List<ProductModel>> searchProducts() async {
    var result = await getProducts();
    if (result.length == 0) {
      throw Exception('Não foi possivel carregar dados do produto');
    } return result;
  }
}
