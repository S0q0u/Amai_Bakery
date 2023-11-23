import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'cake_collection.dart';
import 'edit_cake.dart';

class ManageCake extends StatelessWidget {
  static const String routeName = '/ManageCake';

  const ManageCake({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    final cakeData1 = Provider.of<CakeList>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.primaryColor,
        title: const Text(
          'Manage Cake',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 10.0),
            child: IconButton(
              onPressed: () {
                // Navigator untuk tambah cake
                Navigator.pushNamed(context, EditCake.routeName);
              },
              icon: const Icon(
                Icons.add,
                size: 30,
                color: Colors.white,
              ),
            ),
          ),
        ],
        //centerTitle: true,
      ),
      body: Center(
        child: ListView.builder(
          itemCount: cakeData1.items.length,
          itemBuilder: (_, int index) {
            return Container(
              height: 100,
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.grey, // warna bayangan
                    blurRadius: 5, // radius blur bayangan
                    offset: Offset(
                        0, 0), // pergeseran bayangan (horizontal, vertical)
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(cakeData1.items[index].imageUrl),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10), // Spasi antara gambar dan teks
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          cakeData1.items[index].name,
                          style: Theme.of(context).textTheme.bodyMedium,
                          // const TextStyle(
                          //   fontSize: 15,
                          //   fontWeight: FontWeight.bold,
                          // ),
                        ),
                        Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: () {
                                Navigator.pushNamed(
                                  context,
                                  EditCake.routeName,
                                  arguments: cakeData1.items[index].id,
                                );
                              },
                              color: Theme.of(context).primaryColor,
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () {
                                // Tampilkan dialog konfirmasi sebelum menghapus
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text(
                                        'Konfirmasi',
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelMedium,
                                      ),
                                      content: Text(
                                        'Anda yakin ingin menghapus?',
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelSmall,
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context)
                                                .pop(); // Tutup dialog
                                          },
                                          child: const Text('No'),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            Provider.of<CakeList>(context,
                                                    listen: false)
                                                .deleteCake(
                                                    cakeData1.items[index].id);
                                            Navigator.of(context)
                                                .pop(); // Tutup dialog
                                          },
                                          child: const Text('Yes'),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                              color: Colors.red,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
