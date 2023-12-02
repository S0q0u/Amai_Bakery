import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'cake_collection.dart';

class authUser {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Future<void> regis(String nama, String email, String password, String confirmPass) async {
    try {
      if (password != confirmPass) {
        throw 'Password and confirm password do not match';
      }

      final regisUser = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = regisUser.user;
      final uidPengguna = user?.uid;

      if (user != null) {
        // Update display name
        await user.updateDisplayName(nama);
        print('User registered successfully with name: $nama');

        // Store additional user data in Firestore
        await FirebaseFirestore.instance
            .collection('users')
            .doc(uidPengguna);
        //     .collection('nama_user')
        //     .add({
        // 'nama': nama,
        // });
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
