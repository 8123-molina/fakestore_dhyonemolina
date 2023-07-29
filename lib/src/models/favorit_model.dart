class FavoritsModel {
  String? id;
  bool? isFavorits;

  FavoritsModel();

  FavoritsModel.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        isFavorits = json["isFavorits"];

  Map<String, dynamic> tosJson() => {
        'id': id,
        'isFavorits': isFavorits,
      };

}
