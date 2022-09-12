import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yeditepe_memnuniyet/components/my_radio_list_tile.dart';
import 'package:yeditepe_memnuniyet/constants.dart';
import 'package:yeditepe_memnuniyet/extensions/locale_keys.dart';
import 'package:yeditepe_memnuniyet/models/user_model.dart';
import 'package:yeditepe_memnuniyet/services/auth_service.dart';
import 'package:yeditepe_memnuniyet/services/database_service.dart';
import 'package:yeditepe_memnuniyet/views/user/information_view.dart';
import 'package:yeditepe_memnuniyet/views/user/language_selected_view.dart';
import 'package:yeditepe_memnuniyet/views/user/splash_view.dart';

class ComplaintSelectedView extends StatefulWidget {
  UserModel _userModel;
  ComplaintSelectedView(this._userModel);
  @override
  State<ComplaintSelectedView> createState() => _ComplaintSelectedViewState();
}

class _ComplaintSelectedViewState extends State<ComplaintSelectedView> {
  String? selected;
  String? complaint;
  late TextEditingController controller;

  void initState() {
    controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    controller = TextEditingController();
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
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: 50),
                  Center(child: Text(LocaleKeys.complaint_selected_view_title_1.tr(), style: TextStyle(fontSize: 25,)),),
                  Image.asset('assets/images/unhappy.gif',width: MediaQuery.of(context).size.width * 0.3, height: MediaQuery.of(context).size.height * 0.3,),
                  selected == 'Diğer'
                      ? Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
                    child: TextField(
                      controller: controller,
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
                  )
                      : Container(height: 1, color: Colors.white,),
                  MyRadioListTile(onPressed: (value){setState(() {selected = value; complaint = selected;});},title: LocaleKeys.complaint_selected_view_title_2.tr(), character: selected, value: 'Uzun Mesai Saatleri', widget: selected == 'Uzun Mesai Saatleri' ? Icon(Icons.history_toggle_off_outlined, color: Colors.blue,) : null),
                  MyRadioListTile(onPressed: (value){setState(() {selected = value; complaint = selected;});},title: LocaleKeys.complaint_selected_view_title_3.tr(), character: selected, value: 'Yetersiz Mesai Ücreti', widget: selected == 'Yetersiz Mesai Ücreti' ? Icon(Icons.price_check, color: Colors.blue,) : null),
                  MyRadioListTile(onPressed: (value){setState(() {selected = value; complaint = selected;});},title: LocaleKeys.complaint_selected_view_title_4.tr(), character: selected, value: 'Ekip Ruhu Eksikliği', widget: selected == 'Ekip Ruhu Eksikliği' ? Icon(Icons.supervisor_account_rounded, color: Colors.blue,) : null),
                  MyRadioListTile(onPressed: (value){setState(() {selected = value; complaint = selected;});},title: LocaleKeys.complaint_selected_view_title_5.tr(), character: selected, value: 'Sağlıksız Çalışma Ortamı', widget: selected == 'Sağlıksız Çalışma Ortamı' ? Icon(Icons.health_and_safety, color: Colors.blue,) : null),
                  MyRadioListTile(onPressed: (value){setState(() {selected = value; print(value);});},
                      title: LocaleKeys.complaint_selected_view_title_6.tr(),character: selected, value: 'Diğer', widget: selected == 'Diğer' ? Icon(Icons.more_vert, color: Colors.blue,) : null),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
                    child: ElevatedButton(
                      onPressed: selected == null ? null : (){
                        if(selected == "Diğer"){
                          if(controller.text != null || controller.text != ""){
                            complaint = controller.text;
                          }else{
                            complaint = selected;
                          }
                        }else{
                          complaint = selected;
                        }
                        final snackBar = SnackBar(
                          content: Text(LocaleKeys.home_view_title_5.tr()),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);


                        Provider.of<DatabaseService>(context,listen: false).initDatabaseConnection("${widget._userModel.name}", "${widget._userModel.email}", "${widget._userModel.status}", "${widget._userModel.comment}", "$complaint");
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => InformationView(

                          )),
                              (Route<dynamic> route) => false,
                        );
                      },
                      child: Text(LocaleKeys.complaint_selected_view_title_7.tr()),
                      style: ButtonStyle(
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  side: BorderSide.none
                              )
                          )
                      ),
                    ),
                  )

                ],
              ),
              appBar(context),
            ],
          ),
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
