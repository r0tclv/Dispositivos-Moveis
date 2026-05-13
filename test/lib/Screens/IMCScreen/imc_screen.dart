import 'package:flutter/material.dart';

class IMCScreen extends StatefulWidget {
  const IMCScreen({super.key});

  @override
  State<IMCScreen> createState() => _IMCScreenState();
}

class _IMCScreenState extends State<IMCScreen> {
  int _value = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tela IMC')),
      body: Center(
  child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text("valor: $_value"),
      const SizedBox(height: 20),
      ElevatedButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: const Text('Voltar para Tela Inicial'),
      ),
    ],
  ),
),
      floatingActionButton: FloatingActionButton(
        onPressed: incValue,
        child: const Icon(Icons.add),
      ),
    );
  }

  void incValue() {
    setState(() {
      _value++;
    });
  }
}