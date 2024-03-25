import 'package:ar_earth_map_app/ar_earth_map_screen.dart';
import 'package:ar_earth_map_app/avengersCharacters.dart';
import 'package:ar_earth_map_app/geometricShapes.dart';
import 'package:flutter/material.dart';

import 'augmentedFaces.dart';
import 'custom_3d_object.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter AR Earth Map App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: AugmentedFaces(),
    );
  }
}
