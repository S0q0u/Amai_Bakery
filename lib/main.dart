import 'package:bakery/manage_cake.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'IntroductionPage.dart';
import 'cake_collection.dart';
import 'history_page.dart';
import 'input_bakery_page.dart';
import 'home_page.dart';
import 'about_page.dart';
import 'edit_cake.dart';
import 'package:google_fonts/google_fonts.dart';

import 'login.dart';
import 'settings_screen.dart';
import 'theme_mode_data.dart';

void main() => runApp(
  MultiProvider(
    // providers: [
    // ChangeNotifierProvider(
    //   create: (BuildContext context) => OrderData(),
    // ),
    // ChangeNotifierProvider(
    //   create: (BuildContext context) => ThemeModeData(),
    // ),
    // ],
    providers: [
      ChangeNotifierProvider(
        create: (BuildContext context) => OrderData(),
      ),
      ChangeNotifierProvider(
        create: (BuildContext context) => CakeList(),
      ),
      ChangeNotifierProvider(
        create: (BuildContext context) => ThemeModeData(),
      ),
    ],
    child: MyApp(),
  ),
);

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  // inisiasi currentThemeMode sesuai ThemeMode system
  ThemeMode currentThemeMode = ThemeMode.system;

  // Metode toggleTheme untuk ganti tema dark -> light dan sebaliknya
  @override
  Widget build(BuildContext context) {
    // ColorScheme lightScheme = ColorScheme.fromSeed(
    //   seedColor: Colors.white,
    // );
    // ColorScheme darkScheme = ColorScheme.fromSeed(
    //   seedColor: Colors.black,
    //   brightness: Brightness.dark,
    // );
    //
    // final themeModeData = context.watch<ThemeModeData>();
    // final currentThemeMode = themeModeData.themeMode;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // home: isAdminLoggedIn
      //     ? const BottomNavigationAdmin()
      //     : isUserLoggedIn
      //         ?  BottomNavigation()
      //         : LoginPage(),

      // return MaterialApp(
      //   debugShowCheckedModeBanner: false,
      home: const IntroductionPage(),
      //home: const BottomNavigation(),
      routes: {
        home_page.routeName: (ctx) => home_page(),
        ManageCake.routeName: (ctx) => ManageCake(),
        EditCake.routeName: (ctx) => EditCake(),
      },
      theme: ThemeData(
        // colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        // useMaterial3: true,
        primarySwatch: Colors.pink,
        //primaryColor: Color.fromRGBO(255, 248, 30, 1),
      ),

      // theme: ThemeData(
      //   useMaterial3: true,
      //   brightness: Brightness.light,
      //   colorScheme: lightScheme,
      //   textTheme: TextTheme(
      //     headlineLarge: GoogleFonts.lato(
      //         fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
      //     bodyLarge: GoogleFonts.lato(
      //       fontSize: 24,
      //       fontWeight: FontWeight.bold,
      //       color: Colors.black,
      //     ),
      //     bodyMedium: const TextStyle(color: Colors.black, fontSize: 18),
      //     bodySmall: GoogleFonts.inconsolata(
      //       fontSize: 18,
      //       color: const Color.fromARGB(255, 248, 30, 67),
      //       fontWeight: FontWeight.bold,
      //     ),
      //     labelMedium: const TextStyle(fontSize: 18, color: Colors.black),
      //     labelSmall: const TextStyle(fontSize: 18, color: Colors.white),
      //   ),
      //   dialogBackgroundColor: Colors.black,
      //   iconTheme: const IconThemeData(
      //     color: Colors.black,
      //   ),
      // ),
      // darkTheme: ThemeData(
      //   useMaterial3: true,
      //   brightness: Brightness.dark,
      //   colorScheme: darkScheme,
      //   textTheme: TextTheme(
      //     headlineLarge: GoogleFonts.lato(
      //         fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
      //     bodyLarge: GoogleFonts.lato(
      //       color: Colors.black,
      //       fontSize: 24,
      //       fontWeight: FontWeight.bold,
      //     ),
      //     bodyMedium: const TextStyle(color: Colors.black, fontSize: 18),
      //     bodySmall: GoogleFonts.inconsolata(
      //       fontSize: 18,
      //       fontWeight: FontWeight.bold,
      //       color: const Color.fromARGB(255, 248, 30, 67),
      //     ),
      //     labelMedium: const TextStyle(fontSize: 18, color: Colors.white),
      //     labelSmall: const TextStyle(fontSize: 18, color: Colors.black),
      //   ),
      //   dialogBackgroundColor: Colors.white,
      //   iconTheme: const IconThemeData(
      //     color: Colors.white,
      //   ),
      // ),
      // themeMode: context
      //     .watch<ThemeModeData>()
      //     .themeMode, // Gunakan ThemeMode dari penyedia ThemeModeData
    );
  }
}

