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

  Cake? _selectedCake; // tambahkan properti selectedCake

  Cake? get selectedCake => _selectedCake; // tambahkan getter untuk selectedCake



  // Add
  // void addCake(Cake cake) async{
  //   final newProduct = Cake(
  //     name: cake.name,
  //     description: cake.description,
  //     price: cake.price,
  //     imageUrl: cake.imageUrl,
  //     id: DateTime.now().toString(),
  //   );
  //   _items.add(newProduct);
  //   // _items.insert(0, newProduct); // at the start of the list
  //   notifyListeners();
  // }
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


  // Update
  // void updateCake(String id, Cake newCake) {
  //   final prodIndex = _items.indexWhere((prod) => prod.id == id);
  //   if (prodIndex >= 0) {
  //     _items[prodIndex] = newCake;
  //     notifyListeners();
  //   } else {
  //     print('...');
  //   }
  // }
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

  // Hapus
  // void deleteCake(String id) {
  //   _items.removeWhere((prod) => prod.id == id);
  //   notifyListeners();
  // }
  Future<void> deleteCake(String id) async {
    await _firebaseServiceCake.deleteCake(id);
    notifyListeners();
  }
}
