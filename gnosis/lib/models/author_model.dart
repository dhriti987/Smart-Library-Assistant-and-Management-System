class AuthorModel {
  final String name;
  final String bio;
  final String dob;
  final String wikiLink;
  final String imgURL;

  AuthorModel(
      {required this.name,
      required this.bio,
      required this.dob,
      required this.wikiLink,
      required this.imgURL});

  factory AuthorModel.fromJson(Map<String, dynamic> data) {
    return AuthorModel(
      name: data['name'],
      bio: data['bio'],
      dob: data['date_of_birth'],
      wikiLink: data['wiki_link'],
      imgURL: data['img_url'],
    );
  }

  static List<AuthorModel> listFromJson(List<dynamic> list) =>
      List.from(list.map((e) => AuthorModel.fromJson(e)));
}
