import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/fruit.dart';
import '../repositories/fruit_repository.dart';

class GetAllFruits implements UseCase<List<Fruit>, NoParams> {
  final FruitRepository repository;

  GetAllFruits(this.repository);

  @override
  Future<Either<Failure, List<Fruit>>> call(NoParams params) async {
    return await repository.getAllFruits();
  }
}