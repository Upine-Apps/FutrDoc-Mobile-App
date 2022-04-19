import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:futr_doc/providers/ShadowingProvider.dart';
import 'package:futr_doc/providers/tokenProvider.dart';
import 'package:futr_doc/screens/dashboard/dashboard.dart';
import 'package:futr_doc/screens/home/homeScreen.dart';
import 'package:futr_doc/screens/login/emailOTP.dart';
import 'package:futr_doc/screens/login/login.dart';
import 'package:futr_doc/screens/login/loginHero.dart';
import 'package:futr_doc/screens/login/phoneOTP.dart';
import 'package:futr_doc/screens/login/profileSetup.dart';
import 'package:futr_doc/screens/login/walkthrough.dart';
import 'package:futr_doc/screens/settings/settings.dart';
import 'package:futr_doc/screens/shadowing/shadowingWhen.dart';
import 'package:futr_doc/screens/shadowing/shadowingScreen.dart';
import 'package:futr_doc/theme/appTheme.dart';
import 'package:futr_doc/theme/themeNotifier.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'providers/UserProvider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Future<SharedPreferences> prefs = SharedPreferences.getInstance();
  await dotenv.load(fileName: ".env");
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

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ShadowingProvider()),
        ChangeNotifierProvider(create: (context) => UserProvider()),
        ChangeNotifierProvider(create: (context) => TokenProvider())
      ],
      child: OKToast(
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Dashboard(),
          theme: AppTheme().lightTheme,
          darkTheme: AppTheme().darkTheme,
          themeMode: themeNotifier.getThemeMode(),
        ),
      ),
    );
  }
}
