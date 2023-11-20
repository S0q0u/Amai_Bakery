// ignore_for_file: camel_case_types, library_private_types_in_public_api

import 'package:flutter/material.dart';

class home_page extends StatefulWidget {
  const home_page({Key? key}) : super(key: key);

  @override
  _home_pageState createState() => _home_pageState();
}

class _home_pageState extends State<home_page> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: home_pageContent(),
      // backgroundColor: Color.fromARGB(255, 240, 202, 209),
    );
  }
}

class home_pageContent extends StatelessWidget {
  const home_pageContent({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Center(
        child: Padding(
          // Menambah padding setiap sisi
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              MenuItem(
                  imagePath: 'assets/buaya.jpg',
                  name: 'Roti Buaya',
                  price: 'Rp200.000'),
              MenuItem(
                  imagePath: 'assets/tart.jpg',
                  name: 'Kue Tart',
                  price: 'Rp300.000'),
              MenuItem(
                  imagePath: 'assets/donat.jpg',
                  name: 'Donat',
                  price: 'Rp55.000'),
              MenuItem(
                  imagePath: 'assets/bolu.jpeg',
                  name: 'Bolu Gulung',
                  price: 'Rp200.000'),
              MenuItem(
                  imagePath: 'assets/brownies.jpg',
                  name: 'Brownies',
                  price: 'Rp75.000'),
              MenuItem(
                  imagePath: 'assets/croissant.jpeg',
                  name: 'Croissant',
                  price: 'Rp80.000'),
              MenuItem(
                  imagePath: 'assets/cheesecake.jpg',
                  name: 'Cheese Cake',
                  price: 'Rp120.000'),
              MenuItem(
                  imagePath: 'assets/redvelvet.jpg',
                  name: 'Red Velvet Cake',
                  price: 'Rp90.000'),
              MenuItem(
                  imagePath: 'assets/tiramisu.jpg',
                  name: 'Tiramisu Cake',
                  price: 'Rp120.000'),
            ],
          ),
        ),
      ),
    );
  }
}

// Kelas menu item
class MenuItem extends StatelessWidget {
  final String imagePath;
  final String name;
  final String price;

  // Contructor
  const MenuItem({
    Key? key,
    required this.imagePath,
    required this.name,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    var lebar = MediaQuery.of(context).size.width;
    var tinggi = MediaQuery.of(context).size.height;

    return Container(
      height: tinggi * 0.2,
      // Menambah margin tiap sisi container
      margin: const EdgeInsets.all(16.0), // Atur margin sesuai kebutuhan
      // Styling container
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(255, 185, 165, 168)
                .withOpacity(0.7), // Warna shadow
            spreadRadius: 3, // Radius penyebaran shadow
            blurRadius: 7, // Radius blur shadow
            offset: const Offset(1, 4), // Posisi shadow (x, y)
          ),
        ], // Atur sudut lengkungan sesuai kebutuhan
      ),
      child:
          Row(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
        Container(
          width: lebar * 0.4,
          height: tinggi * 0.4,
          // ClipRRect untuk memotong sudut gambar
          child: ClipRRect(
            borderRadius:
                BorderRadius.circular(10), // Atur sudut lengkungan gambar
            child: Image.asset(
              imagePath,
              // Membuat gambar mengisi seluruh kotak tanpa mengubah rasio gambarnya
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(width: 20),
        Expanded(
          child: ListView(
            padding: EdgeInsets.only(top: 10),
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Padding(padding: EdgeInsets.only(top: 30)),
              // Nama item
              Text(
                name,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 5),
              // Harga item
              Text(
                price,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
