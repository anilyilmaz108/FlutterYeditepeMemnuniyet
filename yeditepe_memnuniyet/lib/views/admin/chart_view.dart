import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:provider/provider.dart';
import 'package:yeditepe_memnuniyet/components/item_container.dart';
import 'package:yeditepe_memnuniyet/components/item_row.dart';
import 'package:yeditepe_memnuniyet/components/progress_item.dart';
import 'package:yeditepe_memnuniyet/constants.dart';
import 'package:yeditepe_memnuniyet/models/user_model.dart';
import 'package:yeditepe_memnuniyet/services/auth_service.dart';
import 'package:yeditepe_memnuniyet/services/calculator_service.dart';
import 'package:yeditepe_memnuniyet/services/database_service.dart';
import 'package:yeditepe_memnuniyet/services/notification_service.dart';
import 'package:yeditepe_memnuniyet/views/admin/member_view.dart';
import 'package:yeditepe_memnuniyet/views/admin/complaint_view.dart';
import 'package:yeditepe_memnuniyet/views/admin/voting_view.dart';
import 'package:yeditepe_memnuniyet/views/user/splash_view.dart';
class ChartView extends StatefulWidget {

  @override
  State<ChartView> createState() => _ChartViewState();
}

class _ChartViewState extends State<ChartView> {
  @override
  void initState() {
    Provider.of<DatabaseService>(context,listen: false).getData();
    Provider.of<NotificationService>(context, listen: false).requestPermission();
    Provider.of<NotificationService>(context, listen: false).loadFCM();
    Provider.of<NotificationService>(context, listen: false).listenFCM();
    //getToken();
    FirebaseMessaging.instance.subscribeToTopic("Satisfaction");
    if(AppConstant.title != '' || AppConstant.subtitle != ''){
      Provider.of<NotificationService>(context, listen: false).sendPushMessage('${AppConstant.title}', "${AppConstant.subtitle}");
      AppConstant.title = '';
      AppConstant.subtitle = '';
    }
    super.initState();
  }

  List<UserModel> allUsers = [];
  List<String> verySatisfied = [];
  List<String> satisfied = [];
  List<String> moderatelySatisfied = [];
  List<String> lessSatisfied = [];
  List<String> notSatisfied = [];

  List<String> longWorkingHours = [];
  List<String> InsufficientOvertimePay = [];
  List<String> lackOfTeamSpirit= [];
  List<String> unhealthyWorkingEnvironment = [];
  List<String> others = [];
  //List<UserModel> queryList = [];

