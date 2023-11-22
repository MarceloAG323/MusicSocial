import 'dart:typed_data';
import 'dart:html' as html;
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
            post.imageBytes != null
                ? Image.memory(
                    post.imageBytes!,
                    width: double.infinity,
                    height: 200.0,
                    fit: BoxFit.cover,
                  )
                : SizedBox.shrink(),
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
    Uint8List? _imageBytes;

    html.InputElement uploadInput = html.InputElement()
      ..type = 'file'
      ..accept = 'image/*';

    uploadInput.click();

    uploadInput.onChange.listen((e) {
      final files = uploadInput.files;
      if (files!.isNotEmpty) {
        final fileReader = html.FileReader();
        fileReader.readAsArrayBuffer(files[0]);
        fileReader.onLoadEnd.listen((event) {
          setState(() {
            _imageBytes = Uint8List.fromList(
                List<int>.from(fileReader.result as List<dynamic>));
          });
        });
      }
    });

    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Criar Novo Post'),
          content: Column(
            children: [
              GestureDetector(
                onTap: () {
                  uploadInput.click();
                },
                child: Container(
                  width: double.infinity,
                  height: 100.0,
                  color: Colors.grey[300],
                  child: _imageBytes != null
                      ? Image.memory(
                          _imageBytes!,
                          fit: BoxFit.cover,
                          width: double.infinity,
                        )
                      : Icon(Icons.add_a_photo),
                ),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () async {
                  // Lógica para adicionar o novo post
                  String postText = _textEditingController.text;
                  // Adicionar o novo post à lista
                  setState(() {
                    _posts.add(Post(
                      userName: 'Usuário Novo',
                      postText: postText,
                      likes: 0,
                      imageBytes: _imageBytes,
                    ));
                  });
                  Navigator.of(context).pop();
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
  final Uint8List? imageBytes;

  Post({
    required this.userName,
    required this.postText,
    required this.likes,
    this.imageBytes,
  });
}
