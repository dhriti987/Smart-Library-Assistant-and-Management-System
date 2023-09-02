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
  final String? boolFile;
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
      required this.boolFile,
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
      boolFile: data['file'],
      category: data['catagory'],
      author: data['author']
    );
  }
}
