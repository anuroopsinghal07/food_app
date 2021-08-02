class Product {
  String? title;
  int? id;
  String? description;
  double? price;
  String? priceUnit;
  bool? isHit;
  String? imageName;
  List<Nutrition>? nutrition;

  Product(
      {this.title,
      this.id,
      this.description,
      this.price,
      this.priceUnit,
      this.isHit,
      this.imageName,
      this.nutrition});

  Product.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    id = json['id'];
    description = json['description'];
    price = json['price'];
    priceUnit = json['priceUnit'];
    isHit = json['isHit'];
    imageName = json['imageName'];
    if (json['nutrition'] != null) {
      nutrition = <Nutrition>[];
      json['nutrition'].forEach((value) {
        nutrition!.add(Nutrition.fromJson(value));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['id'] = id;
    data['description'] = description;
    data['price'] = price;
    data['priceUnit'] = priceUnit;
    data['isHit'] = isHit;
    data['imageName'] = imageName;
    if (nutrition != null) {
      data['nutrition'] = nutrition!.map((value) => value.toJson()).toList();
    }
    return data;
  }
}

class Nutrition {
  String? title;
  String? value;

  Nutrition({this.title, this.value});

  Nutrition.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['value'] = value;
    return data;
  }
}
