import 'package:flutter/material.dart';

class MenuDrawer extends StatelessWidget {
  const MenuDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(child: Text("Menu")),
          ListTile(
            leading: Icon(Icons.home),
            title: Text("Cursos"),
            onTap: () {},
          ),
                    ListTile(
            leading: Icon(Icons.calendar_today),
            title: Text("Feriados"),
            onTap: () {},
          ),
                    ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text("Sair"),
            onTap: () {},
          )
        ],
      ),
    );
  }
}