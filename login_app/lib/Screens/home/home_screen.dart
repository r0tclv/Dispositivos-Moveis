import 'package:flutter/material.dart';
import 'package:login_app/common/app_routes.dart';
import 'package:login_app/components/selection_card.dart';
import 'package:login_app/models/component_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<ComponentModel> _components = [
    ComponentModel(text: 'Facebook', value: -4.0),
    ComponentModel(text: 'Instagram', value: -5.0),
    ComponentModel(text: 'Twitter', value: -2.0),
    ComponentModel(text: 'LinkedIn', value: 10.0),
    ComponentModel(text: 'TikTok', value: -8.0),
    ComponentModel(text: 'YouTube', value: 12.0),
    ComponentModel(text: 'WhatsApp', value: 3.0),
    ComponentModel(text: 'Telegram', value: 1.0),
  ];

  final List<ComponentModel> _multasTransito = [
    ComponentModel(text: 'Batida (valor auto)', value: -50.0),
    ComponentModel(text: 'Beber e dirigir', value: -100.0),
    ComponentModel(text: 'Excesso de velocidade', value: -30.0),
    ComponentModel(text: 'Dirigir na contramão', value: -80.0),
    ComponentModel(text: 'Sem cinto de segurança', value: -15.0),
    ComponentModel(text: 'Sinal vermelho', value: -25.0),
    ComponentModel(text: 'Ultrapassagem proibida', value: -40.0),
    ComponentModel(text: 'Dirigir sem habilitação', value: -200.0),
  ];

  bool get _hasSelection {
    return _components.any((c) => c.isSelected) ||
        _multasTransito.any((c) => c.isSelected);
  }

  void _handleExit(BuildContext context) {
    if (_hasSelection) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Desmarque as opções para sair')),
      );
    } else {
      Navigator.pushNamedAndRemoveUntil(
        context,
        AppRoutes.login,
        (route) => false,
      );
    }
  }

  Widget _getScreen(int index) {
    switch (index) {
      case 0:
        return SingleChildScrollView(
          child: Column(
            children: [
              SelectionCard(
                title: 'Multas de Trânsito',
                components: _multasTransito,
                onChanged: (updated) {
                  setState(() {
                    _multasTransito
                      ..clear()
                      ..addAll(updated);
                  });
                },
              ),
              SelectionCard(
                components: _components,
                onChanged: (updated) {
                  setState(() {
                    _components
                      ..clear()
                      ..addAll(updated);
                  });
                },
              ),
            ],
          ),
        );
      case 1:
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Spacer(),
              const Center(child: Text('Perfil', style: TextStyle(fontSize: 24))),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => _handleExit(context),
                child: const Text('Sair'),
              ),
              const SizedBox(height: 20),
            ],
          ),
        );
      case 2:
        return const Center(child: Text('Configurações', style: TextStyle(fontSize: 24)));
      default:
        return const SizedBox.shrink();
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (bool didPop, dynamic result) {
        if (didPop) return;
        _handleExit(context);
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Home'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => _handleExit(context),
          ),
        ),
        body: _getScreen(_selectedIndex),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Início'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Perfil'),
            BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Config'),
          ],
        ),
      ),
    );
  }
}
