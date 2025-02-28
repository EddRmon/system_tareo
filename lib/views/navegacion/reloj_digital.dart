import 'package:flutter/material.dart';
import 'package:intl/intl.dart';



class DigitalClock extends StatefulWidget {
  final Size size;

  const DigitalClock({super.key, required this.size});

  @override
  State<DigitalClock> createState() => _DigitalClockState();
}

class _DigitalClockState extends State<DigitalClock> {

  Stream<String> getHoraStream() {
  return Stream.periodic(const Duration(seconds: 0), (_) {
    return DateFormat('HH:mm:ss').format(DateTime.now()); // Usamos formato 24 horas para un reloj digital típico
  });
}
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      width: 120,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color.fromARGB(255, 34, 33, 33).withOpacity(0.9), // Fondo negro para un reloj digital
            Colors.grey[800]!.withOpacity(0.8),
          ],
        ),
        borderRadius: BorderRadius.circular(12), // Bordes suaves
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
        border: Border.all(
          color: Colors.grey[600]!,
          width: 2, // Borde gris para simular pantalla LCD/LED
        ),
      ),
      child: Center(
        child: StreamBuilder<String>(
          stream: getHoraStream(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final time = snapshot.data!;
              return _buildDigitalTimeDisplay(time, widget.size);
            }
            return const Text(
              '00:00:00',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontFamily: 'Courier New', // Fuente técnica como alternativa
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildDigitalTimeDisplay(String time, Size size) {
    // Separamos las horas, minutos y segundos
    final parts = time.split(':');
    if (parts.length != 3) return const Text('00:00:00');

    final hours = parts[0];
    final minutes = parts[1];
    final seconds = parts[2];

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildDigit(hours[0], size),
        _buildDigit(hours[1], size),
        _buildColon(size),
        _buildDigit(minutes[0], size),
        _buildDigit(minutes[1], size),
        _buildColon(size),
        _buildDigit(seconds[0], size),
        _buildDigit(seconds[1], size),
      ],
    );
  }

  Widget _buildDigit(String digit, Size size) {
    return Text(
      digit,
      style: TextStyle(
        fontSize: size.width > 600 ? 20 : 16, // Tamaño ajustado para responsividad
        fontWeight: FontWeight.bold,
        color: Colors.white,
        fontFamily: 'Courier New', // Fuente técnica para simular digital
        shadows: [
          Shadow(
            color: Colors.black26,
            offset: const Offset(1, 1),
            blurRadius: 2,
          ),
        ],
      ),
    );
  }

  Widget _buildColon(Size size) {
    return AnimatedBuilder(
      animation: const AlwaysStoppedAnimation(Duration(milliseconds: 500)),
      builder: (context, child) {
        final opacity = DateTime.now().second.isEven ? 1.0 : 0.3; // Parpadeo cada segundo
        return Opacity(
          opacity: opacity,
          child: Text(
            ':',
            style: TextStyle(
              fontSize: size.width > 600 ? 20 : 16, // Tamaño ajustado para responsividad
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontFamily: 'Courier New',
              shadows: [
                Shadow(
                  color: Colors.black26,
                  offset: const Offset(1, 1),
                  blurRadius: 2,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

