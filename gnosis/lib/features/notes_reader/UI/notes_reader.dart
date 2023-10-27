import 'package:flutter/material.dart';
import 'package:gnosis/models/notes_model.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:go_router/go_router.dart';


class NotesReader extends StatelessWidget {
  final NotesModel note;
  const NotesReader({super.key, required this.note});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 0, 40, 73),
        title: Text(
          note.title,
          overflow: TextOverflow.fade,
        ),
        centerTitle: true,
        actions: [
          IconButton(onPressed: () {
            context.push('/note_editor', extra: note).then((value) => context.pop());
          }, icon: Icon(Icons.edit))
        ],
      ),
      body: Container(
        height: double.maxFinite,
        width: double.maxFinite,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromARGB(255, 0, 40, 73),
              Color.fromARGB(255, 0, 20, 39),
            ],
          ),
        ),
        child: SingleChildScrollView(
          child: Html(
            data: note.note,
          ),
        ),
      ),
    );
  }
}
