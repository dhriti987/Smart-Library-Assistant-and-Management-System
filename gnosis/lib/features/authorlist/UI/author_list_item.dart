import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:gnosis/core/services/api_service.dart';
import 'package:gnosis/features/authorlist/repository/author_list_repo.dart';
import 'package:gnosis/models/author_model.dart';
import 'package:gnosis/service_locator.dart';

class AuthorListItem extends StatelessWidget {
  final AuthorModel author;
  final AuthorListRepository authorListRepo =
      AuthorListRepository(apiService: sl.get<ApiService>());
  AuthorListItem({super.key, required this.author});

  @override
  Widget build(BuildContext context) {
    Size windowSize = MediaQuery.of(context).size;
    Size widgetSize = Size(windowSize.width/2, windowSize.width*(3/2));
    return Container(
      color: Colors.blue,
      margin: const EdgeInsets.all(5),
      child: Stack(children: [
        FutureBuilder(
          future: authorListRepo.getImage(author.imgURL),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return CircleAvatar(
                  backgroundColor: Colors.red,
                  radius: widgetSize.width / 2,
                  child: CircleAvatar(
                    backgroundImage:
                        Image.memory(snapshot.data ?? Uint8List(0)).image,
                    radius: widgetSize.width / 2 - 15,
                  ));
            }
            return CircleAvatar(radius: widgetSize.width/2,child: const CircularProgressIndicator(),);
          },
        )
      ]),
    );
  }
}
