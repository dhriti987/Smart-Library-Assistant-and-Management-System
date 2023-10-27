part of 'notes_bloc.dart';

@immutable
sealed class NotesEvent {}

class NotesFetchEvent extends NotesEvent {}

class CreateNewNoteButtonClickedEvent extends NotesEvent {}

class CreateNewNoteEvent extends NotesEvent {
  final String noteName;

  CreateNewNoteEvent({required this.noteName});
}

class NoteClickedEvent extends NotesEvent {
  final NotesModel notesModel;

  NoteClickedEvent({required this.notesModel});
}
class NoteDeleteEvent extends NotesEvent {
  final int id;
  final int index;

  NoteDeleteEvent({required this.id, required this.index});

}
