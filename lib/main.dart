import 'package:flutter/material.dart';
import 'package:genshin_info/pages/%E0%B9%89homepage/homepage.dart';
import 'package:genshin_info/pages/characterpages/characterpage.dart';

import 'pages/artifactspages/artfactpage.dart';
import 'pages/elementspages/elementpage.dart';
import 'pages/nationspages/nationpage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      routes: {
        '/CharacterPage':(context) => const CharacterPage(),
        '/NationPage':(context) => const NationPage(),
        '/ElementPage':(context) => const ElementPage(),
        '/ArtifactPage':(context) => const ArtifactPage()
      },
      home: const HomePage(),
    );
  }
}
