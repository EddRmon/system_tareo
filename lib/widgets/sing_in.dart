import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:system_tareo/providers/auth_provider.dart';
import 'package:system_tareo/providers/machines_providers.dart';
import 'package:system_tareo/views/navegacion/barra_navegacion.dart';

class SingIn extends StatefulWidget {
  const SingIn({super.key});

  @override
  State<SingIn> createState() => _SingInState();
}

class _SingInState extends State<SingIn> {
  final TextEditingController _user = TextEditingController();
  final TextEditingController _pass = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _obscureText = true;

  String? maquinaSeleccionada;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<MachinesProviders>().getMachines();
    });
  }

  @override
  void dispose() {
    super.dispose();
    _user.dispose();
    _pass.dispose();
  }
  void _viewPassword(){
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final machines = context.watch<MachinesProviders>().machines;
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: CustomPaint(
                size: Size(size.width, size.height * 0.5),
                painter: CurvePainter(),
              )),
          SafeArea(
            child: Center(
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
                        style: TextStyle(
                            fontSize: 34, fontFamily: 'Times New Roman'),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: size.height * 0.15,
                      ),
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            SizedBox(
                              width: size.width > 360
                                  ? 600
                                  : 500, // Ancho responsivo
                              child: TextField(
                                controller: _user,
                                keyboardType: TextInputType.number,
                                style: const TextStyle(fontSize: 12),
                                decoration: InputDecoration(
                                    hintText: 'Usuario',
                                    hintStyle: const TextStyle(
                                        fontFamily: 'Times New Roman'),
                                    prefixIcon: const Icon(
                                      Icons.mail_outline,
                                    ),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(16),
                                        borderSide: const BorderSide(
                                            color: Color.fromARGB(
                                                255, 5, 124, 179))),
                                    filled: true,
                                    fillColor: Colors.white),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            SizedBox(
                              width: size.width > 360
                                  ? 600
                                  : 500, // Ancho responsivo
                              child: TextField(
                                controller: _pass,
                                obscureText: _obscureText,
                                keyboardType: TextInputType.number,
                                style: const TextStyle(fontSize: 12),
                                decoration: InputDecoration(
                                    hintText: 'Contraseña',
                                    hintStyle: const TextStyle(
                                        fontFamily: 'Times New Roman'),
                                    prefixIcon: const Icon(Icons.lock_outlined),
                                    suffixIcon: IconButton(onPressed: _viewPassword, icon: const Icon(
                                        Icons.visibility_off_outlined),)
                                    ,
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(16),
                                        borderSide: const BorderSide(
                                            color: Color.fromARGB(
                                                255, 5, 124, 179))),
                                    filled: true,
                                    fillColor: Colors.white),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            comboBoxMaquina(
                                'MAQUINA', machines, maquinaSeleccionada,
                                (String? valor) {
                              setState(() {
                                maquinaSeleccionada = valor;
                                print('Máquina seleccionada: $maquinaSeleccionada'); // Depurar
                              });
                            }),
                          ],
                        ),
                      ),
                      
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        width: size.width,
                        child: Consumer<AuthProvider>(
                          builder: (context, auth, child) {
                            return auth.isLoading
                                ? const Center(
                                    child: CircularProgressIndicator(),
                                  )
                                : MaterialButton(
                                    height: 45,
                                    onPressed: () async {
                                      if(_formKey.currentState?.validate() ?? false){
                                        try{
                                          await auth.login(_user.text, _pass.text);
                                          if(auth.isAuthenticated){
                                            Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                   BarraNavegacion(maquina: maquinaSeleccionada,)));
                                          _user.clear();
                                          _pass.clear();
                                          
                                          } else {
                                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Datos invalidos')));
                                      }
                                    } catch (err) {
                                      ScaffoldMessenger.of(context).showSnackBar( SnackBar(content: Text('Falló la autenticación: $err')));
                                    }
                                      }
                                     /* Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const BarraNavegacion()));*/
                                    },
                                    color: Colors.black,
                                    child: const Text(
                                      'Sign in',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'Times New Roman'),
                                    ),
                                  );
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget comboBoxMaquina(String texto, List<Map<String, String>> maquinas, String? valor, ValueChanged<String?> cambiar) {
  final size = MediaQuery.of(context).size;
  return SizedBox(
    width: size.width,
    height: 65,
    child: DropdownButtonFormField<String>(
      value: valor,
      menuMaxHeight: 300,
      onChanged: cambiar,
      items: maquinas.map((Map<String, String> maquina) {
        return DropdownMenuItem(
          value: maquina['MaqNro'], // Usar MaqNro como valor interno
          child: Text(
            '${maquina['MaqNro']} - ${maquina['MaqDes']}', // Mostrar MaqNro y MaqDes
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 12,
              color: Colors.black,
            ),
          ),
        );
      }).toList(),
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.grey, width: 1.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.grey, width: 1.0),
        ),
        errorBorder: bordesRojos(),
        focusedErrorBorder: bordesRojos(),
        labelText: texto,
        labelStyle: const TextStyle(
          fontSize: 13,
          color: Colors.grey,
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      ),
      focusColor: Colors.white,
      validator: (value2) {
        if (value2 == null || value2.isEmpty) {
          return 'Campo requerido';
        }
        return null;
      },
    ),
  );
}
  OutlineInputBorder bordesRojos() {
    return const OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.red, // Cambia aquí el color del borde en estado de error
        width: 1, // Puedes ajustar el grosor del borde de error
      ),
    );
  }
}

class CurvePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = const Color.fromARGB(255, 5, 124, 179)
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
