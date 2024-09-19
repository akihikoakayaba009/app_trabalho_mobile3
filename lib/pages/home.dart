import 'package:auladois/pages/cachorro.dart';
import 'package:auladois/pages/config.dart';
import 'package:auladois/pages/cores.dart';
import 'package:auladois/pages/lista.dart';
import 'package:auladois/pages/listaUsuarios.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tela Inicial'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset('images/logo.png')
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              title: Text('Cores'),
              onTap: () => {
                Navigator.pop(context),
                Navigator.push(
                  context, 
                  MaterialPageRoute(builder: (context) => const CoresPage())
                )
              },
            ),
            ListTile(
              title: Text('Listas'),
              onTap: () => {
                Navigator.pop(context),
                Navigator.push(
                  context, 
                  MaterialPageRoute(builder: (context) => ListaPage())
                )
              },
            ),
            ListTile(
              title: Text('Configurações'),
              onTap: () => {
                Navigator.pop(context),
                Navigator.push(
                  context, 
                  MaterialPageRoute(builder: (context) => ConfigPage())
                )
              },
            ),
            ListTile(
              title: Text('Lista Usuários'),
              onTap: () => {
                Navigator.pop(context),
                Navigator.push(
                  context, 
                  MaterialPageRoute(builder: (context) => ListaUsuariosPage())
                )
              },
            ),
            ListTile(
              title: Text('Melhor amigo do homem'),
              onTap: () => {
                Navigator.pop(context),
                Navigator.push(
                  context, 
                  MaterialPageRoute(builder: (context) => CachorroPage())
                )
              },
            )
          ],
        ),
      ),
    );
  }
}