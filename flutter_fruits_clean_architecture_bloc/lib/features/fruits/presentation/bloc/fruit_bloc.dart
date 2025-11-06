import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/usecases/usecase.dart';
import '../../domain/usecases/get_all_fruits.dart';
import 'fruit_event.dart';
import 'fruit_state.dart';

class FruitBloc extends Bloc<FruitEvent, FruitState> {
  final GetAllFruits getAllFruits;

  FruitBloc({required this.getAllFruits}) : super(FruitInitial()) {
    on<LoadAllFruitsEvent>(_onLoadAllFruits);
  }

  Future<void> _onLoadAllFruits(
    LoadAllFruitsEvent event,
    Emitter<FruitState> emit,
  ) async {
    emit(FruitLoading());

    final result = await getAllFruits(NoParams());

    result.fold(
      (failure) => emit(FruitError(failure.message)),
      (fruits) => emit(FruitLoaded(fruits)),
    );
  }
}