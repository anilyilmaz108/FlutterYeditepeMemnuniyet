import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:yeditepe_memnuniyet/constants.dart';
import 'package:yeditepe_memnuniyet/extensions/locale_keys.dart';
import 'package:yeditepe_memnuniyet/models/user_model.dart';
import 'package:yeditepe_memnuniyet/services/auth_service.dart';
import 'package:yeditepe_memnuniyet/services/database_service.dart';
import 'package:provider/provider.dart';
import 'package:yeditepe_memnuniyet/services/notification_service.dart';
import 'package:yeditepe_memnuniyet/views/user/complaint_selected_view.dart';
import 'package:yeditepe_memnuniyet/views/user/information_view.dart';
import 'package:yeditepe_memnuniyet/views/user/language_selected_view.dart';
import 'package:yeditepe_memnuniyet/views/user/splash_view.dart';


class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late TextEditingController _descriptionController;
  String _status = "Orta";
  static List<Widget> _widgetOptions = <Widget>[
    Icon(
      Icons.sentiment_very_dissatisfied,
      color: Colors.red,
    ),
    Icon(
      Icons.sentiment_dissatisfied,
      color: Colors.redAccent,
    ),
    Icon(
      Icons.sentiment_neutral,
      color: Colors.amber,
    ),
    Icon(
      Icons.sentiment_satisfied,
      color: Colors.lightGreen,
    ),
    Icon(
      Icons.sentiment_very_satisfied,
      color: Colors.green,
    )
  ];




  @override
  void initState() {
    _descriptionController = TextEditingController();
    //Provider.of<NotificationService>(context, listen: false).requestPermission();
    //Provider.of<NotificationService>(context, listen: false).loadFCM();
    //Provider.of<NotificationService>(context, listen: false).listenFCM();
    //getToken();
    //FirebaseMessaging.instance.subscribeToTopic("Satisfaction");
    super.initState();
  }
  @override
  void dispose() {
    _descriptionController = TextEditingController();
    super.dispose();
  }
  @override


  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Column(
                children: [
                  //SizedBox(height: MediaQuery.of(context).size.height * 0.05,),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        width: 90,
                        height: 90,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                          image: DecorationImage(
                            image: AssetImage('assets/images/logo.png'),
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Text(LocaleKeys.home_view_title_1.tr(),style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),),
                  SizedBox(height: 5,),
                  Text(LocaleKeys.home_view_title_2.tr(),style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),),
                  SizedBox(height: 20,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 70.0),
                    child: Center(child: Text(LocaleKeys.home_view_title_3.tr(),style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300),)),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 38.0),
                    child: RatingBar.builder(
                      initialRating: 3,
                      direction: Axis.horizontal,
                      itemCount: 5,
                      itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                      itemBuilder: (context, index){
                        return _widgetOptions.elementAt(index);
                      },
                      onRatingUpdate: (rating) {
                        print('***** $rating');
                        if(rating == 1.0){
                          _status = "Memnun Değil";
                        }
                        else if(rating == 2.0){
                          _status = "Az Memnun";
                        }
                        else if(rating == 3.0){
                          _status = "Orta";
                        }
                        else if(rating == 4.0){
                          _status = "Memnun";
                        }
                        else {
                          _status = "Çok Memnun";
                        }
                      },
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 23.0),
                    child: TextField(
                      controller: _descriptionController,
                      keyboardType: TextInputType.text,
                      minLines: 1,
                      maxLines: 4,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.title),
                        hintText: LocaleKeys.home_view_title_4.tr(),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 23.0, vertical: 4.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25), // <-- Radius
                        ),
                      ),
                      onPressed: ()  {
                        if(_status == "Az Memnun" || _status == "Memnun Değil"){ //Az Memnun" || _status == "Memnun Değil
                          if(_status == 'Memnun Değil'){
                            AppConstant.title = '${_descriptionController.text}';
                            AppConstant.subtitle = '${FirebaseAuth.instance.currentUser?.email}';
                            //Provider.of<NotificationService>(context, listen: false).sendPushMessage(_descriptionController.text, "${FirebaseAuth.instance.currentUser?.email}");
                          }
                          //final snackBar = SnackBar(
                          //  content: Text(LocaleKeys.home_view_title_5.tr()),
                          //);
                          //ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          //print(_descriptionController.text);
                          //Provider.of<DatabaseService>(context,listen: false).initDatabaseConnection("${FirebaseAuth.instance.currentUser?.displayName}", "${FirebaseAuth.instance.currentUser?.email}", _status, _descriptionController.text);
                          Navigator.push(context, MaterialPageRoute(builder: (context) => ComplaintSelectedView(
                              UserModel(
                                  name: "${FirebaseAuth.instance.currentUser?.displayName}",
                                  email: "${FirebaseAuth.instance.currentUser?.email}",
                                  comment: _descriptionController.text,
                                  status: _status,
                                  datetime: DateTime.now().toString()
                              )
                          )));

                        }else{
                          if(_status == 'Memnun Değil'){
                            AppConstant.title = '${_descriptionController.text}';
                            AppConstant.subtitle = '${FirebaseAuth.instance.currentUser?.email}';
                            //Provider.of<NotificationService>(context, listen: false).sendPushMessage(_descriptionController.text, "${FirebaseAuth.instance.currentUser?.email}");
                          }
                          final snackBar = SnackBar(
                            content: Text(LocaleKeys.home_view_title_5.tr()),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          print(_descriptionController.text);

                          Provider.of<DatabaseService>(context,listen: false).initDatabaseConnection("${FirebaseAuth.instance.currentUser?.displayName}", "${FirebaseAuth.instance.currentUser?.email}", _status, _descriptionController.text, " ");
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (context) => InformationView(

                            )),
                                (Route<dynamic> route) => false,
                          );
                        }


                      },
                      child: Text(LocaleKeys.home_view_title_6.tr()),
                    ),
                  ),
                ],
              ),
              appBar(context),
            ],
          )
        ),
      ),
    );
  }
  Positioned appBar(BuildContext context) {
    return Positioned(
      top: MediaQuery.of(context).size.height * 0.01,
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
