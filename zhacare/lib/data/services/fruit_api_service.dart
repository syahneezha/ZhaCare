import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/fruit_model.dart';

class FruitApiService {
  static const String _baseUrl = 'https://www.fruityvice.com/api/fruit';

  /// Mengambil semua data nutrisi buah dari Fruityvice API publik
  Future<List<FruitModel>> getAllFruits() async {
    try {
      final response = await http
          .get(Uri.parse('$_baseUrl/all'))
          .timeout(const Duration(seconds: 8));

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body) as List<dynamic>;
        return data
            .map((item) => FruitModel.fromJson(item as Map<String, dynamic>))
            .toList();
      } else {
        return _fallbackFruits;
      }
    } catch (_) {
      // Jika offline atau terjadi timeout, gunakan fallback dataset lokal
      return _fallbackFruits;
    }
  }

  /// Mencari buah spesifik berdasarkan nama
  Future<FruitModel?> getFruitByName(String name) async {
    try {
      final response = await http
          .get(Uri.parse('$_baseUrl/${Uri.encodeComponent(name.trim())}'))
          .timeout(const Duration(seconds: 6));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body) as Map<String, dynamic>;
        return FruitModel.fromJson(data);
      }
    } catch (_) {}

    // Cari dari fallback jika API tidak merespons
    final query = name.toLowerCase().trim();
    try {
      return _fallbackFruits.firstWhere(
        (f) =>
            f.name.toLowerCase() == query ||
            f.indonesianName.toLowerCase() == query,
      );
    } catch (_) {
      return null;
    }
  }

  /// Fallback curated dataset buah segar lengkap jika offline
  static final List<FruitModel> _fallbackFruits = [
    const FruitModel(
      id: 6,
      name: 'Apple',
      family: 'Rosaceae',
      order: 'Rosales',
      genus: 'Malus',
      nutritions: FruitNutritions(
        calories: 52,
        fat: 0.4,
        sugar: 10.3,
        carbohydrates: 11.4,
        protein: 0.3,
      ),
    ),
    const FruitModel(
      id: 1,
      name: 'Banana',
      family: 'Musaceae',
      order: 'Zingiberales',
      genus: 'Musa',
      nutritions: FruitNutritions(
        calories: 96,
        fat: 0.2,
        sugar: 17.2,
        carbohydrates: 22.0,
        protein: 1.0,
      ),
    ),
    const FruitModel(
      id: 2,
      name: 'Orange',
      family: 'Rutaceae',
      order: 'Sapindales',
      genus: 'Citrus',
      nutritions: FruitNutritions(
        calories: 43,
        fat: 0.2,
        sugar: 8.2,
        carbohydrates: 8.3,
        protein: 1.0,
      ),
    ),
    const FruitModel(
      id: 3,
      name: 'Strawberry',
      family: 'Rosaceae',
      order: 'Rosales',
      genus: 'Fragaria',
      nutritions: FruitNutritions(
        calories: 29,
        fat: 0.4,
        sugar: 5.4,
        carbohydrates: 5.5,
        protein: 0.8,
      ),
    ),
    const FruitModel(
      id: 25,
      name: 'Watermelon',
      family: 'Cucurbitaceae',
      order: 'Cucurbitales',
      genus: 'Citrullus',
      nutritions: FruitNutritions(
        calories: 30,
        fat: 0.2,
        sugar: 6.0,
        carbohydrates: 8.0,
        protein: 0.6,
      ),
    ),
    const FruitModel(
      id: 27,
      name: 'Mango',
      family: 'Anacardiaceae',
      order: 'Sapindales',
      genus: 'Mangifera',
      nutritions: FruitNutritions(
        calories: 60,
        fat: 0.38,
        sugar: 13.7,
        carbohydrates: 15.0,
        protein: 0.82,
      ),
    ),
    const FruitModel(
      id: 84,
      name: 'Avocado',
      family: 'Lauraceae',
      order: 'Laurales',
      genus: 'Persea',
      nutritions: FruitNutritions(
        calories: 160,
        fat: 14.66,
        sugar: 0.66,
        carbohydrates: 8.53,
        protein: 2.0,
      ),
    ),
    const FruitModel(
      id: 10,
      name: 'Pineapple',
      family: 'Bromeliaceae',
      order: 'Poales',
      genus: 'Ananas',
      nutritions: FruitNutritions(
        calories: 50,
        fat: 0.12,
        sugar: 9.85,
        carbohydrates: 13.12,
        protein: 0.54,
      ),
    ),
    const FruitModel(
      id: 66,
      name: 'Kiwi',
      family: 'Actinidiaceae',
      order: 'Ericales',
      genus: 'Actinidia',
      nutritions: FruitNutritions(
        calories: 61,
        fat: 0.5,
        sugar: 9.0,
        carbohydrates: 15.0,
        protein: 1.1,
      ),
    ),
    const FruitModel(
      id: 42,
      name: 'Papaya',
      family: 'Caricaceae',
      order: 'Brassicales',
      genus: 'Carica',
      nutritions: FruitNutritions(
        calories: 43,
        fat: 0.26,
        sugar: 7.82,
        carbohydrates: 10.82,
        protein: 0.47,
      ),
    ),
    const FruitModel(
      id: 33,
      name: 'Blueberry',
      family: 'Ericaceae',
      order: 'Ericales',
      genus: 'Vaccinium',
      nutritions: FruitNutritions(
        calories: 29,
        fat: 0.33,
        sugar: 5.4,
        carbohydrates: 5.5,
        protein: 0.7,
      ),
    ),
    const FruitModel(
      id: 77,
      name: 'Guava',
      family: 'Myrtaceae',
      order: 'Myrtales',
      genus: 'Psidium',
      nutritions: FruitNutritions(
        calories: 68,
        fat: 0.95,
        sugar: 8.92,
        carbohydrates: 14.32,
        protein: 2.55,
      ),
    ),
  ];
}
