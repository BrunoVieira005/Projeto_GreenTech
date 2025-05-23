import 'package:flutter/material.dart';

class SensorCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const SensorCard({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
  });

  // Função para definir a cor automática baseada no label
  Color _getColor() {
    final labelClean = label.toLowerCase().trim();

    final colorMap = {
      'temperatura': Colors.red,
      'umidade': Colors.blue,
      'luminosidade': Colors.amber,
      'vento': Colors.green,
    };

    for (var key in colorMap.keys) {
      if (labelClean.contains(key)) {
        return colorMap[key]!;
      }
    }

    // Cor padrão se não encontrar nenhum match
    return const Color.fromARGB(255, 57, 172, 47);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 183, // 📏 Largura fixa
      height: 100, // 📏 Altura fixa
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: _getColor(),
                size: 32,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      label,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      value,
                      style: const TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
