import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gnosis/features/Sigin/bloc/signin_bloc.dart';
import 'package:gnosis/service_locator.dart';
import 'package:go_router/go_router.dart';

class SignIn extends StatelessWidget with ValidationMixin {
  SignIn({super.key});

  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  final formGlobalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    final SigninBloc signinBloc = sl<SigninBloc>();

    return BlocConsumer<SigninBloc, SigninState>(
      bloc: signinBloc,
      listenWhen: (previous, current) => current is SigninActionState,
      buildWhen: (previous, current) => current is! SigninActionState,
      listener: (context, state) {
        if (state is SigninToHomePageActionState) {
          context.go('/');
        }
        if (state is SigninToForgotPasswordPageActionState) {
          // Navigator.push(context,
          //     MaterialPageRoute(builder: ((context) => ForgotPassword())));
          context.go('/forgot_password');
        }
        if (state is SigninErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Error Occured!"),
              duration: Duration(seconds: 2),
              behavior: SnackBarBehavior.floating,
              backgroundColor: Colors.white,
              padding: EdgeInsets.all(10),
            ),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: Container(
            height: double.maxFinite,
            width: double.maxFinite,
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
            child: Form(
              key: formGlobalKey,
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
                    height: 20,
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 40),
                    child: Text(
                      'Email',
                      style: textTheme.labelMedium,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 20, right: 20),
                    child: TextFormField(
                      controller: emailController,
                      validator: (email) {
                        if (isEmailValid(email!)) {
                          return null;
                        } else {
                          return 'Email address is not valid';
                        }
                      },
                      decoration: InputDecoration()
                          .applyDefaults(Theme.of(context).inputDecorationTheme)
                          .copyWith(
                            hintText: 'Enter email address',
                            // errorText: emailController.text.isEmpty || RegExp(emailController.text) == RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                            //     ? "Enter a valid email address"
                            //     : null,
                          ),
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
                    height: 10,
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 20, right: 20),
                    child: TextFormField(
                      controller: passwordController,
                      obscureText: true,
                      validator: (password) {
                        if (isPasswordValid(password!)) {
                          return null;
                        } else {
                          return 'Password length is short.';
                        }
                      },
                      decoration: InputDecoration()
                          .applyDefaults(Theme.of(context).inputDecorationTheme)
                          .copyWith(
                            hintText: 'Enter password',
                            // errorText: passwordController.text.length < 6 ||
                            //         passwordController.text.isEmpty
                            //     ? "Password must be at least 6 charaters"
                            //     : null,
                          ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    alignment: Alignment.centerRight,
                    margin: EdgeInsets.only(right: 30),
                    child: TextButton(
                      onPressed: () {
                        signinBloc.add(ForgotPasswordClickedEvent());
                      },
                      child: Text(
                        'Forget your password?',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        // context.go('/');
                        if (formGlobalKey.currentState!.validate()) {
                          formGlobalKey.currentState!.save();
                          signinBloc.add(SignInButtonClickedEvent(
                            email: emailController.text,
                            password: passwordController.text,
                          ));
                        }
                        // signinBloc.add(SignInButtonClickedEvent(
                        //   email: emailController.text,
                        //   password: passwordController.text,
                        // ));
                      },
                      child: Container(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          'Login',
                          style: textTheme.labelLarge,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

mixin ValidationMixin {
  bool isPasswordValid(String inputpassword) => inputpassword.length >= 6;

  bool isEmailValid(String inputemail) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))';
    RegExp regexp = RegExp(pattern.toString());
    return regexp.hasMatch(inputemail);
  }
}
