import 'nutrition_model.dart';

class Fruit {
  final int id;
  final String name;
  final String family;
  final String order;
  final String genus;
  final Nutrition nutritions;

  Fruit({required this.id, required this.name, required this.family, required this.order, required this.genus, required this.nutritions});

  factory Fruit.fromJson(Map<String, dynamic> json) {
    return Fruit(
      id: json['id'] as int,
      name: json['name'] as String,
      family: json['family'] as String,
      order: json['order'] as String,
      genus: json['genus'] as String,
      nutritions: Nutrition.fromJson(json['nutritions'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'family': family, 'order': order, 'genus': genus, 'nutritions': nutritions.toJson()};
  }
}
