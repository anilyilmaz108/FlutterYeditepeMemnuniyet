import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yeditepe_memnuniyet/extensions/locale_keys.dart';
import 'package:yeditepe_memnuniyet/services/auth_service.dart';
import 'package:yeditepe_memnuniyet/views/user/language_selected_view.dart';
import 'package:yeditepe_memnuniyet/views/user/splash_view.dart';

class InformationView extends StatelessWidget {
  const InformationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(14.0),
                child: Container(
                  child: Container(
                    padding: EdgeInsets.all(8.0),
                    height: MediaQuery.of(context).size.height * 0.3,
                    width: MediaQuery.of(context).size.height * 0.3,
                    child: Center(
                      child: Icon(Icons.check_circle, color: Colors.white, size: 75,),
                    ),
                    decoration: BoxDecoration(
                      color: Colors.green,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.white30,
                        width: 18,
                      ),
                    ),
                  ),
                  height: MediaQuery.of(context).size.height * 0.3,
                  width: MediaQuery.of(context).size.height * 0.3,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.greenAccent,
                    border: Border.all(
                      color: Colors.white70,
                      width: 18,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15.0),
                child: Center(child: Text(LocaleKeys.information_view_title_1.tr(), style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400))),
              ),
            ],
          ),
          appBar(context),
        ],
      )
    );
  }

  Positioned appBar(BuildContext context) {
    return Positioned(
      top: MediaQuery.of(context).size.height * 0.05,
      right: MediaQuery.of(context).size.width * 0.05,
      child: Row(
        children: [
          IconButton(
            onPressed: ()async{
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LanguageSelectedView()),
              );
            },
            icon: Icon(Icons.settings),
          ),
          IconButton(
            onPressed: ()async{
              await Provider.of<AuthService>(context,listen: false).SignOut();
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => SplashView(

                )),
                    (Route<dynamic> route) => false,
              );
            },
            icon: Icon(Icons.exit_to_app, color: Colors.black87,),
          ),
        ],
      ),
    );
  }

}
