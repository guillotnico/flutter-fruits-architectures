import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/fruit_controller.dart';
import '../widgets/fruit_card.dart';

class FruitsPage extends GetView<FruitController> {
  const FruitsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fruits Catalog'),
        backgroundColor: Colors.green,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.hasError.value) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error_outline, size: 60, color: Colors.red),
                const SizedBox(height: 16),
                Text(
                  'Erreur: ${controller.errorMessage.value}',
                  style: const TextStyle(fontSize: 16),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: controller.retry,
                  child: const Text('Réessayer'),
                ),
              ],
            ),
          );
        }

        if (controller.fruits.isEmpty) {
          return const Center(
            child: Text('Aucun fruit disponible'),
          );
        }

        return RefreshIndicator(
          onRefresh: controller.loadAllFruits,
          child: ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: controller.fruits.length,
            itemBuilder: (context, index) {
              return FruitCard(fruit: controller.fruits[index]);
            },
          ),
        );
      }),
    );
  }
}