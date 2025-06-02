// lib/screens/splash_screen.dart
import 'package:flutter/material.dart';
import 'package:projeto_grentech/screens/home_screen.dart'; // Importa a HomeScreen

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Navega para a HomeScreen após 3 segundos
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white, // Fundo branco
      body: Center(
        child: Image(
          image: AssetImage('assets/images/logo.png'), // Sua logo
          width: 200, // Ajuste o tamanho conforme necessário
          height: 200,
        ),
      ),
    );
  }
}
