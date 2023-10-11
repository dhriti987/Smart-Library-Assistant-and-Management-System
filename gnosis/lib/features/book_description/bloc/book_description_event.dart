part of 'book_description_bloc.dart';

@immutable
sealed class BookDescriptionEvent {}

class EPubFileClickedEvent extends BookDescriptionEvent{}