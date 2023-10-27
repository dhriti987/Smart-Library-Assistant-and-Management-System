part of 'notes_bloc.dart';

@immutable
sealed class NotesState {}

sealed class NotesActionSTate extends NotesState {}

final class NotesInitial extends NotesState {}

class NotesLoadingState extends NotesState {}

class NotesErrorState extends NotesState {}

class NotesSuccessState extends NotesState {
  final List<NotesModel> notes;

  NotesSuccessState({required this.notes});
}

class NoteCreateState extends NotesActionSTate {
  final NotesModel note;

  NoteCreateState({required this.note});
}

class GetNewNoteNameState extends NotesActionSTate {}

class ViewNoteActionState extends NotesActionSTate {
  final NotesModel notesModel;

  ViewNoteActionState({required this.notesModel});
}

class NoteDeletedState extends NotesState {
  final int index;

  NoteDeletedState({required this.index});
}
