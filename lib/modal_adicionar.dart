import 'package:flutter/material.dart';

class ModalAdicionar extends StatefulWidget {
  final Function(String, String, String) onAdicionarContato;

  ModalAdicionar({required this.onAdicionarContato});

  @override
  _ModalAdicionarState createState() => _ModalAdicionarState();
}

class _ModalAdicionarState extends State<ModalAdicionar> {
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _telefoneController = TextEditingController();
  final _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Adicionar Contato'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _nomeController,
              decoration: InputDecoration(labelText: 'Nome'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor, insira um nome';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _telefoneController,
              decoration: InputDecoration(labelText: 'Telefone'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor, insira um telefone';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor, insira um email';
                }
                return null;
              },
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Cancelar'),
        ),
        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              widget.onAdicionarContato(
                _nomeController.text,
                _telefoneController.text,
                _emailController.text,
              );
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Contato cadastrado com sucesso!'),
                  duration: Duration(seconds: 2),
                ),
              );
            }
          },
          child: Text('Adicionar'),
        ),
      ],
    );
  }
}
