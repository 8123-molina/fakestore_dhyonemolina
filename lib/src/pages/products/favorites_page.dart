
import 'package:flutter/material.dart';

import '../../controllers/products/product_controller.dart';
import '../../data/dio_cliente.dart';
import '../../repositories/product_repository.dart';
import '../../commons/const.dart';
import '../../commons/widget/list_empyt.dart';
import '../../controllers/products/favorits_controller.dart';
import '../../models/product_model.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  final ProductController _productController = ProductController(
    repository: ProductRepository(dio: DioClient()),
  );
  final FavoritsController _favoritsController = FavoritsController();

  bool favorits = false;
  bool isIdFound = false;
  int id = 0;
  late String idf;

  @override
  void initState() {
    _productController.getProduct();
    _favoritsController.getFavorits();
    _favoritsController.stateFavorits;
    _productController.state.value;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Favorites',
          textAlign: TextAlign.left,
          style: TextStyle(fontWeight: FontWeight.bold, fontFamily: font1),
        ),
      ),
      body: productsList(screenSize),
    );
  }

  // Carrega lista de produtos
  RefreshIndicator productsList(Size screenSize) {
    return RefreshIndicator(
      onRefresh: () async {
        _favoritsController.getFavorits();
      },
      child: SizedBox(
        height: screenSize.height,
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

            if (_favoritsController.stateFavorits.value.isEmpty) {
              return const ListEmpyt();
            } else {
              return ListView.separated(
                itemCount: _favoritsController.stateFavorits.value.length,
                separatorBuilder: (context, index) => const SizedBox(height: 2),
                itemBuilder: (_, index) {
                  var idF = _favoritsController.stateFavorits.value[index];
                  var list = _productController.state.value;
                  for (int i = 0; i < list.length; i++) {
                    if (list[i].id.toString() == idF) {
                      // Elemento encontrado!
                      id = list[i].id;
                      break;
                    }
                  }
                  return GestureDetector(
                    onTap: () => Navigator.of(context)
                        .pushNamed('/product', arguments: list[id]),
                    child: Container(
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          children: [
                            Image.network(list[id].image,
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
                                      list[id].title,
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
                                              '${list[id].rate.toString()} (${list[id].count.toString()} reviews)',
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
                                        favoritsButton(list[id], idF),
                                      ],
                                    ),
                                    Text(
                                      '\$${list[id].price}',
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
                  // ignore: dead_code
                  return const ListEmpyt();
                },
              );
            }
          },
        ),
      ),
    );
  }

  // Botão de favorito
  IconButton favoritsButton(item, idF) {
    id = item.id;
    id -= 1;
    favorits = (idF == id.toString());
    return IconButton(
        iconSize: 24,
        icon: Icon(
          favorits ? Icons.favorite : Icons.favorite_border,
          color: favorits ? Colors.red : null,
        ),
        onPressed: () {
          _favoritsController.remove(idF.toString());
          setState(() {});
        });
  }
}
