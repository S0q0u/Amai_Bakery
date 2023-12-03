// ignore_for_file: camel_case_types

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'cake_collection.dart';

// ==========CLASS AUTH USER===========
class authUser {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> regis(String email, String password, String confirmPass) async {
    try {
      if (password != confirmPass) {
        throw 'Password dan confirm password tidak sesuai';
      }

      // Pemeriksaan jika ada yg regis dengan email admin
      if (email.toLowerCase() == 'admin@gmail.com') {
        throw 'Email sudah digunakan';
      }

      final regisUser = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = regisUser.user;
      final uidPengguna = user?.uid;

      if (user != null) {
        await user.updateDisplayName(user.email!);
        print('User registered successfully with email: $email');

        // MENYIMPAN AKUN KE FIREBASE
        await FirebaseFirestore.instance
            .collection('users')
            .doc(uidPengguna).set({
          'email': email,
        });
      } else {
        throw 'User registration failed';
      }
    } catch (e) {
      print('Registrasi Error: $e');
      if (e is FirebaseAuthException && e.code == 'email-already-in-use') {
        throw 'Email sudah digunakan.';
      } else {
        throw 'Registrasi Error: $e';
      }
    }
  }

  // UNTUK LOGIN
  Future<void> login(String email, String password) async {
    await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }
}


//==========CLASS AUTH CAKE=============
class FirebaseServiceCake {
  final FirebaseFirestore _firestoreCake = FirebaseFirestore.instance;

  // UNTUK MENAMPILKAN CAKE
  Stream<List<Cake>> getCakesStream() {
    return _firestoreCake
        .collection('cakes')
        .snapshots()
        .map((snapshot) => snapshot.docs
        .map((doc) => Cake(
      id: doc.id,
      name: doc['name'],
      description: doc['description'],
      price: doc['price'],
      imageUrl: doc['imageUrl'],
    ))
        .toList());
  }

  // UNTUK MENANGKAP CAKE DARI ID (DI BAGIAN UPDATE)
  Future<Cake?> getCakeById(String id) async {
    try {
      final DocumentSnapshot cakeDoc =
      await _firestoreCake.collection('cakes').doc(id).get();

      if (cakeDoc.exists) {
        return Cake(
          id: cakeDoc.id,
          name: cakeDoc['name'],
          description: cakeDoc['description'],
          price: cakeDoc['price'],
          imageUrl: cakeDoc['imageUrl'],
        );
      } else {
        print('Cake with ID $id not found.');
        return null;
      }
    } catch (e) {
      print('Error fetching cake details: $e');
      return null;
    }
  }

  // UNTUK TAMBAH CAKE BARU
  Future<void> addCake(Map<String, dynamic> cakeData) async {
    await _firestoreCake.collection('cakes').add(cakeData);
  }

  // UNTUK UPDATE CAKE
  Future<void> updateCake(String id, Map<String, dynamic> updatedCakeData) async {
    await _firestoreCake.collection('cakes').doc(id).update(updatedCakeData);
  }

  // UNTUK HAPUS CAKE
  Future<void> deleteCake(String id) async {
    await _firestoreCake.collection('cakes').doc(id).delete();
  }
}
