import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'; // Importer Riverpod

import '../providers/fruit_providers.dart';
import '../widgets/fruit_card.dart';

class FruitsPage extends ConsumerWidget {
  const FruitsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fruitState = ref.watch(fruitListNotifierProvider);

    final fruitNotifier = ref.read(fruitListNotifierProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Fruits (Clean Arch + Riverpod)'),
        backgroundColor: Colors.green,
      ),
      body: RefreshIndicator(
        onRefresh: () => fruitNotifier.refreshFruits(),

        child: fruitState.when(
          data: (fruits) {
            if (fruits.isEmpty) {
              return const Center(child: Text('Aucun fruit disponible'));
            }
            return ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: fruits.length,
              itemBuilder: (context, index) {
                return FruitCard(fruit: fruits[index]);
              },
            );
          },
          error: (error, stackTrace) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 60, color: Colors.red),
                  const SizedBox(height: 16),
                  Text(
                    'Erreur: ${error.toString().replaceFirst("Exception: ", "")}',
                    style: const TextStyle(fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => fruitNotifier.refreshFruits(),
                    child: const Text('Réessayer'),
                  ),
                ],
              ),
            );
          },
          loading: () {
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}