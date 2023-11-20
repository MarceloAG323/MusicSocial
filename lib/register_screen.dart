// register_screen.dart
import 'package:flutter/material.dart';
import 'login_screen.dart'; // Importe o componente LoginScreen

class RegisterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Registro')),
      body: Padding(padding: EdgeInsets.all(16.0), child: RegisterForm()),
    );
  }
}

class RegisterForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextField(decoration: InputDecoration(labelText: 'Nome')),
        SizedBox(height: 16.0),
        TextField(decoration: InputDecoration(labelText: 'Email')),
        SizedBox(height: 16.0),
        TextField(decoration: InputDecoration(labelText: 'Password'), obscureText: true),
        SizedBox(height: 32.0),
        ElevatedButton(
          onPressed: () {
            // Simule a lógica de registro bem-sucedido
            // Em um aplicativo real, você deve salvar os detalhes do usuário
            bool registrationSuccessful = true;

            if (registrationSuccessful) {
              // Se o registro for bem-sucedido, navegue para a tela de login
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen()),
              );
            }
          },
          child: Text('Registrar'),
        ),
        SizedBox(height: 16.0),
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text('Já tem uma conta? Faça login'),
        ),
      ],
    );
  }
}
