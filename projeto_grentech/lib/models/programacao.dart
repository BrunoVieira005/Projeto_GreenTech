// lib/models/programacao.dart
import 'package:flutter/material.dart'; // Importação padrão, não estritamente necessária para o modelo.

/// Um modelo de dados que representa um programa de irrigação agendado.
class Programacao {
  /// A duração do programa de irrigação em minutos.
  /// Usado como double para compatibilidade com sliders ou entradas numéricas flexíveis.
  final double tempoMinutos;

  /// O volume estimado de água a ser dispensado em litros.
  final double litros;

  /// A data e hora em que este programa está agendado para ser executado.
  final DateTime dataHora;

  /// Construtor para o modelo Programacao.
  /// Todos os parâmetros são obrigatórios.
  Programacao({
    required this.tempoMinutos,
    required this.litros,
    required this.dataHora,
  });

  /// Fornece uma representação em string do objeto Programacao para depuração.
  @override
  String toString() {
    return 'Programacao(tempoMinutos: ${tempoMinutos.round()}, litros: ${litros.toStringAsFixed(1)}, dataHora: $dataHora)';
  }
}
