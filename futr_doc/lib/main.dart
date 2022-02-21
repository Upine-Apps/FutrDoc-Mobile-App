import 'package:flutter/material.dart';
import 'package:futr_doc/screens/login/login.dart';
import 'package:futr_doc/screens/settings/settings.dart';
import 'package:futr_doc/theme/appTheme.dart';
import 'package:futr_doc/theme/themeNotifier.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Future<SharedPreferences> prefs = SharedPreferences.getInstance();
  prefs.then((value) {
    runApp(
      ChangeNotifierProvider<ThemeNotifier>(
        create: (BuildContext context) {
          String? theme = value.getString("Theme");
          print(value.getString('Theme'));

          return ThemeNotifier(
              theme == 'Dark' ? ThemeMode.dark : ThemeMode.light);
        },
        child: MyApp(),
      ),
    );
  });
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Login(),
      theme: AppTheme().lightTheme,
      darkTheme: AppTheme().darkTheme,
      themeMode: themeNotifier.getThemeMode(),
    );
  }
}
