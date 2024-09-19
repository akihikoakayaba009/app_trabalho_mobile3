import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class CachorroPage extends StatefulWidget {
  const CachorroPage({super.key});

  @override
  State<CachorroPage> createState() => _CachorroPageState();
}
class _CachorroPageState extends State<CachorroPage> {
  late Future<String> cachorro;

  @override
  void initState() {
    super.initState();
    cachorro = getCachorro();
  }

  Future<String> getCachorro() async {
    try {
      String url = 'https://dog.ceo/api/breeds/image/random';
      final response = await http.get(Uri.parse(url));
      if(response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);
        var parsedResponse = jsonResponse as Map<String, dynamic>;
        return parsedResponse['message'];
      } else {
        throw Exception('Erro ao converter os dados da API.');
      }
    } catch (e) {
      throw Exception('Erro ao buscar os dados da API.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cachorro'),
      ),
      body: FutureBuilder(
        future: cachorro, 
        builder: (context, snapshot) {
          if (snapshot.hasData!) {
            return Image.network(snapshot.data!);
          } else {
            return Center(child: const CircularProgressIndicator());
          }
        }
      ),
    );
  }
}