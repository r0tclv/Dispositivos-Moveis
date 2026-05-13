import 'package:flutter/material.dart';
import 'package:login_app/components/selection_card.dart';
import 'package:login_app/models/component_model.dart';

class Page1Screen extends StatefulWidget {
  const Page1Screen({super.key});

  @override
  State<Page1Screen> createState() => _Page1ScreenState();
}

class _Page1ScreenState extends State<Page1Screen> {
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

  Future<bool> _checkCanPop() async {
    final hasSelection = _components.any((c) => c.isSelected);
    if (hasSelection) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Desmarque as opções para voltar')),
          );
        }
      });
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (bool didPop, dynamic result) async {
        if (didPop) return;
        final canPop = await _checkCanPop();
        if (canPop && context.mounted) {
          Navigator.pop(context);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () async {
              final canPop = await _checkCanPop();
              if (canPop && context.mounted) {
                Navigator.pop(context);
              }
            },
          ),
        ),
        body: SingleChildScrollView(
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
        ),
      ),
    );
  }
}
