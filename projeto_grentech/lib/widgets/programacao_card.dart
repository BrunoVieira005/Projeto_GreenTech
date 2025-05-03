// Importa os widgets visuais padrão do Flutter
import 'package:flutter/material.dart';

// Cria um widget do tipo Stateless (sem estado), que exibe a programação de irrigação
class ProgramacaoCard extends StatelessWidget {
  const ProgramacaoCard({super.key}); // Construtor da classe

  @override
  Widget build(BuildContext context) {
    // Retorna um cartão visual com conteúdo de programação
    return Card(
      color: Colors.white, // Cor de fundo do card
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12), // Bordas arredondadas do card
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0), // Espaçamento interno do card
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // Alinha o conteúdo à esquerda
          children: [
            // Título da seção
            const Text(
              'Programação',
              style: TextStyle(fontWeight: FontWeight.bold), // Negrito
            ),

            const SizedBox(height: 10), // Espaço entre o título e a próxima linha

            // Linha com informações da próxima irrigação
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween, // Espaça os dois textos nos extremos
              children: const [
                Text('Próxima Irrigação'), // Texto à esquerda
                Text('08:00'), // Horário à direita (simulado)
              ],
            ),

            const SizedBox(height: 10), // Espaço antes do botão

            // Botão para adicionar nova programação
            ElevatedButton(
              onPressed: () {
                // Aqui vai a ação que será executada quando o botão for pressionado
                // Pode abrir um modal, tela ou formulário
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green, // Cor de fundo do botão
              ),
              child: const Text('Adicionar Nova Programação'), // Texto do botão
            ),
          ],
        ),
      ),
    );
  }
}
