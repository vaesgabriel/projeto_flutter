import 'package:flutter/material.dart';
import 'package:meuapp/view/home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/logotipo_firma.png",
                width: MediaQuery.of(context).size.width * 0.5,
              ),
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Email obrigatório";
                  }
                  return null;
                },
                maxLength: 50,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  hintText: "Insira seu email",
                ),
              ),
              const SizedBox(height: 15),
              TextFormField(
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Senha obrigatória";
                  }
                  return null;
                },
                maxLength: 10,
                decoration: const InputDecoration(
                  hintText: "Insira sua senha",
                ),
              ),
              const SizedBox(height: 15),
              SizedBox(
                height: 48,
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HomeScreen(),
                        ),
                      );
                    }
                  },
                  child: const Text("Entrar"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