class BottomNavigationAdmin extends StatefulWidget {
  const BottomNavigationAdmin({Key? key});

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

  // Metode untuk pindah halaman ke about page
  void _navigateToAboutPage() {
    setState(() {
      _selectedIndex = 3;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   // foregroundColor: Colors.pink,
      //   centerTitle: true,
      //   title: Row(
      //     children: [
      //       ElevatedButton(
      //         style: ElevatedButton.styleFrom(
      //             backgroundColor: Colors.black,
      //             shape: const CircleBorder(),
      //             padding: const EdgeInsets.all(15.0)),
      //         onPressed: () {
      //           Navigator.of(context).push(
      //             MaterialPageRoute(
      //               builder: (_) => const SettingsScreen(),
      //             ),
      //           );
      //         },
      //         child: const Icon(
      //           Icons.settings,
      //           size: 20.0,
      //         ),
      //       ),
      //       const Spacer(), // Spacer akan mengisi ruang di antara dua elemen berikutnya.
      //       Text(
      //         'ORDERING BAKERY',
      //         style: Theme.of(context).textTheme.headlineLarge,
      //       ),
      //       const Spacer(),
      //       IconButton(
      //         icon: const Icon(Icons.logout),
      //         onPressed: () {
      //           Navigator.of(context).pushReplacement(
      //             MaterialPageRoute(
      //               builder: (context) => LoginPage(),
      //             ),
      //           );
      //         },
      //       ),
      //     ],
      //   ),
      //   // backgroundColor: backgroundColors[currentThemeMode.index],
      // ),
      body: _pages[_selectedIndex],
      // bottomNavigationBar: BottomNavigationBar(
      //   items: const [
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.home),
      //       label: 'Home',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.edit),
      //       label: 'Manage Cake',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.info),
      //       label: 'About',
      //     ),
      //   ],
      //   currentIndex: 0,
      //   onTap: (index) {},
      // ),
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
  const BottomNavigation({Key? key});

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
    // // Ambil tema yang aktif dari ThemeModeData
    // final currentThemeMode = context.watch<ThemeModeData>().themeMode;
    //
    // // Daftar warna latar belakang sesuai dengan tema
    // final backgroundColors = [
    //   Colors
    //       .pink, // Background App Bar dan Bottom Navigation Bar untuk ThemeMode.system
    //   Colors
    //       .green, // Background App Bar dan Bottom Navigation Bar untuk ThemeMode.light
    //   Colors
    //       .blue, // Background App Bar dan Bottom Navigation Bar untuk ThemeMode.dark
    // ];

    return Scaffold(
      // appBar: AppBar(
      //   // foregroundColor: Colors.pink,
      //   centerTitle: true,
      //   title: Row(
      //     children: [
      //       ElevatedButton(
      //         style: ElevatedButton.styleFrom(
      //             backgroundColor: Colors.black,
      //             shape: const CircleBorder(),
      //             padding: const EdgeInsets.all(15.0)),
      //         onPressed: () {
      //           Navigator.of(context).push(
      //             MaterialPageRoute(
      //               builder: (_) => const SettingsScreen(),
      //             ),
      //           );
      //         },
      //         child: const Icon(
      //           Icons.settings,
      //           size: 20.0,
      //         ),
      //       ),
      //       const Spacer(), // Spacer akan mengisi ruang di antara dua elemen berikutnya.
      //       Text(
      //         'ORDERING BAKERY',
      //         style: Theme.of(context).textTheme.headlineLarge,
      //       ),
      //       const Spacer(),
      //       IconButton(
      //         icon: const Icon(Icons.logout),
      //         onPressed: () {
      //           Navigator.of(context).pushReplacement(
      //             MaterialPageRoute(
      //               builder: (context) => LoginPage(),
      //             ),
      //           );
      //         },
      //       ),
      //     ],
      //   ),
      //   backgroundColor: backgroundColors[currentThemeMode.index],
      // ),
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
  List<Map<String, dynamic>> _orders = [];

  // Fungsi untuk menyimpan daftar pesanan
  void addOrder(Map<String, dynamic> order) {
    _orders.add(order);
    notifyListeners();
  }

  // Mengakses daftar pesanan dari luar
  List<Map<String, dynamic>> get orders => _orders;
}
