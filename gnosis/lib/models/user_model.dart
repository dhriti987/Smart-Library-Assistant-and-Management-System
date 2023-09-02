
class UserModel{
  final String name;
  final String email;

  UserModel({required this.name, required this.email});

  factory UserModel.fromJson(Map<String,dynamic> data){
    return UserModel(name: data['name'], email: data['email']);
  }

}