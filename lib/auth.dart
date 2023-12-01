import 'package:firebase_auth/firebase_auth.dart';

class auth {
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
