import 'package:equatable/equatable.dart';

abstract class FruitEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadAllFruitsEvent extends FruitEvent {}

class LoadFruitByIdEvent extends FruitEvent {
  final int id;

  LoadFruitByIdEvent(this.id);

  @override
  List<Object> get props => [id];
}