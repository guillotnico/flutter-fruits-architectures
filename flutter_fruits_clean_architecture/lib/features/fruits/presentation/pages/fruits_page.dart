import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/fruit_bloc.dart';
import '../bloc/fruit_event.dart';
import '../bloc/fruit_state.dart';
import '../widgets/fruit_card.dart';

class FruitsPage extends StatelessWidget {
  const FruitsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fruits Catalog'),
        backgroundColor: Colors.green,
      ),
      body: BlocBuilder<FruitBloc, FruitState>(
        builder: (context, state) {
          if (state is FruitInitial) {
            context.read<FruitBloc>().add(LoadAllFruitsEvent());
            return const Center(child: CircularProgressIndicator());
          }

          if (state is FruitLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is FruitError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 60, color: Colors.red),
                  const SizedBox(height: 16),
                  Text(
                    'Erreur: ${state.message}',
                    style: const TextStyle(fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      context.read<FruitBloc>().add(LoadAllFruitsEvent());
                    },
                    child: const Text('Réessayer'),
                  ),
                ],
              ),
            );
          }

          if (state is FruitLoaded) {
            return RefreshIndicator(
              onRefresh: () async {
                context.read<FruitBloc>().add(LoadAllFruitsEvent());
              },
              child: ListView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: state.fruits.length,
                itemBuilder: (context, index) {
                  return FruitCard(fruit: state.fruits[index]);
                },
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}