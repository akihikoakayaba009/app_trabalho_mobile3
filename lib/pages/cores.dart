import 'package:auladois/pages/config.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CoresPage extends StatefulWidget {
  const CoresPage({super.key});

  @override
  State<CoresPage> createState() => _CoresPageState();
}

class _CoresPageState extends State<CoresPage> {
  final Map<String, Color> colors = {
    'blue': Colors.blue,
    'red': Colors.red,
    'green': Colors.green,
    'yellow': Colors.yellow,
    'purple': Colors.purple,
    'teal': Colors.teal,
    'orange': Colors.orange
  };

  Color? selectedColor;

  void setColor(String nome, Color cor) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('color', nome);
    print(prefs.getKeys());
    setState(() {
      selectedColor = cor;
    });
  }

  void getColor() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? cor = await prefs.getString('color');
    setState(() {
      selectedColor = colors[cor];
    });
  }

  @override
  void initState() {
    super.initState();
    getColor();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: selectedColor ?? Colors.orange,
        title: const Text('Theme'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () => {
              Navigator.push(
                context, 
                MaterialPageRoute(builder: (context) => ConfigPage()))
            },
            child: Text('Configurações')
          ),
          for (var entry in colors.entries)
            Container(
              margin: const EdgeInsets.all(10),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: entry.value,
                  minimumSize: const Size(300, 60),
                ),
                child: Text(entry.key),
                onPressed: () => setColor(entry.key, entry.value),
              ),
            ),
        ],
      ),
    );
  }
}