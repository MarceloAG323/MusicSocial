import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: HomeLayout(),
    );
  }
}

class HomeLayout extends StatefulWidget {
  @override
  _HomeLayoutState createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  List<Post> _posts = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Posts'),
      ),
      body: ListView.builder(
        itemCount: _posts.length,
        itemBuilder: (context, index) {
          return _buildPost(_posts[index]);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await _createPostDialog(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildPost(Post post) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              post.userName,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
            SizedBox(height: 8.0),
            Text(post.postText),
            SizedBox(height: 16.0),
            Row(
              children: [
                IconButton(
                  icon: Icon(Icons.favorite_border),
                  onPressed: () {
                    // Atualiza o estado ao curtir o post
                    setState(() {
                      post.likes += 1;
                    });
                  },
                ),
                Text(post.likes.toString()), // Número de curtidas
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _createPostDialog(BuildContext context) async {
    TextEditingController _textEditingController = TextEditingController();
    bool _imageSelected = false;

    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Criar Novo Post'),
          content: Column(
            children: [
              TextField(
                controller: _textEditingController,
                decoration: InputDecoration(
                  hintText: 'Digite seu post aqui...',
                ),
                maxLines: 3,
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () async {
                  // Lógica para adicionar o novo post
                  String postText = _textEditingController.text.trim();
                  bool containsLetters = RegExp(r'[a-zA-Z]').hasMatch(postText);

                  if (postText.isNotEmpty && containsLetters) {
                    // Adicionar o novo post à lista
                    setState(() {
                      _posts.add(Post(
                        userName: 'Usuário Novo',
                        postText: postText,
                        likes: 0,
                      ));
                    });
                    Navigator.of(context).pop();
                  } else {
                    // Mostrar uma mensagem de erro se o texto estiver vazio ou não conter letras
                    String errorMessage = 'Por favor, escreva algo com pelo menos uma letra no post.';
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(errorMessage),
                      duration: Duration(seconds: 2),
                    ));
                  }
                },
                child: Text('Concluir'),
              ),
              ElevatedButton(
                onPressed: () {
                  // Cancelar a criação do post
                  Navigator.of(context).pop();
                },
                child: Text('Cancelar'),
              ),
            ],
          ),
        );
      },
    );
  }
}

class Post {
  final String userName;
  final String postText;
  int likes;

  Post({required this.userName, required this.postText, required this.likes});
}
