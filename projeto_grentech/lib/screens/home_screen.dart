// Importa o pacote do Flutter responsável pelos componentes visuais
import 'package:flutter/material.dart';

// Importa os widgets personalizados que você criou (devem estar dentro da pasta widgets)
import '../widgets/status_card.dart';
import '../widgets/sensor_card.dart';
import '../widgets/programacao_card.dart';
import '../widgets/historico_card.dart';

// Define a tela principal do app como um widget sem estado (StatelessWidget)
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key}); // Construtor padrão

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // O corpo da tela é rolável (caso os elementos passem do tamanho da tela)
      body: SingleChildScrollView(
        child: Padding(
          // Espaçamento interno nas laterais e no topo/inferior
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 40),

          // Coluna que organiza os elementos de cima para baixo
          child: Column(
            children: [
              // Exibe a imagem do logo na parte superior
              Image.asset(
                'assets/images/logo.png', // Caminho da imagem na pasta assets
                height: 100, // Altura do logo
              ),

              const SizedBox(height: 20), // Espaço entre logo e próximo item

              const StatusCard(), // Card de status do sistema

              const SizedBox(height: 20), // Espaço entre os cards

              // Conjunto de cards de sensores em forma de grade (responsivo)
              Wrap(
                spacing: 10, // Espaço horizontal entre os cards
                runSpacing: 10, // Espaço vertical entre as linhas de cards
                children: const [
                  // Sensor de temperatura
                  SensorCard(
                    icon: Icons.thermostat, // Ícone
                    label: 'Temperatura',    // Texto do card
                    value: '24°C',           // Valor exibido
                  ),
                  // Sensor de umidade do solo
                  SensorCard(
                    icon: Icons.water_drop,
                    label: 'Umidade do Solo',
                    value: '65%',
                  ),
                  // Sensor de luminosidade
                  SensorCard(
                    icon: Icons.wb_sunny,
                    label: 'Luminosidade',
                    value: '80%',
                  ),
                  // Sensor de velocidade do vento
                  SensorCard(
                    icon: Icons.air,
                    label: 'Velocidade do vento',
                    value: '12 km/h',
                  ),
                ],
              ),

              const SizedBox(height: 20), // Espaço entre sensores e próxima seção

              const ProgramacaoCard(), // Card de programação de irrigação

              const SizedBox(height: 20), // Espaço entre seções

              const HistoricoCard(), // Card do histórico de irrigação
            ],
          ),
        ),
      ),
    );
  }
}
