import 'package:flutter/material.dart';
import 'cake_collection.dart';
import 'edit_cake.dart';
import 'auth.dart';

class ManageCake extends StatelessWidget {
  static const String routeName = '/ManageCake';

  const ManageCake({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    final firestoreService = FirebaseServiceCake();

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
                Navigator.pushNamed(
                    context,
                    EditCake.routeName
                );
              },
              icon: const Icon(
                Icons.add,
                size: 30,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      body: StreamBuilder<List<Cake>>(
        // Menggunakan stream untuk mendengarkan perubahan data dari Firestore
        stream: firestoreService.getCakesStream(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            // Menampilkan data kue dalam ListView.builder
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (_, int index) {
                final cake = snapshot.data![index];
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
                          0, 0, // pergeseran bayangan (horizontal, vertical)
                        ),
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
                            image: NetworkImage(cake.imageUrl),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10), // Spasi antara gambar dan teks
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                cake.name,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Row(
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.edit),
                                  onPressed: () {
                                    Navigator.pushNamed(
                                      context,
                                      EditCake.routeName,
                                      arguments: cake.id,
                                    );
                                  },
                                  color: Colors.black,
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete),
                                  onPressed: () {
                                    // Tampilkan dialog konfirmasi sebelum menghapus
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          backgroundColor: Colors.pink,
                                          title: const Text(
                                            'Konfirmasi',
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                          content: const Text(
                                            'Anda yakin ingin menghapus?',
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                          actions: [
                                            TextButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: const Text(
                                                'No',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                firestoreService.deleteCake(cake.id);
                                                Navigator.of(context).pop();
                                              },
                                              child: const Text(
                                                'Yes',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                ),
                                              ),
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
            );
          }
        },
      ),
    );
  }
}
