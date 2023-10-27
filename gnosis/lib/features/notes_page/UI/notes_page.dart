import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gnosis/features/notes_page/bloc/notes_bloc.dart';
import 'package:gnosis/models/notes_model.dart';
import 'package:gnosis/service_locator.dart';
import 'package:go_router/go_router.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({super.key});

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  final NotesBloc notesBloc = sl.get<NotesBloc>();

  final TextEditingController _fileNameController = TextEditingController();

  List<NotesModel> notes = [];

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Container(
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
      child: BlocConsumer<NotesBloc, NotesState>(
        bloc: notesBloc,
        listenWhen: (previous, current) => current is NotesActionSTate,
        buildWhen: (previous, current) => current is! NotesActionSTate,
        listener: (context, state) async {
          if (state is GetNewNoteNameState) {
            _displayTextInputDialog(context);
          }
          if (state is NoteCreateState) {
            context
                .push('/note_editor', extra: state.note)
                .then((value) => notesBloc.add(NotesFetchEvent()));
          }
          if (state is ViewNoteActionState) {
            context
                .push('/note_reader', extra: state.notesModel)
                .then((value) => notesBloc.add(NotesFetchEvent()));
          }
        },
        builder: (context, state) {
          if (state is NotesInitial) {
            notesBloc.add(NotesFetchEvent());
          }
          if (state is NotesLoadingState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is NotesSuccessState) {
            notes = state.notes;
          }
          if(state is NoteDeletedState){
            print('deleted');
            notes.removeAt(state.index);
          }

          return Stack(children: [
            ListView.builder(
                itemBuilder: (context, index) => Dismissible(
                      key: UniqueKey(),
                      onDismissed: (direction) => notesBloc.add(
                          NoteDeleteEvent(id: notes[index].id, index: index)),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Material(
                          color: Colors.transparent,
                          child: ListTile(
                            tileColor: Color.fromARGB(255, 3, 50, 91),
                            title: Text(notes[index].title),
                            subtitle: Text(notes[index].date),
                            titleTextStyle: textTheme.labelLarge,
                            subtitleTextStyle: textTheme.labelSmall,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            onTap: () => notesBloc.add(
                                NoteClickedEvent(notesModel: notes[index])),
                          ),
                        ),
                      ),
                    ),
                itemCount: notes.length),
            Positioned(
                bottom: 20,
                right: 20,
                child: FloatingActionButton(
                  onPressed: () {
                    notesBloc.add(CreateNewNoteButtonClickedEvent());
                  },
                  child: Icon(Icons.add),
                )),
          ]);
        },
      ),
    );
  }

  Future<void> _displayTextInputDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Enter Notes Title'),
          content: TextField(
            controller: _fileNameController,
            decoration: InputDecoration(hintText: "Project Notes"),
          ),
          actions: <Widget>[
            ElevatedButton(
              child: Text('CANCEL'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            ElevatedButton(
              child: Text('OK'),
              onPressed: () {
                notesBloc.add(
                    CreateNewNoteEvent(noteName: _fileNameController.text));
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}
