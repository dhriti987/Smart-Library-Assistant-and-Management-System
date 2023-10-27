import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:gnosis/features/notes_page/repository/notes_repo.dart';
import 'package:gnosis/service_locator.dart';
import 'package:meta/meta.dart';

part 'notes_editor_event.dart';
part 'notes_editor_state.dart';

class NotesEditorBloc extends Bloc<NotesEditorEvent, NotesEditorState> {
  final NotesRepository notesRepository = sl.get<NotesRepository>();
  NotesEditorBloc() : super(NotesEditorInitial()) {
    on<NotesEditorEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<NotesSaveEvent>(notesSaveEvent);
  }

  FutureOr<void> notesSaveEvent(
      NotesSaveEvent event, Emitter<NotesEditorState> emit) async {
    try {
      await notesRepository.updateNote(event.id, event.content);
      emit(NotesEditorSavedActionState());
    } on Exception catch (exception) {
      print(exception);
    }
  }
}
