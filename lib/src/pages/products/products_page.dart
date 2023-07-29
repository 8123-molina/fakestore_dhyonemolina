import 'package:fakestore_dhyonemolina/src/models/product_model.dart';
import 'package:flutter/material.dart';

import '../../commons/const.dart';

class ProductsPage extends StatelessWidget {
  const ProductsPage({super.key});

  @override
  Widget build(BuildContext context) {
    ProductModel item =
        ModalRoute.of(context)!.settings.arguments as ProductModel;
    Size screenSize = MediaQuery.of(context).size;
    bool isFavorits = false; ///altera para items.favorits
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Products Details',
          textAlign: TextAlign.left,
          style: TextStyle(fontWeight: FontWeight.bold, fontFamily: font1),
        ),
        actions:  [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: IconButton(
                icon: Icon(
                  isFavorits ? Icons.favorite : Icons.favorite_border,
                  color: isFavorits ? Colors.red : null,
                ),
                onPressed: () {
                  isFavorits = !isFavorits;
                  // setState(() {
                  //   if (item.isFavorits) {
                  //     _productController.addFavorits();
                  //   } else {
                  //     _productController.removeFavorits();
                  //   }
                  // });
                }),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Image.network(item.image,
                  width: screenSize.width * 0.9,
                  height: screenSize.width * 0.9),
              SizedBox(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Text(
                        item.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            color: colorTitle,
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            fontFamily: font1),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Row(
                              children: [
                                Icon(
                                  Icons.star,
                                  color: Color.fromARGB(255, 255, 215, 1),
                                  size: 24.0,
                                ),
                                Text(
                                  '4.8 (100 reviews)',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      color: Color.fromARGB(55, 71, 79, 65),
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                      fontFamily: font1),
                                  textAlign: TextAlign.left,
                                ),
                              ],
                            ),
                            Text(
                              '\$${item.price}',
                              style: const TextStyle(
                                  color: colorPrice,
                                  fontSize: 30,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: font1),
                              textAlign: TextAlign.left,
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(
                            Icons.sort,
                            color: Color(0xFF3E3E3E),
                            size: 24.0,
                          ),
                          Expanded(
                            child: Text(
                              item.category,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  color: colorCategory,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: font1),
                              textAlign: TextAlign.left,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(
                            Icons.menu,
                            color: Color(0xFF3E3E3E),
                            size: 24.0,
                          ),
                          Expanded(
                            child: Text(
                              item.description,
                              softWrap: true,
                              style: const TextStyle(
                                  color: colorDescription,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: font1),
                              textAlign: TextAlign.left,
                            ),
                          ),
                        ],
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
  }
}
