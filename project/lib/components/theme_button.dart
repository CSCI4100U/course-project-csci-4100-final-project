import 'package:flutter/material.dart';
import 'package:project/classes/themeProvier.dart';
import 'package:provider/provider.dart';


class ChangeThemeButtonWidget extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Switch.adaptive(
      value: themeProvider.isDark,
      onChanged: (value) {
        final provider = Provider.of<ThemeProvider>(context, listen: false);
        provider.toggleTheme(value);

      },
    );
  }
}