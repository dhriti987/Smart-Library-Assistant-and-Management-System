import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gnosis/features/forgot_password/bloc/forgot_password_bloc.dart';
import 'package:gnosis/service_locator.dart';
import 'package:go_router/go_router.dart';

class ForgotPassword extends StatelessWidget {
  ForgotPassword({super.key});
  final otpController = TextEditingController();
  final forgotEmailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    final ForgotPasswordBloc forgotPasswordBloc = sl<ForgotPasswordBloc>();

    return BlocConsumer<ForgotPasswordBloc, ForgotPasswordState>(
      bloc: forgotPasswordBloc,
      listenWhen: (previous, current) => current is ForgotPasswordActionState,
      buildWhen: (previous, current) => current is! ForgotPasswordActionState,
      listener: (context, state) {
        // TODO: implement listener
        if (state is ForgotPasswordToHomePageActionState) {
          context.go('/');
        }
      },
      builder: (context, state) {
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
                    'Forgot Password',
                    style: textTheme.headlineLarge,
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Container(
                  margin: EdgeInsets.only(left: 20, right: 20),
                  child: TextField(
                    controller: forgotEmailController,
                    decoration: InputDecoration()
                        .applyDefaults(Theme.of(context).inputDecorationTheme)
                        .copyWith(hintText: 'Enter email address or number'),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Container(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        'Send OTP',
                        style: textTheme.labelLarge,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  margin: EdgeInsets.only(left: 20, right: 20),
                  child: TextField(
                    controller: otpController,
                    decoration: InputDecoration()
                        .applyDefaults(Theme.of(context).inputDecorationTheme)
                        .copyWith(hintText: 'Enter your OTP'),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      forgotPasswordBloc.add(LoginButtonClickedEvent());
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
        );
      },
    );
  }
}
