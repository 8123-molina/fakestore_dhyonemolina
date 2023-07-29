import 'dart:developer';

import 'package:fakestore_dhyonemolina/src/data/dio_cliente.dart';
import 'package:fakestore_dhyonemolina/src/models/product_model.dart';
import 'package:flutter/material.dart';

import 'package:fakestore_dhyonemolina/src/repositories/product_repository.dart';
import 'package:fakestore_dhyonemolina/src//commons/const.dart';
import 'package:fakestore_dhyonemolina/src//commons/widget/list_empyt.dart';
import 'package:fakestore_dhyonemolina/src//controllers/products/product_controller.dart';
import 'package:fakestore_dhyonemolina/src//controllers/products/favorits_controller.dart';

const productId = 1;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ProductController _productController = ProductController(
    repository: ProductRepository(dio: DioClient()),
  );
  final FavoritsController _favoritsController = FavoritsController();

  bool favorits = false;

  @override
  void initState() {
    _productController.getProduct();
    _favoritsController.getFavorits();
    _favoritsController.stateFavorits.value;
    _productController.state.value;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Products',
          textAlign: TextAlign.left,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontFamily: font1,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.favorite_border_sharp,
              size: 25,
            ),
            color: Colors.black,
            onPressed: () => Navigator.of(context).pushNamed('/favorites'),
          ),
        ],
      ),
      body: Stack(
        children: [
          Positioned(
            left: 0.0,
            right: 0.0,
            top: screenSize.height * 0.01,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: ValueListenableBuilder<List>(
                valueListenable: _productController.state,
                builder: (__, searchProduct, _) {
                  return TextField(
                    onChanged: _productController.onChanged,
                    decoration: const InputDecoration(
                        hintText: "Search Anything",
                        prefixIcon: Icon(Icons.search),
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius:
                                BorderRadius.all(Radius.circular(25.0)))),
                  );
                },
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            top: 100,
            child: productsList(screenSize),
          ),
        ],
      ),
    );
  }

  // Carrega lista de produtos
  RefreshIndicator productsList(Size screenSize) {
    return RefreshIndicator(
      onRefresh: () async {
        _productController.getProduct();
      },
      child: SizedBox(
        height: screenSize.height * 0.8,
        child: AnimatedBuilder(
          animation: Listenable.merge([
            _productController.isLoading,
            _productController.state,
            _favoritsController.stateFavorits,
            _productController.erro,
          ]),
          builder: (context, child) {
            if (_productController.isLoading.value) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (_productController.state.value.isEmpty) {
              return const ListEmpyt();
            } else {
              return ListView.separated(
                itemCount: _productController.state.value.length,
                separatorBuilder: (context, index) => const SizedBox(height: 2),
                itemBuilder: (_, index) {
                  final item = _productController.state.value[index];
                  return GestureDetector(
                    onTap: () => Navigator.of(context)
                        .pushNamed('/product', arguments: item),
                    child: Container(
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          children: [
                            Image.network(item.image,
                                width: screenSize.width * 0.4,
                                height: screenSize.width * 0.4),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SizedBox(
                                width: screenSize.width * 0.5,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item.title,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                          color: colorTitle,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500,
                                          fontFamily: font1),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            const Icon(
                                              Icons.star,
                                              color: Colors.yellow,
                                              size: 24.0,
                                            ),
                                            Text(
                                              '${item.rate.toString()} (${item.count.toString()} reviews)',
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 108, 108, 108),
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w600,
                                                  fontFamily: font1),
                                              textAlign: TextAlign.left,
                                            ),
                                          ],
                                        ),
                                        favoritsButton(item),
                                      ],
                                    ),
                                    Text(
                                      '\$${item.price}',
                                      style: const TextStyle(
                                          color: colorPrice2,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600,
                                          fontFamily: font1),
                                      textAlign: TextAlign.left,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }

  // Botão de favorito
  IconButton favoritsButton(ProductModel item) {
    var id = item.id;
    id -= 1;
    favorits = (100 == item.id);
    return IconButton(
        iconSize: 24,
        icon: Icon(
          favorits ? Icons.favorite : Icons.favorite_border,
          color: favorits ? Colors.red : null,
        ),
        onPressed: () {
          log(id.toString());
          favorits
              ? _favoritsController.remove(item.id.toString())
              : _favoritsController.save(id.toString());
        });
  }
}
