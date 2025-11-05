import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/fruit.dart';

class FruitService {
  static const String baseUrl = 'https://www.fruityvice.com/api';

  static final FruitService _instance = FruitService._internal();
  factory FruitService() => _instance;
  FruitService._internal();

  Future<List<Fruit>> getFruits() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/fruit/all'),
        headers: {'Accept': 'application/json'},
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);
        return jsonData.map((json) => Fruit.fromJson(json)).toList();
      } else {
        throw Exception('Erreur ${response.statusCode}: ${response.reasonPhrase}');
      }
    } catch (e) {
      throw Exception('Erreur de connexion: $e');
    }
  }

  Future<Fruit> getFruitById(int id) async {
    final response = await http.get(
      Uri.parse('$baseUrl/fruits/$id'),
      headers: {'Accept': 'application/json'},
    );

    if (response.statusCode == 200) {
      return Fruit.fromJson(json.decode(response.body));
    } else {
      throw Exception('Fruit non trouvé');
    }
  }
}