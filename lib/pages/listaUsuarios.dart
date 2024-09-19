import 'dart:convert';
import 'package:auladois/models/usuario.dart';
import 'package:auladois/pages/editUsuarios.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ListaUsuariosPage extends StatefulWidget {
  const ListaUsuariosPage({super.key});
  @override
  State<ListaUsuariosPage> createState() => _ListaUsuariosPageState();
}

class _ListaUsuariosPageState extends State<ListaUsuariosPage> {
  Future<List<Usuario>> _futureUsuarios = Future.value([]);
  
  @override
  void initState() {
    super.initState();
    _loadUsuarios();
  }

  void _loadUsuarios() {
    setState(() {
      _futureUsuarios = getUsuarios();
    });
  }

  Future<List<Usuario>> getUsuarios() async {
    try {
      String url =
          'https://66ce59e9901aab24841e5f1d.mockapi.io/api/usuarios';
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        return data.map((item) {
          //print('Item: $item');
          return Usuario.fromJson(item);
        }).toList();
      } else {
        throw Exception('Falha na requisição: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Erro ao buscar os dados da API.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Usuários'),
      ),
      body: FutureBuilder(
        future: _futureUsuarios,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Usuario> dados = snapshot.data!;
            return ListView.builder(
              itemCount: dados.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 5,
                  child: ListTile(
                    title: Text(dados[index].nome ?? 'Sem nome'),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    subtitle: Text(dados[index].email ?? 'usuario sem email'),
                    onTap: () => {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              EditUsuarioPage(usuario: dados[index]),
                        ),
                      ).then((_) => _loadUsuarios())
                    },
                  ),
                );
              },
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      )
    );
  }
}
