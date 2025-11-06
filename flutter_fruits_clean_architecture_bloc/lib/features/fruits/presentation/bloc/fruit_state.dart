import 'package:equatable/equatable.dart';
import '../../domain/entities/fruit.dart';

abstract class FruitState extends Equatable {
  @override
  List<Object> get props => [];
}

class FruitInitial extends FruitState {}

class FruitLoading extends FruitState {}

class FruitLoaded extends FruitState {
  final List<Fruit> fruits;

  FruitLoaded(this.fruits);

  @override
  List<Object> get props => [fruits];
}

class FruitError extends FruitState {
  final String message;

  FruitError(this.message);

  @override
  List<Object> get props => [message];
}