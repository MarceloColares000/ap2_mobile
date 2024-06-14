import 'package:flutter/material.dart';
import 'modal_adicionar.dart';
import 'modal_editar.dart';

class PaginaListaContatos extends StatefulWidget {
  @override
  _PaginaListaContatosState createState() => _PaginaListaContatosState();
}

class _PaginaListaContatosState extends State<PaginaListaContatos> {
  final List<Contato> contatos = [];

  void _adicionarContato(String nome, String telefone, String email) {
    setState(() {
      contatos.add(Contato(nome: nome, telefone: telefone, email: email));
    });
  }

  void _editarContato(int index, String nome, String telefone, String email) {
    setState(() {
      contatos[index] = Contato(nome: nome, telefone: telefone, email: email);
    });
  }

  void _deletarContato(int index) {
    setState(() {
      contatos.removeAt(index);
    });
  }

  void _confirmarDelecaoContato(int index) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Confirmar Deleção'),
          content: Text('Você tem certeza que deseja deletar este contato?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () {
                _deletarContato(index);
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Contato apagado com sucesso!'),
                    duration: Duration(seconds: 2),
                  ),
                );
              },
              child: Text('Deletar'),
            ),
          ],
        );
      },
    );
  }

  void _mostrarModalAdicionar() {
    showDialog(
      context: context,
      builder: (context) {
        return ModalAdicionar(onAdicionarContato: _adicionarContato);
      },
    );
  }

  void _mostrarModalEditar(int index) {
    showDialog(
      context: context,
      builder: (context) {
        return ModalEditar(
          contato: contatos[index],
          onEditarContato: (nome, telefone, email) {
            _editarContato(index, nome, telefone, email);
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Agenda de Contatos'),
      ),
      body: ListView.builder(
        itemCount: contatos.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(contatos[index].nome),
            subtitle: Text(
              'Telefone: ${contatos[index].telefone}\nEmail: ${contatos[index].email}',
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () => _mostrarModalEditar(index),
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () => _confirmarDelecaoContato(index),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _mostrarModalAdicionar,
        child: Icon(Icons.add),
      ),
    );
  }
}

class Contato {
  final String nome;
  final String telefone;
  final String email;

  Contato({required this.nome, required this.telefone, required this.email});
}
