import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'dart:async';

class Cake {
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

  // Konstruktor untuk membuat objek Cake dari Map
  Cake.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        name = map['name'],
        description = map['description'],
        price = map['price'],
        imageUrl = map['imageUrl'];

  // Metode untuk mengubah objek Cake menjadi Map
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'price': price,
      'imageUrl': imageUrl,
    };
  }
}


class FirebaseServiceCake {
  final FirebaseFirestore _firestoreCake = FirebaseFirestore.instance;

  Stream<List<Cake>> getCakesStream() {
    return _firestoreCake.collection('cakes').snapshots().map(
          (snapshot) => snapshot.docs
          .map(
            (doc) => Cake.fromMap({
          'id': doc.id,
          'name': doc['name'],
          'description': doc['description'],
          'price': doc['price'],
          'imageUrl': doc['imageUrl'],
        }),
      )
          .toList(),
    );
  }

  Future<Cake?> getCakeById(String id) async {
    try {
      final DocumentSnapshot cakeDoc =
      await _firestoreCake.collection('cakes').doc(id).get();

      if (cakeDoc.exists) {
        return Cake.fromMap({
          'id': cakeDoc.id,
          'name': cakeDoc['name'],
          'description': cakeDoc['description'],
          'price': cakeDoc['price'],
          'imageUrl': cakeDoc['imageUrl'],
        });
      } else {
        print('Cake with ID $id not found.');
        return null;
      }
    } catch (e) {
      print('Error fetching cake details: $e');
      return null;
    }
  }

  Future<void> addCake(Cake cake) async {
    await _firestoreCake.collection('cakes').add(cake.toMap());
  }

  Future<Cake?> updateCake(String id, Map<String, dynamic> updatedCakeData) async {
    await _firestoreCake.collection('cakes').doc(id).update(updatedCakeData);

    final updatedCakeDoc =
    await _firestoreCake.collection('cakes').doc(id).get();

    if (updatedCakeDoc.exists) {
      return Cake.fromMap({
        'id': updatedCakeDoc.id,
        'name': updatedCakeDoc['name'],
        'description': updatedCakeDoc['description'],
        'price': updatedCakeDoc['price'],
        'imageUrl': updatedCakeDoc['imageUrl'],
      });
    } else {
      print('Cake with ID $id not found.');
      return null;
    }
  }

  // HAPUS
  Future<void> deleteCake(String id) async {
    await _firestoreCake.collection('cakes').doc(id).delete();
  }
}


//============PROVIDER===============
class CakeList with ChangeNotifier {
  final FirebaseServiceCake _firebaseServiceCake = FirebaseServiceCake();
  Cake? _selectedCake; // Variabel yang menyimpan satu instance dari kue yang dipilih.
  Cake? get selectedCake => _selectedCake; // Getter yang memberikan akses ke instance kue yang dipilih.
  final Set<Cake> _selectedCakes = {}; //Set yang menyimpan banyak instance dari kue yang dipilih.
  Set<Cake> get selectedCakes => _selectedCakes; //Getter yang memberikan akses ke Set kue yang dipilih.

  void selectCake(Cake cake) {
    _selectedCakes.add(cake);
    notifyListeners();
  }

  Future<void> addCake(Cake cake) async {
    await _firebaseServiceCake.addCake(cake);
  }

  Future<void> updateCake(String id, Cake newCake) async {
    final updatedCake = await _firebaseServiceCake.updateCake(id, newCake.toMap());

    if (updatedCake != null) {
      _selectedCakes.removeWhere((cake) => cake.id == id);
      _selectedCakes.add(updatedCake);
      notifyListeners();
    }
  }
}
