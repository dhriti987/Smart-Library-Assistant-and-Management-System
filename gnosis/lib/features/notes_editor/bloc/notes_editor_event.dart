part of 'notes_editor_bloc.dart';

@immutable
sealed class NotesEditorEvent {}

class NotesSaveEvent extends NotesEditorEvent{
  final int id;
  final String content;

  NotesSaveEvent({required this.id ,required this.content});
}
