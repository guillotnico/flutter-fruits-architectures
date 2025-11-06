import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../models/fruit.dart';
import '../repositories/fruit_repository_impl.dart';

class GetAllFruits implements UseCase<List<Fruit>, NoParams> {
  final FruitRepository repository;

  GetAllFruits(this.repository);

  @override
  Future<Either<Failure, List<Fruit>>> call(NoParams params) async {
    return await repository.getAllFruits();
  }
}