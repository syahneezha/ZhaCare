import 'package:flutter/material.dart';
import '../data/models/fruit_model.dart';
import '../data/services/fruit_api_service.dart';

class FruitProvider extends ChangeNotifier {
  final FruitApiService _apiService = FruitApiService();

  List<FruitModel> _fruits = [];
  List<FruitModel> _filteredFruits = [];
  bool _isLoading = false;
  String? _errorMessage;
  String _searchQuery = '';
  String _selectedFilter = 'Semua';
  FruitModel? _selectedFruit;

  FruitProvider() {
    loadFruits();
  }

  List<FruitModel> get fruits => _fruits;
  List<FruitModel> get filteredFruits => _filteredFruits;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  String get searchQuery => _searchQuery;
  String get selectedFilter => _selectedFilter;
  FruitModel? get selectedFruit => _selectedFruit;

  Future<void> loadFruits() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final list = await _apiService.getAllFruits();
      _fruits = list;
      _applyFilters();
    } catch (e) {
      _errorMessage = 'Gagal memuat data buah. Silakan coba lagi.';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void search(String query) {
    _searchQuery = query;
    _applyFilters();
  }

  void setFilter(String filter) {
    if (_selectedFilter != filter) {
      _selectedFilter = filter;
      _applyFilters();
    }
  }

  void selectFruit(FruitModel? fruit) {
    _selectedFruit = fruit;
    notifyListeners();
  }

  void _applyFilters() {
    var result = List<FruitModel>.from(_fruits);

    // Filter berdasarkan query teks
    if (_searchQuery.trim().isNotEmpty) {
      final q = _searchQuery.toLowerCase().trim();
      result = result.where((fruit) {
        return fruit.name.toLowerCase().contains(q) ||
            fruit.indonesianName.toLowerCase().contains(q) ||
            fruit.family.toLowerCase().contains(q);
      }).toList();
    }

    // Filter berdasarkan kriteria nutrisi
    switch (_selectedFilter) {
      case 'Rendah Kalori':
        result = result.where((f) => f.nutritions.calories < 50).toList();
        break;
      case 'Tinggi Protein':
        result = result.where((f) => f.nutritions.protein >= 1.0).toList();
        break;
      case 'Rendah Gula':
        result = result.where((f) => f.nutritions.sugar < 7.0).toList();
        break;
      case 'Padat Energi':
        result = result.where((f) => f.nutritions.calories >= 70).toList();
        break;
      default:
        break;
    }

    _filteredFruits = result;
    notifyListeners();
  }
}
