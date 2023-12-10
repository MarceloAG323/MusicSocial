import 'package:flutter/material.dart';

import 'home_layout.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('MusicSocial')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginScreenPage(),
                  ),
                );
              },
              child: Text('Login'),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RegisterScreenPage(
                      onRegisterPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginScreenPage(),
                          ),
                        );
                      },
                    ),
                  ),
                );
              },
              child: Text('Registrar'),
            ),
          ],
        ),
      ),
    );
  }
}

class LoginScreenPage extends StatelessWidget {
  TextEditingController loginController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: loginController,
                decoration: InputDecoration(
                  labelText: 'Usuário',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  prefixIcon: Icon(Icons.person),
                ),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: passwordController,
                decoration: InputDecoration(
                  labelText: 'Senha',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  prefixIcon: Icon(Icons.lock),
                ),
                obscureText: true,
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  if (loginController.text.isNotEmpty && passwordController.text.isNotEmpty) {
                    // Lógica de autenticação
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomeLayout(), // Alterado para PostScreen
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Preencha todos os campos para fazer login.'),
                      ),
                    );
                  }
                },
                child: Text('Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RegisterScreenPage extends StatelessWidget {
  final Function() onRegisterPressed;

  RegisterScreenPage({
    required this.onRegisterPressed,
  });

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
              TextField(
                controller: registerUsernameController,
                decoration: InputDecoration(
                  labelText: 'Novo Usuário',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  prefixIcon: Icon(Icons.person),
                ),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: registerPasswordController,
                decoration: InputDecoration(
                  labelText: 'Nova Senha',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  prefixIcon: Icon(Icons.lock),
                ),
                obscureText: true,
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  if (registerUsernameController.text.isNotEmpty &&
                      registerPasswordController.text.isNotEmpty) {
                    // Ambos os campos estão preenchidos, pode chamar a função onRegisterPressed
                    onRegisterPressed();
                  } else {
                    // Exibe uma mensagem no ScaffoldMessenger se um ou ambos os campos estiverem em branco
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Preencha todos os campos para se registrar.'),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  }
                },
                child: Text('Registrar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}



void main() {
  runApp(MaterialApp(home: LoginPage()));
}
