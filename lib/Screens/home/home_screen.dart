import 'package:flutter/material.dart';

class IMCScreen extends StatefulWidget {
  @override
  State<IMCScreen> createState() => _IMCScreenState();
}

class _IMCScreenState extends State<IMCScreen> {
  int _value = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tela IMC')),
      body: Center(child: Text("valor: $_value")),
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