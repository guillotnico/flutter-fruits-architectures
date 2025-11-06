import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../domain/entities/fruit.dart';
import 'info_row.dart';

class FruitCard extends StatelessWidget {
  final Fruit fruit;

  const FruitCard({Key? key, required this.fruit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
      elevation: 2,
      child: ListTile(
        contentPadding: const EdgeInsets.all(12),
        leading: CircleAvatar(
          backgroundColor: Colors.green.shade700,
          radius: 28,
          child: Text(
            fruit.name[0].toUpperCase(),
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
        ),
        title: Text(
          fruit.name,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 6),
            Text(
              'Famille: ${fruit.family}',
              style: TextStyle(color: Colors.grey.shade700),
            ),
            const SizedBox(height: 2),
            Text(
              '${fruit.nutritions.calories} cal • ${fruit.nutritions.sugar}g sucre',
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 13,
              ),
            ),
          ],
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.restaurant_menu,
              color: Colors.green.shade700,
            ),
            const SizedBox(height: 4),
            Text(
              '${fruit.nutritions.protein}g',
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        onTap: () {
          Get.dialog(
            AlertDialog(
              title: Text(fruit.name),
              content: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    InfoRow(label: 'ID', value: fruit.id.toString()),
                    InfoRow(label: 'Famille', value: fruit.family),
                    InfoRow(label: 'Ordre', value: fruit.order),
                    InfoRow(label: 'Genre', value: fruit.genus),
                    const Divider(height: 24),
                    const Text(
                      'Informations nutritionnelles',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 8),
                    InfoRow(label: 'Calories', value: '${fruit.nutritions.calories} kcal'),
                    InfoRow(label: 'Lipides', value: '${fruit.nutritions.fat}g'),
                    InfoRow(label: 'Sucre', value: '${fruit.nutritions.sugar}g'),
                    InfoRow(label: 'Glucides', value: '${fruit.nutritions.carbohydrates}g'),
                    InfoRow(label: 'Protéines', value: '${fruit.nutritions.protein}g'),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Get.back(),
                  child: const Text('Fermer'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}