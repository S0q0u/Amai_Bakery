// ignore_for_file: library_private_types_in_public_api, use_key_in_widget_constructors, camel_case_types

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'main.dart';

class input_bakery_page extends StatefulWidget {
  const input_bakery_page({Key? key});

  @override
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<input_bakery_page> {
  final name = TextEditingController();
  final phoneNumber = TextEditingController();
  final address = TextEditingController();

  // Map untuk menyimpan jumlah item yang ingin dibeli
  Map<String, int> quantities = {};

// Map untuk menyimpan nama item beserta harganya
  Map<String, int> menuPrices = {
    'Roti Buaya': 200000,
    'Kue Tart': 300000,
    'Donat': 55000,
    'Bolu Gulung': 200000,
    'Brownies': 75000,
    'Croissant': 80000,
    'Cheese Cake': 120000,
    'Redvelvet Cake': 90000,
    'Tiramisu Cake': 120000,
  };

// Fungsi untuk mengembalikan nilai jumlah yang harus dibayar
  int getTotal() {
    int total = 0;
    for (String item in quantities.keys) {
      total += (menuPrices[item]! * quantities[item]!).toInt();
    }
    return total;
  }

  // Fungsi untuk mengosongkan semua inputan saat tombol tutup ditekan
  void kosong() {
    name.clear();
    phoneNumber.clear();
    address.clear();
    quantities.clear();
    setState(() {}); // Memaksa widget untuk melakukan rebuild
  }

  // Fungsi untuk menampilkan nota pesanan
  void submitOrder() {
    String nameValue = name.text;
    String phoneNumberValue = phoneNumber.text;
    String addressValue = address.text;

// Map untuk menyimpan data pesanan
    Map<String, dynamic> order = {
      'name': nameValue,
      'phoneNumber': phoneNumberValue,
      'address': addressValue,
      'items':
          List<Map<String, dynamic>>.from(quantities.entries.map((entry) => {
                'item': entry.key,
                'quantity': entry.value,
                'price': menuPrices[entry.key],
              })),
      'total': getTotal(),
    };

    // Mengambil waktu saat tombol "Pesan Sekarang" diklik
    DateTime orderDate = DateTime.now();
    order['orderDate'] = orderDate;

    int year = orderDate.year;
    int month = orderDate.month;
    int day = orderDate.day;
    int hour = orderDate.hour;
    int minute = orderDate.minute;

    // Tambahkan tanggal, jam, dan menit ke dalam nota pesanan
    order['orderYear'] = year;
    order['orderMonth'] = month;
    order['orderDay'] = day;
    order['orderHour'] = hour;
    order['orderMinute'] = minute;

    // Menyimpan data pesanan
    OrderData orderData = Provider.of<OrderData>(context, listen: false);
    orderData.addOrder(order);
    // OrderData().addOrder(order);

    // Menampilkan nota
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.pink,
          title: Text(
            'NOTA PESANAN',
            style: TextStyle(
              color: Colors.white,
            ),
            //style: Theme.of(context).textTheme.bodyMedium,
          ),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Nama: $nameValue',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              Text(
                'Nomor Telepon: $phoneNumberValue',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              Text(
                'Alamat: $addressValue',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              const Text(
                'Pesanan:',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              for (String item in quantities.keys)
              Text(
                '$item: ${quantities[item]} x Rp ${menuPrices[item]}',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              Text(''
                'Total: Rp ${getTotal()}',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              Text(
                'Tanggal Pemesanan: $day/$month/$year',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              Text(
                'Waktu Pemesanan: $hour:$minute',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ],
          ),
          // Menerapkan background color sesuai tema
          //backgroundColor: Theme.of(context).dialogBackgroundColor,
          // Menutup nota dan membersihkan inputan
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                kosong();
              },
              child: Text(
                'Tutup',
                style: TextStyle(
                  color: Colors.white,
                ),
                //style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink,
        title: const Text(
          'Buy Cake',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextField(
                  controller: name,
                  style: Theme.of(context).textTheme.bodyMedium,
                  decoration: InputDecoration(
                    labelText: 'Nama',
                    labelStyle: Theme.of(context).textTheme.labelMedium,
                    filled: true, // Mengaktifkan pengisian latar belakang
                    fillColor: Colors.white, // Warna latar belakang
                    border: const OutlineInputBorder(),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color.fromARGB(255, 248, 30, 67),
                      ), // Border ketika fokus
                    ),
                  ),
                  maxLength: 50,
                ),
                const SizedBox(height: 10.0),
                TextField(
                  controller: phoneNumber,
                  keyboardType: TextInputType.phone,
                  style: Theme.of(context).textTheme.bodyMedium,
                  decoration: InputDecoration(
                    labelText: 'Nomor Telepon',
                    labelStyle: Theme.of(context).textTheme.labelMedium,
                    filled: true, // Mengaktifkan pengisian latar belakang
                    fillColor: Colors.white, // Warna latar belakang
                    border: const OutlineInputBorder(),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color.fromARGB(255, 248, 30, 67),
                      ), // Border ketika fokus
                    ),
                  ),
                  maxLength: 13,
                ),
                const SizedBox(height: 10.0),
                TextField(
                  controller: address,
                  maxLines: 3,
                  style: Theme.of(context).textTheme.bodyMedium,
                  decoration: InputDecoration(
                    labelText: 'Alamat',
                    labelStyle: Theme.of(context).textTheme.labelMedium,
                    filled: true, // Mengaktifkan pengisian latar belakang
                    fillColor: Colors.white, // Warna latar belakang
                    border:
                        const OutlineInputBorder(), // Atau gunakan jenis border yang sesuai dengan kebutuhan Anda
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color.fromARGB(255, 248, 30, 67),
                      ), // Border ketika fokus
                    ),
                  ),
                ),
                const SizedBox(height: 20.0),
                // Listview, separated digunakan untuk memisahkan tiap item
                ListView.separated(
                  shrinkWrap: true,
                  itemCount: menuPrices.keys.length,
                  itemBuilder: (context, index) {
                    String item = menuPrices.keys.toList()[index];
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          item,
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                        Row(
                          children: <Widget>[
                            FloatingActionButton(
                              onPressed: () {
                                setState(() {
                                  if (quantities.containsKey(item) &&
                                      quantities[item]! > 0) {
                                    quantities[item] = quantities[item]! - 1;
                                  }
                                });
                              },
                              mini: true,
                              backgroundColor:
                                  const Color.fromARGB(255, 248, 30, 67),
                              child: const Icon(
                                CupertinoIcons.minus,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(width: 10.0),
                            Text(
                              style: Theme.of(context).textTheme.labelMedium,
                              '${quantities[item] ?? 0}',
                            ),
                            const SizedBox(width: 10.0),
                            FloatingActionButton(
                              onPressed: () {
                                setState(() {
                                  if (quantities.containsKey(item)) {
                                    quantities[item] = quantities[item]! + 1;
                                  } else {
                                    quantities[item] = 1;
                                  }
                                });
                              },
                              mini: true,
                              backgroundColor:
                                  const Color.fromARGB(255, 248, 30, 67),
                              child: const Icon(
                                CupertinoIcons.add,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                  separatorBuilder: (context, index) => const SizedBox(
                      height: 10.0), // jarak antar item adalah 10
                ),
                const SizedBox(
                  height: 15,
                ),
                CupertinoButton(
                  color: const Color.fromARGB(255, 248, 30, 67),
                  onPressed: () {
                    submitOrder();
                    // Menampilkan snackbar saat button order diklik
                    const mySnackBar = SnackBar(
                      content: Text("Order berhasil"),
                      duration: Duration(seconds: 3),
                      padding: EdgeInsets.all(10),
                      backgroundColor: Color.fromARGB(255, 248, 30, 67),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(mySnackBar);
                  },
                  child: const Text(
                    'Pesan Sekarang',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
