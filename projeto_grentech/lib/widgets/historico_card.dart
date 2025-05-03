// Importa os componentes visuais do Flutter
import 'package:flutter/material.dart';

// Cria um widget customizado do tipo Stateless (sem estado)
class HistoricoCard extends StatelessWidget {
  const HistoricoCard({super.key}); // Construtor padrão

  @override
  Widget build(BuildContext context) {
    // Lista simulando dados de histórico de irrigação
    final historico = [
      {'dia': 'Hoje, 06:00', 'tempo': '30 min', 'litros': '150L'},
      {'dia': 'Ontem, 06:00', 'tempo': '25 min', 'litros': '125L'},
      {'dia': 'Ontem, 06:00', 'tempo': '25 min', 'litros': '150L'},
    ];

    // Retorna um cartão visual (Card) com o conteúdo do histórico
    return Card(
      color: Colors.white, // Cor de fundo do cartão
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12), // Borda arredondada
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0), // Espaçamento interno do cartão
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // Alinhamento à esquerda
          children: [
            // Título do cartão
            const Text(
              'Histórico de Irrigação',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10), // Espaço entre o título e os itens

            // Gera dinamicamente cada linha do histórico
            ...historico.map((item) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4), // Espaço entre as linhas
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween, // Itens distribuídos nas extremidades
                  children: [
                    // Data e hora da irrigação
                    Text(item['dia']!),

                    // Duração da irrigação
                    Text(item['tempo']!),

                    // Quantidade de água utilizada, com destaque na cor azul
                    Text(
                      item['litros']!,
                      style: const TextStyle(color: Colors.blue),
                    ),
                  ],
                ),
              );
            }).toList(), // Converte a lista de Widgets gerados pelo map para uma lista utilizável no Column
          ],
        ),
      ),
    );
  }
}
