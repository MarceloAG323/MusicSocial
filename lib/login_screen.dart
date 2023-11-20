// login_screen.dart
import 'package:flutter/material.dart';
import 'package:musicsocial/register_screen.dart';
import 'home_layout.dart'; // Importe o componente HomeLayout

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Padding(padding: EdgeInsets.all(16.0), child: LoginForm()),
    );
  }
}

class LoginForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextField(decoration: InputDecoration(labelText: 'Email')),
        SizedBox(height: 16.0),
        TextField(decoration: InputDecoration(labelText: 'Password'), obscureText: true),
        SizedBox(height: 32.0),
        ElevatedButton(
          onPressed: () {
            // Simule a lógica de login bem-sucedido
            // Em um aplicativo real, você deve verificar a autenticação
            bool loginSuccessful = true;

            if (loginSuccessful) {
              // Se o login for bem-sucedido, navegue para o HomeLayout
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => HomeLayout()),
              );
            }
          },
          child: Text('Login'),
        ),
        SizedBox(height: 16.0),
        TextButton(
          onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterScreen())),
          child: Text('Não tem uma conta? Registre-se'),
        ),
      ],
    );
  }
}
