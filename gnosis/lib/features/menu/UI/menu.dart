import 'package:flutter/material.dart';
import 'package:gnosis/features/Sigin/repository/sign_in_repo.dart';
import 'package:gnosis/models/user_model.dart';
import 'package:gnosis/service_locator.dart';

class MenuPage extends StatelessWidget {
  final UserModel userModel = sl.get<SignInRepository>().getUserData();
  MenuPage({super.key});

  @override
  Widget build(BuildContext context) {
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
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
