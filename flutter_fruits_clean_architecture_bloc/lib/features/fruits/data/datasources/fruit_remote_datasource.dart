import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../../core/error/exceptions.dart';
import '../models/fruit_model.dart';

abstract class FruitRemoteDataSource {
  Future<List<FruitModel>> getAllFruits();
  Future<FruitModel> getFruitById(int id);
}

class FruitRemoteDataSourceImpl implements FruitRemoteDataSource {
  final http.Client client;
  static const String baseUrl = 'https://www.fruityvice.com/api/fruit';

  FruitRemoteDataSourceImpl({required this.client});

  @override
  Future<List<FruitModel>> getAllFruits() async {
    try {
      final response = await client.get(
        Uri.parse('$baseUrl/all'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = json.decode(response.body);
        return jsonList.map((json) => FruitModel.fromJson(json)).toList();
      } else {
        throw ServerException('Failed to load fruits: ${response.statusCode}');
      }
    } catch (e) {
      throw ServerException('Network error: $e');
    }
  }

  @override
  Future<FruitModel> getFruitById(int id) async {
    try {
      final response = await client.get(
        Uri.parse('$baseUrl/$id'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        return FruitModel.fromJson(json.decode(response.body));
      } else {
        throw ServerException('Failed to load fruit: ${response.statusCode}');
      }
    } catch (e) {
      throw ServerException('Network error: $e');
    }
  }
}