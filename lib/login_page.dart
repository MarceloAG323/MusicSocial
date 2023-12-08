import 'package:flutter/material.dart';

import 'home_layout.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MusicSocial'),
        automaticallyImplyLeading: false, // Impede a exibição do botão de voltar
      ),
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

// Restante do código sem alterações...


class LoginScreenPage extends StatelessWidget {
  TextEditingController loginController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: loginController,
                decoration: InputDecoration(
                  labelText: 'E-mail',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  prefixIcon: Icon(Icons.email),
                ),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: passwordController,
                decoration: InputDecoration(
                  labelText: 'Senha (mínimo 8 caracteres)',
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
                  if (isValidEmail(loginController.text) &&
                      isPasswordValid(passwordController.text)) {
                    // Lógica de autenticação
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomeLayout(),
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Insira um e-mail válido e uma senha com pelo menos 8 caracteres.'),
                      ),
                    );
                  }
                },
                child: Text('Login'),
              ),
              SizedBox(height: 16.0),
              GestureDetector(
                onTap: () {
                  // Navegar para a página de registro
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
                child: Text(
                  'Não tem uma conta? Clique aqui para se registrar.',
                  style: TextStyle(
                    color: const Color.fromARGB(255, 25, 125, 207),
                    decoration: TextDecoration.underline,
                  ),
                ),
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
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: registerUsernameController,
                decoration: InputDecoration(
                  labelText: 'E-mail',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  prefixIcon: Icon(Icons.email),
                ),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: registerPasswordController,
                decoration: InputDecoration(
                  labelText: 'Senha (mínimo 8 caracteres)',
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
                  if (isValidEmail(registerUsernameController.text) &&
                      isPasswordValid(registerPasswordController.text)) {
                    onRegisterPressed();
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Insira um e-mail válido e uma senha com pelo menos 8 caracteres para se registrar.'),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  }
                },
                child: Text('Registrar'),
              ),
              SizedBox(height: 16.0),
              GestureDetector(
                onTap: () {
                  // Navegar para a página de login
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginScreenPage(),
                    ),
                  );
                },
                child: Text(
                  'Já tem uma conta? Clique aqui para fazer login.',
                  style: TextStyle(
                    color: const Color.fromARGB(255, 25, 125, 207),
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

bool isValidEmail(String email) {
  // Verifica se o e-mail tem um formato válido
  final emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
  return emailRegex.hasMatch(email);
}

bool isPasswordValid(String password) {
  return password.length >= 8;
}

void main() {
  runApp(MaterialApp(home: LoginPage()));
}
