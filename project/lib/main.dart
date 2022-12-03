import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'views/home_page.dart';
import 'package:flutter_localizations/flutter_localizations.dart';


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
            return MaterialApp(
              title: "Project",
              theme: ThemeData(
                  primarySwatch: Colors.purple
              ),
              home: const HomePage(),
              localizationsDelegates: [
                FlutterI18nDelegate(
                  missingTranslationHandler: (key, locale){
                    print("MISSING KEY: $key, Language Code: ${locale!.languageCode}");
                  },
                  translationLoader: FileTranslationLoader(
                    useCountryCode: false,
                    fallbackFile: 'en',
                  ),

                )
              ],


            );
          }
          else{
            return CircularProgressIndicator();
          }
        }
    );
  }
}
