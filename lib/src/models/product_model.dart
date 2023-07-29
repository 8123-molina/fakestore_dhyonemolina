class ProductModel {
  final int id;
  final String title;
  final double price;
  final String description;
  final String category;
  final String image;
  final int count;
  final double rate;

  ProductModel({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.image,
    required this.count,
    required this.rate,
  });

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
        id: map['id'],
        title: map['title'],
        price: map['price'] * 1.0,
        description: map['description'],
        category: map['category'],
        image: map['image'],
        count: map['rating']["count"],
        rate: map['rating']["rate"] * 1.0
        );
  }

  @override
  String toString() {
    return 'ProductModel{id=$id, title=$title, price=$price, description=$description, category=$category, image=$image}';
  }

  List get props => [id, title, price, description, category, image];

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ProductModel &&
        other.id == id &&
        other.title == title &&
        other.description == description &&
        other.category == category &&
        other.image == image;
  }
  ProductModel copyWith({
    int? id,
    String? title,
    double? price,
    String? description,
    String? category,
    String? image,
    int? count,
    double? rate,
  }) {
    return ProductModel(
      id: id ?? this.id,
      title: title ?? this.title,
      price: price ?? this.price,
      description: description ?? this.description,
      category: category ?? this.category,
      image: image ?? this.image,
      count: count ?? this.count,
      rate: rate ?? this.rate,
    );
  }
  
  @override
  int get hashCode => super.hashCode;
  
}

class Rating {
  final double rate;
  final int count;

  Rating({required this.rate, required this.count});

  factory Rating.fromMap(Map<String, dynamic> json) {
    return Rating(
      count: json['count'],
      rate: json['rate']
    );
  }
}
