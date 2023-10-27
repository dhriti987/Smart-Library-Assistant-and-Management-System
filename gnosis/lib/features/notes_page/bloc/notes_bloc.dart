import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:gnosis/features/notes_page/repository/notes_repo.dart';
import 'package:gnosis/models/notes_model.dart';
import 'package:gnosis/service_locator.dart';
import 'package:meta/meta.dart';

part 'notes_event.dart';
part 'notes_state.dart';

class NotesBloc extends Bloc<NotesEvent, NotesState> {
  final NotesRepository notesRepository = sl.get<NotesRepository>();

  NotesBloc() : super(NotesInitial()) {
    on<NotesEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<CreateNewNoteButtonClickedEvent>(createNewNoteButtonClickedEvent);
    on<CreateNewNoteEvent>(createNewNoteEvent);
    on<NotesFetchEvent>(notesFetchEvent);
    on<NoteClickedEvent>(noteClickedEvent);
    on<NoteDeleteEvent>(noteDeleteEvent);
  }

  FutureOr<void> createNewNoteButtonClickedEvent(
      CreateNewNoteButtonClickedEvent event, Emitter<NotesState> emit) {
    emit(GetNewNoteNameState());
  }

  FutureOr<void> createNewNoteEvent(
      CreateNewNoteEvent event, Emitter<NotesState> emit) async {
    try {
      NotesModel note = await notesRepository.createNewNote(event.noteName);
      emit(NoteCreateState(note: note));
    } catch (e) {
      print(e);
    }
  }

  FutureOr<void> notesFetchEvent(
      NotesFetchEvent event, Emitter<NotesState> emit) async {
    emit(NotesLoadingState());
    try {
      final data = await notesRepository.getAllNotes();
      emit(NotesSuccessState(notes: data));
    } on Exception catch (e) {
      print(e);
    }
  }

  FutureOr<void> noteClickedEvent(NoteClickedEvent event, Emitter<NotesState> emit) {
    emit(ViewNoteActionState(notesModel: event.notesModel));
  }

  FutureOr<void> noteDeleteEvent(NoteDeleteEvent event, Emitter<NotesState> emit) async{
    await notesRepository.deleteNote(event.id);
    emit(NoteDeletedState(index: event.index));
  }
}
