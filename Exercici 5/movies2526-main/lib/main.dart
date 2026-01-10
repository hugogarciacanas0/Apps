
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:movies/screens/main.dart';

// Función principal que inicia la aplicación
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Color(0xFF242A32),
      ),
    );
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFF242A32),
        textTheme: const TextTheme(
          // Estilo para texto grande
          bodyLarge: TextStyle(
            color: Colors.white,
            fontFamily: 'Poppins',
          ),
          // Estilo para texto mediano
          bodyMedium: TextStyle(
            color: Colors.white,
            fontFamily: 'Poppins',
          ),
        ),
      ),
      // Pantalla inicial
      home: Main(),
    );
  }
}
