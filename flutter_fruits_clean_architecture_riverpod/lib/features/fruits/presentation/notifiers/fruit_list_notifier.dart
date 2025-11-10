import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/usecases/usecase.dart';
import '../../domain/entities/fruit.dart';
import '../providers/fruit_providers.dart';

class FruitListNotifier extends AutoDisposeAsyncNotifier<List<Fruit>> {

  @override
  Future<List<Fruit>> build() async {
    final getAllFruits = ref.read(getAllFruitsUseCaseProvider);

    final result = await getAllFruits(NoParams());

    return result.fold(
          (failure) {
        throw Exception(failure.message);
      },
          (fruits) {
        return fruits;
      },
    );
  }

  Future<void> refreshFruits() async {
    state = const AsyncValue.loading();
    try {
      final fruits = await build();
      state = AsyncValue.data(fruits);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }
}