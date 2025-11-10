import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/fruit.dart';

class FruitService {
  static const String baseUrl = 'https://www.fruityvice.com/api';

  final http.Client client;

  FruitService({required this.client});

  Future<List<Fruit>> getFruits() async {
    try {
      final response = await client.get(
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
}