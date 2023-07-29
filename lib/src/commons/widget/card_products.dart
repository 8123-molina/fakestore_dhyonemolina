import 'package:flutter/material.dart';

class CardProducts extends StatelessWidget {
  final int id;
  final String title;
  final double price;
  final String category;
  final String description;
  final String image;
  final bool favorit;

  const CardProducts({
    super.key,
    required this.id,
    required this.title,
    required this.price,
    required this.category,
    required this.description,
    required this.image,
    required this.favorit,
  });
  // List<String> stringFavoriteIds =
  //     favoriteList.map((e) => e.toString()).toList();
  // SharedPrefs().favoriteIds = stringFavoriteIds ;

  @override
  Widget build(BuildContext context) {
    
    Size screenSize = MediaQuery.of(context).size;
    return Container(
        color: Colors.white,
        // margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              Image.network(image,
                  width: screenSize.width * 0.4,
                  height: screenSize.width * 0.4),
              SizedBox(
                width: screenSize.width * 0.5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          color: Color.fromARGB(255, 108, 108, 108),
                          fontSize: 20,
                          fontWeight: FontWeight.w400),
                    ),
                     Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Row(
                          children: [
                            Icon(
                              Icons.star,
                              color: Colors.yellow,
                              size: 24.0,
                            ),
                            Text(
                              '4.8 (100 reviews)',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color: Color.fromARGB(255, 108, 108, 108),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700),
                              textAlign: TextAlign.left,
                            ),
                          ],
                        ),
                        IconButton(
                          icon: Icon(
                            favorit ? Icons.favorite 
                            // ignore: dead_code
                            : Icons.favorite_border,
                            color: favorit ? Colors.red : null,
                          ),
                          onPressed: (){},
                        ),
                      ],
                    ),
                    Text(
                      '\$$price',
                      style: TextStyle(
                        color: Colors.orange[800],
                        fontSize: 20,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
  
 
}
