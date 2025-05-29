import 'package:flutter/material.dart';

class ProgramacaoCard extends StatelessWidget {
  const ProgramacaoCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Programação',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text('Próxima Irrigação'),
                Text('08:00'),
              ],
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                  ),
                  isScrollControlled: true,
                  builder: (context) => const IrrigacaoConfigModal(),
                );
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              child: const Text('Adicionar Nova Programação'),
            ),
          ],
        ),
      ),
    );
  }
}

class IrrigacaoConfigModal extends StatefulWidget {
  const IrrigacaoConfigModal({super.key});

  @override
  State<IrrigacaoConfigModal> createState() => _IrrigacaoConfigModalState();
}

class _IrrigacaoConfigModalState extends State<IrrigacaoConfigModal> {
  double tempoMinutos = 10; // Tempo inicial

  double get litros => tempoMinutos * 5; // Cálculo: 5 litros por minuto

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: 16,
        left: 16,
        right: 16,
        bottom: MediaQuery.of(context).viewInsets.bottom + 16,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Configurar Irrigação',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),

          // Slider de tempo
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Tempo (min):'),
              Text('${tempoMinutos.round()} min'),
            ],
          ),
          Slider(
            value: tempoMinutos,
            min: 1,
            max: 60,
            divisions: 59,
            label: '${tempoMinutos.round()} min',
            activeColor: Colors.green,
            onChanged: (value) {
              setState(() {
                tempoMinutos = value;
              });
            },
          ),

          const SizedBox(height: 10),

          // Quantidade de água
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Quantidade de água:'),
              Text('${litros.round()} Litros'),
            ],
          ),

          const SizedBox(height: 20),

          // Botões
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Botão Info
              ElevatedButton.icon(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                      title: const Text('Informações'),
                      content: const Text(
                        'O cálculo da irrigação é simples:\n\n'
                        '✔️ 5 litros de água por minuto.\n'
                        'Exemplo: 20 minutos = 100 litros.',
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('Fechar'),
                        )
                      ],
                    ),
                  );
                },
                icon: const Icon(Icons.info_outline),
                label: const Text('Informações'),
                style: ElevatedButton.styleFrom(backgroundColor: const Color.fromARGB(255, 69, 77, 83)),
              ),

              // Botão Fechar
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                child: const Text('Fechar'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
