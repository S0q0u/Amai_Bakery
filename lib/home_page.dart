import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:uas_bakery/cake_collection.dart';
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
        //backgroundColor: theme.primaryColor,
        backgroundColor: Colors.pink,
        title: Text(
          'AMAI BAKERY',
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          Container(
            margin: EdgeInsets.only(right: 10.0),
            child: IconButton(
              onPressed: () {
                // Navigator.of(context).push(
                //   MaterialPageRoute(
                //     builder: (_) => LoginPage(),
                //   ),
                // );
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => LoginPage(),
                  ),
                );
              },
              icon: Icon(
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
            Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 5),
              child: Text(
                'Delicious Bake Collection',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: cakeData.items.length,
                itemBuilder: (_, int index) {
                  return Container(
                    height: 100,
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.grey, // warna bayangan
                          blurRadius: 5, // radius blur bayangan
                          offset: Offset(0, 0), // pergeseran bayangan (horizontal, vertical)
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 150,
                          //height: 80,
                          decoration: BoxDecoration(
                            //borderRadius: BorderRadius.circular(5),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(5),
                              bottomLeft: Radius.circular(5),
                            ),
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(cakeData.items[index].imageUrl),
                            ),
                          ),
                        ),
                        // SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: EdgeInsets.only(left: 10),
                                child: Text(
                                  cakeData.items[index].name,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              SizedBox(height: 5),
                              Container(
                                margin: EdgeInsets.only(left: 10),
                                child: Text(
                                  'Rp ${cakeData.items[index].price.toString()}',
                                  style: TextStyle(
                                    color: theme.primaryColor,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              // Text(
                              //   cakeData.items[index].name,
                              //   style: TextStyle(
                              //     color: Colors.black,
                              //     fontSize: 18,
                              //     fontWeight: FontWeight.bold,
                              //   ),
                              // ),
                              // SizedBox(height: 5),
                              // Text(
                              //   'Rp ${cakeData.items[index].price.toString()}',
                              //   style: TextStyle(
                              //     color: Colors.black,
                              //     fontSize: 14,
                              //   ),
                              // ),
                              // Add more details if needed
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
