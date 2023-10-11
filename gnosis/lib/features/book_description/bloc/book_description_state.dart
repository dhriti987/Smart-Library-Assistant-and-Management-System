part of 'book_description_bloc.dart';

@immutable
sealed class BookDescriptionState {}

abstract class BookDescriptionActionState extends BookDescriptionState{}

final class BookDescriptionInitial extends BookDescriptionState {}

class BookDescriptionSuccessState extends BookDescriptionState{}

class BookDescriptionPageToEPubFileActionState extends BookDescriptionActionState{}