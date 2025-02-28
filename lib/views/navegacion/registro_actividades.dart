import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

const tipoLetra = 'Monospace';

class RegistroActividades extends StatefulWidget {
  const RegistroActividades({super.key});

  @override
  State<RegistroActividades> createState() => _RegistroActividadesState();
}

class _RegistroActividadesState extends State<RegistroActividades> {
  // ignore: prefer_final_fields
  List<String> _images = [
    'https://media.licdn.com/dms/image/v2/C4E03AQEdSK4YkDhv0w/profile-displayphoto-shrink_200_200/profile-displayphoto-shrink_200_200/0/1658904251136?e=2147483647&v=beta&t=_O6mtTA6_7TPfhr8mpnBwJuYPze-590YZM9T4w8Hr6k',
    'https://vegaperu.vtexassets.com/arquivos/ids/164772/130064.jpg?v=638248566159570000',
    'https://media.licdn.com/dms/image/v2/C4E03AQEdSK4YkDhv0w/profile-displayphoto-shrink_200_200/profile-displayphoto-shrink_200_200/0/1658904251136?e=2147483647&v=beta&t=_O6mtTA6_7TPfhr8mpnBwJuYPze-590YZM9T4w8Hr6k'
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        height: size.height,
        width: size.width,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CarouselSlider(
                  
                  options: CarouselOptions(
                    autoPlay: true,
                      enableInfiniteScroll: false,
                      height: 200,
                      aspectRatio: 16 / 9,
                      viewportFraction: 0.4),
                  items: _images.map((image) {
                    return Builder(builder: (BuildContext context) {
                      return Stack(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.network(
                                image,
                                fit: BoxFit.cover,
                                width: double.infinity,
                              ),
                            ),
                          ),
                          Positioned(
                              top: 10,
                              right: 10,
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(20)),
                                child: const Icon(
                                  Icons.close,
                                  color: Colors.white,
                                ),
                              )),
                              
                        ],
                      );
                    });
                  }).toList(),
                ),
                const SizedBox(height: 20),
                _buildInfoCard(
                  context,
                  color: Colors.grey[100]!,
                  icon: Icons.play_arrow,
                  label: 'Fecha inicio:',
                  value: '10:12',
                ),
                const SizedBox(height: 20),
                _buildInfoCard(
                  context,
                  color: Colors.red[100]!,
                  icon: Icons.flag,
                  label: 'Fecha Fin:',
                  value: '11:59',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoCard(BuildContext context,
      {required Color color,
      required IconData icon,
      required String label,
      required String value}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            blurRadius: 8,
            offset: const Offset(4, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InfoRow(icon: icon, label: label, value: value),
          const Divider(color: Colors.black),
          const InfoRow(icon: Icons.thumb_up, label: 'Buenas:', value: '4000'),
          const Divider(color: Colors.black),
          const InfoRow(icon: Icons.thumb_down, label: 'Malas:', value: '30'),
          const Divider(color: Colors.black),
          const InfoRow(
              icon: Icons.event_available_outlined,
              label: 'Tipo de Evento:',
              value: 'Producción'),
        ],
      ),
    );
  }
}

class InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const InfoRow({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: Colors.black87,
          size: 18,
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            '$label  $value',
            style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
                fontFamily: 'Times New Roman'),
          ),
        ),
      ],
    );
  }
}
