import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class VistaInicio extends StatefulWidget {
  const VistaInicio({super.key});

  @override
  State<VistaInicio> createState() => _VistaInicioState();
}

class _VistaInicioState extends State<VistaInicio> {
  final List<String> imagenes = [
    'https://images.pexels.com/photos/6620970/pexels-photo-6620970.jpeg?auto=compress&cs=tinysrgb&w=300',
    'https://images.pexels.com/photos/6620989/pexels-photo-6620989.jpeg?auto=compress&cs=tinysrgb&w=300'
   
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            color: const Color.fromARGB(255, 5, 124, 179),
          ),
          Column(
            children: [
              const SizedBox(height: 10), // Espacio superior para la imagen de perfil
              /*const CircleAvatar(
                radius: 40,
                backgroundImage: NetworkImage(
                    'https://images.pexels.com/photos/16171084/pexels-photo-16171084/free-photo-of-naturaleza-rocas-animal-mono.jpeg'),
              ),*/
              const SizedBox(height: 20), // Espacio entre el avatar y el carrusel
              CarouselSlider(
                options: CarouselOptions(
                  height: 150.0,
                  enlargeCenterPage: true,
                  autoPlay: true, // Agregar autoplay
                  autoPlayInterval: const Duration(seconds: 4),
                ),
                items: imagenes.map((url) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      url,
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                  );
                }).toList(),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
                child: Card(
                  child: Container(
                    width: double.infinity,
                    height: 200,
                    color: Colors.white,
                    child: Column(
                      children: [
                        
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
