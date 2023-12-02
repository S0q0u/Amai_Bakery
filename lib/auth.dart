import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'cake_collection.dart';

class authUser {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Future<void> regis(
      String nama, String email, String password, String confirmPass) async {
    try {
      if (password != confirmPass) {
        throw 'Password and confirm password do not match';
      }

      final UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user != null) {
        User? firebaseUser = userCredential.user;
        // Simpan nama pengguna ke dalam dokumen user Firebase
        await firebaseUser!.updateDisplayName(nama);
        print('User registered successfully with name: $nama');
      } else {
        throw 'User registration failed';
      }
    } catch (e) {
      print('Registration error: $e');
      // Handle error accordingly, show snackbar, dialog, or navigate to an error page
    }
  }

  Future<void> login(String email, String password) async {
    final user = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }
}

class FirebaseServiceCake {
  final FirebaseFirestore _firestoreCake = FirebaseFirestore.instance;

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

  Future<void> addCake(Map<String, dynamic> cakeData) async {
    await _firestoreCake.collection('cakes').add(cakeData);
  }

  Future<void> updateCake(String id, Map<String, dynamic> updatedCakeData) async {
    await _firestoreCake.collection('cakes').doc(id).update(updatedCakeData);
  }

  Future<void> deleteCake(String id) async {
    await _firestoreCake.collection('cakes').doc(id).delete();
  }
}
