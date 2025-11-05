import 'package:flutter/material.dart';

import '../models/fruit.dart';
import '../services/fruit_service.dart';
import '../widgets/fruit_card.dart';

class FruitsScreen extends StatefulWidget {
  const FruitsScreen({Key? key}) : super(key: key);

  @override
  State<FruitsScreen> createState() => _FruitsScreenState();
}

class _FruitsScreenState extends State<FruitsScreen> {
  final FruitService _fruitService = FruitService();
  late Future<List<Fruit>> _futurefruits;

  @override
  void initState() {
    super.initState();
    _futurefruits = _fruitService.getFruits();
  }

  // Méthode pour rafraîchir les données
  Future<void> _refreshFruits() async {
    setState(() {
      _futurefruits = _fruitService.getFruits();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Liste des Fruits'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _refreshFruits,
          ),
        ],
      ),
      body: FutureBuilder<List<Fruit>>(
        future: _futurefruits,
        builder: (context, snapshot) {

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 60, color: Colors.red),
                  const SizedBox(height: 16),
                  Text(
                    'Erreur: ${snapshot.error}',
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _refreshFruits,
                    child: const Text('Réessayer'),
                  ),
                ],
              ),
            );
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text('Aucun fruit disponible'),
            );
          }

          final fruits = snapshot.data!;
          return RefreshIndicator(
            onRefresh: _refreshFruits,
            child: ListView.builder(
              itemCount: fruits.length,
              padding: const EdgeInsets.all(8),
              itemBuilder: (context, index) {
                final fruit = fruits[index];
                return FruitCard(fruit: fruit);
              },
            ),
          );
        },
      ),
    );
  }
}