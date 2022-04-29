import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:developer' as developer;
import './apothecary_actions.dart';

void main() {
  runApp(const ApothecaryApp());
}

class ApothecaryApp extends StatelessWidget {
  const ApothecaryApp({Key? key}) : super(key: key);

  // Root of application
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage()
    );
  }
}
