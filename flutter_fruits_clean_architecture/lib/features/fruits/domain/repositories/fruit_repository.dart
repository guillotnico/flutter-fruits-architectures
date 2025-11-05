import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/fruit.dart';

// Le contrat d'interface !
abstract class FruitRepository {
  Future<Either<Failure, List<Fruit>>> getAllFruits();
  Future<Either<Failure, Fruit>> getFruitById(int id);
}