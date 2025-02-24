import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:system_tareo/blocs/auth_bloc.dart';
import 'package:system_tareo/blocs/auth_event.dart';
import 'package:system_tareo/blocs/auth_state.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        actions: [
          IconButton(
            icon:const Icon(Icons.logout),
            onPressed: () {
              BlocProvider.of<AuthBloc>(context).add(LogoutRequested());
            },
          ),
        ],
      ),
      body: Center(
        child: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            if (state is Authenticated) {
              return Text("Bienvenido, Usuario ${state.user.usuario}");
            } else {
              return const Text("No autenticado");
            }
          },
        ),
      ),
    );
  }
}