  //DateTime _dateTime = DateTime.now();
  //var queryWithDate = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Stack(
            children: [
              FutureBuilder<List<UserModel>>(
                future: Provider.of<DatabaseService>(context,listen: false).getData(),
                builder: (context, snapshot) {
                  try{
                    if(snapshot.data!.length != 0){
                      for(int i = 0; i < snapshot.data!.length; i++){
                        allUsers.add(
                            UserModel(
                                name: '${snapshot.data![i].name}',
                                email: '${snapshot.data![i].email}',
                                comment: '${snapshot.data![i].comment}',
                                status: '${snapshot.data![i].status}',
                                datetime: '${snapshot.data![i].datetime}',
                              complaint: '${snapshot.data![i].complaint}'
                            )
                        );
                        if(snapshot.data![i].status == 'Çok Memnun'){
                          verySatisfied.add('${snapshot.data![i].status}');
                        }
                        else if(snapshot.data![i].status == 'Memnun'){
                          satisfied.add('${snapshot.data![i].status}');
                        }
                        else if(snapshot.data![i].status == 'Orta'){
                          moderatelySatisfied.add('${snapshot.data![i].status}');
                        }
                        else if(snapshot.data![i].status == 'Az Memnun'){
                          lessSatisfied.add('${snapshot.data![i].status}');
                        }
                        else{
                          notSatisfied.add('${snapshot.data![i].status}');
                        }

                        if(snapshot.data![i].complaint != null || snapshot.data![i].complaint != " "){
                          if(snapshot.data![i].complaint == "Uzun Mesai Saatleri"){
                            longWorkingHours.add('${snapshot.data![i].complaint}');
                          }
                          else if(snapshot.data![i].complaint == "Yetersiz Mesai Ücreti"){
                            InsufficientOvertimePay.add('${snapshot.data![i].complaint}');
                          }
                          else if(snapshot.data![i].complaint == "Ekip Ruhu Eksikliği"){
                            lackOfTeamSpirit.add('${snapshot.data![i].complaint}');
                          }
                          else if(snapshot.data![i].complaint == "Sağlıksız Çalışma Ortamı"){
                            unhealthyWorkingEnvironment.add('${snapshot.data![i].complaint}');
                          }
                          else if(snapshot.data![i].complaint == "Diğer"){
                            others.add('${snapshot.data![i].complaint}');
                          }
                          else{
                            others.add('${snapshot.data![i].complaint}');
                          }
                        }

                      }
                    }
                  }catch(e){
                    print(e);
                  }

                  if (snapshot.hasData) {
                    return Column(
                      children: [
                        SizedBox(height: 5,),
                        Text('Personel Memnuniyet Tablosu', style: TextStyle(fontSize: 20),),
                        /*Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('${_dateTime.day}/${_dateTime.month}/${_dateTime.year}',style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20),),
                            TextButton(
                            onPressed: () {
                            DatePicker.showDatePicker(context,
                            showTitleActions: true,
                            minTime: DateTime(2018, 3, 5),
                            maxTime: DateTime.now(), onChanged: (date) {
                            print('change $date');
                            }, onConfirm: (date) {
                                  setState(() {
                                    _dateTime = date;
                                    //queryWithDate = _dateTime.toString().split(' ')[0];
                                    //String newQueryDate = '${queryWithDate}T21:00:00.000Z';
                                    //print(queryWithDate);
                                    //print(newQueryDate);
                                    //queryList.clear();
                                    //Provider.of<DatabaseService>(context, listen: false).queryData(newQueryDate, queryList);
                                    //print('${queryList.length} ******** ');
                                  });
                            print('confirm $date');
                            }, currentTime: DateTime.now(), locale: LocaleType.tr);
                            },
                            child: Text(
                            'Tarih Giriniz',
                            style: TextStyle(color: Colors.blue),
                            )),

                          ],
                        ),*/
                        Container(
                          height: MediaQuery.of(context).size.height * 0.4,
                          child: Row(
                            children: [
                              allUsers.length == 0 ? Text('') : Container(
                                width: MediaQuery.of(context).size.width * 0.55,
                                child: PieChart(
                                    PieChartData(
                                        centerSpaceRadius: 40,
                                        centerSpaceColor: Colors.white,
                                        borderData: FlBorderData(show: false),
                                        sections: [
                                          PieChartSectionData(value: Provider.of<CalculatorService>(context, listen: false).pieChartCalculator(verySatisfied.length.toDouble(), satisfied.length.toDouble(), moderatelySatisfied.length.toDouble(), lessSatisfied.length.toDouble(), notSatisfied.length.toDouble()), color: Colors.blue, title: '%${Provider.of<CalculatorService>(context, listen: false).pieChartCalculator(verySatisfied.length.toDouble(), satisfied.length.toDouble(), moderatelySatisfied.length.toDouble(), lessSatisfied.length.toDouble(), notSatisfied.length.toDouble()).toStringAsFixed(2)}', titleStyle: TextStyle(color: Colors.white)),
                                          PieChartSectionData(value: Provider.of<CalculatorService>(context, listen: false).pieChartCalculator(satisfied.length.toDouble(), satisfied.length.toDouble(), moderatelySatisfied.length.toDouble(), lessSatisfied.length.toDouble(), notSatisfied.length.toDouble()), color: Colors.orange, title: '%${Provider.of<CalculatorService>(context, listen: false).pieChartCalculator(satisfied.length.toDouble(), verySatisfied.length.toDouble(), moderatelySatisfied.length.toDouble(), lessSatisfied.length.toDouble(), notSatisfied.length.toDouble()).toStringAsFixed(2)}', titleStyle: TextStyle(color: Colors.white)),
                                          PieChartSectionData(value: Provider.of<CalculatorService>(context, listen: false).pieChartCalculator(moderatelySatisfied.length.toDouble(), satisfied.length.toDouble(), moderatelySatisfied.length.toDouble(), lessSatisfied.length.toDouble(), notSatisfied.length.toDouble()), color: Colors.red, title: '%${Provider.of<CalculatorService>(context, listen: false).pieChartCalculator(moderatelySatisfied.length.toDouble(), satisfied.length.toDouble(), verySatisfied.length.toDouble(), lessSatisfied.length.toDouble(), notSatisfied.length.toDouble()).toStringAsFixed(2)}', titleStyle: TextStyle(color: Colors.white)),
                                          PieChartSectionData(value: Provider.of<CalculatorService>(context, listen: false).pieChartCalculator(lessSatisfied.length.toDouble(), satisfied.length.toDouble(), moderatelySatisfied.length.toDouble(), lessSatisfied.length.toDouble(), notSatisfied.length.toDouble()), color: Colors.purple, title: '%${Provider.of<CalculatorService>(context, listen: false).pieChartCalculator(lessSatisfied.length.toDouble(), satisfied.length.toDouble(), moderatelySatisfied.length.toDouble(), verySatisfied.length.toDouble(), notSatisfied.length.toDouble()).toStringAsFixed(2)}', titleStyle: TextStyle(color: Colors.white)),
                                          PieChartSectionData(value: Provider.of<CalculatorService>(context, listen: false).pieChartCalculator(notSatisfied.length.toDouble(), satisfied.length.toDouble(), moderatelySatisfied.length.toDouble(), lessSatisfied.length.toDouble(), notSatisfied.length.toDouble()), color: Colors.green, title: '%${Provider.of<CalculatorService>(context, listen: false).pieChartCalculator(notSatisfied.length.toDouble(), satisfied.length.toDouble(), moderatelySatisfied.length.toDouble(), lessSatisfied.length.toDouble(), verySatisfied.length.toDouble()).toStringAsFixed(2)}', titleStyle: TextStyle(color: Colors.white))
                                        ]
                                    )
                                ),
                              ),
                              Container(
                                height: MediaQuery.of(context).size.height * 0.5,
                                padding: EdgeInsets.symmetric(vertical: 48.0, horizontal: 8.0),
                                child: Column(
                                  children: [
                                    ItemRow(title: 'Çok Memnun', color: Colors.blue),
                                    ItemRow(title: 'Memnun', color: Colors.orange),
                                    ItemRow(title: 'Orta', color: Colors.red),
                                    ItemRow(title: 'Az Memnun', color: Colors.purple),
                                    ItemRow(title: 'Memnun Değil', color: Colors.green),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ItemContainer(color: Colors.lightBlue, title: 'Oylamalar', icon: Icons.account_circle, onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => VotingView()));},),
                            ItemContainer(color: Colors.greenAccent, title: 'Şikayetler', icon: Icons.comment, onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => ComplaintView()));},),
                            ItemContainer(color: Colors.amberAccent, title: 'Üyeler', icon: Icons.card_membership, onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => MemberView()));},),
                          ],
                        ),
                        ProgressItem(color: Colors.greenAccent, title: 'Uzun Mesai Saatleri', percent: Provider.of<CalculatorService>(context, listen: false).progressItemCalculator(longWorkingHours.length.toDouble(), InsufficientOvertimePay.length.toDouble(), lackOfTeamSpirit.length.toDouble(), unhealthyWorkingEnvironment.length.toDouble(), others.length.toDouble()), percentageTitle: '${Provider.of<CalculatorService>(context, listen: false).progressItemCalculator(longWorkingHours.length.toDouble(), InsufficientOvertimePay.length.toDouble(), lackOfTeamSpirit.length.toDouble(), unhealthyWorkingEnvironment.length.toDouble(), others.length.toDouble()).toStringAsFixed(2)}'),
                        ProgressItem(color: Colors.amberAccent, title: 'Yetersiz Mesai Ücreti', percent: Provider.of<CalculatorService>(context, listen: false).progressItemCalculator(InsufficientOvertimePay.length.toDouble(), longWorkingHours.length.toDouble(), lackOfTeamSpirit.length.toDouble(), unhealthyWorkingEnvironment.length.toDouble(), others.length.toDouble()), percentageTitle: '${Provider.of<CalculatorService>(context, listen: false).progressItemCalculator(InsufficientOvertimePay.length.toDouble(), longWorkingHours.length.toDouble(), lackOfTeamSpirit.length.toDouble(), unhealthyWorkingEnvironment.length.toDouble(), others.length.toDouble()).toStringAsFixed(2)}'),
                        ProgressItem(color: Colors.red, title: 'Ekip Ruhu Eksikliği', percent: Provider.of<CalculatorService>(context, listen: false).progressItemCalculator(lackOfTeamSpirit.length.toDouble(), InsufficientOvertimePay.length.toDouble(), longWorkingHours.length.toDouble(), unhealthyWorkingEnvironment.length.toDouble(), others.length.toDouble()), percentageTitle: '${Provider.of<CalculatorService>(context, listen: false).progressItemCalculator(lackOfTeamSpirit.length.toDouble(), InsufficientOvertimePay.length.toDouble(), longWorkingHours.length.toDouble(), unhealthyWorkingEnvironment.length.toDouble(), others.length.toDouble()).toStringAsFixed(2)}'),
                        ProgressItem(color: Colors.purpleAccent, title: 'Sağlıksız Çalışma Ortamı', percent: Provider.of<CalculatorService>(context, listen: false).progressItemCalculator(unhealthyWorkingEnvironment.length.toDouble(), InsufficientOvertimePay.length.toDouble(), lackOfTeamSpirit.length.toDouble(), longWorkingHours.length.toDouble(), others.length.toDouble()), percentageTitle: '${Provider.of<CalculatorService>(context, listen: false).progressItemCalculator(unhealthyWorkingEnvironment.length.toDouble(), InsufficientOvertimePay.length.toDouble(), lackOfTeamSpirit.length.toDouble(), longWorkingHours.length.toDouble(), others.length.toDouble()).toStringAsFixed(2)}'),
                        ProgressItem(color: Colors.pinkAccent, title: 'Diğer', percent: Provider.of<CalculatorService>(context, listen: false).progressItemCalculator(others.length.toDouble(), InsufficientOvertimePay.length.toDouble(), lackOfTeamSpirit.length.toDouble(), unhealthyWorkingEnvironment.length.toDouble(), longWorkingHours.length.toDouble()), percentageTitle: '${Provider.of<CalculatorService>(context, listen: false).progressItemCalculator(others.length.toDouble(), InsufficientOvertimePay.length.toDouble(), lackOfTeamSpirit.length.toDouble(), unhealthyWorkingEnvironment.length.toDouble(), longWorkingHours.length.toDouble()).toStringAsFixed(2)}'),
                      ],
                    );
                  } else if (snapshot.hasError) {
                    return Text('${snapshot.error}');
                  }
                  return const CircularProgressIndicator();
                },
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
      top: MediaQuery.of(context).size.height * 0.05,
      right: MediaQuery.of(context).size.width * 0.05,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            onPressed: (){
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => super.widget));
            },
            icon: Icon(Icons.refresh),
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




