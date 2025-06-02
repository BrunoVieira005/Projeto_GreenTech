// lib/widgets/sensor_card.dart
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; // Importa o pacote http
import 'dart:convert'; // Importa para decodificar JSON

/// Um widget para exibir leituras individuais de sensores, agora buscando dados de uma API.
class SensorCard extends StatefulWidget {
  /// O ícone que representa o sensor.
  final IconData icon;

  /// O rótulo para o sensor (por exemplo, 'Temperatura').
  final String label;

  /// A cor do ícone do sensor.
  final Color iconColor;

  /// Construtor para o widget SensorCard.
  const SensorCard({
    super.key,
    required this.icon,
    required this.label,
    required this.iconColor,
  });

  @override
  State<SensorCard> createState() => _SensorCardState();
}

class _SensorCardState extends State<SensorCard> {
  String _currentValue = 'Carregando...'; // Estado para o valor do sensor
  String _errorMessage = ''; // Estado para mensagens de erro

  @override
  void initState() {
    super.initState();
    _fetchSensorData(); // Inicia a busca de dados quando o widget é criado
  }

  /// Busca os dados do sensor da API.
  Future<void> _fetchSensorData() async {
    setState(() {
      _currentValue = 'Carregando...'; // Mostra "Carregando" enquanto busca
      _errorMessage = ''; // Limpa qualquer mensagem de erro anterior
    });

    // Se o sensor for "Velocidade do vento" ou "Luminosidade", usa um valor fictício.
    if (widget.label == 'Velocidade do vento') {
      setState(() {
        _currentValue = '12 km/h'; // Valor fictício para velocidade do vento
      });
      return; // Sai da função, não precisa chamar a API
    } else if (widget.label == 'Luminosidade') {
      setState(() {
        _currentValue = '80%'; // Valor fictício para luminosidade
      });
      return; // Sai da função, não precisa chamar a API
    }

    try {
      final response = await http.get(
        Uri.parse('https://apiintegrador-production.up.railway.app/dados'),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        String fetchedValue = 'N/A'; // Valor padrão caso não encontre o dado

        // Mapeia o rótulo do sensor para a chave correspondente na resposta da API
        switch (widget.label) {
          case 'Temperatura':
            if (data.containsKey('temperatura')) {
              fetchedValue = '${data['temperatura'].toStringAsFixed(1)}°C';
            }
            break;
          case 'Umidade do Solo':
            // Usa 'sensor_umidsolo' da API para umidade do solo
            if (data.containsKey('sensor_umidsolo')) {
              fetchedValue = '${data['sensor_umidsolo'].toStringAsFixed(1)}%';
            }
            break;
          case 'Umidade do Ar':
            // Novo card para umidade do ar, usando 'umidade' da API
            if (data.containsKey('umidade')) {
              fetchedValue = '${data['umidade'].toStringAsFixed(1)}%';
            }
            break;
          // Luminosidade foi movida para a lógica de valor fixo acima, então não precisa de um case aqui.
          case 'pH do Solo':
            // Novo card para pH, usando 'pH' da API
            if (data.containsKey('pH')) {
              fetchedValue = '${data['pH'].toStringAsFixed(1)}';
            }
            break;
          default:
            fetchedValue = 'Desconhecido';
        }

        setState(() {
          _currentValue = fetchedValue; // Atualiza o valor com os dados da API
        });
      } else {
        // Se a resposta não for 200 OK, mostra um erro
        setState(() {
          _errorMessage = 'Erro API: ${response.statusCode}';
          _currentValue = 'Erro!';
        });
        print('Failed to load sensor data: ${response.statusCode}');
      }
    } catch (e) {
      // Captura qualquer exceção durante a requisição (ex: sem internet)
      setState(() {
        _errorMessage = 'Conexão: $e';
        _currentValue = 'Erro!';
      });
      print('Error fetching sensor data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.43,
      child: Card(
        color: Colors.white,
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(widget.icon, color: widget.iconColor, size: 24),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      widget.label,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Center(
                child: Column(
                  children: [
                    Text(
                      _currentValue, // Exibe o valor do estado
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    if (_errorMessage
                        .isNotEmpty) // Exibe mensagem de erro se houver
                      Padding(
                        padding: const EdgeInsets.only(top: 4.0),
                        child: Text(
                          _errorMessage,
                          style: const TextStyle(
                            color: Colors.red,
                            fontSize: 10,
                          ),
                          textAlign: TextAlign.center,
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
