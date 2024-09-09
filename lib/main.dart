import 'package:flutter/material.dart';
import 'package:pure_pixels_wallpaper_app/custom_scroll_behaviour.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      scrollBehavior: CustomScrollBehaviour(),
      home: Scaffold(
        body: Center(
          child: Text('Usama'),
        ),
      ),
    );
  }
}
