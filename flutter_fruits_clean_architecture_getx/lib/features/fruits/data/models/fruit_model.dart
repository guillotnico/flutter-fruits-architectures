// lib/features/fruits/data/models/fruit_model.dart
import '../../domain/models/fruit.dart';
import 'nutrition_model.dart';

class FruitModel extends Fruit {
  const FruitModel({
    required super.id,
    required super.name,
    required super.family,
    required super.order,
    required super.genus,
    required super.nutritions,
  });

  factory FruitModel.fromJson(Map<String, dynamic> json) {
    return FruitModel(
      id: json['id'] as int,
      name: json['name'] as String,
      family: json['family'] as String,
      order: json['order'] as String,
      genus: json['genus'] as String,
      nutritions: NutritionModel.fromJson(json['nutritions'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'family': family,
      'order': order,
      'genus': genus,
      'nutritions': (nutritions as NutritionModel).toJson(),
    };
  }
}