import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SignIn extends StatelessWidget {
  const SignIn({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                'Explore the World of \nBooks',
                style: textTheme.headlineLarge,
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              margin: EdgeInsets.only(left: 40),
              child: Text(
                'Email',
                style: textTheme.labelMedium,
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              margin: EdgeInsets.only(left: 20, right: 20),
              child: TextField(
                decoration: InputDecoration()
                    .applyDefaults(Theme.of(context).inputDecorationTheme)
                    .copyWith(hintText: 'Enter email address'),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              margin: EdgeInsets.only(left: 40),
              child: Text(
                'Password',
                style: textTheme.labelMedium,
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              margin: EdgeInsets.only(left: 20, right: 20),
              child: TextField(
                decoration: InputDecoration()
                    .applyDefaults(Theme.of(context).inputDecorationTheme)
                    .copyWith(hintText: 'Enter password'),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              alignment: Alignment.centerRight,
              margin: EdgeInsets.only(right: 30),
              child: Text(
                'Forget your password?',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
            SizedBox(
              height: 28,
            ),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  context.go('/');
                },
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    'Login',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
