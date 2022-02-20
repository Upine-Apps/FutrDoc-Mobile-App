import 'package:flutter/material.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';
import 'package:futr_doc/theme/appColor.dart';
import 'package:futr_doc/theme/themeNotifier.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Settings extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  void initState() {
    super.initState();
    getSelectPosition();
  }

  getSelectPosition() async {
    var prefs = await SharedPreferences.getInstance();
    setState(() {
      selectedPosition = themes.indexOf(prefs.getString('Theme'));
    });
  }

  int selectedPosition =-1;
  List themes = ["Light", "Dark"];

  @override
  Widget build(BuildContext context) {
    ThemeNotifier themeNotifier = Provider.of<ThemeNotifier>(context);
    return Scaffold(
        body: Container(
                height: 500,
                child: ListView.builder(
                  itemBuilder: (context, position) {
                    return _createList(
                        context, themes[position], position, themeNotifier);
                  },
                  itemCount: themes.length,
                ),
              ));
  }

  _createList(context, item, position, themeNotifier) {
    return InkWell(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      onTap: () {
        _updateState(position, themeNotifier);
      },
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Radio(
            value: selectedPosition,
            groupValue: position,
            activeColor: AppColors.black,
            onChanged: (_) {
              _updateState(position, themeNotifier);
            },
          ),
          Text(item),
        ],
      ),
    );
  }

  _updateState(int position, ThemeNotifier themeNotifier) {
    setState(() {
      selectedPosition = position;
    });
    onThemeChanged(themes[position], themeNotifier);
  }

  void onThemeChanged(String value, ThemeNotifier themeNotifier) async {
    var prefs = await SharedPreferences.getInstance();
    if (value == 'Dark') {
      themeNotifier.setThemeMode(ThemeMode.dark);
    } else {
      themeNotifier.setThemeMode(ThemeMode.light);
    }
    prefs.setString('Theme', value);
  }
}
