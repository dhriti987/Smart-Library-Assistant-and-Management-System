class BookModel {
  final int id;
  final String title;
  final String isbn;
  final String description;
  final int ratings;
  final String publisher;
  final String year;
  final int copies;
  final String location;
  final String imgUrl;
  final String? bookFile;
  final List<String> category;
  final List<String> author;

  BookModel( 
      {required this.id,
      required this.title,
      required this.isbn,
      required this.description,
      required this.ratings,
      required this.publisher,
      required this.year,
      required this.copies,
      required this.location,
      required this.imgUrl,
      required this.bookFile,
      required this.category,
      required this.author});

  factory BookModel.fromJson(Map<String, dynamic> data) {
    return BookModel(
      id: data['id'],
      title: data['title'],
      isbn: data['isbn'],
      description: data['description'],
      ratings: data['number_of_ratings'],
      publisher: data['publisher'],
      year: data['year'],
      copies: data['copies'],
      location: data['location'],
      imgUrl: data['img_url'],
      bookFile: data['file'],
      category: (data['category'] as List).cast<String>(),
      author: (data['author'] as List).cast<String>(),
    );
  }

  static List<BookModel> listFromJson(List<dynamic> list) =>
      List<BookModel>.from(list.map((e) => BookModel.fromJson(e)));
}
