import 'package:get/get.dart';
import '../../../../core/usecases/usecase.dart';
import '../../domain/entities/fruit.dart';
import '../../domain/usecases/get_all_fruits.dart';

class FruitController extends GetxController {
  final GetAllFruits getAllFruitsUseCase;

  FruitController({required this.getAllFruitsUseCase});

  // Observables
  final RxList<Fruit> fruits = <Fruit>[].obs;
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;
  final RxBool hasError = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadAllFruits();
  }

  Future<void> loadAllFruits() async {
    isLoading.value = true;
    hasError.value = false;
    errorMessage.value = '';

    final result = await getAllFruitsUseCase(NoParams());

    result.fold(
          (failure) {
        hasError.value = true;
        errorMessage.value = failure.message;
        isLoading.value = false;
      },
          (loadedFruits) {
        fruits.value = loadedFruits;
        isLoading.value = false;
      },
    );
  }

  void retry() {
    loadAllFruits();
  }
}