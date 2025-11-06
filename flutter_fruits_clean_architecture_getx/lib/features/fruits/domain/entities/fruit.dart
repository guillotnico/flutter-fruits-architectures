import 'package:equatable/equatable.dart';
import 'nutrition_model.dart';

class Fruit extends Equatable {
  final int id;
  final String name;
  final String family;
  final String order;
  final String genus;
  final Nutrition nutritions;

  const Fruit({
    required this.id,
    required this.name,
    required this.family,
    required this.order,
    required this.genus,
    required this.nutritions,
  });

  @override
  List<Object> get props => [id, name, family, order, genus, nutritions];
}