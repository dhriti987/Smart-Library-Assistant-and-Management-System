class NotesModel{
  final int id;
  final String title;
  final String note;
  final String date;

  NotesModel( {required this.id,required this.title, required this.note, required this.date});

  factory NotesModel.fromJson(Map<String,dynamic> data) {
    return NotesModel(id: data['id'], title: data['title'], note: data['content'] ?? "", date: data['last_edited']);
  }

  static List<NotesModel> listFromJson(List<dynamic> list) =>
      List<NotesModel>.from(list.map((e) => NotesModel.fromJson(e)));
}