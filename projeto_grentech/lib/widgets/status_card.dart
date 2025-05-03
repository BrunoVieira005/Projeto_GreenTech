// Importa os componentes de interface do Flutter
import 'package:flutter/material.dart';

// Criação de um widget sem estado (StatelessWidget) chamado StatusCard
class StatusCard extends StatelessWidget {
  const StatusCard({super.key}); // Construtor padrão com uma chave opcional

  @override
  Widget build(BuildContext context) {
    // Retorna um card com estilo e conteúdo definidos
    return Card(
      color: Colors.white, // Cor de fundo do card
      elevation: 3, // Elevação do card (sombra)
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12), // Bordas arredondadas
      ),

      // O conteúdo principal do card será um ListTile (item de lista)
      child: ListTile(
        title: const Text('Status do sistema'), // Título do item
        subtitle: const Text('Sistema em Espera'), // Subtítulo (descrição do status)

        // Ícone de botão à direita do card
        trailing: IconButton(
          icon: const Icon(Icons.power_settings_new, color: Colors.green), // Ícone de ligar/desligar
          onPressed: () {
            // Aqui será colocada a lógica para ligar ou desligar o sistema
          },
        ),
      ),
    );
  }
}
