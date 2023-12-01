import 'package:flutter/material.dart';

class about_page extends StatelessWidget {
  const about_page({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var lebar = MediaQuery.of(context).size.width;
    var tinggi = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink,
        title: const Text(
          'About',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: Center(
        child: ListView(
          padding: const EdgeInsets.all(20.0),
          children: [
            CircleAvatar(
              backgroundImage: const AssetImage('assets/potooo.jpg'),
              radius: lebar < tinggi ? lebar * 0.2 : tinggi * 0.4,
            ),
            const SizedBox(height: 20),
            const ListTile(
              title: Text(
                'Kelompok 3',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const ListTile(
              title: Text(
                'UAS MOBILE',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black, fontSize: 15),
              ),
            ),
            const ListTile(
              title: Text(
                'Mobile Programming B 21',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black, fontSize: 15),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
