import 'package:flutter/material.dart';

class StatusCard extends StatefulWidget {
  const StatusCard({super.key});

  @override
  State<StatusCard> createState() => _StatusCardState();
}

class _StatusCardState extends State<StatusCard> {
  bool isOn = false; // Estado inicial

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        title: const Text('Status do sistema'),
        subtitle: Text(isOn ? 'Sistema Ligado' : 'Sistema Desligado'),
        trailing: GestureDetector(
          onTap: () {
            setState(() {
              isOn = !isOn;
            });
          },
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: isOn ? Colors.green.withOpacity(0.2) : Colors.red.withOpacity(0.2), // Fundo transparente
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.power_settings_new,
              color: isOn ? Colors.green : Colors.red,
              size: 28,
            ),
          ),
        ),
      ),
    );
  }
}
