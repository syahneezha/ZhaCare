import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zhacare/data/models/bmi_model.dart';
import 'package:zhacare/data/models/fruit_model.dart';
import 'package:zhacare/main.dart';
import 'package:zhacare/providers/auth_provider.dart';

void main() {
  test('BmiResult calculates score and category correctly', () {
    final result = BmiResult.calculate(weightKg: 62.0, heightCm: 168.0);
    expect(result.score, 22.0);
    expect(result.category, BmiCategory.normal);
    expect(result.category.label, 'Normal & Ideal');
    expect(result.idealWeightMin, 52.2);
    expect(result.idealWeightMax, 70.3);
  });

  test('FruitModel parses JSON and maps Indonesian names', () {
    final json = {
      'id': 6,
      'name': 'Apple',
      'family': 'Rosaceae',
      'order': 'Rosales',
      'genus': 'Malus',
      'nutritions': {
        'calories': 52,
        'fat': 0.4,
        'sugar': 10.3,
        'carbohydrates': 11.4,
        'protein': 0.3,
      },
    };
    final fruit = FruitModel.fromJson(json);
    expect(fruit.name, 'Apple');
    expect(fruit.indonesianName, 'Apel');
    expect(fruit.nutritions.calories, 52.0);
    expect(fruit.calorieCategory, 'Kalori Sedang');
  });

  test('AuthProvider manages login, guest, and logout states', () async {
    final auth = AuthProvider();
    expect(auth.isLoggedIn, false);

    // Test Login
    await auth.login(identifier: 'zhahira@gmail.com', password: 'password123');
    expect(auth.isLoggedIn, true);
    expect(auth.userName, 'Zhahira');
    expect(auth.isGuest, false);

    // Test Logout
    auth.logout();
    expect(auth.isLoggedIn, false);

    // Test Guest Login
    auth.loginAsGuest();
    expect(auth.isLoggedIn, true);
    expect(auth.isGuest, true);
  });

  testWidgets('ZhaCare app renders Login and transitions to Home on Guest Login', (WidgetTester tester) async {
    tester.view.physicalSize = const Size(800, 1000);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);

    await tester.pumpWidget(const ZhaCareApp());

    // Awal: Menampilkan layar login
    expect(find.text('ZhaCare'), findsOneWidget);

    final guestButton = find.text('Lanjutkan sebagai Tamu (Guest Mode)');
    expect(guestButton, findsOneWidget);

    // Klik tombol Guest Mode
    await tester.tap(guestButton);
    await tester.pumpAndSettle();

    // Berhasil masuk ke Home Screen
    expect(find.text('Halo, Sobat ZhaCare! 👋'), findsOneWidget);
    expect(find.text('Dashboard'), findsOneWidget);
    expect(find.text('BMI'), findsOneWidget);
    expect(find.text('Nutrisi Buah'), findsOneWidget);
  });
}
