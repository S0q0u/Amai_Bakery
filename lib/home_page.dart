import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'cake_collection.dart';
import 'login.dart';

class home_page extends StatelessWidget {
  static const String routeName = '/Home';

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    final cakeData = Provider.of<CakeList>(context);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: theme.primaryColor,
        title: const Text(
          'AMAI BAKERY',
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 10.0),
            child: IconButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => LoginPage(),
                  ),
                );
              },
              icon: const Icon(
                Icons.logout,
                size: 30,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            // Container(
            //   alignment: Alignment.center,
            //   margin: const EdgeInsets.only(
            //       left: 10, right: 10, top: 10, bottom: 5),
            //   child: const Text(
            //     'Delicious Bake Collection',
            //     style: TextStyle(
            //       color: Colors.black,
            //       fontSize: 15,
            //       fontWeight: FontWeight.bold,
            //     ),
            //   ),
            // ),
            Expanded(
              child: ListView.builder(
                itemCount: cakeData.items.length,
                itemBuilder: (_, int index) {
                  return Container(
                    height: 100,
                    margin:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.grey, // warna bayangan
                          blurRadius: 5, // radius blur bayangan
                          offset: Offset(0,
                              0), // pergeseran bayangan (horizontal, vertical)
                        ),
                      ],
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(
                              10), // Atur sudut lengkungan gambar
                          child: Container(
                            width: 150,
                            //height: 80,
                            decoration: BoxDecoration(
                              //borderRadius: BorderRadius.circular(5),
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(5),
                                bottomLeft: Radius.circular(5),
                              ),
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                    cakeData.items[index].imageUrl),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: const EdgeInsets.only(left: 10),
                                child: Text(
                                  cakeData.items[index].name,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 5),
                              Container(
                                alignment: Alignment.bottomRight,
                                margin: const EdgeInsets.only(right: 20),
                                child: Text(
                                  'Rp ${cakeData.items[index].price.toString()}',
                                  style: TextStyle(
                                    color: theme.primaryColor,
                                    fontSize: 16,
                                  ),
                                ),
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
          ],
        ),
      ),
    );
  }
}
