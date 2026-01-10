import 'package:flutter/material.dart';

/// Widget que muestra un número grande con efecto de contorno/sombra
class IndexNumber extends StatelessWidget {
  const IndexNumber({
    super.key,
    required this.number,
  });
  
  final int number;
  
  @override
  Widget build(BuildContext context) {
    return Text(
      (number).toString(),
      style: const TextStyle(
        fontSize: 120,
        fontWeight: FontWeight.w600,
        // Efecto de contorno con 4 sombras en las esquinas
        shadows: [
          Shadow(
            offset: Offset(-1.5, -1.5),
            color: Color(0xFF0296E5),
          ),
          Shadow(
            offset: Offset(1.5, -1.5),
            color: Color(0xFF0296E5),
          ),
          Shadow(
            offset: Offset(1.5, 1.5),
            color: Color(0xFF0296E5),
          ),
          Shadow(
            offset: Offset(-1.5, 1.5),
            color: Color(0xFF0296E5),
          ),
        ],
        color: Color(0xFF242A32),
      ),
    );
  }
}
