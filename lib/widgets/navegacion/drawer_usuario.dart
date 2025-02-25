import 'package:flutter/material.dart';
import 'package:system_tareo/views/login_page.dart';

class DrawerUsuario extends StatelessWidget {
  const DrawerUsuario({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white, // todo
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color:  Color.fromARGB(255, 38, 50, 56)),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage(
                      'https://media.licdn.com/dms/image/v2/C4E03AQEdSK4YkDhv0w/profile-displayphoto-shrink_200_200/profile-displayphoto-shrink_200_200/0/1658904251136?e=2147483647&v=beta&t=_O6mtTA6_7TPfhr8mpnBwJuYPze-590YZM9T4w8Hr6k'),
                ),
                SizedBox(height: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Usuario: Ricardo",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    Text(
                      "Usuario: Ricardo",
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                  ],
                )
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Inicio'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Cerrar Sesión'),
            onTap: () {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginPage()));
            },
          ),
        ],
      ),
    );
  }
}
