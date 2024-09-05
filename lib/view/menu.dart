import 'package:flutter/material.dart';
import 'package:meuapp/view/login_screen.dart';

class MenuDrawer extends StatelessWidget {
  const MenuDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.deepPurple,
            ),
            child: Text(
              "Menu",
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text("Cursos"),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/home'); // Navegar para a tela de cursos
            },
          ),
          ListTile(
            leading: const Icon(Icons.calendar_today),
            title: const Text("Feriados"),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/holidays'); // Navegar para a tela de feriados
            },
          ),
          ListTile(
            leading: const Icon(Icons.exit_to_app),
            title: const Text("Sair"),
            onTap: () async {
              // Implementar lógica de logout se necessário, como limpar o estado de autenticação

              // Exemplo: Navegar para a tela de login e limpar a pilha de navegação
              Navigator.pushNamedAndRemoveUntil(
                context,
                '/login', // Rota para a tela de login
                (route) => false, // Remove todas as rotas anteriores
              );
            },
          ),
        ],
      ),
    );
  }
}
