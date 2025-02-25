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
        if(state is AuthError){
         ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
        if(state is Authenticated){
          Navigator.popAndPushNamed(context, '/barraNavegacion');
        }
       },
      child: Stack(
          children: [
            Positioned(
              top:0,
              left: 0,
              right: 0,
              child: CustomPaint(
                size: Size(size.width, size.height *0.5),
                painter: CurvePainter(),
              )),
              Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      'Bienvenido\n de nuevo',
                      style: TextStyle(fontSize: 34),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: size.height * 0.1,
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    TextField(
                      controller: _user,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          hintText: 'Email',
                          prefixIcon: const Icon(Icons.mail_outline),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide.none
                              ),
                          filled: true,
                          fillColor: const Color.fromARGB(255, 228, 225, 225)
                          ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextField(
                      controller: _pass,
                      obscureText: true,
                      decoration: InputDecoration(
                          hintText: 'Password',
                          prefixIcon: const Icon(Icons.lock_outlined),
                          suffixIcon: const Icon(Icons.visibility_off_outlined),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide.none),
      
                          filled: true,
                          fillColor: const Color.fromARGB(255, 228, 225, 225)
                        ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                  
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black),
                        onPressed: ()  {
                          //final username = _user.text;
                         // final password = _pass.text; 
                         // final conver = int.parse(username);
                         // context.read<AuthBloc>().add(LoginRequested(username: conver, password: password)) ;
                          Navigator.popAndPushNamed(context, '/barraNavegacion');
                        },
                        child: const SizedBox(
                          height: 40,
                          child: Center(
                            child: Text(
                              'Sign in',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        )),
                    const SizedBox(
                      height: 15,
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
}

class CurvePainter extends CustomPainter{
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = Colors.blueGrey..style = PaintingStyle.fill;
    Path path = Path()..moveTo(0, size.width)..quadraticBezierTo(size.height * 0.7, size.height, size.width, size.width * 0.5)..lineTo(size.width, 0)..lineTo(0, 0)..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }

}