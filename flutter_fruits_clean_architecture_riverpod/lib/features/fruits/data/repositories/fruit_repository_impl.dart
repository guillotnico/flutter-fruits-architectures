// lib/features/fruits/data/repositories/fruit_repository_impl.dart
import 'package:dartz/dartz.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../domain/models/fruit.dart';
import '../../domain/repositories/fruit_repository_impl.dart';
import '../datasources/fruit_remote_data_source.dart';

class FruitRepositoryImpl implements FruitRepository {
  final FruitRemoteDataSource remoteDataSource;

  FruitRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<Fruit>>> getAllFruits() async {
    try {
      final fruits = await remoteDataSource.getAllFruits();
      return Right(fruits);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure('Unexpected error: $e'));
    }
  }

  @override
  Future<Either<Failure, Fruit>> getFruitById(int id) async {
    try {
      final fruit = await remoteDataSource.getFruitById(id);
      return Right(fruit);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure('Unexpected error: $e'));
    }
  }
}