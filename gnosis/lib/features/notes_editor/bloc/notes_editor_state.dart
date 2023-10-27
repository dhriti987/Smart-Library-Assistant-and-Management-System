part of 'notes_editor_bloc.dart';

@immutable
sealed class NotesEditorState {}
sealed class NotesEditorActionState extends NotesEditorState {}

final class NotesEditorInitial extends NotesEditorState {}

class NotesEditorSavedActionState extends NotesEditorActionState {}
