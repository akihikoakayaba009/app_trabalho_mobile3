import 'dart:convert';

import 'package:auladois/models/usuario.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class EditUsuarioPage extends StatefulWidget {
  final Usuario usuario;
  
  EditUsuarioPage({required this.usuario});

  @override
  State<EditUsuarioPage> createState() => _EditUsuarioPageState();
}

class _EditUsuarioPageState extends State<EditUsuarioPage> {
  final _formKey = GlobalKey<FormState>();
  late String nome;
  late String email;
  late String senha;

  @override
  void initState() {
    super.initState();
    nome = widget.usuario.nome ?? 'usuario sem nome';
    email = widget.usuario.email ?? '';
    senha = widget.usuario.senha ?? '';
  }

  updateUsuario() async {
    if(_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final usuarioParaSalvar = Usuario(
        id: widget.usuario.id,
        nome: nome,
        email: email,
        senha: senha
      );

      final response = await http.put(
        Uri.parse('https://66ce59e9901aab24841e5f1d.mockapi.io/api/usuarios/${widget.usuario.id}'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(usuarioParaSalvar.toJson()),
      );

      if(response.statusCode == 200) {
        Navigator.pop(context);
      } else {
         ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao atualizar o usuário')),
        );
      }
    }
  }

  excluirUsuario() async {
    final response = await http.delete(
      Uri.parse('https://66ce59e9901aab24841e5f1d.mockapi.io/api/usuarios/${widget.usuario.id}')
    ); 
    if(response.statusCode == 200) {
      Navigator.pop(context);
    } else {
        ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao apagar o usuário')),
      );
    } 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar Usuário'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextFormField(
                initialValue: nome,
                decoration: const InputDecoration(
                  labelText: 'Nome',
                  border: OutlineInputBorder(),
                ),
                onSaved: (value) => nome = value ?? '',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira um nome';
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextFormField(
                initialValue: senha,
                decoration: const InputDecoration(
                  labelText: 'Senha',
                  border: OutlineInputBorder(),
                ),
                onSaved: (value) => senha = value ?? '',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira uma senha forte';
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextFormField(
                initialValue: email,
                decoration: const InputDecoration(
                  labelText: 'email',
                  border: OutlineInputBorder(),
                ),
                onSaved: (value) => email = value ?? '',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira um email';
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () => {
                      updateUsuario()
                    }, 
                    child: const Text('Editar')
                  ),
                  ElevatedButton(
                    onPressed: () => {
                      excluirUsuario()
                    }, 
                    child: const Text('Excluir')
                  ),
                ],
              ),
            ),
          ],
        ),
      )
    );
  }
}