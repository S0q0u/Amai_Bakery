import 'package:bakery/login.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'theme_mode_data.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeModeData = context.watch<ThemeModeData>();
    final currentThemeMode = themeModeData.themeMode;

    final themeOptions = [
      ThemeMode.system,
      ThemeMode.light,
      ThemeMode.dark,
      // ThemeMode.pink, // Tambahkan lebih banyak tampilan tema di sini
    ];

    final backgroundColors = [
      Colors
          .pink, // Background App Bar dan Bottom Navigation Bar untuk ThemeMode.system
      Colors
          .green, // Background App Bar dan Bottom Navigation Bar untuk ThemeMode.light
      Colors
          .blue, // Background App Bar dan Bottom Navigation Bar untuk ThemeMode.dark
      // Warna latar belakang yang lain untuk tampilan tambahan
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
        backgroundColor:
            backgroundColors[themeOptions.indexOf(currentThemeMode)],
      ),
      body: Column(
        children: [
          ListTile(
            leading: Icon(
              themeModeData.isDarkModeActive
                  ? Icons.dark_mode
                  : Icons.light_mode,
            ),
            trailing: Switch(
              value: themeModeData.isDarkModeActive,
              onChanged: (bool value) {
                themeModeData.changeTheme(
                  value ? ThemeMode.dark : ThemeMode.light,
                );
              },
            ),
            onTap: () {
              themeModeData.changeTheme(
                themeOptions[(themeOptions.indexOf(currentThemeMode) + 1) %
                    themeOptions.length],
              );
            },
          ),
          // Tampilkan tampilan tema yang dapat di-slide dan diklik
          Expanded(
            child: PageView.builder(
              itemCount: themeOptions.length,
              controller: PageController(viewportFraction: 0.3),
              itemBuilder: (context, index) {
                final themeOption = themeOptions[index];
                final isSelected = currentThemeMode == themeOption;
                return GestureDetector(
                  onTap: () {
                    themeModeData.changeTheme(themeOption);
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeOut,
                    padding: EdgeInsets.all(isSelected ? 10.0 : 0.0),
                    child: Container(
                      width: isSelected ? 40 : 30,
                      height: isSelected ? 40 : 30,
                      decoration: BoxDecoration(
                        color: isSelected
                            ? backgroundColors[
                                themeOptions.indexOf(themeOption)]
                            : backgroundColors[
                                index], // Menggunakan warna dari daftar customColors
                        borderRadius: BorderRadius.circular(40),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
