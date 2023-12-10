import 'package:flutter/material.dart';
import 'login_page.dart';

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
      darkTheme: ThemeData.dark(),
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
  TextEditingController _textEditingController = TextEditingController();
  String _userName = 'Usuário Novo';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Posts'),
        actions: [
          Row(
            children: [
              IconButton(
                icon: Icon(Icons.person),
                onPressed: () {
                  _openUserSettingsDialog(context);
                },
              ),
            ],
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildPostList(),
            SizedBox(height: 80.0), // Espaço adicional para evitar o overflow
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await _createPostDialog(context);
        },
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            // IconButton removido aqui
          ],
        ),
      ),
    );
  }

  Widget _buildPostList() {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: _posts.length,
      itemBuilder: (context, index) {
        return _buildPost(_posts[index]);
      },
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
              'Seu Nome é $_userName',
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
    bool _imageSelected = false;

    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Criar Novo Post'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: _textEditingController,
                  decoration: InputDecoration(
                    hintText: 'Digite seu post aqui...',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  maxLines: 2,
                ),
                SizedBox(height: 10.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        // Lógica para adicionar o novo post
                        String postText = _textEditingController.text.trim();
                        bool containsLetters = RegExp(r'[a-zA-Z]').hasMatch(postText);

                        if (postText.isNotEmpty && containsLetters) {
                          // Adicionar o novo post à lista
                          setState(() {
                            _posts.add(Post(
                              userName: _userName,
                              postText: postText,
                              likes: 0,
                            ));
                          });
                          Navigator.of(context).pop();
                        } else {
                          // Mostrar uma mensagem de erro se o texto estiver vazio ou não conter letras
                          String errorMessage =
                              'Por favor, escreva algo com pelo menos uma letra no post.';
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
              ],
            ),
          ),
        );
      },
    );
  }

  void _openUserSettingsDialog(BuildContext context) {
  TextEditingController _textController = TextEditingController();

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            title: Text('Seu Nome é: $_userName'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _textController,
                        onChanged: (value) {
                          // Atualiza temporariamente o título enquanto digita
                          setState(() {});
                        },
                        decoration: InputDecoration(
                          hintText: 'Novo Nome de Usuário',
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10.0),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _userName = _textController.text;
                          });
                        },
                        child: Text('Salvar'),
                      ),
                    ),
                    SizedBox(width: 10.0), // Espaço entre os botões
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          // Lógica para cancelar
                          Navigator.of(context).pop();
                        },
                        child: Text('Cancelar'),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10.0),
                ElevatedButton(
                  onPressed: () {
                    // Navegar para a página de login
                    Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
                  },
                  child: Text('Ir para a Página de Login'),
                ),
              ],
            ),
          );
        },
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
