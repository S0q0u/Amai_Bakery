import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'cake_collection.dart';
import 'login.dart';
import 'auth.dart';

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
        child: StreamBuilder<List<Cake>>(
          stream: FirebaseServiceCake().getCakesStream(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              List<Cake> cakes = snapshot.data ?? [];

              return ListView.builder(
                itemCount: cakes.length,
                itemBuilder: (_, int index) {
                  return Container(
                    height: 100,
                    margin: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 5,
                          offset: Offset(0, 0),
                        ),
                      ],
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 150,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(5),
                              bottomLeft: Radius.circular(5),
                            ),
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(cakes[index].imageUrl),
                            ),
                          ),
                        ),
                        //const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: const EdgeInsets.only(left: 10),
                                child: Text(
                                  cakes[index].name,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Container(
                                //alignment: Alignment.bottomRight,
                                margin: const EdgeInsets.only(left: 10),
                                child: Text(
                                  'Rp ${cakes[index].price.toString()}',
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
              );
            }
          },
        ),
      ),
    );
  }
}
