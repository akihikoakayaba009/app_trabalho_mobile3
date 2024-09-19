import 'package:flutter/material.dart';

class ListaPage extends StatefulWidget {
  const ListaPage({super.key});

  @override
  State<ListaPage> createState() => _ListaPageState();
}

class _ListaPageState extends State<ListaPage> {
  late Future<List<String>> listas;

  Future<List<String>> getListas() async {
    return Future.delayed(const Duration(seconds: 10), () {
      return ['pabloleon@upf.br', 'email@email.com', 'teste@teste.com'];
    });
  }

  @override
  void initState() {
    listas = getListas();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Listas'),
        ),
        body: FutureBuilder(
          future: listas,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 5,
                    child: ListTile(
                      title: Text(snapshot.data![index]),
                      leading: const CircleAvatar(
                        child: Text("CS"),
                      ),
                      trailing: const Icon(Icons.arrow_forward_ios),
                      subtitle: const Text("Subtitulo do curso"),
                    ),
                  );
                },
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ));
  }
}
