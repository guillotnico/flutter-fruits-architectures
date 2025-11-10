import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/fruit_provider.dart';
import '../widgets/fruit_card.dart';

class FruitsScreen extends StatelessWidget {
  const FruitsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Liste des Fruits (Provider)'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => context.read<FruitProvider>().fetchFruits(),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () => context.read<FruitProvider>().fetchFruits(),
        child: const FruitsBodyContent(),
      ),
    );
  }


}