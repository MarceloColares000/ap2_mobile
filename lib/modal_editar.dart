import 'package:flutter/material.dart';
import 'lista_contato.dart';

class ModalEditar extends StatefulWidget {
  final Contato contato;
  final Function(String, String, String) onEditarContato;

  ModalEditar({required this.contato, required this.onEditarContato});

  @override
  _ModalEditarState createState() => _ModalEditarState();
}

class _ModalEditarState extends State<ModalEditar> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nomeController;
  late TextEditingController _telefoneController;
  late TextEditingController _emailController;

  @override
  void initState() {
    super.initState();
    _nomeController = TextEditingController(text: widget.contato.nome);
    _telefoneController = TextEditingController(text: widget.contato.telefone);
    _emailController = TextEditingController(text: widget.contato.email);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Editar Contato'),
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
              widget.onEditarContato(
                _nomeController.text,
                _telefoneController.text,
                _emailController.text,
              );
              Navigator.of(context).pop();
            }
          },
          child: Text('Salvar'),
        ),
      ],
    );
  }
}
