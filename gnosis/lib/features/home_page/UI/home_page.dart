import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    final topList = ['Genres', 'Top Reted', 'New Launched'];
    final bookList = {
      "Twilight":
          "https://upload.wikimedia.org/wikipedia/en/1/1d/Twilightbook.jpg",
      "New Moon":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT3rth1CWmpkN0g-lVufd4QY_hRS6xdiHyFzw&usqp=CAU",
      "Eclipse":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSe3TSolpYt9IkUJ_4khLVzgQTAjqxpLBCjww&usqp=CAU",
      "Breacking Dawn":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTNyIfU76bSSz1VFrXE26ZsC5lUvenduUGC6A&usqp=CAU",
      "Midnight Sun":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSy8XZf4jxPUTA3wlFKIpG2DsQK1EOb6ykofg&usqp=CAU",
    };
    return Scaffold(
      body: Container(
        height: double.maxFinite,
        width: double.maxFinite,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/video/library_bg_gif.gif'),
            fit: BoxFit.cover,
          ),
        ),
        child: ListView(
          children: [
            Container(
              margin: EdgeInsets.only(
                top: 20,
              ),
              padding: EdgeInsets.only(left: 20),
              width: double.maxFinite,
              height: 30,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: topList.length,
                separatorBuilder: (BuildContext context, int index) => SizedBox(
                  width: 20,
                ),
                itemBuilder: (BuildContext context, int index) {
                  return ElevatedButton(
                      onPressed: () {}, child: Text(topList[index]));
                },
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: double.maxFinite,
              padding: EdgeInsets.only(left: 20),
              color: Colors.white10,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Text(
                      'Recommended for you',
                      style: textTheme.headlineMedium,
                    ),
                  ),
                  Container(
                    child: Text(
                      'Based on your reading',
                      style: textTheme.labelMedium,
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              padding: EdgeInsets.only(left: 20),
              width: double.maxFinite,
              height: 230,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: bookList.length,
                separatorBuilder: (BuildContext context, int index) => SizedBox(
                  width: 10,
                ),
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    child: Column(
                      children: [
                        Container(
                          width: 130,
                          height: 180,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                              image: NetworkImage(
                                  bookList.values.elementAt(index)),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          bookList.keys.elementAt(index),
                          style: textTheme.labelMedium,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 20, top: 5, bottom: 5),
              color: Colors.white10,
              width: double.maxFinite,
              child: Text(
                'New Launched',
                style: textTheme.headlineMedium,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              padding: EdgeInsets.only(left: 20),
              width: double.maxFinite,
              height: 230,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: bookList.length,
                separatorBuilder: (BuildContext context, int index) => SizedBox(
                  width: 10,
                ),
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    child: Column(
                      children: [
                        Container(
                          width: 130,
                          height: 180,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                              image: NetworkImage(
                                  bookList.values.elementAt(index)),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          bookList.keys.elementAt(index),
                          style: textTheme.labelMedium,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
