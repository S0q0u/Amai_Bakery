import 'package:bakery/login.dart';
import 'package:bakery/manage_cake.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'cake_collection.dart';
import 'history_page.dart';
import 'input_bakery_page.dart';
import 'home_page.dart';
import 'about_page.dart';
import 'edit_cake.dart';
import 'theme_mode_data.dart';
import 'IntroductionPage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (BuildContext context) => CakeList()),
        ChangeNotifierProvider(create: (BuildContext context) => OrderData()),
        ChangeNotifierProvider(
            create: (BuildContext context) => ThemeModeData()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const IntroductionPage(),
        routes: {
          home_page.routeName: (ctx) => home_page(),
          ManageCake.routeName: (ctx) => const ManageCake(),
          EditCake.routeName: (ctx) => EditCake(),
        },
        theme: ThemeData(
          primarySwatch: Colors.pink,
          primaryColor: Colors.pink,
        ),
      ),
    );
  }
}

class BottomNavigationAdmin extends StatefulWidget {
  const BottomNavigationAdmin({super.key});

  @override
  _BottomNavigationAdminState createState() => _BottomNavigationAdminState();
}

class _BottomNavigationAdminState extends State<BottomNavigationAdmin> {
  int _selectedIndex = 0;

  // List pages yang ditampilkan
  final List<Widget> _pages = [
    home_page(),
    const ManageCake(),
    const about_page(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: const Color.fromARGB(255, 248, 30, 67),
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.cake_outlined),
            label: 'Manage Cake',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.info),
            label: 'About',
          ),
        ],
        unselectedIconTheme: Theme.of(context).iconTheme,
        type: BottomNavigationBarType.fixed,
      ),
      // Menampilkan floating button menuju about page hanya di home page
    );
  }
}

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});

  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _selectedIndex = 0;

  // List pages yang ditampilkan
  final List<Widget> _pages = [
    home_page(),
    const input_bakery_page(),
    const history_page(),
    const about_page(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: const Color.fromARGB(255, 248, 30, 67),
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.gift),
            label: 'Shop',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.clock),
            label: 'History',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.info),
            label: 'About',
          ),
        ],
        unselectedIconTheme: Theme.of(context).iconTheme,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}

// Kelas untuk daftar pesanan
class OrderData extends ChangeNotifier {
  static final OrderData _instance = OrderData._internal();

  factory OrderData() {
    return _instance;
  }

  // Constructor pribadi
  OrderData._internal();

  // List kosong untuk pesanan
  final List<Map<String, dynamic>> _orders = [];

  // Fungsi untuk menyimpan daftar pesanan
  void addOrder(Map<String, dynamic> order) {
    _orders.add(order);
    notifyListeners();
  }

  // Mengakses daftar pesanan dari luar
  List<Map<String, dynamic>> get orders => _orders;
}
