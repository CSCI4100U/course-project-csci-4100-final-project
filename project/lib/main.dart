import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:provider/provider.dart';
import 'views/home_page.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:project/classes/themeProvier.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Firebase.initializeApp(),
        builder: (context, snapshot){
          if (snapshot.hasError){
            print("Error initializing Firebase");
          }
          if (snapshot.connectionState == ConnectionState.done){
            print ("Successfully connected to Firebase");
            return ChangeNotifierProvider(
              create: (context) => ThemeProvider(),
              builder: (context, _) {
                final themeProvider = Provider.of<ThemeProvider>(context);
                return MaterialApp(
                  title: "Project",
                  themeMode: themeProvider.themeMode,
                  theme: DarkMode.lightTheme,
                  darkTheme: DarkMode.darkTheme,
                  // theme: ThemeData(
                  //     primarySwatch: Colors.purple,
                  // ),

                  home: const HomePage(),
                  localizationsDelegates: [
                    FlutterI18nDelegate(
                      missingTranslationHandler: (key, locale) {
                        print("MISSING KEY: $key, Language Code: ${locale!
                            .languageCode}");
                      },
                      translationLoader: FileTranslationLoader(
                          useCountryCode: false,
                          fallbackFile: 'en',
                          basePath: 'assets/i18n'
                      ),

                    ),
                    GlobalMaterialLocalizations.delegate,
                    GlobalMaterialLocalizations.delegate,
                  ],
                  supportedLocales: [
                    Locale('en'),
                    Locale('fr'),
                    Locale('es')
                  ],

                );
              }
            );
          }
          else{
            return CircularProgressIndicator();
          }
        }
    );
  }
}
