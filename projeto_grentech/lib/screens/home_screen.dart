// lib/screens/home_screen.dart
import 'package:flutter/material.dart';

import '../widgets/status_card.dart';
import '../widgets/sensor_card.dart';
import '../widgets/programacao_card.dart'; // Importa o widget ProgramacaoCard
import '../models/programacao.dart'; // Importa o modelo Programacao
import '../widgets/historico_card.dart';
import 'package:projeto_grentech/screens/chatbot_screen.dart';

// HomeScreen agora é um StatefulWidget para gerenciar a animação do FAB
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

// Com SingleTickerProviderStateMixin para a animação
class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  // Controlador de animação
  late AnimationController _animationController;
  // Animação para a escala (para o "pulinho")
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this, // Sincroniza a animação com a tela
      duration: const Duration(
        milliseconds: 600,
      ), // Duração de um ciclo de animação
    )..repeat(
      reverse: true,
    ); // Repete a animação infinitamente, revertendo no final

    // Define a animação de escala
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.1).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut, // Curva suave para o movimento
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose(); // Libera o controlador de animação
    super.dispose();
  }

  void _showChatPreview(BuildContext context) {
    final TextEditingController _controller = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF276F1D),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Stack(
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset('assets/images/broc.png', height: 80),
                  const SizedBox(height: 10),
                  const Text(
                    "Olá, eu sou o assistente virtual Broc! Como posso te ajudar?",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              Positioned(
                top: 0,
                right: 0,
                child: IconButton(
                  icon: const Icon(Icons.close, color: Colors.white),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
            ],
          ),
          content: TextField(
            controller: _controller,
            decoration: InputDecoration(
              hintText: "Digite sua mensagem...",
              hintStyle: const TextStyle(color: Colors.black87),
              filled: true,
              fillColor: Colors.white,
              contentPadding: const EdgeInsets.symmetric(
                vertical: 12,
                horizontal: 16,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide.none,
              ),
              suffixIcon: IconButton(
                icon: Icon(Icons.send, color: Colors.grey[500]),
                onPressed: () {
                  String userInput = _controller.text;
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (context) => ChatbotScreen(initialMessage: userInput),
                    ),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }

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
                  child: Container(height: 230, color: Colors.white),
                ),

                // Logo centralizada
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
                        iconColor: Colors.red,
                      ),
                      SensorCard(
                        icon: Icons.water_drop,
                        label: 'Umidade do Solo',
                        iconColor: Colors.blue,
                      ),
                      SensorCard(
                        icon: Icons.water,
                        label: 'Umidade do Ar',
                        iconColor: Colors.lightBlue,
                      ),
                      SensorCard(
                        icon: Icons.wb_sunny,
                        label: 'Luminosidade',
                        iconColor: Colors.amber,
                      ),
                      SensorCard(
                        icon: Icons.science,
                        label: 'pH do Solo',
                        iconColor: Colors.purple,
                      ),
                      SensorCard(
                        icon: Icons.air,
                        label: 'Velocidade do vento',
                        iconColor: Color.fromARGB(255, 67, 79, 78),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  ProgramacaoCard(
                    programacoes: [
                      Programacao(
                        tempoMinutos: 45,
                        litros: 225.0,
                        dataHora: DateTime.now().add(const Duration(hours: 2)),
                      ),
                      Programacao(
                        tempoMinutos: 20,
                        litros: 100.0,
                        dataHora: DateTime.now().add(
                          const Duration(days: 1, hours: 10),
                        ),
                      ),
                    ],
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
      // FloatingActionButton animado
      floatingActionButton: ScaleTransition(
        // Usa ScaleTransition para aplicar a animação
        scale: _scaleAnimation,
        child: FloatingActionButton(
          backgroundColor: Colors.transparent,
          elevation: 0,
          splashColor: Colors.white10,
          onPressed: () => _showChatPreview(context),
          child: Image.asset(
            'assets/images/broc.png',
            fit: BoxFit.fill,
            height: 80,
            width: 80,
          ),
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
