import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gnosis/features/notes_editor/bloc/notes_editor_bloc.dart';
import 'package:gnosis/models/notes_model.dart';
import 'package:html_editor_enhanced/html_editor.dart';

class NotesEditor extends StatelessWidget {
  final NotesModel note;
  NotesEditor({super.key, required this.note});

  final HtmlEditorController _htmlEditorController = HtmlEditorController();
  final NotesEditorBloc notesEditorBloc = NotesEditorBloc();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NotesEditorBloc, NotesEditorState>(
      bloc: notesEditorBloc,
      listenWhen: (previous, current) => current is NotesEditorActionState,
      buildWhen: (previous, current) => current is! NotesEditorActionState,
      listener: (context, state) {
        if(state is NotesEditorSavedActionState){
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Notes is Saved")));
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Color.fromARGB(255, 0, 40, 73),
            title: Text(
              note.title,
              overflow: TextOverflow.fade,
            ),
            centerTitle: true,
            actions: [
              IconButton(
                  onPressed: () async {
                    final content = await _htmlEditorController.getText();
                    print(content);
                    notesEditorBloc.add(NotesSaveEvent(id: note.id,content: content));
                  },
                  icon: Icon(Icons.save))
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
            child: HtmlEditor(
              controller: _htmlEditorController,
              htmlEditorOptions: HtmlEditorOptions(darkMode: true, initialText: note.note),
              htmlToolbarOptions:
                  HtmlToolbarOptions(textStyle: TextStyle(color: Colors.white)),
              otherOptions: OtherOptions(
                  height: MediaQuery.of(context).size.height - 100),
            ),
          ),
        );
      },
    );
  }
}
