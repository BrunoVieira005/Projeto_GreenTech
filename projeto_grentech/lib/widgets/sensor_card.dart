// Importa os widgets visuais do Flutter
import 'package:flutter/material.dart';

// Declara um widget do tipo Stateless, ou seja, sem estado interno
class SensorCard extends StatelessWidget {
  // Declaração das propriedades que esse card recebe:
  final IconData icon;   // Ícone a ser exibido (ex: termômetro)
  final String label;    // Texto com o nome do sensor (ex: Temperatura)
  final String value;    // Valor atual (ex: 24°C)

  // Construtor do widget, com os três campos obrigatórios
  const SensorCard({
    super.key,
    required this.icon,   // O ícone precisa ser informado
    required this.label,  // O nome também
    required this.value,  // E o valor também
  });

  @override
  Widget build(BuildContext context) {
    // Retorna um container com largura fixa
    return SizedBox(
      width: 160, // Largura do card (ideal para usar no Wrap com espaçamento)
      child: Card(
        color: Colors.white, // Cor de fundo do card
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12), // Bordas arredondadas
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0), // Espaçamento interno
          child: Column(
            children: [
              // Ícone do sensor (ex: termômetro, gota, sol, vento)
              Icon(icon, color: Colors.green),

              const SizedBox(height: 8), // Espaçamento entre ícone e texto

              // Nome do sensor em negrito (ex: "Temperatura")
              Text(
                label,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),

              // Valor atual do sensor (ex: "24°C")
              Text(value),
            ],
          ),
        ),
      ),
    );
  }
}
