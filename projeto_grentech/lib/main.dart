// Importa o pacote Flutter com os componentes visuais (widgets)
import 'package:flutter/material.dart';

// Importa o tema visual personalizado definido no arquivo theme.dart
import 'core/theme.dart';

// Importa a Splash Screen
import 'package:projeto_grentech/screens/splash_screen.dart';

// Função principal do app, ponto de entrada da aplicação
void main() {
  // Executa o app chamando a classe principal (GreenTechApp)
  runApp(const GreenTechApp());
}

// Classe principal do aplicativo, sem estado (StatelessWidget)
class GreenTechApp extends StatelessWidget {
  const GreenTechApp({super.key}); // Construtor padrão

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Título do aplicativo (usado em algumas plataformas)
      title: 'GreenTech',

      // Aplica o tema personalizado definido em core/theme.dart
      theme: appTheme,

      // Remove a faixa de "debug" que aparece no canto superior direito da tela
      debugShowCheckedModeBanner: false,

      // Define qual será a primeira tela exibida ao abrir o app
      home: const SplashScreen(),
    );
  }
}
