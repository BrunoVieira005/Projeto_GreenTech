import 'package:flutter/material.dart';

import '../widgets/status_card.dart';
import '../widgets/sensor_card.dart';
import '../widgets/programacao_card.dart';
import '../widgets/historico_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Seção superior com curva e logo
            Stack(
              children: [
                // Sombra por trás da curva
                Positioned(
                  top: 4,
                  left: 0,
                  right: 0,
                  child: ClipPath(
                    clipper: CurvedClipper(),
                    child: Container(
                      height: 230,
                      color: Colors.black.withOpacity(0.9), // sombra simulada
                    ),
                  ),
                ),
                // Curva branca por cima
                ClipPath(
                  clipper: CurvedClipper(),
                  child: Container(height: 230, color: Colors.white),
                ),
                // Logo centralizada por cima
                Positioned.fill(
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 45),
                      child: Image.asset('assets/images/logo.png', height: 170),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  StatusCard(),
                  SizedBox(height: 20),
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: [
                      SensorCard(
                        icon: Icons.thermostat,
                        label: 'Temperatura',
                        value: '24°C',
                      ),
                      SensorCard(
                        icon: Icons.water_drop,
                        label: 'Umidade do Solo',
                        value: '65%',
                      ),
                      SensorCard(
                        icon: Icons.wb_sunny,
                        label: 'Luminosidade',
                        value: '80%',
                      ),
                      SensorCard(
                        icon: Icons.air,
                        label: 'Velocidade do vento',
                        value: '12 km/h',
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  ProgramacaoCard(),
                  SizedBox(height: 20),
                  HistoricoCard(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Classe que desenha a curva arredondada
class CurvedClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();

    path.lineTo(0, 0); // topo esquerdo
    path.lineTo(0, size.height); // lado esquerdo até a base

    path.lineTo(size.width * 0.6, size.height); // base até 70% da largura

    // Curva no canto inferior direito
    path.quadraticBezierTo(
      size.width,
      size.height, // ponto de controle
      size.width,
      size.height * 0.3, // ponto final da curva
    );

    path.lineTo(size.width, 0); // sobe no lado direito
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
