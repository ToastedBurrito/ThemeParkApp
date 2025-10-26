import 'package:flutter/material.dart';
import 'navigator.dart';

void main() async{
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Main',
      home: Navigation(),
    );
  }
}

// make 3 more widgets
// 1 for attraction card, this will be a big as hell class 
// 2 for FutureBuilder and list/grid logic
// 3 for ExploreHeader which is at the top, its only 
// a few lines but it'll be helpful to make it look nicer