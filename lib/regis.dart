// ignore_for_file: use_build_context_synchronously

import 'package:bakery/auth.dart';
import 'package:bakery/login.dart';
import 'package:flutter/material.dart';

class RegisPage extends StatefulWidget {
  const RegisPage({super.key});

  @override
  State<RegisPage> createState() => _RegisPageState();
}

class _RegisPageState extends State<RegisPage> {
  final TextEditingController _gmailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final TextEditingController _confirmPassController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _loading = false;

  final authUser _auth = authUser(); // Buat instance dari class Auth

  void handleSubmit() async {
    if (!_formKey.currentState!.validate()) return;

    final email = _gmailController.text;
    final password = _passController.text;
    final confPass = _confirmPassController.text;

    setState(() => _loading = true);

    if (password != confPass) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Registrasi Gagal'),
            content: const Text('Password dan Confirm Password tidak cocok.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
      setState(() => _loading = false);
      return;
    }
    try {
      await _auth.regis(email, password, confPass);

      // Show success dialog
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Registrasi Berhasil'),
            content: const Text(
                'Akun Anda telah berhasil terdaftar. Anda sekarang dapat masuk menggunakan kredensial Anda.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the success dialog

                  // Navigate to the LoginPage after the dialog is closed
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => const LoginPage(),
                    ),
                  );
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    } catch (e) {
      // Display error dialog
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Registrasi Error'),
            content: Text(e.toString()),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }

    setState(() => _loading = false);
  }

  bool isPasswordVisible = false;

  void _togglePasswordVisibility() {
    setState(() {
      isPasswordVisible = !isPasswordVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 248, 226, 230),
      body: Form(
        key: _formKey,
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 50),
              child: Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                  color: Colors.white,
                ),
                height: double.infinity,
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.only(left: 18.0, right: 18),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'REGISTRASI',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 223, 128, 144),
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _gmailController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Email masih kosong';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          suffixIcon: Icon(
                            Icons.email,
                            color: Colors.grey,
                          ),
                          labelText: 'Email',
                          labelStyle: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 223, 128, 144),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors
                                  .pink, // Warna outline saat dalam keadaan fokus
                              width: 2.0, // Lebar garis
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _passController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Password masih kosong';
                          }
                          return null;
                        },
                        style: const TextStyle(
                          fontSize: 14,
                        ),
                        obscureText: !isPasswordVisible,
                        decoration: InputDecoration(
                          suffixIcon: GestureDetector(
                            onTap: _togglePasswordVisibility,
                            child: Icon(
                              isPasswordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Colors.grey,
                            ),
                          ),
                          labelText: 'Password',
                          labelStyle: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 223, 128, 144),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors
                                  .pink, // Warna outline saat dalam keadaan fokus
                              width: 2.0, // Lebar garis
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _confirmPassController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Confirm Password masih kosong';
                          }
                          return null;
                        },
                        style: const TextStyle(
                          fontSize: 14,
                        ),
                        obscureText: !isPasswordVisible,
                        decoration: InputDecoration(
                          suffixIcon: GestureDetector(
                            onTap: _togglePasswordVisibility,
                            child: Icon(
                              isPasswordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Colors.grey,
                            ),
                          ),
                          labelText: 'Confirm Password',
                          labelStyle: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 223, 128, 144),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors
                                  .pink, // Warna outline saat dalam keadaan fokus
                              width: 2.0, // Lebar garis
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () => handleSubmit(),
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 248, 30, 67),
                          minimumSize: const Size(250, 50),
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                        ),
                        child: _loading
                            ? const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2,
                                ),
                              )
                            : const Text(
                                'Simpan',
                                style: TextStyle(color: Colors.white),
                              ),
                      ),
                      const SizedBox(height: 20),
                      Align(
                        alignment: Alignment.center,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const LoginPage()));
                          },
                          child: const Column(
                            children: [
                              Text(
                                "Already have an account?",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey,
                                ),
                              ),
                              Text(
                                "Sign in",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  color: Colors.blue,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
