import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

import '../../data/datasources/fruit_remote_data_source.dart';
import '../../data/repositories/fruit_repository_impl.dart';
import '../../domain/repositories/fruit_repository.dart';
import '../../domain/usecases/get_all_fruit.dart';
import '../notifiers/fruit_list_notifier.dart';

final httpClientProvider = Provider<http.Client>(
      (ref) => http.Client(),
);

final fruitRemoteDataSourceProvider = Provider<FruitRemoteDataSource>(
      (ref) {
    final client = ref.watch(httpClientProvider);
    return FruitRemoteDataSourceImpl(client: client);
  },
);

final fruitRepositoryProvider = Provider<FruitRepository>(
      (ref) {
    final dataSource = ref.watch(fruitRemoteDataSourceProvider);
    return FruitRepositoryImpl(remoteDataSource: dataSource);
  },
);

final getAllFruitsUseCaseProvider = Provider<GetAllFruits>(
      (ref) {
    final repository = ref.watch(fruitRepositoryProvider);
    return GetAllFruits(repository);
  },
);

final fruitListNotifierProvider =
AsyncNotifierProvider.autoDispose<FruitListNotifier, List<Fruit>>(
      () => FruitListNotifier(),
);