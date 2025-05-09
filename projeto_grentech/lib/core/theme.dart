// Importa o pacote Flutter responsável pelos componentes visuais (widgets) e temas
import 'package:flutter/material.dart';

// Cria uma constante chamada 'appTheme' que define o tema visual do aplicativo
final ThemeData appTheme = ThemeData(
  // Define a cor primária do app (usada em botões, AppBar, etc.)
  primaryColor: const Color(0xFF1B5E20), // Cor verde escuro em hexadecimal

  // Define a cor de fundo padrão das telas (Scaffold)
  scaffoldBackgroundColor: const Color(0xFF1B5E20), // Cor de fundo verde escuro

  // Define estilos padrão para os textos usados no app
  textTheme: const TextTheme(
    // Estilo do corpo de texto médio (exemplo: textos de parágrafo)
    bodyMedium: TextStyle(
      color: Color.fromARGB(255, 7, 7, 7), // Cor do texto: branco
      fontSize: 16,        // Tamanho da fonte: 16 pixels
    ),
  ),
);
