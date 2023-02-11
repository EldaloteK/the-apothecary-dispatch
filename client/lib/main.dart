import 'package:flutter/material.dart';
import './apothecary_actions.dart';

void main() {
  runApp(const ApothecaryApp());
}

class ApothecaryApp extends StatelessWidget {
  const ApothecaryApp({Key? key}) : super(key: key);

  // Root of application
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage()
    );
  }
}
