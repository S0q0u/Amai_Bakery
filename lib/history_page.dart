import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'main.dart';

class history_page extends StatefulWidget {
  const history_page({Key? key});

  @override
  _history_pageState createState() => _history_pageState();
}

class _history_pageState extends State<history_page> {
  // list orders untuk menyimpan daftar pesanan
  List<Map<String, dynamic>> orders = OrderData().orders;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: const Color.fromARGB(255, 240, 202, 209),
      body: ListView.builder(
        // Menghitung jumlah item sesuai panjang list
        itemCount: orders.length,
        // Mengembalikan widget HistoryCard setiap item
        itemBuilder: (context, index) {
          return HistoryCard(order: orders[index]);
        },
      ),
    );
  }
}

class HistoryCard extends StatefulWidget {
  final Map<String, dynamic> order;

  const HistoryCard({Key? key, required this.order}) : super(key: key);

  @override
  _HistoryCardState createState() => _HistoryCardState();
}

class _HistoryCardState extends State<HistoryCard> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> order = widget.order;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      margin: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        // Mengatur border radius 16 saat ekspansi dan 8 saat dikembalikan ke kondisi awal
        borderRadius: BorderRadius.circular(isExpanded ? 16.0 : 8.0),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 3,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          ListTile(
            title: Text(
              // Mengatur nama menjadi uppercase
              'CUSTOMER: ${order['name'].toString().toUpperCase()}',
              textAlign: TextAlign.center,
              // style: const TextStyle(
              //   fontSize: 20,
              //   fontWeight: FontWeight.bold,
              // ),
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            subtitle: Text(
              'Total: Rp ${order['total']}',
              textAlign: TextAlign.center,
              // style: const TextStyle(
              //   fontSize: 16,
              //   color: Colors.red,
              // ),
              style: Theme.of(context).textTheme.bodySmall,
            ),
            // Button Ekspansi
            trailing: IconButton(
              icon: Icon(
                  isExpanded
                      ? CupertinoIcons.arrow_up
                      : CupertinoIcons.arrow_down,
                  color: Colors.black),
              onPressed: toggleExpansion,
            ),
          ),
          // Tampilkan detail jika ekspansi
          if (isExpanded)
            Column(
              children: [
                for (var item in order['items'])
                  ListTile(
                    title: Text(
                      '${item['item']} x ${item['quantity']}',
                      // style: const TextStyle(
                      //   fontStyle: FontStyle.italic,
                      // ),
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    subtitle: Text(
                      'Price: Rp ${item['price']}',
                      // style: const TextStyle(
                      //   fontStyle: FontStyle.italic,
                      // ),
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                ListTile(
                  title: Text(
                    'Alamat: ${order['address']}',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
                ListTile(
                  title: Text(
                    'Nomor Telepon: ${order['phoneNumber']}',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
                ListTile(
                  title: Text(
                    'Tanggal Pemesanan: ${order['orderDay']}/${order['orderMonth']}/${order['orderYear']} ${order['orderHour']}.${order['orderMinute']}',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }

  // Fungsi ekspansi
  void toggleExpansion() {
    setState(() {
      isExpanded = !isExpanded;
    });
  }
}
