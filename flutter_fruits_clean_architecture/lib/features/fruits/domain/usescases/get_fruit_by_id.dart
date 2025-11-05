import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/fruit.dart';
import '../repositories/fruit_repository.dart';

class GetFruitById implements UseCase<Fruit, int> {
  final FruitRepository repository;

  GetFruitById(this.repository);

  @override
  Future<Either<Failure, Fruit>> call(int id) async {
    return await repository.getFruitById(id);
  }
}