import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../models/fruit.dart';
import '../repositories/fruit_repository_impl.dart';

class GetFruitById implements UseCase<Fruit, int> {
  final FruitRepository repository;

  GetFruitById(this.repository);

  @override
  Future<Either<Failure, Fruit>> call(int id) async {
    return await repository.getFruitById(id);
  }
}