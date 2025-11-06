import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../data/datasources/fruit_remote_data_source.dart';
import '../../data/repositories/fruit_repository_impl.dart';
import '../../domain/repositories/fruit_repository.dart';
import '../../domain/usecases/get_all_fruits.dart';
import '../controllers/fruit_controller.dart';

class FruitBinding extends Bindings {
  @override
  void dependencies() {
    // HTTP Client
    Get.lazyPut<http.Client>(() => http.Client());

    // Data Source
    Get.lazyPut<FruitRemoteDataSource>(
          () => FruitRemoteDataSourceImpl(client: Get.find()),
    );

    // Repository
    Get.lazyPut<FruitRepository>(
          () => FruitRepositoryImpl(remoteDataSource: Get.find()),
    );

    // Use Cases
    Get.lazyPut(() => GetAllFruits(Get.find()));

    // Controller
    Get.lazyPut(
          () => FruitController(getAllFruitsUseCase: Get.find()),
    );
  }
}