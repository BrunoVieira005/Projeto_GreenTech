// lib/widgets/historico_card.dart
import 'package:flutter/material.dart';

/// Um widget que exibe um histórico simulado de eventos de irrigação.
class HistoricoCard extends StatelessWidget {
  const HistoricoCard({super.key});

  @override
  Widget build(BuildContext context) {
    // Lista simulada de dados de histórico de irrigação.
    final historico = [
      {'dia': 'Hoje, 06:00', 'tempo': '30 min', 'litros': '150L'},
      {'dia': 'Ontem, 06:00', 'tempo': '25 min', 'litros': '125L'},
      {
        'dia': 'Anteontem, 06:00',
        'tempo': '25 min',
        'litros': '150L',
      }, // Corrigido para 'Anteontem'
    ];

    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Histórico de Irrigação',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            // Gera dinamicamente as linhas do histórico a partir da lista.
            ...historico.map((item) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(item['dia']!), // Exibe o dia e hora
                    Text(item['tempo']!), // Exibe a duração
                    Text(
                      item['litros']!, // Exibe a quantidade de litros com cor azul
                      style: const TextStyle(color: Colors.blue),
                    ),
                  ],
                ),
              );
            }).toList(), // Converte o resultado do map em uma lista de Widgets.
          ],
        ),
      ),
    );
  }
}
