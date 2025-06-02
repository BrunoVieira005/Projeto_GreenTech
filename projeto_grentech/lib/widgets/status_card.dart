// lib/widgets/status_card.dart
import 'package:flutter/material.dart';

class StatusCard extends StatefulWidget {
  const StatusCard({super.key});

  @override
  State<StatusCard> createState() => _StatusCardState();
}

class _StatusCardState extends State<StatusCard> {
  bool isOn = false; // Estado inicial para o status do sistema

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        title: const Text('Status do sistema'),
        subtitle: Text(isOn ? 'Sistema Ligado' : 'Sistema Desligado'),
        trailing: GestureDetector(
          onTap: () {
            // Alterna o estado 'isOn' quando o ícone é tocado
            setState(() {
              isOn = !isOn;
            });
          },
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              // Define a cor de fundo com base no estado 'isOn'
              color:
                  isOn
                      ? Colors.green.withOpacity(0.2)
                      : Colors.red.withOpacity(0.2),
              shape: BoxShape.circle, // Forma circular para o container
            ),
            child: Icon(
              Icons.power_settings_new, // Ícone de energia
              color:
                  isOn
                      ? Colors.green
                      : Colors.red, // Cor do ícone baseada no estado
              size: 28,
            ),
          ),
        ),
      ),
    );
  }
}
