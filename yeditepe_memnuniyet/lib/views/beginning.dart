import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yeditepe_memnuniyet/services/auth_service.dart';
import 'package:yeditepe_memnuniyet/views/admin/chart_view.dart';
import 'package:yeditepe_memnuniyet/views/user/home_view.dart';
import 'package:yeditepe_memnuniyet/views/user/login_view.dart';

class Beginning extends StatefulWidget {
  @override
  _BeginningState createState() => _BeginningState();
}

class _BeginningState extends State<Beginning> {
  bool isLogged = true;
  String? admin = 'anilyilmaz108@gmail.com';
  bool isAdmin = false;
  @override
  void initState() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
        setState(() {
          isLogged = false;
          isAdmin = false;
        });
      } else {
        print('User is signed in!');
        if (user.email == '$admin') {
          print('Admin is signed in!');
          setState(() {
            isLogged = true;
            isAdmin = true;
          });
        }else{
          setState(() {
            isLogged = true;
            isAdmin = false;
          });
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
        stream: Provider.of<AuthService>(context, listen: false).authStatus(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            return snapshot.data != null
                ? isAdmin == true
                    ? ChartView()
                    : HomeView()
                : LoginView();
          } else {
            return SizedBox(
              width: 300,
              height: 300,
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}
