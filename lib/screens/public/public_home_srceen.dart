import 'package:borderlessWorking/bloc/auth_bloc/auth.dart';
import 'package:borderlessWorking/data/repositories/auth_repositories.dart';
import 'package:borderlessWorking/screens/auth/login_screen.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:borderlessWorking/style/theme.dart' as Style;
import 'package:get/get.dart';

class PublicHome extends StatelessWidget {
  final AuthRepository authRepository;
  PublicHome({Key key, @required this.authRepository}) : super(key: key);

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Style.Colors.mainColor,
        actions: <Widget>[
          FlatButton(
            textColor: Colors.white,
            onPressed: () {
              Get.to(() => LoginScreen(authRepository: authRepository));
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //         builder: (_) =>
              //             LoginScreen(authRepository: authRepository)));
            },
            child: Text("login"),
          ),
        ],
      ),
      body: Center(
        child: Text('Home Page'),
      ),
    );
  }
}
