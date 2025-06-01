import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/programacao.dart';

class IrrigacaoConfigModal extends StatefulWidget {
  final Function(Programacao) onSave;

  const IrrigacaoConfigModal({
    super.key,
    required this.onSave,
  });

  @override
  State<IrrigacaoConfigModal> createState() => _IrrigacaoConfigModalState();
}

class _IrrigacaoConfigModalState extends State<IrrigacaoConfigModal> {
  double tempoMinutos = 10;
  DateTime dataHora = DateTime.now().add(const Duration(minutes: 1));

  double get litros => tempoMinutos * 5;

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
          // Topo
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(Icons.info_outline),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                      title: const Text('Informações'),
                      content: const Text(
                        '✔️ 5 litros de água por minuto.\n'
                        'Exemplo: 20 minutos = 100 litros.',
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('Fechar'),
                        ),
                      ],
                    ),
                  );
                },
              ),
              const Text(
                'Configurar Irrigação',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),

          const SizedBox(height: 10),

          // Tempo
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

          // Quantidade
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Quantidade de água:'),
              Text('${litros.round()} Litros'),
            ],
          ),
          const SizedBox(height: 10),

          // Data e Hora
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Data e Hora:'),
              Text(DateFormat('dd/MM HH:mm').format(dataHora)),
            ],
          ),
          ElevatedButton(
            onPressed: () async {
              final selected = await showDatePicker(
                context: context,
                initialDate: dataHora,
                firstDate: DateTime.now(),
                lastDate: DateTime.now().add(const Duration(days: 30)),
              );

              if (selected != null) {
                final time = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.fromDateTime(dataHora),
                );

                if (time != null) {
                  setState(() {
                    dataHora = DateTime(
                      selected.year,
                      selected.month,
                      selected.day,
                      time.hour,
                      time.minute,
                    );
                  });
                }
              }
            },
            child: const Text('Selecionar Data e Hora'),
          ),

          const SizedBox(height: 20),

          // Botão Salvar
          ElevatedButton(
            onPressed: () {
              widget.onSave(
                Programacao(
                  tempoMinutos: tempoMinutos,
                  litros: litros,
                  dataHora: dataHora,
                ),
              );
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              minimumSize: const Size(double.infinity, 48),
            ),
            child: const Text('Salvar'),
          ),
        ],
      ),
    );
  }
}
