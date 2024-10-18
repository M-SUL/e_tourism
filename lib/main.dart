import 'dart:convert';
import 'package:e_tourism/screens/driversListScreen.dart';
import 'package:e_tourism/screens/editGuide.dart';
import 'package:e_tourism/screens/guidesListScreen.dart';
import 'package:e_tourism/screens/loginScreen.dart';
import 'package:e_tourism/screens/programDetailsScreen.dart';
import 'package:e_tourism/screens/programsScreen.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'E_Tourism',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        // colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        // useMaterial3: true,
      ),
      home:  const LoginScreen(),
    );
  }
}
