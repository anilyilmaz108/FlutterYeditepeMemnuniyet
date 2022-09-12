import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yeditepe_memnuniyet/components/my_raised_button.dart';
import 'package:yeditepe_memnuniyet/extensions/locale_keys.dart';
import 'package:yeditepe_memnuniyet/services/auth_service.dart';
import 'package:yeditepe_memnuniyet/views/user/language_selected_view.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  bool _isLoading = false;

  Future<void> _signInWithGoogle() async {
    try {
      setState(() {
        _isLoading = true;
      });
      Provider.of<AuthService>(context,listen: false).signInWithGoogle();
    } on FirebaseAuthException catch (e) {
      _showErrorDialog(e.code);
    } catch (e) {
      _showErrorDialog(e.toString());
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100.0),
                      image: DecorationImage(
                        fit: BoxFit.contain,
                        image: AssetImage("assets/images/login.gif",),
                      )
                  ),
                ),
                SizedBox(height: 60,),
                Text(LocaleKeys.login_view_title_1.tr(),style: TextStyle(fontSize: 24, fontWeight: FontWeight.w400),),
                SizedBox(height: 5,),
                Text(LocaleKeys.login_view_title_2.tr(),style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),),
                SizedBox(height: 40,),
                MyRaisedButton(
                  color: Colors.lightBlueAccent,
                  child: Text(LocaleKeys.login_view_title_3.tr(), style: TextStyle(color: Colors.white),),
                  onPressed: ()async{
                    if(_isLoading == true){
                      null;
                    }else{
                      await _signInWithGoogle();
                    }
                  },
                ),
              ],
            ),
          ),
          appBar(context),
        ],
      ),
    );
  }

  Future<void> _showErrorDialog(String errorText) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(LocaleKeys.login_view_error.tr()),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(errorText),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(LocaleKeys.login_view_ok.tr()),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Positioned appBar(BuildContext context) {
    return Positioned(
      top: MediaQuery.of(context).size.height * 0.05,
      right: MediaQuery.of(context).size.width * 0.05,
      child: IconButton(
        onPressed: ()async{
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => LanguageSelectedView()),
          );
        },
        icon: Icon(Icons.settings),
      ),
    );
  }
}
