import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:search_page/search_page.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:yeditepe_memnuniyet/models/user_model.dart';
import 'package:yeditepe_memnuniyet/services/database_service.dart';
import 'package:http/http.dart' as http;

class ComplaintView extends StatefulWidget {
  @override
  State<ComplaintView> createState() => _ComplaintViewState();
}

class _ComplaintViewState extends State<ComplaintView> {

  @override
  void initState() {
    Provider.of<DatabaseService>(context,listen: false).getData();
    super.initState();
  }



  //final List<UserModel> userList = [];
  List<UserModel> searchList = [];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Şikayetler'),
        actions: [
          IconButton(
            icon: Icon(
              Icons.search,
            ),
            color: Colors.white,
            onPressed: (){
              showSearch(
                context: context,
                delegate: SearchPage<UserModel>(
                  barTheme: ThemeData(
                    primaryColor: Color(0xFF5F627D),
                  ),
                  items: searchList,
                  searchLabel: 'Şikayet Ara',
                  suggestion: Center(
                    child: Text('Email veya Şikayete Göre Arama Yapınız.'),
                  ),
                  failure: Center(
                    child: Text('Herhangi bir Şikayet bulunamadı!'),
                  ),
                  filter: (searchList) => [
                    searchList.comment,
                    searchList.email
                  ],
                  builder: (searchList) => ListTile(
                    title: Text('${searchList.comment}'),
                    subtitle: Text('${searchList.email}'),
                    trailing: Icon(
                      Icons.arrow_right,
                      size: 20,
                    ),
                    ),
                  ),
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: FutureBuilder<List<UserModel>>(
          future: Provider.of<DatabaseService>(context,listen: false).getData(),
          builder: (context, snapshot) {
            try{
              for(int i = 0; i < snapshot.data!.length; i++){
                if(snapshot.data![i].comment != ''){
                  /*userList.add(
                    UserModel(
                      name: '${snapshot.data?[i].name}',
                      email: '${snapshot.data?[i].email}',
                      comment: '${snapshot.data?[i].comment}',
                      datetime: '${snapshot.data?[i].datetime}',
                      status: '${snapshot.data?[i].status}'
                    )
                  );*/

                  searchList.add(
                    UserModel(
                      comment: '${snapshot.data![i].comment}',
                      email: '${snapshot.data![i].email}'
                    )
                  );
                }
              }
            }catch(e){
              print(e);
            }

            if (snapshot.hasData) {
              return snapshot.data?.length == 0
                  ? Center(child: Text('Herhangi bir veri bulunamadı'),)
                  : ListView.builder(
                itemCount: snapshot.data?.length,
                itemBuilder: (context, index){
                  return ListTile(
                    title: Text('${snapshot.data?[index].comment}'),
                    subtitle: Text('${snapshot.data?[index].email}'),
                    trailing: IconButton(icon: Icon(Icons.edit,color: Colors.amber,),
                        onPressed: ()async{
                      String email = '${snapshot.data?[index].email}';
                      String subject = '${snapshot.data?[index].comment}';
                      String body = 'Feedback';

                      String? encodeQueryParameters(Map<String, String> params){
                        return params.entries.map((e) =>
                        '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}').join('&');
                      }

                      final Uri emailUri = Uri(
                        scheme: 'mailto',
                        path: email,
                        query: encodeQueryParameters(<String, String>{'subject': subject, 'body': body}),
                      );

                      if(await canLaunchUrl(emailUri)){
                        launchUrl(emailUri);
                      }else{
                        print('No Email!!');
                      }

                        }
                    ),
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }
            return const CircularProgressIndicator();
          },
        ),
      ),);
  }
}

/*Accordion(
                maxOpenSections: 2,
                headerBackgroundColorOpened: Colors.black54,
                scaleWhenAnimating: true,
                openAndCloseAnimation: true,
                headerPadding:
                const EdgeInsets.symmetric(vertical: 7, horizontal: 15),
                sectionOpeningHapticFeedback: SectionHapticFeedback.heavy,
                sectionClosingHapticFeedback: SectionHapticFeedback.light,
                children: accordionList,
                rightIcon: IconButton(icon: Icon(Icons.delete, color: Colors.white,),
                  onPressed: (){
                    setState(() {
                      accordionList.removeAt(0);
                    });
                  print('${accordionList.removeAt(0)} is clicked');
                },
                ),
              );*/

/*AccordionSection(
                      isOpen: true,
                      leftIcon: const Icon(Icons.insights_rounded, color: Colors.white),
                      headerBackgroundColor: Colors.lightBlueAccent,
                      headerBackgroundColorOpened: Colors.blue[900],
                      header: Text('Şikayet', style: _headerStyle),
                      content: Text('${snapshot.data![i].comment}', style: _contentStyle),
                      contentHorizontalPadding: 20,
                      contentBorderWidth: 1,
                    ),*/

/*IconButton(icon: Icon(Icons.delete,color: Colors.red,), onPressed: (){
                            try{
                              setState(() {
                                //print(snapshot.data![index].id);
                                print(index);
                                snapshot.data?.removeAt(index);
                                Provider.of<DatabaseService>(context, listen: false).deleteDataWithID(snapshot.data![index].id!);
                              });
                            }catch(e){
                              print(e);
                            }
                          }),*/