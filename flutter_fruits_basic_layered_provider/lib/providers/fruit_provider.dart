import 'package:flutter/foundation.dart'; import '../models/fruit.dart';
import '../services/fruit_service.dart';

enum ViewState { initial, loading, loaded, error }

class FruitProvider extends ChangeNotifier {
  final FruitService _fruitService;

  FruitProvider({required FruitService fruitService}) : _fruitService = fruitService {
    fetchFruits();
  }

  List<Fruit> _fruits = [];
  ViewState _state = ViewState.initial;
  String _errorMessage = '';
  .
  List<Fruit> get fruits => _fruits;
  ViewState get state => _state;
  String get errorMessage => _errorMessage;

  Future<void> fetchFruits() async {
    _state = ViewState.loading;
    _errorMessage = '';
    notifyListeners();

    try {
      _fruits = await _fruitService.getFruits();
      _state = ViewState.loaded;
    } catch (e) {
      _errorMessage = e.toString().replaceFirst("Exception: ", "");
      _state = ViewState.error;
    }

    notifyListeners();
  }
}