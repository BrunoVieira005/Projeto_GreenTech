import 'package:flutter/material.dart';

import '../widgets/status_card.dart';
import '../widgets/sensor_card.dart';
import '../widgets/programacao_card.dart';
import '../models/programacao.dart';
import '../widgets/historico_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Seção superior com curva, sombra e logo
            Stack(
              children: [
                // Sombra natural aplicada na curva
                Positioned(
                  top: 4,
                  left: 0,
                  right: 0,
                  child: ClipPath(
                    clipper: CurvedClipper(),
                    child: Container(
                      height: 230,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            spreadRadius: 5,
                            blurRadius: 15,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                // Curva branca sobreposta para reforçar a forma
                ClipPath(
                  clipper: CurvedClipper(),
                  child: Container(
                    height: 230,
                    color: Colors.white,
                  ),
                ),

                // Logo centralizada
                Positioned.fill(
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 45),
                      child: Image.asset(
                        'assets/images/logo.png',
                        height: 170,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  const StatusCard(),
                  const SizedBox(height: 20),
                  const Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: [
                      SensorCard(
                        icon: Icons.thermostat,
                        label: 'Temperatura',
                        value: '24°C',
                        iconColor: Colors.red,
                      ),
                      SensorCard(
                        icon: Icons.water_drop,
                        label: 'Umidade do Solo',
                        value: '65%',
                        iconColor: Colors.blue,
                      ),
                      SensorCard(
                        icon: Icons.wb_sunny,
                        label: 'Luminosidade',
                        value: '80%',
                        iconColor: Colors.amber,
                      ),
                      SensorCard(
                        icon: Icons.air,
                        label: 'Velocidade do vento',
                        value: '12 km/h',
                        iconColor: Color.fromARGB(255, 67, 79, 78),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Programacao(
  programacoes: [],
  onAdd: (novaProgramacao) {
    print('Nova programação adicionada: $novaProgramacao');
  },
),

                  const SizedBox(height: 20),
                  const HistoricoCard(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Classe que desenha a curva arredondada superior
class CurvedClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();

    // Começa no topo esquerdo
    path.lineTo(0, 0);

    // Vai até a base do lado esquerdo
    path.lineTo(0, size.height);

    // Linha até 60% da base
    path.lineTo(size.width * 0.6, size.height);

    // Cria uma curva do ponto atual até o canto superior direito
    path.quadraticBezierTo(
      size.width,
      size.height,
      size.width,
      size.height * 0.3,
    );

    // Linha até o topo do lado direito
    path.lineTo(size.width, 0);

    // Fecha o caminho
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
