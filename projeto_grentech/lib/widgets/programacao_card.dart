// lib/widgets/programacao_card.dart
import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Importado para formatar a data e hora
import '../models/programacao.dart';

/// Um widget para exibir uma lista de programas de irrigação e permitir adicionar novos.
/// Este widget é Stateless e recebe a lista de programações e uma função de callback.
class ProgramacaoCard extends StatelessWidget {
  /// A lista de objetos Programacao para exibir.
  final List<Programacao> programacoes;

  /// Função de callback a ser chamada quando uma nova programação for adicionada.
  /// Recebe o objeto Programacao recém-criado.
  final Function(Programacao) onAdd;

  /// Construtor para o widget ProgramacaoCard.
  const ProgramacaoCard({
    super.key,
    required this.programacoes,
    required this.onAdd,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(0), // Margem 0, o padding é tratado pelo pai
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Programação de Irrigação',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
            const SizedBox(height: 10),
            // Exibe as programações existentes
            if (programacoes.isEmpty)
              const Text(
                'Nenhuma programação agendada.',
                style: TextStyle(
                  fontStyle: FontStyle.italic,
                  color: Colors.grey,
                ),
              )
            else
              // Mapeia cada programação para um widget Row
              ...programacoes.map((program) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Exibe tempo e litros, arredondando o tempo e formatando litros
                      Text(
                        '${program.tempoMinutos.round()} min, ${program.litros.toStringAsFixed(1)} L',
                        style: const TextStyle(fontSize: 16),
                      ),
                      // Exibe a data e hora formatadas
                      Text(
                        DateFormat('dd/MM HH:mm').format(program.dataHora),
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(), // Converte o iterável em uma lista de widgets
            const SizedBox(height: 15),
            Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  // Chama a função onAdd com uma nova programação de exemplo.
                  // Em uma aplicação real, isso abriria um formulário para o usuário preencher.
                  onAdd(
                    Programacao(
                      tempoMinutos: 15, // Valor de exemplo
                      litros: 75.0, // Valor de exemplo (15 * 5)
                      dataHora: DateTime.now().add(
                        const Duration(days: 1),
                      ), // Exemplo: amanhã
                    ),
                  );
                },
                icon: const Icon(Icons.add, color: Colors.white),
                label: const Text(
                  'Adicionar Programação',
                  style: TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 12,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
