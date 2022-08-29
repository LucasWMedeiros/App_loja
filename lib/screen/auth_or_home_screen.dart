import 'package:app_loja/models/auth.dart';
import 'package:app_loja/screen/auth_screen.dart';
import 'package:app_loja/screen/produtcs_overview_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

class AuthOrHomeScreen extends StatelessWidget {
  const AuthOrHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Auth auth = Provider.of(context);

    // return auth.isAuth ? ProductsOverviewScreen() : authScreen();
    return FutureBuilder(
      future: auth.tryAutoLogin(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.error != null) {
          return const Center(
            child: Text('Ocorreu um erro!'),
          );
        } else {
          return auth.isAuth ? ProductsOverviewScreen() : authScreen();
        }
      },
    );
  }
}
