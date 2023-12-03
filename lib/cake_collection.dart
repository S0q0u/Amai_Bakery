import 'package:flutter/foundation.dart';
import 'auth.dart';
import 'dart:async';

class Cake with ChangeNotifier {
  final String id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;

  Cake({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
  });
}

class CakeList with ChangeNotifier {
  final FirebaseServiceCake _firebaseServiceCake = FirebaseServiceCake();
  // Properti stream untuk mendengarkan perubahan pada daftar kue
  StreamController<List<Cake>> _cakesController = StreamController<List<Cake>>.broadcast();

  // Stream untuk digunakan oleh StreamBuilder di ManageCake
  Stream<List<Cake>> get cakesStream => _cakesController.stream;

  Cake? _selectedCake; // Variabel yang menyimpan satu instance dari kue yang dipilih.
  Cake? get selectedCake => _selectedCake; // Getter yang memberikan akses ke instance kue yang dipilih.
  Set<Cake> _selectedCakes = {}; //Set yang menyimpan banyak instance dari kue yang dipilih.
  Set<Cake> get selectedCakes => _selectedCakes; //Getter yang memberikan akses ke Set kue yang dipilih.

  void selectCake(Cake cake) {
    _selectedCakes.add(cake);
    notifyListeners();
  }

  void unselectCake(Cake cake) {
    _selectedCakes.remove(cake);
    notifyListeners();
  }


  // TAMBAH CAKE
  Future<void> addCake(Cake cake) async {
    final newProduct = {
      'name': cake.name,
      'description': cake.description,
      'price': cake.price,
      'imageUrl': cake.imageUrl,
    };

    await _firebaseServiceCake.addCake(newProduct);
    notifyListeners();
  }

  // UPDATE CAKE
  Future<void> updateCake(String id, Cake newCake) async {
    final updatedCake = {
      'name': newCake.name,
      'description': newCake.description,
      'price': newCake.price,
      'imageUrl': newCake.imageUrl,
    };

    await _firebaseServiceCake.updateCake(id, updatedCake);
    notifyListeners();
  }


  // HAPUS CAKE
  Future<void> deleteCake(String id) async {
    await _firebaseServiceCake.deleteCake(id);
    notifyListeners();
  }
}
