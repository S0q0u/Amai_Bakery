import 'package:flutter/material.dart';

class about_page extends StatelessWidget {
  const about_page({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var lebar = MediaQuery.of(context).size.width;
    var tinggi = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Center(
        child: ListView(
          padding: const EdgeInsets.all(20.0),
          children: [
            CircleAvatar(
              backgroundImage: const AssetImage('assets/potooo.jpg'),
              radius: lebar < tinggi ? lebar * 0.2 : tinggi * 0.4,
            ),
            const SizedBox(height: 20),
            ListTile(
              title: Text(
                'Kelompok 3',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.labelMedium,
              ),
            ),
            ListTile(
              title: Text(
                'UAS MOBILE',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.labelMedium,
              ),
            ),
            ListTile(
              title: Text(
                'Mobile Programming B 21',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.labelMedium,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
