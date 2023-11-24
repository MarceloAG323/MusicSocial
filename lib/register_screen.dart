import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'home_screen.dart';

class RegisterScreenPage extends StatelessWidget {
  TextEditingController registerUsernameController = TextEditingController();
  TextEditingController registerPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Registrar')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/your_logo.png', // Substitua pelo caminho da imagem do seu logo
                height: 100.0,
              ),
              SizedBox(height: 20.0),
              TextFormField(
                controller: registerUsernameController,
                decoration: InputDecoration(
                  labelText: 'Novo Usuário',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person),
                ),
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: registerPasswordController,
                decoration: InputDecoration(
                  labelText: 'Nova Senha',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.lock),
                ),
                obscureText: true,
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  if (registerUsernameController.text.isNotEmpty && registerPasswordController.text.isNotEmpty) {
                    // Lógica de registro
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomeScreen(),
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Preencha todos os campos para se registrar.'),
                      ),
                    );
                  }
                },
                child: Text('Registrar'),
              ),
              SizedBox(height: 16.0),
              TextButton(
                onPressed: () {
                  Navigator.pop(context); // Voltar para a tela de login
                },
                child: Text('Já tem uma conta? Faça login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}