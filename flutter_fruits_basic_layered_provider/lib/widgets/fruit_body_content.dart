import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/fruit_provider.dart';
import 'fruit_card.dart';

class FruitsBodyContent extends StatelessWidget {
  const FruitsBodyContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<FruitProvider>();

    switch (provider.state) {
      case ViewState.loading:
      case ViewState.initial:
        return const Center(
          child: CircularProgressIndicator(),
        );

      case ViewState.error:
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 60, color: Colors.red),
              const SizedBox(height: 16),
              Text(
                'Erreur: ${provider.errorMessage}',
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => context.read<FruitProvider>().fetchFruits(),
                child: const Text('Réessayer'),
              ),
            ],
          ),
        );

      case ViewState.loaded:
        if (provider.fruits.isEmpty) {
          return const Center(
            child: Text('Aucun fruit disponible'),
          );
        }

        return ListView.builder(
          itemCount: provider.fruits.length,
          padding: const EdgeInsets.all(8),
          itemBuilder: (context, index) {
            final fruit = provider.fruits[index];
            return FruitCard(fruit: fruit);
          },
        );
    }
  }
}