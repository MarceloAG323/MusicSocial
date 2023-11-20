// home_screen.dart
import 'package:flutter/material.dart';
import 'home_layout.dart'; // Importe o componente HomeLayout

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: HomeLayout(), // Use o componente HomeLayout aqui
    );
  }
}
