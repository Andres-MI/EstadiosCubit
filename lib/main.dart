import 'package:flutter/material.dart';

import 'package:turistic_poi_test/presentation/view/poi_homepage.dart';
import 'package:turistic_poi_test/utils/get_it.dart';


void main() async {
  DependencyInjector().setup();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const PoiHomepage(),
    );
  }
}

