
import 'package:fakestore_dhyonemolina/src/models/product_model.dart';
import 'package:fakestore_dhyonemolina/src/repositories/product_repository.dart';
import 'package:flutter/material.dart';

import '../../data/exceptions.dart';

class ProductController {
  final IProductRepository repository;

  ProductController({required this.repository}) {
    fetch();
  }

  // Reatividade loading
  final ValueNotifier<bool> isLoading = ValueNotifier<bool>(false);

  // Reatividade state
  final ValueNotifier<List<ProductModel>> state =
      ValueNotifier<List<ProductModel>>([]);

  // Reatividade erro
  final ValueNotifier<String> erro = ValueNotifier<String>('');

  // Requisição ao repository
  Future getProduct() async {
    isLoading.value = true;

    try {
      final result = await repository.getProducts();
      state.value = result;
    } on NotfoundException catch (e) {
      erro.value = e.message;
    } catch (e) {
      erro.value = e.toString();
    }

    isLoading.value = false;
  }

  // Reatividade do Search
  final ValueNotifier<List<ProductModel?>> searchProduct =
      ValueNotifier<List<ProductModel?>>([]);

  // Requisição ao repository
  Future getSearchProduct() async {
    isLoading.value = true;

    try {
      final result = await repository.getProducts();
      return result;
    } on NotfoundException catch (e) {
      erro.value = e.message;
    } catch (e) {
      erro.value = e.toString();
    }

    isLoading.value = false;
  }

  // Retorna dados do search
  onChanged(String value) {
    if (value == '') {
      fetch();
    } else {
      var items = state.value
          .where((item) =>
              item.toString().toLowerCase().contains(value.toLowerCase()))
          .toList();

      state.value = items;
    }
  }

  fetch() async {
    var result = await repository.searchProducts();
    state.value = result;
  }

}
