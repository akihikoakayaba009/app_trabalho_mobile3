import 'package:flutter/material.dart';

class ConfigPage extends StatelessWidget {
  const ConfigPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*appBar: AppBar(
        title: Text('Configurações'),
      ),*/
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.all(100),
            child: ElevatedButton(
              onPressed: () => {
                Navigator.pop(context)
              },
              child: Text('Configurações')
            ),
          ),
        ],
      ),
    );
  }
}
