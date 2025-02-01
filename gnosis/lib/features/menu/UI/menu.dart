import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gnosis/features/Sigin/repository/sign_in_repo.dart';
import 'package:gnosis/features/menu/bloc/menu_bloc.dart';
import 'package:gnosis/models/user_model.dart';
import 'package:gnosis/service_locator.dart';
import 'package:go_router/go_router.dart';

class MenuPage extends StatelessWidget {
  final UserModel userModel = sl.get<SignInRepository>().getUserData();
  final MenuBloc menuBloc = sl.get<MenuBloc>();
  MenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MenuBloc, MenuState>(
      bloc: menuBloc,
      listenWhen: (previous, current) => current is MenuActionState,
      buildWhen: (previous, current) => current is! MenuActionState,
      listener: (context, state) {
        if (state is GoToSignInPageMenuActionState) {
          context.go('/');
          
        }
      },
      builder: (context, state) {
        return Drawer(
          width: 250,
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: BoxDecoration(color: Colors.grey),
                child: UserAccountsDrawerHeader(
                  decoration: BoxDecoration(color: Colors.grey),
                  accountName: Text(
                    userModel.name,
                    style: TextStyle(fontSize: 18),
                  ),
                  accountEmail: Text(userModel.email),
                  currentAccountPictureSize: Size.square(50),
                  currentAccountPicture: CircleAvatar(
                    backgroundColor: Color.fromARGB(250, 205, 97, 129),
                    child: Text(
                      userModel.name[0],
                      style: TextStyle(color: Colors.white, fontSize: 30),
                    ),
                  ),
                ),
              ),
              ListTile(
                title: const Text(
                  ' Profile ',
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {},
              ),
              ListTile(
                title: const Text(
                  ' Saved Books ',
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {},
              ),
              ListTile(
                title: const Text(
                  ' Notification ',
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {},
              ),
              ListTile(
                title: const Text(
                  ' Settings ',
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {},
              ),
              ListTile(
                title: const Text(
                  ' Logout ',
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {
                  menuBloc.add(LogoutMenuEvent());
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
