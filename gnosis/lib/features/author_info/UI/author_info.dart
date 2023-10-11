import 'package:flutter/material.dart';
import 'package:gnosis/models/author_model.dart';

class AuthorInfo extends StatefulWidget {
  const AuthorInfo({super.key});

  @override
  State<AuthorInfo> createState() => _AuthorInfoState();
}

class _AuthorInfoState extends State<AuthorInfo> {
  List<AuthorModel> authorList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromARGB(255, 0, 40, 73),
              Color.fromARGB(255, 0, 20, 39),
            ],
          ),
        ),
        child: ListView.builder(
          itemCount: 1,
          itemBuilder: (context, index) {
            return Column(
              children: [
                Container(
                  width: 100,
                  height: 100,
                  alignment: Alignment.topCenter,
                  margin: EdgeInsets.only(top: 30),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(50),
                    ),
                    image: DecorationImage(
                      image: NetworkImage(
                        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSoEUc7Lz7xKxzYnhcVATENskw88eWliB0YUw&usqp=CAU',
                      ),
                      fit: BoxFit.cover
                    ),
                  ),
                ),
                SizedBox(height: 15,),
                Text(
                  'John Grisham',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20),
                ),
              ],
            );
          },
        ),
      ),
      extendBodyBehindAppBar: true,
    );
  }
}
