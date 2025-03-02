import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:system_tareo/blocs/auth_bloc.dart';
import 'package:system_tareo/blocs/auth_state.dart';

class SingIn extends StatefulWidget {
  const SingIn({super.key});

  @override
  State<SingIn> createState() => _SingInState();
}

class _SingInState extends State<SingIn> {
  final TextEditingController _user = TextEditingController();
  final TextEditingController _pass = TextEditingController();

  List<String> maquinas = ['BOTS 1', 'L20', 'ENTHRONE', 'S40', 'K40'];

  String? maquinaSeleccionada;

  @override
  void dispose() {
    super.dispose();
    _user.dispose();
    _pass.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocListener<AuthBloc, AuthState>(
      listener: (BuildContext context, state) {
        if (state is AuthError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
        if (state is Authenticated) {
          Navigator.popAndPushNamed(context, '/barraNavegacion');
        }
      },
      child: Stack(
        children: [
          Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: CustomPaint(
                size: Size(size.width, size.height * 0.5),
                painter: CurvePainter(),
              )),
          Center(
            child: SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  //crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      'Bienvenido\n de nuevo',
                      style: TextStyle(fontSize: 34, fontFamily: 'Times New Roman'),
                      textAlign: TextAlign.center,
                    ),
                    
                     SizedBox(
                      height: size.height * 0.15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          width:
                              size.width > 360 ? 200 : 180, // Ancho responsivo
                          child: TextField(
                            controller: _user,
                            keyboardType: TextInputType.number,
                            style: const TextStyle(fontSize: 12),
                            decoration: InputDecoration(
                                hintText: 'Usuario',
                                hintStyle: const TextStyle(fontFamily: 'Times New Roman'),
                                prefixIcon: const Icon(Icons.mail_outline, ),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16),
                                    borderSide: BorderSide.none),
                                filled: true,
                                fillColor:
                                    const Color.fromARGB(255, 228, 225, 225)),
                          ),
                        ),
                        comboBoxMaquina('MAQUINA',maquinas, maquinaSeleccionada, (String? valor){
                          setState(() {
                            maquinaSeleccionada = valor;
                          });
                        })
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          width:
                              size.width > 360 ? 200 : 180, // Ancho responsivo
                          child: TextField(
                            controller: _pass,
                            obscureText: true,
                            style: const TextStyle(fontSize: 12),
                            decoration: InputDecoration(
                                hintText: 'Contraseña',
                                hintStyle: const TextStyle(fontFamily: 'Times New Roman'),
                                prefixIcon: const Icon(Icons.lock_outlined),
                                suffixIcon:
                                    const Icon(Icons.visibility_off_outlined),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16),
                                    borderSide: BorderSide.none),
                                filled: true,
                                fillColor:
                                    const Color.fromARGB(255, 228, 225, 225)),
                          ),
                        ),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.black),
                            onPressed: () {
                              //final username = _user.text;
                              // final password = _pass.text;
                              // final conver = int.parse(username);
                              // context.read<AuthBloc>().add(LoginRequested(username: conver, password: password)) ;
                              Navigator.popAndPushNamed(
                                  context, '/barraNavegacion');
                            },
                            child: const SizedBox(
                              height: 50,
                              width: 75,
                              child: Center(
                                child: Text(
                                  'Sign in',
                                  style: TextStyle(color: Colors.white, fontFamily: 'Times New Roman'), 
                                ),
                              ),
                            )),
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
  Widget comboBoxMaquina(String texto, List<String> maquinas, String? valor, ValueChanged<String?> cambiar){
    final size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width * 0.34,
      height: 50,
      child: DropdownButtonFormField(
        onChanged: cambiar,
        items: maquinas.map((String maquina){
          return DropdownMenuItem(
            value:maquina ,
            child: Text(maquina, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.black),));
        }).toList(),
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.grey, width: 1.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color:Colors.grey, width: 1.0),
            ),
            labelText: texto,
              labelStyle: const TextStyle(
                fontSize: 13,
                color: Colors.grey,
              ),
        ),
        focusColor: Colors.white,
        
      
      ),
    );
  }
}

class CurvePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.blueGrey
      ..style = PaintingStyle.fill;
    Path path = Path()
      ..moveTo(0, size.width)
      ..quadraticBezierTo(
          size.height * 0.7, size.height, size.width, size.width * 0.5)
      ..lineTo(size.width, 0)
      ..lineTo(0, 0)
      ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
